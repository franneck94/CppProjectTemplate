if(ENABLE_TESTING)
    set(TEST_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/main.cc")
    set(TEST_HEADERS "")

    add_executable(${UNIT_TEST_NAME} ${TEST_SOURCES} ${TEST_HEADERS})

    target_link_libraries(${UNIT_TEST_NAME} PUBLIC ${LIBRARY_NAME})
    target_link_libraries(${UNIT_TEST_NAME} PRIVATE Catch2::Catch2)

    target_set_warnings(
        TARGET
        ${UNIT_TEST_NAME}
        ENABLE
        ${ENABLE_WARNINGS}
        AS_ERRORS
        ${ENABLE_WARNINGS_AS_ERRORS})

    if(ENABLE_COVERAGE)
        set(COVERAGE_MAIN "coverage")
        set(COVERAGE_EXCLUDES
            "${PROJECT_SOURCE_DIR}/app/*"
            "${PROJECT_SOURCE_DIR}/cmake/*"
            "${PROJECT_SOURCE_DIR}/docs/*"
            "${PROJECT_SOURCE_DIR}/external/*"
            "${PROJECT_SOURCE_DIR}/tests/*"
            "${PROJECT_SOURCE_DIR}/build/*"
            "/usr/include/*")
        setup_target_for_coverage_lcov(
            NAME
            ${COVERAGE_MAIN}
            EXECUTABLE
            ${UNIT_TEST_NAME}
            DEPENDENCIES
            ${UNIT_TEST_NAME})
    endif()
endif()
