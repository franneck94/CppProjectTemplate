OS_NAME := $(shell uname)
CPP_FILES=$(wildcard ./src/*.cc ./src/*.cpp ./include/*.h /include/*.hpp)

ifeq ($(OS), Windows_NT)
	PYTHON=python
	PIP=pip
	RM=rmdir /Q /S
else
	PYTHON=python3
	PIP=pip3
	RM=sudo rm -r
endif

help:
	@echo "Some available commands:"
	@echo " * prepare-build         - Remove old build dir, create new build dir, install conan deps"
	@echo " * cpplint-run          	- Run the cpplint tool (python3 needed)"
	@echo " * cpplint-install       - Install the cpplint tool (python3 needed)"
	@echo " * cppcheck-run  		- Run the cppcheck tool (Unix only)"
	@echo " * cppcheck-install    	- Install the cppcheck tool (Unix only)"

prepare-build:
	@$(RM) build
	@mkdir build
	@cd build && conan install ..

cpplint-run:
	@cpplint --linelength=120 $(CPP_FILES)

cpplint-install:
	@$(PIP) install cpplint

cppcheck-run:
ifeq ($(OS_NAME), Linux)
	@cppcheck src/* include/* --language=c++ --std=c++17
else
	@echo "Not available!"
endif

cppcheck-install:
ifeq ($(OS_NAME), Linux)
	@sudo apt-get install cppcheck
else
	@echo "Not available!"
endif