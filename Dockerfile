ARG CLANG_VER
ARG UBUNTU_VER
FROM nemirtingas/nemirtingas_compilation_base:ubuntu${UBUNTU_VER}_clang${CLANG_VER}
COPY install.sh /install.sh
COPY linux_vcpkg /linux_vcpkg
RUN /install.sh && rm install.sh
