#!/bin/bash

set -e
set -x

rm -rf build
mkdir build
pushd build

conan install ..
cd ..
