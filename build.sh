#!/bin/bash
rm -r build
mkdir build
cd build

conan install ..
cd ..
