#include <iostream>
#include <string>
#include <thread>

#include <zmq.h>

void ServerThread() {
  void* context = zmq_ctx_new();

  void* responder = zmq_socket(context, ZMQ_REP);

  zmq_bind(responder, "tcp://*:5555");

  while (true) {
    char buffer[10];
    zmq_recv(responder, buffer, 10, 0);
    std::cout << "Server received: " << buffer << std::endl;

    zmq_send(responder, "Hello", 5, 0);
  }

  zmq_close(responder);
  zmq_ctx_destroy(context);
}

void ClientThread() {
  void* context = zmq_ctx_new();

  void* requester = zmq_socket(context, ZMQ_REQ);

  zmq_connect(requester, "tcp://localhost:5555");

  while (true) {
    zmq_send(requester, "World", 5, 0);

    char buffer[10];
    zmq_recv(requester, buffer, 10, 0);
    std::cout << "Client received: " << buffer << std::endl;

    std::this_thread::sleep_for(std::chrono::seconds(1));
  }

  zmq_close(requester);
  zmq_ctx_destroy(context);
}

int main() {
  // 创建三个线程
  std::thread server_thread(ServerThread);
  std::thread client_thread(ClientThread);

  // 等待线程结束
  server_thread.join();
  client_thread.join();

  return 0;
}
