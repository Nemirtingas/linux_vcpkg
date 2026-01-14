set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

set(CLANG_TRIPLE x86_64-linux-gnu)
set(DEFAULT_SIMD_ARCH "haswell")

include("${CMAKE_CURRENT_LIST_DIR}/linux-common-clang.cmake")
