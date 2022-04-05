if (ENABLE_TESTING)
    set(TEST_MAIN
        "unit_tests")
    set(TEST_SOURCES
        "main.cc")

    add_executable(${TEST_MAIN}
        ${TEST_SOURCES})

    target_link_libraries(${TEST_MAIN} PUBLIC
        ${LIBRARY_NAME})
    target_link_libraries(${TEST_MAIN} PRIVATE
        ${CONAN_CATCH2})

    if (${ENABLE_WARNINGS})
        target_set_warnings(TARGET ${TEST_MAIN} ENABLE ON AS_ERROR OFF)
    endif()

    if (ENABLE_COVERAGE)
        set(COVERAGE_MAIN "coverage")
        set(COVERAGE_EXCLUDES
            "${PROJECT_SOURCE_DIR}/app/*"
            "${PROJECT_SOURCE_DIR}/cmake/*"
            "${PROJECT_SOURCE_DIR}/docs/*"
            "${PROJECT_SOURCE_DIR}/external/*"
            "${PROJECT_SOURCE_DIR}/tests/*"
            "${CONAN_CATCH2_ROOT}/*"
            "${CONAN_CXXOPTS_ROOT}/*"
            "/usr/include/*")
        setup_target_for_coverage_lcov(
            NAME ${COVERAGE_MAIN}
            EXECUTABLE ${TEST_MAIN}
            DEPENDENCIES ${TEST_MAIN}
        )
    endif()
endif()
