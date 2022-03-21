#pragma once
#include <cassert>
#include <iostream>

#define MAXSIZE 10000000

//一个立方矩阵
class cube {
 public:
  double*** val;
  uint32_t x, y, z;
  cube() : x(0), y(0), z(0), val(NULL) {}
  cube(const uint32_t x_, const uint32_t y_, const uint32_t z_) {
    _allocateMemory(x_, y_, z_);
  }
  cube(const cube& CB) {
    _allocateMemory(CB.x, CB.y, CB.z);
    memcpy(val[0][0], CB.val[0][0], x * y * z * sizeof(double));
  }

  ~cube() {
    _releaseMemory();
  }
  cube& operator=(const cube& CB) {
    if (this != &CB) {
      if (CB.x != x || CB.y != y || CB.z != z) {
        _releaseMemory();
        _allocateMemory(CB.x, CB.y, CB.z);
      }
      memcpy(val[0][0], CB.val[0][0], x * y * z * sizeof(double));
    }
    return *this;
  }
  cube(cube&& CB) : val(CB.val), x(CB.x), y(CB.y), z(CB.z) {
    CB.val = NULL;
    CB.x = CB.y = CB.z = 0;
  }
  cube& operator=(cube&& CB) {
    if (this != &CB) {
      //先释放自己的资源
      _releaseMemory();
      val = CB.val;
      x = CB.x;
      y = CB.y;
      z = CB.z;
      CB.val = NULL;
      CB.x = CB.y = CB.z = 0;
    }
    return *this;
  }

  friend std::ostream& operator<<(std::ostream& out, const cube& CB) {
    if (CB.x == 0 || CB.y == 0 || CB.z == 0) {
      out << "[empty cube]";
    } else {
      for (uint32_t i = 0; i < CB.x; ++i) {
        out << '(' << i << " ; : ; :)\n";
        for (uint32_t j = 0; j < CB.y; ++j) {
          for (uint32_t k = 0; k < CB.z; ++k) {
            out << CB.val[i][j][k] << '\t';
          }
          out << std::endl;
        }
      }
    }
    return out;
  }

 private:
  void _allocateMemory(const uint32_t x_, const uint32_t y_, const uint32_t z_) {
    assert(x_ * y_ * z_ < MAXSIZE);
    x = x_;
    y = y_;
    z = z_;
    if (x == 0 || y == 0 || z == 0) return;

    val = (double***)malloc(x * sizeof(double**));

    val[0] = (double**)malloc(x * y * sizeof(double*));
    for (uint32_t i = 1; i < x; ++i)
      val[i] = val[i - 1] + y;

    val[0][0] = (double*)calloc(x * y * z, sizeof(double));
    for (uint32_t i = 0; i < x; ++i) {
      if (i > 0) val[i][0] = val[i - 1][0] + z * y;
      for (uint32_t j = 1; j < y; ++j) {
        val[i][j] = val[i][j - 1] + z;
      }
    }
  }

  void _releaseMemory() {
    if (val != NULL) {
      free(val[0][0]);
      free(val[0]);
      free(val);
    }
  }
};