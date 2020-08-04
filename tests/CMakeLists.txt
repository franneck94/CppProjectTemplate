set(TESTFILES main.cc)
set(TEST_MAIN "${NAME}_unit_tests")
set(TEST_RUNNER_PARAMS "-O0;-g3")
add_executable(${TEST_MAIN} ${TESTFILES})

if(WIN32)
    target_link_libraries(${TEST_MAIN} PRIVATE ${LIBRARY_NAME} gtest)
endif()
if(UNIX)
    target_link_libraries(${TEST_MAIN} PRIVATE ${LIBRARY_NAME} gtest pthread)
endif()

set_target_properties(${TEST_MAIN} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
target_compile_options(${TEST_MAIN} PUBLIC ${TEST_RUNNER_PARAMS})
target_compile_features(${TEST_MAIN} PUBLIC cxx_std_17)

add_test(NAME ${LIBRARY_NAME}.${TEST_MAIN} COMMAND ${TEST_MAIN})

# sudo apt-get install lcov (for macos with brew)
# sudo apt-get install gcov (for macos with brew)
if (USE_GCOV)
    if (${CMAKE_CXX_COMPILER_ID} MATCHES "GNU|Clang")
        set(COVERAGE_MAIN "${NAME}_coverage")
        set(COVERAGE_EXCLUDES 
            "${PROJECT_SOURCE_DIR}/app/*"
            "${PROJECT_SOURCE_DIR}/benchmarks/*"
            "${PROJECT_SOURCE_DIR}/external/*"
            "${PROJECT_SOURCE_DIR}/tests/*"
            "${CONAN_GTEST_ROOT}/*"
            "${CONAN_BOOST_ROOT}/*"
            "/usr/include/*")
        # cd build
        # cmake .. -DCMAKE_BUILD_TYPE=Coverage -DUSE_GCOV=On
        # make CppTemplate_coverage
        setup_target_for_coverage_lcov(
            NAME ${COVERAGE_MAIN}
            EXECUTABLE ctest -j ${ProcessorCount}
            DEPENDENCIES ${TEST_MAIN})
    endif()
endif()
