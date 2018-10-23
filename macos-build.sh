#!/usr/bin/env bash

set -e

VERSION=$(cat src/cpp/flann/config.h | grep 'define FLANN_VERSION_' | sed 's/.*VERSION_ \"//g' | sed 's/\"//g')

rm -rf build
mkdir build
cd build

PACK_ROOT="deb"
DEBIAN_FOLDER="$PACK_ROOT/DEBIAN"
LOCAL_INSTALL="$PACK_ROOT/usr/local"
mkdir -p "$LOCAL_INSTALL"
LOCAL_INSTALL_FULL="$(pwd)"/"$LOCAL_INSTALL"

cmake .. -DBUILD_TESTS=OFF \
-DBUILD_PYTHON_BINDINGS=OFF -DBUILD_MATLAB_BINDINGS=OFF -DBUILD_EXAMPLES=OFF \
-DBUILD_DOC=OFF -DBUILD_CUDA_LIB=OFF -DUSE_OPENMP=OFF \
-DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$LOCAL_INSTALL_FULL" \
-DCMAKE_MACOSX_RPATH=1

make -j8
make install

