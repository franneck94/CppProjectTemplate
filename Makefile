ifeq '$(findstring ;,$(PATH))' ';'
  CONAN_FLAGS = -s compiler='Visual Studio' -s compiler.version=16 -s cppstd=17 --build missing
else
  CONAN_FLAGS = -s cppstd=17 --build missing
endif

all: prepare_conan

install:
	sudo apt-get install gcovr lcov pkg-config curl zip unzip tar ccache

install_doc:
	pip install jinja2 Pygments
	sudo apt-get install doxygen

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
