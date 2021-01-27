conan_setup:
	@pip install conan
	@ conan user

prepare:
	@rm -r build
	@mkdir build
	@cd build && conan install .. && cd ..
