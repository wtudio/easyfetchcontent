#include <iostream>
#include <sstream>
#include <thread>
#include <vector>

#include "asio.hpp"

int32_t main(int32_t argc, char** argv) {
  uint32_t n = 2;
  asio::io_context io(n);
  asio::steady_timer t(io);

  asio::co_spawn(
      io,
      [&t]() -> asio::awaitable<void> {
        try {
          for (uint32_t ii = 0; ii < 5; ++ii) {
            std::stringstream ss;
            ss << "thread " << std::this_thread::get_id() << " run, index " << ii << "\n";
            std::cerr << ss.str();

            t.expires_after(std::chrono::seconds(1));
            co_await t.async_wait(asio::use_awaitable);
          }
        } catch (const std::exception& e) {
          std::cerr << "get exception:" << e.what() << '\n';
        }
        co_return;
      },
      asio::detached);

  std::list<std::thread> threads_;

  for (uint32_t ii = 0; ii < n; ++ii) {
    threads_.emplace(threads_.end(), [&io] {
      std::stringstream ss;

      ss << "thread " << std::this_thread::get_id() << " start.\n";
      std::cerr << ss.str();

      io.run();

      ss.str("");
      ss << "thread " << std::this_thread::get_id() << " exit.\n";
      std::cerr << ss.str();
    });
  }

  for (auto itr = threads_.begin(); itr != threads_.end();) {
    itr->join();
    threads_.erase(itr++);
  }
  return 0;
}