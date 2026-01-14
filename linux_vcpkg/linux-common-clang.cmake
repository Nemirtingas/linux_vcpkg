macro(cmake_get_optional VAR DEFAULT)
  if(NOT DEFINED ${VAR})
    if(DEFINED ENV{${VAR}})
      set(${VAR} "$ENV{${VAR}}" CACHE STRING "${VAR}")
      message(STATUS "Using ${VAR} from env: ${${VAR}}")
    else()
      set(${VAR} "${DEFAULT}" CACHE STRING "${VAR}")
      message(STATUS "Using default ${VAR}: ${DEFAULT}")
    endif()
  endif()
endmacro()

macro(cmake_get_required VAR)
  if(NOT DEFINED ${VAR})
    if(DEFINED ENV{${VAR}})
      set(${VAR} "$ENV{${VAR}}" CACHE STRING "${VAR}")
      message(STATUS "Found ${VAR}: ${${VAR}}")
    else()
      message(FATAL_ERROR
        "Required variable ${VAR} is not set.\n"
        "Please define it with:\n"
        "  -D${VAR}=value\n"
        "or via environment variable ${VAR}"
      )
    endif()
  endif()
endmacro()

function(_append_compile_flags_unique var)
    foreach(flag IN LISTS ARGN)
        if(NOT "${${var}}" MATCHES "(^|;| )${flag}($|;| )")
            list(APPEND ${var} "${flag}")
        endif()
    endforeach()
    set(${var} "${${var}}" PARENT_SCOPE)
endfunction()

cmake_get_required(CLANG_TRIPLE)
cmake_get_optional(LLVM_LTO OFF)
cmake_get_optional(SIMD_ARCH "${DEFAULT_SIMD_ARCH}")

find_program(CLANG_PATH NAMES clang)
if("${CLANG_PATH}" STREQUAL "CLANG_PATH-NOTFOUND")
  message(FATAL_ERROR "Unable to find clang")
endif()

find_program(CLANGXX_PATH NAMES clang++)
if("${CLANGXX_PATH}" STREQUAL "CLANGXX_PATH-NOTFOUND")
  message(FATAL_ERROR "Unable to find clang++")
endif()

find_program(LLVM_AR_PATH NAMES llvm-ar)
if("${LLVM_AR_PATH}" STREQUAL "LLVM_AR_PATH-NOTFOUND")
  message(FATAL_ERROR "Unable to find llvm-ar")
endif()

find_program(LLVM_RANLIB_PATH NAMES llvm-ranlib)
if("${LLVM_RANLIB_PATH}" STREQUAL "LLVM_RANLIB_PATH-NOTFOUND")
  message(FATAL_ERROR "Unable to find llvm-ranlib")
endif()

find_program(LLD_LINK_PATH NAMES lld-link)
if("${LLD_LINK_PATH}" STREQUAL "LLD_LINK_PATH-NOTFOUND")
  message(SEND_ERROR "Unable to find lld-link")
endif()

find_program(LLVM_NM_PATH NAMES llvm-nm)
if("${LLVM_NM_PATH}" STREQUAL "LLVM_NM_PATH-NOTFOUND")
  message(SEND_ERROR "Unable to find llvm-nm")
endif()

set(CMAKE_C_COMPILER   "${CLANG_PATH}"       CACHE FILEPATH "")
set(CMAKE_CXX_COMPILER "${CLANGXX_PATH}"     CACHE FILEPATH "")
set(CMAKE_AR           "${LLVM_AR_PATH}"     CACHE FILEPATH "")
set(CMAKE_RANLIB       "${LLVM_RANLIB_PATH}" CACHE FILEPATH "")
set(CMAKE_LINKER       "${LLD_LINK_PATH}"    CACHE FILEPATH "")
set(CMAKE_LINKER_LLD   "${LLD_LINK_PATH}"    CACHE FILEPATH "")
set(CMAKE_NM           "${LLVM_NM_PATH}"     CACHE FILEPATH "")
set(CMAKE_LINKER_TYPE  "LLD" CACHE STRING "")

set(CMAKE_C_COMPILER_TARGET   "${CLANG_TRIPLE}")
set(CMAKE_CXX_COMPILER_TARGET "${CLANG_TRIPLE}")

if(LLVM_LTO)
  string(TOLOWER "${LLVM_LTO}" _LLVM_LTO)
  if(_LLVM_LTO STREQUAL "on" OR _LLVM_LTO STREQUAL "1")
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE CACHE BOOL "")
  endif()
endif()

if(${CMAKE_INTERPROCEDURAL_OPTIMIZATION})
  message(STATUS "LTO: Enabled")
else()
  message(STATUS "LTO: Disabled")
endif()

set(_CMAKE_COMPILE_FLAGS)

if(SIMD_ARCH)
  list(APPEND _CMAKE_COMPILE_FLAGS "-march=${SIMD_ARCH}")
endif()

_append_compile_flags_unique(CMAKE_C_FLAGS_INIT   ${_CMAKE_COMPILE_FLAGS})
_append_compile_flags_unique(CMAKE_CXX_FLAGS_INIT ${_CMAKE_COMPILE_FLAGS})

if(DEFINED ENV{VCPKG_TOOLCHAIN} AND NOT "$ENV{VCPKG_TOOLCHAIN}" STREQUAL "")
  message(STATUS "Including VCPKG toolchain: $ENV{VCPKG_TOOLCHAIN}")
  include($ENV{VCPKG_TOOLCHAIN})
endif()