set(TEST_SOURCES "main.cc")
add_executable(${TEST_MAIN} ${TEST_SOURCES})

if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    set(TEST_FLAGS "/Od")
    target_link_libraries(${TEST_MAIN} PRIVATE ${LIBRARY_NAME} gtest)
elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    set(TEST_FLAGS "-O0;-g")
    target_link_libraries(${TEST_MAIN} PRIVATE ${LIBRARY_NAME} gtest pthread)
endif()

target_compile_options(${TEST_MAIN} PUBLIC ${TEST_FLAGS})
target_compile_features(${TEST_MAIN} PUBLIC cxx_std_17)
target_set_warnings(TARGET ${TEST_MAIN} ENABLE OFF AS_ERROR OFF)

add_test(NAME ${LIBRARY_NAME}.${TEST_MAIN} COMMAND ${TEST_MAIN})

# sudo apt-get install lcov (for macos with brew install lcov)
# sudo apt-get install gcovr (for macos with brew install gcovr)
if(USE_GCOV)
    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        set(COVERAGE_MAIN "${PROJECT}_coverage")
        set(COVERAGE_LCOV_EXCLUDES
            "${PROJECT_SOURCE_DIR}/external/*"
            "${PROJECT_SOURCE_DIR}/app/*"
            "${CONAN_GTEST_ROOT}/*"
            "${CONAN_BOOST_ROOT}/"
            "/usr/include/c++/*")
        # cd build
        # cmake -DCMAKE_BUILD_TYPE=Coverage -DUSE_GCOV=ON ..
        # cmake --build . --target BetterProjectStructure_coverage
        setup_target_for_coverage_lcov(
            NAME ${COVERAGE_MAIN}
            EXECUTABLE ctest
            DEPENDENCIES ${TEST_MAIN})
    endif()
endif()
