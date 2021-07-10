FROM ubuntu:18.04
RUN dpkg --add-architecture i386 &&\
    apt update &&\
    apt -y install build-essential python git wget curl zip unzip gcc g++ gcc-multilib g++-multilib pkg-config ninja-build &&\
    apt clean
RUN cd / &&\
    git clone --depth 1 -b my_crosscompile https://github.com/Nemirtingas/vcpkg.git vcpkg &&\
    cd /vcpkg &&\
    ./bootstrap-vcpkg.sh -disableMetrics &&\
    ln -s /vcpkg/vcpkg /usr/bin/ &&\
    ln -s /vcpkg/downloads/tools/cmake-*-linux/cmake-*-Linux-x86_64/bin/cmake /usr/bin/
