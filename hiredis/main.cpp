#include <string>

#include "hiredis.h"

using namespace std;

int32_t main(int32_t argc, char **argv) {
  redisContext *c = nullptr;
  redisReply *reply = nullptr;

  // connect
  c = redisConnect("127.0.0.1", 6379);
  if (c == nullptr || c->err) {
    if (c) {
      printf("Connection error: %s\n", c->errstr);
      redisFree(c);
    } else {
      printf("Connection error: can't allocate redis context\n");
    }
    exit(1);
  }

  // ping
  reply = static_cast<redisReply *>(redisCommand(c, "PING"));
  if (reply == nullptr) {
    printf("PING failed, no rsp\n");
  } else {
    printf("PING: %s\n", reply->str);
    freeReplyObject(reply);
  }

  // set
  reply = static_cast<redisReply *>(redisCommand(c, "SET %s %s", "foo", "hello world"));
  if (reply == nullptr) {
    printf("SET failed, no rsp\n");
  } else {
    printf("SET: %s\n", reply->str);
    freeReplyObject(reply);
  }

  // get
  reply = static_cast<redisReply *>(redisCommand(c, "GET foo"));
  if (reply == nullptr) {
    printf("GET failed, no rsp\n");
  } else {
    printf("GET foo: %s\n", reply->str);
    freeReplyObject(reply);
  }

  // Disconnects and frees the context
  redisFree(c);

  return 0;
}
