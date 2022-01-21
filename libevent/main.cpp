#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>

#include "event2/event.h"
#include "event2/event_struct.h"

int idx;

static void timeout_cb(evutil_socket_t fd, short event, void *arg) {
  printf("run timeout_cb, idx:%d\n", idx);

  if (--idx) {
    struct event *timeout = (struct event *)arg;
    struct timeval tv;
    tv.tv_sec = 2;
    tv.tv_usec = 0;
    event_add(timeout, &tv);
  }
}

int32_t main(int32_t argc, char **argv) {
  int flags = 0;
  idx = 5;

  /* Initalize the event library */
  struct event_base *base = event_base_new();

  /* Initalize one event */
  struct event timeout;
  event_assign(&timeout, base, -1, flags, timeout_cb, (void *)&timeout);

  struct timeval tv;
  tv.tv_sec = 2;
  tv.tv_usec = 0;
  event_add(&timeout, &tv);

  event_base_dispatch(base);

  return 0;
}
