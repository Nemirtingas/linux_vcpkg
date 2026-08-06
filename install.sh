#! /bin/bash

export DEBIAN_FRONTEND=noninteractive &&\
dpkg --add-architecture i386 &&\
apt-get update &&\
apt-get install -y gcc g++ libc6-dev libgl1-mesa-dev &&\
apt-get install -y g++-multilib gcc-multilib libc6-dev:i386 libgl1-mesa-dev:i386 &&\
apt-get install -y libxcb1-dev:i386 libxcb-keysyms1-dev:i386 libxcb-xkb-dev:i386 libxcb-xinput-dev:i386 libxcb1-dev libxcb-keysyms1-dev libxcb-xkb-dev libxcb-xinput-dev &&\
apt-get install -y gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu linux-libc-dev-arm64-cross linux-libc++-dev-arm64-cross libgcc-13-dev-arm64-cross libstdc++-13-dev-arm64-cross &&\
apt-get clean &&\
ps=(
  "http://ports.ubuntu.com/pool/main/g/gcc-14/libstdc++6_14.2.0-4ubuntu2~24.04_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libx/libx11/libx11-dev_1.7.5-1_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libg/libglvnd/libgl1_1.4.0-1_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libx/libx11/libx11-6_1.7.5-1_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libx/libxau/libxau6_1.0.9-1build5_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libx/libxcb/libxcb1_1.14-3ubuntu3_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libx/libxdmcp/libxdmcp6_1.1.3-0ubuntu5_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libb/libbsd/libbsd0_0.11.5-1_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libm/libmd/libmd0_1.0.4-1build1_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libx/libxau/libxau-dev_1.0.9-1build5_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libx/libxcb/libxcb1-dev_1.14-3ubuntu3_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libx/libxdmcp/libxdmcp-dev_1.1.3-0ubuntu5_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libp/libpthread-stubs/libpthread-stubs0-dev_0.4-1build2_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libx/libxcb/libxcb-xinput-dev_1.15-1ubuntu2_arm64.deb"
  "http://ports.ubuntu.com/pool/main/libx/libxcb/libxcb-xkb-dev_1.15-1ubuntu2_arm64.deb"
  "https://ports.ubuntu.com/pool/main/x/xcb-util-keysyms/libxcb-keysyms1-dev_0.4.0-1build4_arm64.deb"
)


for p in "${ps[@]}"; do
  wget "$p"
  # Don't use dpkg -i, cause adding the arm64 architecture in dpkg is quite buggy
  dpkg-deb -xv *.deb /
  rm *.deb
done

ln -s libGL.so.1 /usr/lib/aarch64-linux-gnu/libGL.so