#include <iostream>

#include <stdexec/execution.hpp>

#include "exec/static_thread_pool.hpp"

using namespace stdexec;
using stdexec::sync_wait;

int main() {
  exec::static_thread_pool ctx{8};
  scheduler auto sch = ctx.get_scheduler();                               // 1
                                                                          //
  sender auto begin = schedule(sch);                                      // 2
  sender auto hi_again = then(                                            // 3
      begin,                                                              // 3
      [] {                                                                // 3
        std::cout << "Hello world! Have an int.\n";                       // 3
        return 13;                                                        // 3
      });                                                                 // 3
                                                                          //
  sender auto add_42 = then(hi_again, [](int arg) { return arg + 42; });  // 4
                                                                          //
  auto [i] = sync_wait(std::move(add_42)).value();                        // 5
  std::cout << "Result: " << i << std::endl;

  // Sync_wait provides a run_loop scheduler
  std::tuple<run_loop::__scheduler> t = sync_wait(get_scheduler()).value();
  (void)t;

  auto y = let_value(get_scheduler(), [](auto sched) {
    return on(sched, then(just(), [] {
                std::cout << "from run_loop\n";
                return 42;
              }));
  });
  sync_wait(std::move(y));

  sync_wait(when_all(just(42), get_scheduler(), get_stop_token()));
}