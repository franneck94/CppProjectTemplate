ifeq '$(findstring ;,$(PATH))' ';'
  CONAN_FLAGS = -s compiler.cppstd=17
else
  CONAN_FLAGS = -s compiler.cppstd=17
endif

all: prepare

install_min:
	sudo apt-get install gcc g++ cmake make doxygen

install_tests: install_min
	sudo apt-get install gcovr lcov

install: install_min install_tests
	sudo apt-get install git llvm pkg-config curl zip unzip tar python3-dev clang-format clang-tidy

install_pip:
	pip install jinja2 Pygments cmake-format pre-commit

install_doc: install_min
	sudo apt-get install doxygen
	pip install jinja2 Pygments

setup:
	pip install --user -U conan

prepare:
	rm -rf build
	mkdir build

prepare_conan:
	rm -rf build
	mkdir build
	cd build && conan install .. $(CONAN_FLAGS) --build missing
