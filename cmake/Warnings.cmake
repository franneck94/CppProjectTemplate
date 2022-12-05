function(target_set_warnings)
    set(oneValueArgs TARGET ENABLE AS_ERRORS)
    cmake_parse_arguments(
        TARGET_SET_WARNINGS
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN})

    if(NOT ${TARGET_SET_WARNINGS_ENABLE})
        message("==> Warnings Disabled for: ${TARGET_SET_WARNINGS_TARGET}")
        return()
    endif()
    message("==> Warnings Active for: ${TARGET_SET_WARNINGS_TARGET}")
    message("==> Warnings as Errors: ${TARGET_SET_WARNINGS_AS_ERRORS}")

    set(MSVC_WARNINGS
        # Baseline
        /W4 # Baseline reasonable warnings
        /permissive- # standards conformance mode for MSVC compiler
        # C and C++ Warnings
        /w14242 # conversion from 'type1' to 'type1', possible loss of data
        /w14287 # unsigned/negative constant mismatch
        /w14296 # expression is always 'boolean_value'
        /w14311 # pointer truncation from 'type1' to 'type2'
        /w14826 # Conversion from 'type1' to 'type_2' is sign-extended
        /w44062 # enumerator in a switch of enum 'enumeration' is not handled
        /w44242 # conversion from 'type1' to 'type2', possible loss of data
        # C++ Only
        /w14928 # more than one implicitly user-defined conversion
        /w14263 # function does not override any base class virtual function
        /w14265 # class has virtual functions, but destructor is not virtual
    )

    set(CLANG_WARNINGS
        # Baseline
        -Wall
        -Wextra # reasonable and standard
        -Wpedantic # warn if non-standard is used
        # C and C++ Warnings
        -Wshadow # if a variable declaration shadows one from a parent context
        -Wunused # warn on anything being unused
        -Wformat=2 # warn on security issues around functions that format output
        -Wcast-align # warn for potential performance problem casts
        -Wconversion # warn on type conversions that may lose data
        -Wnull-dereference # warn if a null dereference is detected
        # C++ Warnings
        -Wnon-virtual-dtor # if a class with virtual func has a non-virtual dest
        -Wold-style-cast # warn for c-style casts
        -Woverloaded-virtual # if you overload (not override) a virtual function
        -Weffc++ # violations from Scott Meyers’ Effective C++
    )

    set(GCC_WARNINGS ${CLANG_WARNINGS})

    if(${TARGET_SET_WARNINGS_AS_ERRORS})
        set(CLANG_WARNINGS ${CLANG_WARNINGS} -Werror)
        set(GCC_WARNINGS ${GCC_WARNINGS} -Werror)
        set(MSVC_WARNINGS ${MSVC_WARNINGS} /WX)
    endif()

    if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        set(WARNINGS ${MSVC_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        set(WARNINGS ${CLANG_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        set(WARNINGS ${GCC_WARNINGS})
    endif()

    target_compile_options(${TARGET_SET_WARNINGS_TARGET} PRIVATE ${WARNINGS})

endfunction(target_set_warnings)
