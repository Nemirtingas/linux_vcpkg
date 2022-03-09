FROM ubuntu:18.04
RUN export DEBIAN_FRONTEND=noninteractive &&\
    export TZ=Etc/UTC &&\
    dpkg --add-architecture i386 &&\
    apt update &&\
    apt -y install build-essential python git wget curl zip unzip gcc g++ gcc-multilib g++-multilib pkg-config ninja-build &&\
    apt clean
RUN cd / &&\
    git clone --depth 1 -b my_crosscompile https://github.com/Nemirtingas/vcpkg.git vcpkg &&\
    cd /vcpkg &&\
    ./bootstrap-vcpkg.sh -disableMetrics &&\
    ln -s /vcpkg/vcpkg /usr/bin/ &&\
    vcpkg install vcpkg-cmake &&\
    ln -s /vcpkg/downloads/tools/cmake-*/cmake-*/bin/cmake /usr/bin/
