cmake_minimum_required(VERSION 3.8.2)

# List all files containing tests. (Change as needed)
set(TESTFILES        # All .c files in tests/
    main.c
    test_dummy.c
)

set(TEST_MAIN unit_tests)   # Default name for test executable (change if you wish).
set(TEST_RUNNER_PARAMS "-g3 -O0 -Wall -fprofile-arcs -ftest-coverage")  # Any arguemnts to feed the test runner (change as needed).

# --------------------------------------------------------------------------------
#                         Make Tests (no change needed).
# --------------------------------------------------------------------------------
add_executable(${TEST_MAIN} ${TESTFILES})
target_link_libraries(${TEST_MAIN} PRIVATE ${LIBRARY_NAME})

set_target_properties(${TEST_MAIN} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set_target_properties(${TEST_MAIN} PROPERTIES 
    C_STANDARD 11 
    C_STANDARD_REQUIRED YES
)

add_test(
    # Use some per-module/project prefix so that it is easier to run only tests for this module
    NAME ${LIBRARY_NAME}.${TEST_MAIN}
    COMMAND ${TEST_MAIN} ${TEST_RUNNER_PARAMS}
)

# Adds a 'coverage' target.
if (CMAKE_COMPILER_IS_GNUCC)
    include(CodeCoverage)
    setup_target_for_coverage_lcov(
        NAME coverage
        EXECUTABLE ctest -j 2
        DEPENDENCIES ${TEST_MAIN}
    )
endif()
