#include <algorithm>
#include <iostream>
#include "cube.h"
#include "glsys.h"

using namespace std;

std::vector<float> val2rgba(float h) {
  assert(h >= 0.0 && h <= 360.0);
  float s = 0.5, v = 0.5, r = 0, g = 0, b = 0;
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
  return std::vector<float>{r, g, b, 1.0f};
}

cube CB;                       //待画立方体
double thr;                    //阈值，小于等于其的不画
float maxVal, minVal, colorD;  //颜色变换
float cubeD, deX, deY, deZ;    //位置变换

//核心函数，cube绘图。使用opengl。坐标系-10000~10000
void cubeDisplay() {
  //画立方体，六个方向进行遍历
  float curX, curY, curZ, curX_, curY_, curZ_;

  for (int32_t xx = 0; xx < CB.x; ++xx) {
    curX = (xx - deX) * cubeD;
    curX_ = curX + cubeD;
    for (uint32_t yy = 0; yy < CB.y; ++yy) {
      curY = (yy - deY) * cubeD;
      curY_ = curY + cubeD;
      for (uint32_t zz = 0; zz < CB.z; ++zz) {
        if (CB.val[xx][yy][zz] <= thr) continue;
        curZ = (zz - deZ) * cubeD;
        curZ_ = curZ + cubeD;
        bool colorFlag = false;
        if (xx == 0 || CB.val[xx - 1][yy][zz] <= thr) {
          if (!colorFlag) {
            float h = (CB.val[xx][yy][zz] - minVal) * colorD;
            glColor4fv(&(val2rgba(h)[0]));
            colorFlag = true;
          }
          glBegin(GL_POLYGON);
          glVertex3f(curX, curY, curZ);
          glVertex3f(curX, curY_, curZ);
          glVertex3f(curX, curY_, curZ_);
          glVertex3f(curX, curY, curZ_);
          glEnd();
        }
        if (xx == CB.x - 1 || CB.val[xx + 1][yy][zz] <= thr) {
          if (!colorFlag) {
            float h = (CB.val[xx][yy][zz] - minVal) * colorD;
            glColor4fv(&(val2rgba(h)[0]));
            colorFlag = true;
          }
          glBegin(GL_POLYGON);
          glVertex3f(curX_, curY, curZ);
          glVertex3f(curX_, curY, curZ_);
          glVertex3f(curX_, curY_, curZ_);
          glVertex3f(curX_, curY_, curZ);
          glEnd();
        }
        if (yy == 0 || CB.val[xx][yy - 1][zz] <= thr) {
          if (!colorFlag) {
            float h = (CB.val[xx][yy][zz] - minVal) * colorD;
            glColor4fv(&(val2rgba(h)[0]));
            colorFlag = true;
          }
          glBegin(GL_POLYGON);
          glVertex3f(curX, curY, curZ);
          glVertex3f(curX, curY, curZ_);
          glVertex3f(curX_, curY, curZ_);
          glVertex3f(curX_, curY, curZ);
          glEnd();
        }
        if (yy == CB.y - 1 || CB.val[xx][yy + 1][zz] <= thr) {
          if (!colorFlag) {
            float h = (CB.val[xx][yy][zz] - minVal) * colorD;
            glColor4fv(&(val2rgba(h)[0]));
            colorFlag = true;
          }
          glBegin(GL_POLYGON);
          glVertex3f(curX, curY_, curZ);
          glVertex3f(curX_, curY_, curZ);
          glVertex3f(curX_, curY_, curZ_);
          glVertex3f(curX, curY_, curZ_);
          glEnd();
        }
        if (zz == 0 || CB.val[xx][yy][zz - 1] <= thr) {
          if (!colorFlag) {
            float h = (CB.val[xx][yy][zz] - minVal) * colorD;
            glColor4fv(&(val2rgba(h)[0]));
            colorFlag = true;
          }
          glBegin(GL_POLYGON);
          glVertex3f(curX, curY, curZ);
          glVertex3f(curX_, curY, curZ);
          glVertex3f(curX_, curY_, curZ);
          glVertex3f(curX, curY_, curZ);
          glEnd();
        }
        if (zz == CB.z - 1 || CB.val[xx][yy][zz + 1] <= thr) {
          if (!colorFlag) {
            float h = (CB.val[xx][yy][zz] - minVal) * colorD;
            glColor4fv(&(val2rgba(h)[0]));
            colorFlag = true;
          }
          glBegin(GL_POLYGON);
          glVertex3f(curX, curY, curZ_);
          glVertex3f(curX, curY_, curZ_);
          glVertex3f(curX_, curY_, curZ_);
          glVertex3f(curX_, curY, curZ_);
          glEnd();
        }
      }
    }
  }
}
static void myKeyboard(unsigned char key, int x, int y) {
  switch (key) {
    case 27:  //按ESCAPE时退出窗口
              //exit(0);
      glutLeaveMainLoop();
      break;
    case 'z':
      thr += ((maxVal - minVal) / 100.0);
      break;
    case 'x':
      thr -= ((maxVal - minVal) / 100.0);
      break;
    default:
      break;
  }
}

int32_t main(int32_t argc, char** argv) {
  CB = cube(128, 128, 128);
  int ct = 1;
  for (uint32_t i = 0; i < CB.x; ++i) {
    for (uint32_t j = 0; j < CB.y; ++j) {
      for (uint32_t k = 0; k < CB.z; ++k) {
        CB.val[i][j][k] = ct++;
      }
    }
  }

  //位置变换
  cubeD = 1.8 * BASELEN / max(max(CB.x, CB.y), CB.z);
  deX = CB.x / 2.0f, deY = CB.y / 2.0f, deZ = CB.z / 2.0f;

  //颜色变换
  pair<double*, double*> minmaxVal = minmax_element(CB.val[0][0], CB.val[0][0] + CB.x * CB.y * CB.z);
  maxVal = *(minmaxVal.second) + 1.0;
  minVal = *(minmaxVal.first) - 1.0;
  colorD = 360.0f / (maxVal - minVal);

  //设置打印帧率
  glSys* p = glSys::getInstance();
  p->blPrintFPS = true;

  //初试阈值
  thr = minVal;

  glSysSetDisplay(cubeDisplay);
  glSysInit(argc, argv);
  glutKeyboardFunc(myKeyboard);
  glSysStart();

  printf("Press any key to exit.");
  getchar();

  return 0;
}
