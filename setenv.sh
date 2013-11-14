#!/bin/sh
export VENDOR=fugu
export ARCH=arm 
export TOOLCHAIN=~/x-tools/arm-${VENDOR}-linux-gnueabi
export TOOLPREFIX=arm-${VENDOR}-linux-gnueabi
#export TOOLCHAIN=~/android-ndk-r8d/toolchains/arm-linux-androideabi-4.6/prebuilt/linux-x86
#export TOOLPREFIX=arm-linux-androideabi
export PATH=$PATH:${TOOLCHAIN}/bin:/usr/java/jdk1.6.0_21/bin
export CROSS_COMPILE=${TOOLCHAIN}/bin/${TOOLPREFIX}-
export CC=${TOOLCHAIN}/bin/${TOOLPREFIX}-gcc
export LD=${TOOLCHAIN}/bin/${TOOLPREFIX}-ld
export AR=${TOOLCHAIN}/bin/${TOOLPREFIX}-ar
export RANLIB=${TOOLCHAIN}/arm-${VENDOR}-linux-gnueabi/bin/ranlib
export PATH=$PATH:${TOOLCHAIN}/bin
export PATH=$PATH:${TOOLCHAIN}/
export PATH=$PATH:${TOOLCHAIN}/lib
#export CFLAGS="-mcpu=cortex-a8 -mfpu=neon -mfloat-abi=softfp -static -fstack-protector -fstack-protector-all -fno-gcse -fprefetch-loop-arrays --param l2-cache-size=512 --param l1-cache-size=64 --param simultaneous-prefetches=6 --param prefetch-latency=400 --param l1-cache-line-size=64"
export CFLAGS="-static -fstack-protector -fstack-protector-all -mfpu=neon -mcpu=cortex-a9"
export LDFLAGS="-static -z relro -z now -z muldefs"
export CPPFLAGS="-static"
export KBUILD_BUILD_HOST=fugu
export KBUILD_BUILD_USER=r

alias gcp='git cherry-pick -x '
alias rel='make -j20 CONFIG_NO_ERROR_ON_MISMATCH=y DISABLE_PAX_PLUGINS=y && cd release && ./repack_bootimg.sh 4.4 && cd ..'

echo "ARM environment set"
