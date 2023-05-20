# Software Installation

## How to install VCPKG

Official Link: <https://vcpkg.io/en/index.html>

```cmd
cd external
git clone https://github.com/Microsoft/vcpkg.git
.\vcpkg\bootstrap-vcpkg.bat # windows
./vcpkg/bootstrap-vcpkg.sh # Unix
```

## How to install the Conan Package Manager

Official installation guide is [here](https://docs.conan.io/2/).

The conan database is [here](https://conan.io/center/).

### Installation Steps

1. Install Python (3.7+)
2. Type ``pip install --user -U conan`` into the terminal
   1. Unix: Append conan to the PATH by: ``source ~/.profile``
3. Run the conan command: ``conan``
4. conan profile detect --force
5. conan profile path default

## Formatter and Static Analyzer

### Tooling

Clang-Format: Formatting tool for your C/C++ code:

- Documentation for Clang-Format: [Link](https://clang.llvm.org/docs/ClangFormat.html)

Clang-Tidy: Static linting tool for your C/C++ code:

- Documentation for Clang-Tidy: [Link](https://clang.llvm.org/extra/clang-tidy/)

Cmake-Format:

```bash
pip install cmake-format # python 3.7+
```

### Install Clang Tools

It's included in the LLVM toolchain, but also installable by apt, brew, winget etc.

https://github.com/llvm/llvm-project/releases/tag/llvmorg-16.0.0
