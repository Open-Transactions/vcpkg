set(VCPKG_ENV_PASSTHROUGH "OT_OSX_DEPLOYMENT_TARGET")
set(VCPKG_ENV_PASSTHROUGH_UNTRACKED "EXTERNAL_QT_DIR;XCODE_ROOT")

set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)

set(VCPKG_CMAKE_SYSTEM_NAME Darwin)
set(VCPKG_OSX_ARCHITECTURES x86_64)

set(VCPKG_C_FLAGS_DEBUG "-fno-omit-frame-pointer -fno-optimize-sibling-calls -fsanitize=address,undefined -fsanitize-address-use-after-scope -fno-sanitize-recover=all -fsanitize-recover=implicit-conversion -fsanitize-recover=signed-integer-overflow -fsanitize-recover=unsigned-integer-overflow -fno-sanitize=pointer-overflow")
set(VCPKG_CXX_FLAGS_DEBUG "-fno-omit-frame-pointer -fno-optimize-sibling-calls -fsanitize=address,undefined -fsanitize-address-use-after-scope -fno-sanitize-recover=all -fsanitize-recover=implicit-conversion -fsanitize-recover=signed-integer-overflow -fsanitize-recover=unsigned-integer-overflow -fno-sanitize=pointer-overflow")
set(VCPKG_LINKER_FLAGS_DEBUG "-fsanitize=address,undefined")

if(DEFINED ENV{OT_OSX_DEPLOYMENT_TARGET})
  message(STATUS "using $ENV{OT_OSX_DEPLOYMENT_TARGET} for VCPKG_OSX_DEPLOYMENT_TARGET")
  set(CMAKE_OSX_DEPLOYMENT_TARGET "$ENV{OT_OSX_DEPLOYMENT_TARGET}")
  set(VCPKG_OSX_DEPLOYMENT_TARGET "$ENV{OT_OSX_DEPLOYMENT_TARGET}")
else()
  message(FATAL_ERROR "you must set OT_OSX_DEPLOYMENT_TARGET in the environment before using this triplet")
endif()

if(NOT DEFINED ENV{XCODE_ROOT})
  message(FATAL_ERROR "you must set XCODE_ROOT in the environment before using this triplet")
endif()

set(SDKROOT "$ENV{XCODE_ROOT}/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk")
set(ENV{SDKROOT} "${SDKROOT}")
