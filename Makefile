all: prepare_conan

install:
	sudo apt-get install gcovr lcov

install_doc:
	pip install jinja2 Pygments
	sudo apt-get install doxygen

setup:
	pip install conan
	conan user

prepare_conan:
	rm -rf build
	mkdir build
	ifeq '$(findstring ;,$(PATH))' ';'  # Windows
		cd build && conan install ..  -s compiler='Visual Studio' -s compiler.version=16
	else
		cd build && conan install ..
	endif

prepare_vcpkg:
	rm -rf build
	mkdir build

install_vcpkg_win:
	vcpkg install --triplet x64-windows

install_vcpkg_linux:
	vcpkg install --triplet x64-linux

install_vcpkg_mac:
	vcpkg install --triplet x64-macos

build_vcpkg:
	cd build && cmake -S.. -B. -DUSE_CONAN=OFF -DCMAKE_TOOLCHAIN_FILE:STRING="/home/jan/cpp/vcpkg/scripts/buildsystems/vcpkg.cmake"
	cd build && cmake --build .
