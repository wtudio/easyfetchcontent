#include <cstdio>
#include <cstdlib>

#include "uv.h"

using namespace std;

int32_t main(int32_t argc, char** argv) {
  uv_loop_t* loop = (uv_loop_t*)(malloc(sizeof(uv_loop_t)));
  uv_loop_init(loop);

  printf("Now quitting.\n");
  uv_run(loop, UV_RUN_DEFAULT);

  uv_loop_close(loop);
  free(loop);

  return 0;
}
