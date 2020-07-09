@ECHO ON

RMDIR /Q /S build
MKDIR build
PUSHD build

conan install ..
cd ..
