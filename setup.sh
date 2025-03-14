#!/usr/bin/env bash

set -e

install_missing_packages() {
    local packages=("$@")
    local missing_packages=()

    for package in "${packages[@]}"; do
        if ! dpkg -l $package > /dev/null 2>&1; then
            missing_packages+=($package)
        fi
    done

    if [ ${#missing_packages[@]} -ne 0 ]; then
        echo "Installing missing packages: ${missing_packages[@]}"
        sudo apt-get install -y "${missing_packages[@]}"
    fi
}

if [ ! -f /tmp/updated ]; then
    sudo bash -c "apt update && apt upgrade -y && apt install -y apt-file && apt-file update"
    touch /tmp/updated
fi

install_missing_packages "build-essential" "git" "libpng-dev" "cmake-curses-gui" "cmake" "clang-18" "clang-format-18" "clang-tools-18"

cd $(dirname $0)
ROOT_DIR="$(pwd)"
cd - > /dev/null

cd ${ROOT_DIR}
mkdir -p tmp
cd tmp

if [ ! -d "rgbds-prefix" ]; then
    if [ ! -d "rgbds" ]; then
    git clone https://github.com/rednex/rgbds.git
    fi

    rm -rf rgbds-build rgbds-prefix
    mkdir -p rgbds-build
    cd rgbds-build

    cmake ../rgbds \
    -DCMAKE_INSTALL_PREFIX=$(pwd)/../rgbds-prefix \
    -DCMAKE_CXX_COMPILER=$(which clang++-18) \
    -DCMAKE_BUILD_TYPE=Release

    make -j$(nproc) VERBOSE=1
    make install
fi