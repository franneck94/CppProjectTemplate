# ---- Sources ----

set(TEST_SOURCES "main.cc")

# ---- Executable ----

add_executable(${TEST_MAIN} ${TEST_SOURCES})

# ---- Settings ----


target_link_libraries(${TEST_MAIN} PRIVATE ${LIBRARY_NAME} ${CONAN_Catch2})
target_compile_options(${TEST_MAIN} PUBLIC ${TEST_FLAGS})
target_compile_features(${TEST_MAIN} PUBLIC cxx_std_17)
target_set_warnings(TARGET ${TEST_MAIN} ENABLE OFF AS_ERROR OFF)

# ---- Test ----

enable_testing()
add_test(NAME ${LIBRARY_NAME}.${TEST_MAIN} COMMAND ${TEST_MAIN})

# ---- Coverage ----

if(ENABLE_COVERAGE)
    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        set(COVERAGE_MAIN "${PROJECT}_coverage")
        set(COVERAGE_LCOV_EXCLUDES
            "${PROJECT_SOURCE_DIR}/app/*"
            "${PROJECT_SOURCE_DIR}/benchmarks/*"
            "${PROJECT_SOURCE_DIR}/external/*"
            "${PROJECT_SOURCE_DIR}/tests/*"
            "${CONAN_BOOST_ROOT}/*"
            "${CONAN_CATCH2_ROOT}/*"
            "${CONAN_CXXOPTS_ROOT}/*"
            "${CONAN_CELERO_ROOT}/*"
            "/usr/include/*"))
        setup_target_for_coverage_lcov(
            NAME ${COVERAGE_MAIN}
            EXECUTABLE ctest
            DEPENDENCIES ${TEST_MAIN})
    endif()
endif()
