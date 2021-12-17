#include <cstdio>
#include <sstream>
#include <vector>

#include "test.pb.h"

using namespace std;

int32_t main(int32_t argc, char** argv) {
  GOOGLE_PROTOBUF_VERIFY_VERSION;

  test::testmsg msg;
  msg.set_id(1234);
  msg.set_name("testname");
  msg.set_age(18);

  stringstream ss;

  msg.SerializeToOstream(&ss);

  test::testmsg msg2;
  msg2.ParseFromIstream(&ss);
  printf("msg2.id() = %llu\n", msg2.id());
  printf("msg2.name() = %s\n", msg2.name().c_str());
  printf("msg2.age() = %d\n", msg2.age());

  google::protobuf::ShutdownProtobufLibrary();

  return 0;
}
