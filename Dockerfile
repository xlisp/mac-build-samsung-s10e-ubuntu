FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    bc \
    bison \
    flex \
    libncurses-dev \
    libssl-dev \
    device-tree-compiler \
    git \
    wget \
    curl \
    unzip \
    xz-utils \
    ccache \
    python3 \
    python3-pip \
    clang \
    llvm \
    gcc \
    g++ \
    android-sdk-libsparse-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
CMD ["/bin/bash"]

