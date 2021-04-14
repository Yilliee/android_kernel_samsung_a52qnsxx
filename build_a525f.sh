#!/bin/bash -x

export ARCH=arm64

BUILD_CROSS_COMPILE=../toolchains/aarch64-linux-android-4.9/bin/aarch64-linux-android-

KERNEL_LLVM_BIN=../toolchains/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04/bin/clang
CLANG_TRIPLE=aarch64-linux-gnu-

KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

# If not cleaning the tree between builds, the following command will be
# required on 2nd and subsequent builds to prevent a huge slowdown of the
# build.
#
# find techpack -type f -name \*.o | xargs rm -f

make REAL_CC=$KERNEL_LLVM_BIN mrproper

touch .scmversion

make -j$(nproc) $KERNEL_MAKE_ENV CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE CFP_CC=$KERNEL_LLVM_BIN a52q_eur_open_defconfig

make -j$(nproc) $KERNEL_MAKE_ENV CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE CFP_CC=$KERNEL_LLVM_BIN
