ARG CLANG_VER
ARG UBUNTU_VER
FROM nemirtingas_compilation_base:ubuntu${UBUNTU_VER}_clang${CLANG_VER}
ARG CLANG_VER
ARG MSVC_VER
ENV CLANG_VER         ${CLANG_VER}
ENV LLVM_VER          ${CLANG_VER}
RUN export DEBIAN_FRONTEND=noninteractive &&\
    dpkg --add-architecture i386 &&\
    apt-get update &&\
    apt-get install -y gcc g++ libc6-dev libc6-dev:i386 g++-multilib gcc-multilib libgl1-mesa-dev libgl1-mesa-dev:i386 &&\
    apt-get clean
