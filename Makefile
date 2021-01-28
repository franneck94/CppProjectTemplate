install:
	@sudo apt-get install gcovr lcov

setup:
	@pip install conan
	@conan user

prepare:
	@rm -rf build
	@mkdir build
	@cd build && conan install .. && cd ..
