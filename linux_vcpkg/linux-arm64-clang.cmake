set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

set(CLANG_TRIPLE aarch64-linux-gnu)
set(DEFAULT_SIMD_ARCH "")

include("${CMAKE_CURRENT_LIST_DIR}/linux-common-clang.cmake")
