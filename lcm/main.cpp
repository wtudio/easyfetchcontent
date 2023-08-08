#include <atomic>
#include <iostream>
#include <string>
#include <thread>

#include <lcm/lcm-cpp.hpp>

using namespace std;

atomic_bool stop_flag;

void PublishThread() {
  lcm::LCM lcm;
  if (!lcm.good())
    return;

  string topic = "test_topic";

  uint32_t count = 0;
  while (!stop_flag) {
    string s = "hello " + to_string(count++);
    cout << "lcm publish [" + topic + "][" + s << +"]" << endl;
    lcm.publish(topic, s.c_str(), s.size());
    this_thread::sleep_for(chrono::milliseconds(100));
  }

  cout << "Exit publish thread" << endl;
}

void Handle(const lcm::ReceiveBuffer* rbuf, const string& topic, void*) {
  cout << "lcm recv [" + topic + "][" + string(static_cast<const char*>(rbuf->data), rbuf->data_size) + "]" << endl;
}

void SubscribeThread() {
  lcm::LCM lcm;
  if (!lcm.good())
    return;

  string topic = "test_topic";

  lcm.subscribeFunction(topic, Handle, static_cast<void*>(nullptr));

  while (!stop_flag) {
    lcm.handleTimeout(1000);
  }

  cout << "Exit subscribe thread" << endl;
}

int32_t main(int32_t argc, char** argv) {
  stop_flag = false;

  thread t1(SubscribeThread);

  this_thread::sleep_for(chrono::seconds(1));

  thread t2(PublishThread);

  this_thread::sleep_for(chrono::seconds(5));

  stop_flag = true;

  t2.join();
  t1.join();

  return 0;
}
