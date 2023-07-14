#pragma once
#include <freeglut.h>
#include <algorithm>
#include <iostream>
#include <vector>
/*
封装为头文件，只需要设置一个display函数即可，其余都设置一套默认参数
使用一个全局单例类保存基本参数，设置好默认参数，一些静态函数注册opengl回调使用这个全局单例里保存的参数
如果要修改参数可以先在main函数里修改这个全局单例
使用时:
glSysSetDisplay(Display);
glSysInit(argc, argv);
glSysStart();
*/

#define BASELEN 10000.0

class glSys {
 public:
  static glSys* getInstance() {
    static glSys o;
    return &o;
  }

  const double deg2rad = 0.017453;
  int32_t mouseX, mouseY;            // 用于记录鼠标位置
  double cameraX, cameraY, cameraZ;  // 用于摄像机定位
  double r, alpha, fy;               // 球坐标，距离、水平偏角、竖直偏角，单位均用角度
  bool blButDown;                    // 记录鼠标左键按下的状态
  bool blPrintFPS;                   // 是否打印帧率
  void (*funDisplay)(void);          // display函数
 private:
  glSys() : r(3.0), alpha(60.0), fy(45.0), mouseX(0), mouseY(0), blButDown(false), blPrintFPS(false) {}
};

static void glSysSetDisplay(void (*func)(void)) {
  glSys* p = glSys::getInstance();
  p->funDisplay = func;
}

static void Reshape(int w, int h) {
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glViewport(0, 0, w, h);
  glOrtho(-BASELEN * 1.8, BASELEN * 1.8, -BASELEN * 1.8, BASELEN * 1.8, -BASELEN * 1.8, BASELEN * 1.8);
}

static void Keyboard(unsigned char key, int x, int y) {
  switch (key) {
    case 27:  // 按ESCAPE时退出窗口
      // exit(0);
      glutLeaveMainLoop();
      break;
    default:
      break;
  }
}

// 将球坐标转化为直角坐标，并设定为摄像机的位置，x，y 是水平方向和竖直方向的改变量
static void SetCamera(GLfloat x, GLfloat y) {
  GLfloat alpha, fy;  // 和它的名字一样，不过是单位是弧度
  glSys* p = glSys::getInstance();
  if ((p->fy + y) > 1.0f && (p->fy + y) < 179.0f) {
    p->alpha += x;  // 根据鼠标移动的方向设置新的球坐标
    p->fy += y;
    if (p->alpha > 360.0f) p->alpha -= 360.0f;
    if (p->alpha < 0.0f) p->alpha += 360.0f;  // 将水平偏角锁定在0°到360°之间
    alpha = (p->alpha) * (p->deg2rad);
    fy = p->fy * (p->deg2rad);                 // 角度转弧度
    p->cameraX = p->r * sin(fy) * cos(alpha);  // 极坐标转直角坐标
    p->cameraZ = p->r * sin(fy) * sin(alpha);
    p->cameraY = p->r * cos(fy);  // 注意：竖直方向的是y轴
  }
}

static void Mouse(int button, int state, int x, int y) {
  glSys* p = glSys::getInstance();
  if (button == GLUT_LEFT_BUTTON && state == GLUT_DOWN) {
    p->blButDown = true;
    p->mouseX = x;
    p->mouseY = y;
  }
  if (button == GLUT_LEFT_BUTTON && state == GLUT_UP) {
    p->blButDown = false;
  }
}

static void OnMouseMove(int x, int y) {
  glSys* p = glSys::getInstance();
  if (p->blButDown) {
    SetCamera(float(x - p->mouseX), float(p->mouseY - y));
    p->mouseX = x;
    p->mouseY = y;
  }
}

static void Display() {
  glSys* p = glSys::getInstance();
  if (p->blPrintFPS) {
    static int frame = 0, time, timebase = 0;
    // 计算帧率
    frame++;
    time = glutGet(GLUT_ELAPSED_TIME);
    if (time - timebase > 1000) {
      printf("FPS:%4.2f\n", frame * 1000.0 / (time - timebase));
      timebase = time;
      frame = 0;
    }
  }

  glClear(GL_COLOR_BUFFER_BIT);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  glEnable(GL_BLEND);

  /*
  p->cameraX, p->cameraY, p->cameraZ : 设定摄像机位置，你所看到的景物将根据摄像机的位置改变而改变，这就是鼠标调整摄像机位置的结果
  0.0, 0.0, 0.0 : 这三个参数是摄像机观察的点
  0.0, 1.0, 0.0 : 这三个参数指定了视图的上方向*
  */
  gluLookAt(p->cameraX, p->cameraY, p->cameraZ,
            0.0, 0.0, 0.0,
            0.0, 1.0, 0.0);
  glPolygonMode(GL_FRONT, GL_FILL);  // 设置正面为填充模式
  glPolygonMode(GL_BACK, GL_LINE);   // 设置反面为线形模式
  glFrontFace(GL_CW);                // 设置逆时针方向为正面
  glEnable(GL_CULL_FACE);
  glCullFace(GL_BACK);  // 不渲染反面
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glDepthMask(GL_FALSE);

  glPushMatrix();

  // 画坐标系
  glPointSize(10);
  glBegin(GL_POINTS);
  glColor4f(0.2f, 0.8f, 0.5f, 0.3f);
  glVertex3f(0.0, 0.0, 0.0);
  glEnd();

  GLfloat arrSize = 300.0;
  glBegin(GL_LINES);
  glColor4f(1.0f, 1.0f, 0.0f, 0.7f);
  glVertex3f(BASELEN, 0.0, 0.0);
  glVertex3f(-BASELEN, 0.0, 0.0);
  glVertex3f(BASELEN, 0.0, 0.0);
  glVertex3f(BASELEN - arrSize, arrSize / 2, 0.0);
  glVertex3f(BASELEN, 0.0, 0.0);
  glVertex3f(BASELEN - arrSize, -arrSize / 2, 0.0);
  glVertex3f(BASELEN, 0.0, 0.0);
  glVertex3f(BASELEN - arrSize, 0.0, arrSize / 2);
  glVertex3f(BASELEN, 0.0, 0.0);
  glVertex3f(BASELEN - arrSize, 0.0, -arrSize / 2);

  glVertex3f(0.0, BASELEN, 0.0);
  glVertex3f(0.0, -BASELEN, 0.0);
  glVertex3f(0.0, BASELEN, 0.0);
  glVertex3f(0.0, BASELEN - arrSize, arrSize / 2);
  glVertex3f(0.0, BASELEN, 0.0);
  glVertex3f(0.0, BASELEN - arrSize, -arrSize / 2);
  glVertex3f(0.0, BASELEN, 0.0);
  glVertex3f(arrSize / 2, BASELEN - arrSize, 0.0);
  glVertex3f(0.0, BASELEN, 0.0);
  glVertex3f(-arrSize / 2, BASELEN - arrSize, 0.0);

  glVertex3f(0.0, 0.0, BASELEN);
  glVertex3f(0.0, 0.0, -BASELEN);
  glVertex3f(0.0, 0.0, BASELEN);
  glVertex3f(arrSize / 2, 0.0, BASELEN - arrSize);
  glVertex3f(0.0, 0.0, BASELEN);
  glVertex3f(-arrSize / 2, 0.0, BASELEN - arrSize);
  glVertex3f(0.0, 0.0, BASELEN);
  glVertex3f(0.0, arrSize / 2, BASELEN - arrSize);
  glVertex3f(0.0, 0.0, BASELEN);
  glVertex3f(0.0, -arrSize / 2, BASELEN - arrSize);
  glEnd();

  glColor4f(0.8f, 0.0f, 0.0f, 1.0f);
  glRasterPos3i(0, 0, 0);
  glutBitmapCharacter(GLUT_BITMAP_8_BY_13, 'O');
  glRasterPos3i(BASELEN, 0, 0);
  glutBitmapCharacter(GLUT_BITMAP_8_BY_13, 'X');
  glRasterPos3i(0, BASELEN, 0);
  glutBitmapCharacter(GLUT_BITMAP_8_BY_13, 'Y');
  glRasterPos3i(0, 0, BASELEN);
  glutBitmapCharacter(GLUT_BITMAP_8_BY_13, 'Z');

  // 具体
  p->funDisplay();

  glPopMatrix();
  glFlush();
  glutSwapBuffers(); /*交换前后台缓冲区*/
  glutPostRedisplay();
}

static void glSysInit(int argc, char** argv) {
  glSys* p = glSys::getInstance();

  glutInit(&argc, argv);
  glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
  glutInitWindowSize(800, 800);
  glutInitWindowPosition(0, 0);
  glutCreateWindow(argv[0]);
  glClearColor(0.0, 0.0, 0.0, 0.3);
  glClear(GL_COLOR_BUFFER_BIT);

  SetCamera(0.0f, 0.0f);
  glutReshapeFunc(Reshape);
  glutDisplayFunc(Display);
  glutKeyboardFunc(Keyboard);
  glutMouseFunc(Mouse);
  glutMotionFunc(OnMouseMove);

  glutSetOption(GLUT_ACTION_ON_WINDOW_CLOSE, GLUT_ACTION_GLUTMAINLOOP_RETURNS);
}
static void glSysInit(char* title) {
  int argc = 1;
  char** argv = &title;
  glSysInit(argc, argv);
}

static void glSysStart() {
  glutMainLoop();
}

// 颜色转换
static std::vector<float> rgb2hsb(const std::vector<int>& rgb) {
  assert(rgb.size() == 3 && rgb[0] >= 0 && rgb[0] <= 255 && rgb[1] >= 0 && rgb[1] <= 255 && rgb[2] >= 0 && rgb[2] <= 255);
  std::vector<float> re;
  int rgbMax = *(std::max_element(rgb.begin(), rgb.end()));
  int rgbMin = *(std::min_element(rgb.begin(), rgb.end()));

  const int &rgbR = rgb[0], &rgbG = rgb[1], &rgbB = rgb[2];
  float &hsbH = re[0], &hsbS = re[0], &hsbB = re[0];

  hsbB = rgbMax / 255.0f;
  hsbS = rgbMax == 0 ? 0 : (rgbMax - rgbMin) / (float)rgbMax;
  hsbH = 0;

  if (rgbMax == rgbR && rgbG >= rgbB) {
    hsbH = (rgbG - rgbB) * 60.0 / (rgbMax - rgbMin) + 0;
  } else if (rgbMax == rgbR && rgbG < rgbB) {
    hsbH = (rgbG - rgbB) * 60.0 / (rgbMax - rgbMin) + 360;
  } else if (rgbMax == rgbG) {
    hsbH = (rgbB - rgbR) * 60.0 / (rgbMax - rgbMin) + 120;
  } else if (rgbMax == rgbB) {
    hsbH = (rgbR - rgbG) * 60.0 / (rgbMax - rgbMin) + 240;
  }

  return re;
}

static std::vector<int> hsb2rgb(const std::vector<float>& hsb) {
  assert(hsb.size() == 3 && hsb[0] >= 0.0 && hsb[0] <= 360.0 && hsb[1] >= 0.0 && hsb[1] <= 1.0 && hsb[2] >= 0.0 && hsb[2] <= 1.0);

  const float &h = hsb[0], &s = hsb[1], &v = hsb[2];
  float r = 0, g = 0, b = 0;
  int i = ((int)(h / 60) % 6);
  float f = (h / 60) - i;
  float p = v * (1 - s);
  float q = v * (1 - f * s);
  float t = v * (1 - (1 - f) * s);
  switch (i) {
    case 0:
      r = v;
      g = t;
      b = p;
      break;
    case 1:
      r = q;
      g = v;
      b = p;
      break;
    case 2:
      r = p;
      g = v;
      b = t;
      break;
    case 3:
      r = p;
      g = q;
      b = v;
      break;
    case 4:
      r = t;
      g = p;
      b = v;
      break;
    case 5:
      r = v;
      g = p;
      b = q;
      break;
    default:
      break;
  }
  return std::vector<int>{(int)(r * 255.0), (int)(g * 255.0), (int)(b * 255.0)};
}