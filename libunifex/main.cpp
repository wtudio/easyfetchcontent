#include <iostream>

#include <unifex/execute.hpp>
#include <unifex/scheduler_concepts.hpp>
#include <unifex/single_thread_context.hpp>

using namespace std;
using namespace unifex;

int32_t main(int32_t argc, char** argv) {
  std::cout << "[run in thread " << std::this_thread::get_id() << "] main\n";

  single_thread_context ctx;

  for (int i = 0; i < 5; ++i) {
    execute(ctx.get_scheduler(), [i]() {
      std::cout << "[run in thread " << std::this_thread::get_id() << "] hello execute() " << i << "\n";
    });
  }

  return 0;
}
