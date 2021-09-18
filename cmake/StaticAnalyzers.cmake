if(ENABLE_CLANG_TIDY)
    find_program(CLANGTIDY clang-tidy)
    if(CLANGTIDY)
        set(CLANGTIDY_EXTRA_ARGS
            "-extra-arg=-Wno-unknown-warning-option")
        set(CLANGTIDY_EXTRA_ARGS_BEFORE
            "--extra-arg-before=-std=${CMAKE_CXX_STANDARD}")
        set(CMAKE_CXX_CLANG_TIDY
            ${CLANGTIDY}
            ${CLANGTIDY_EXTRA_ARGS_BEFORE}
            ${CLANGTIDY_EXTRA_ARGS}
            ${CLANGTIDY_IGNORE})
        message("Clang-Tidy finished setting up.")
    else()
        message("Clang-Tidy executable not found..")
    endif()
endif()

if(ENABLE_CPPCHECK)
    find_program(CPPCHECK cppcheck)
    if(CPPCHECK)
        set(CMAKE_CXX_CPPCHECK ${CPPCHECK} --suppress=missingInclude --enable=all)
        message("Cppcheck finished setting up.")
    else()
        message("Cppcheck executable not found..")
    endif()
endif()
