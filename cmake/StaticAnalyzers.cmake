if(ENABLE_CLANG_TIDY)
    if(CMake_SOURCE_DIR STREQUAL CMake_BINARY_DIR)
        message(FATAL_ERROR "CMake_RUN_CLANG_TIDY requires an out-of-source build!")
    endif()
    find_program(CLANG_TIDY_COMMAND NAMES clang-tidy)
    if(NOT CLANG_TIDY_COMMAND)
        message(WARNING "CMake_RUN_CLANG_TIDY is ON but clang-tidy is not found!")
        set(CMAKE_CXX_CLANG_TIDY "" CACHE STRING "" FORCE)
    else()
        set(CLANGTIDY_EXTRA_ARGS
            "-extra-arg=-Wno-unknown-warning-option")
        set(CLANGTIDY_EXTRA_ARGS_BEFORE
            "--extra-arg-before=-std=${CMAKE_CXX_STANDARD}")
        set(CMAKE_CXX_CLANG_TIDY
            "${CLANG_TIDY_COMMAND}"
            ${CLANGTIDY_EXTRA_ARGS_BEFORE}
            ${CLANGTIDY_EXTRA_ARGS})
    endif()
endif()

if(ENABLE_CPPCHECK)
    find_program(CPPCHECK_BIN NAMES cppcheck)

    if(CPPCHECK_BIN)
        execute_process(COMMAND ${CPPCHECK_BIN} --version
            OUTPUT_VARIABLE CPPCHECK_VERSION
            ERROR_QUIET
            OUTPUT_STRIP_TRAILING_WHITESPACE)

        set(CPPCHECK_PROJECT_ARG "--project=${PROJECT_BINARY_DIR}/compile_commands.json")
        set(CPPCHECK_BUILD_DIR_ARG "--cppcheck-build-dir=${PROJECT_BINARY_DIR}/analysis/cppcheck" CACHE STRING "The build directory to use")

        set(CPPCHECK_ERROR_EXITCODE_ARG "--error-exitcode=0" CACHE STRING "The exitcode to use if an error is found")
        set(CPPCHECK_CHECKS_ARGS "--enable=all" CACHE STRING "Arguments for the checks to run")
        set(CPPCHECK_OTHER_ARGS "--suppress=missingIncludeSystem" CACHE STRING "Other arguments")
        set(_CPPCHECK_EXCLUDES)
        set(CPPCHECK_EXCLUDES
            ${CMAKE_SOURCE_DIR}/external
            ${CMAKE_BINARY_DIR}/
        )

        ## set exclude files and folders
        foreach(ex ${CPPCHECK_EXCLUDES})
            list(APPEND _CPPCHECK_EXCLUDES "-i${ex}")
        endforeach(ex)

        set(CPPCHECK_ALL_ARGS
            ${CPPCHECK_PROJECT_ARG}
            ${CPPCHECK_BUILD_DIR_ARG}
            ${CPPCHECK_ERROR_EXITCODE_ARG}
            ${CPPCHECK_CHECKS_ARGS}
            ${CPPCHECK_OTHER_ARGS}
            ${_CPPCHECK_EXCLUDES}
        )

        set(CPPCHECK_COMMAND
            ${CPPCHECK_BIN}
            ${CPPCHECK_ALL_ARGS}
        )

        file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/analysis/cppcheck)
        add_custom_target(cppcheck_analysis
            COMMAND ${CPPCHECK_COMMAND})
        message("Cppcheck finished setting up.")
    else()
        message("Cppcheck executable not found..")
    endif()
endif()
