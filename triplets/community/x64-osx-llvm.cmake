set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)

set(VCPKG_CMAKE_SYSTEM_NAME Darwin)
set(VCPKG_OSX_ARCHITECTURES x86_64)

set(LLVM_PATH /usr/local/opt/llvm)

if(NOT DEFINED ENV{OT_OSX_LLVM_PATH})
  message(STATUS "Using the default homebrew llvm path.  You can set a custom location by setting the OT_OSX_LLVM_PATH environment variable.")
else()
  message(STATUS "Using the llvm path set with the OT_OSX_LLVM_PATH environment variable.")
  set(LLVM_PATH $ENV{OT_OSX_LLVM_PATH})
endif()

if(NOT DEFINED ENV{OT_OSX_LLVM_VERSION})
  message(STATUS "Using the default homebrew llvm version.  You can set a specific version by setting the OT_OSX_LLVM_VERSION environment variable.")
else()
  message(STATUS "Using the llvm version set with OT_OSX_LLVM_VERSION environment variable.")
  set(LLVM_PATH ${LLVM_PATH}@$ENV{OT_OSX_LLVM_VERSION})
endif()

if(NOT EXISTS ${LLVM_PATH})
  message(FATAL_ERROR "Cannot locate llvm build tools at ${LLVM_PATH}")
endif()

message(STATUS "Using build tools located at ${LLVM_PATH}")

set(VCPKG_CMAKE_CONFIGURE_OPTIONS -DCMAKE_C_COMPILER=${LLVM_PATH}/bin/clang -DCMAKE_CXX_COMPILER=${LLVM_PATH}/bin/clang++ -DCMAKE_CXX_COMPILER_LINKER=${LLVM_PATH}/bin/ld64.lld -DCMAKE_AR=${LLVM_PATH}/bin/llvm-ar -DCMAKE_RANLIB=${LLVM_PATH}/bin/llvm-ranlib)
set(VCPKG_C_FLAGS -I${LLVM_PATH}/include)
set(VCPKG_CXX_FLAGS -I${LLVM_PATH}/include)
set(VCPKG_LINKER_FLAGS "-L${LLVM_PATH}/lib/c++ -L${LLVM_PATH}/lib -L${LLVM_PATH}/lib/unwind -lunwind")

if(DEFINED ENV{OT_OSX_DEPLOYMENT_TARGET})
  message(STATUS "Using $ENV{OT_OSX_DEPLOYMENT_TARGET} for VCPKG_OSX_DEPLOYMENT_TARGET")

  set(CMAKE_OSX_DEPLOYMENT_TARGET "$ENV{OT_OSX_DEPLOYMENT_TARGET}")
  set(VCPKG_OSX_DEPLOYMENT_TARGET "$ENV{OT_OSX_DEPLOYMENT_TARGET}")
else()
  message(FATAL_ERROR "You must set OT_OSX_DEPLOYMENT_TARGET in the environment before using this triplet")
endif()

if(DEFINED ENV{XCODE_ROOT})
  set(SDKROOT "$ENV{XCODE_ROOT}/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk")
  set(ENV{SDKROOT} "${SDKROOT}")

  message(STATUS "Using MacOSX sdk at $ENV{SDKROOT}")
else()
  message(FATAL_ERROR "You must set XCODE_ROOT in the environment before using this triplet")
endif()
