cmake_minimum_required(VERSION 3.8.2)

# List all files containing tests. (Change as needed)
set(TESTFILES
    main.cc
    test_dummy.cc
)

set(TEST_MAIN unit_tests)   # Default name for test executable (change if you wish).
set(TEST_RUNNER_PARAMS "-g3 -O0")  # Any arguemnts to feed the test runner (change as needed).

# --------------------------------------------------------------------------------
#                         Make Tests
# --------------------------------------------------------------------------------
add_executable(${TEST_MAIN} ${TESTFILES})

if(WIN32)
    target_link_libraries(${TEST_MAIN} PRIVATE ${LIBRARY_NAME} gtest)
endif(WIN32)
if(UNIX)
    target_link_libraries(${TEST_MAIN} PRIVATE ${LIBRARY_NAME} gtest pthread)
endif(UNIX)

set_target_properties(${TEST_MAIN} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})

add_test(
    # Use some per-module/project prefix so that it is easier to run only tests for this module
    NAME ${LIBRARY_NAME}.${TEST_MAIN}
    COMMAND ${TEST_MAIN} ${TEST_RUNNER_PARAMS}
)

if (USE_GCOV)
    if(CMAKE_COMPILER_IS_GNUCXX)
        set(GCC_COVERAGE_COMPILE_FLAGS  "-g3 -O0 -fprofile-arcs -ftest-coverage")
        set(GCC_COVERAGE_LINK_FLAGS     "-lgcov")
        set(CMAKE_CXX_FLAGS             "${CMAKE_CXX_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}" )
        set(CMAKE_EXE_LINKER_FLAGS      "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}")
        include(CodeCoverage)
        set(COVERAGE_EXCLUDES
            "${PROJECT_SOURCE_DIR}/external/*"
            "${PROJECT_SOURCE_DIR}/app/*"
            "${PROJECT_SOURCE_DIR}/benchmarks/*"
            "${CONAN_GTEST_ROOT}/*"
        )
        setup_target_for_coverage_lcov(
            NAME coverage
            EXECUTABLE ctest -j 2
            DEPENDENCIES ${TEST_MAIN}
        )
    endif()
endif()
