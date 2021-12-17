#include <benchmark/benchmark.h>

#include "mybenchlib.hpp"

static void BM_BubbleSort(benchmark::State& state) {
  auto sort_size = state.range(0);
  std::vector<int> vec(static_cast<uint32_t>(sort_size));

  for (auto _ : state) {
    state.PauseTiming();
    std::generate(vec.begin(), vec.end(), [] { return rand(); });
    state.ResumeTiming();

    BubbleSort(vec.data(), vec.size());
  }
}
BENCHMARK(BM_BubbleSort)->RangeMultiplier(8)->Range(128, 1024);

static void BM_MergeSort(benchmark::State& state) {
  auto sort_size = state.range(0);
  std::vector<int> vec(static_cast<uint32_t>(sort_size));

  for (auto _ : state) {
    state.PauseTiming();  // 暂停计时
    std::generate(vec.begin(), vec.end(), [] { return rand(); });
    state.ResumeTiming();  // 恢复计时

    MergeSort(vec.data(), vec.size());
  }
}
BENCHMARK(BM_MergeSort)->RangeMultiplier(8)->Range(128, 1024);

BENCHMARK_MAIN();
