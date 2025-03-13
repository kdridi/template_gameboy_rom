#!/usr/bin/env bash

set -e

install_missing_packages() {
    local packages=("$@")
    local missing_packages=()

    sudo apt-get update
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

install_missing_packages "build-essential" "git" "curl" "wget"

cd $(dirname $0)
ROOT_DIR="$(pwd)"
cd - > /dev/null

cd ${ROOT_DIR}
mkdir -p tmp
cd tmp

if [ ! -d "rgbds" ]; then
  git clone https://github.com/rednex/rgbds.git
fi
