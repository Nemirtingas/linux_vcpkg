set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86)

set(CLANG_TRIPLE i686-linux-gnu)
set(DEFAULT_SIMD_ARCH "haswell")

include("${CMAKE_CURRENT_LIST_DIR}/linux-common-clang.cmake")
