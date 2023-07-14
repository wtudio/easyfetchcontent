#include "mybenchlib.hpp"

#include <cstring>
#include <vector>

void BubbleSort(int* arr, size_t len) {
  if (len < 2) return;
  using std::swap;
  for (size_t ii = 0; ii < len; ++ii) {
    for (size_t jj = 0; jj < len - 1 - ii; ++jj) {
      if (arr[jj] > arr[jj + 1]) {
        swap(arr[jj], arr[jj + 1]);
      }
    }
  }
}

void MergeSort(int* arr, size_t len) {
  if (len < 2) return;
  if (len == 2) {
    using std::swap;
    if (arr[0] > arr[1]) swap(arr[0], arr[1]);
    return;
  }
  size_t middle = len / 2;
  MergeSort(arr, middle);
  MergeSort(arr + middle, len - middle);

  std::vector<int> tmp_vec(len);
  size_t lc = 0, rc = middle, tc = 0;
  while ((lc < middle) && (rc < len)) {
    tmp_vec[tc++] = (arr[lc] < arr[rc]) ? arr[lc++] : arr[rc++];
  }
  if (rc == len) memcpy(arr + tc, arr + lc, (middle - lc) * sizeof(int));
  memcpy(arr, tmp_vec.data(), tc * sizeof(int));
}
