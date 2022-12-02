ifeq '$(findstring ;,$(PATH))' ';'
  CONAN_FLAGS = -s compiler='Visual Studio' -s compiler.version=16 -s cppstd=17 --build missing
else
  CONAN_FLAGS = -s cppstd=17 --build missing
endif

all: prepare_conan

install:
	sudo apt-get gcc g++ gdb cmake git make llvm install gcovr lcov pkg-config curl zip unzip tar doxygen python3-dev clang-format clang-tidy cppcheck iwyu

install_pip:
	pip install jinja2 Pygments cmake-format pre-commit conan --user

install_doc:
	sudo apt-get install doxygen
	pip install jinja2 Pygments

setup:
	pip install conan
	conan user

prepare:
	rm -rf build
	mkdir build

prepare_conan:
	rm -rf build
	mkdir build
	cd build && conan install .. $(CONAN_FLAGS)
