include(Catch)

add_executable(UnitTestFoo "test_foo.cc")
target_link_libraries(UnitTestFoo PUBLIC ${LIB_FOO_NAME})
target_link_libraries(UnitTestFoo PRIVATE Catch2::Catch2WithMain)

add_executable(UnitTestBar "test_bar.cc")
target_link_libraries(UnitTestBar PUBLIC ${LIB_BAR_NAME})
target_link_libraries(UnitTestBar PRIVATE Catch2::Catch2WithMain)

target_set_warnings(
    TARGET
    UnitTestFoo
    ENABLE
    ${ENABLE_WARNINGS}
    AS_ERRORS
    ${ENABLE_WARNINGS_AS_ERRORS})
target_set_warnings(
    TARGET
    UnitTestBar
    ENABLE
    ${ENABLE_WARNINGS}
    AS_ERRORS
    ${ENABLE_WARNINGS_AS_ERRORS})

catch_discover_tests(UnitTestFoo)
catch_discover_tests(UnitTestBar)

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
    set(COVERAGE_DEPENDENCIES UnitTestFoo UnitTestBar)

    setup_target_for_coverage_lcov(
        NAME
        ${COVERAGE_MAIN}
        EXECUTABLE
        ctest
        DEPENDENCIES
        ${COVERAGE_DEPENDENCIES}
        LCOV_ARGS
        --rc
        lcov_branch_coverage=1
        GENHTML_ARGS
        --branch-coverage
        --legend
        --title
        "CPP Project Demo Coverage")
endif()
