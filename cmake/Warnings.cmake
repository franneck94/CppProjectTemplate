function(target_set_warnings)

    if(NOT ENABLE_WARNINGS)
        return()
    endif()

    set(oneValueArgs TARGET ENABLE AS_ERROR)
    cmake_parse_arguments(target_set_warnings "" "${oneValueArgs}" "" ${ARGN} )

    if(NOT ${target_set_warnings_ENABLE})
        return()
    endif()

    set(MSVC_WARNINGS
        /W4 # Baseline reasonable warnings
        /w14242 # 'identifier': conversion from 'type1' to 'type1', possible loss of data
        /w14263 # 'function': member function does not override any base class virtual member function
        /w14265 # 'classname': class has virtual functions, but destructor is not virtual
        /w14287 # 'operator': unsigned/negative constant mismatch
        /w14296 # 'operator': expression is always 'boolean_value'
        /w14311 # 'variable': pointer truncation from 'type1' to 'type2'
        /w14826 # Conversion from 'type1' to 'type_2' is sign-extended. This may cause unexpected runtime behavior.
        /w14928 # illegal copy-initialization; more than one user-defined conversion has been implicitly applied
        /w44062 # enumerator 'identifier' in a switch of enum 'enumeration' is not handled
        /w44242 # 'identifier': conversion from 'type1' to 'type2', possible loss of data
        /permissive- # standards conformance mode for MSVC compiler.
    )

    set(CLANG_WARNINGS
        -Wall
        -Wextra # reasonable and standard
        -Wshadow # warn the user if a variable declaration shadows one from a parent context
        -Wnon-virtual-dtor # warn the user if a class with virtual functions has a non-virtual destructor
        -Wold-style-cast # warn for c-style casts
        -Wcast-align # warn for potential performance problem casts
        -Wunused # warn on anything being unused
        -Woverloaded-virtual # warn if you overload (not override) a virtual function
        -Wpedantic # warn if non-standard is used
        -Wconversion # warn on type conversions that may lose data
        -Wnull-dereference # warn if a null dereference is detected
        -Wformat=2 # warn on security issues around functions that format output (ie printf)
    )

    set(GCC_WARNINGS
        ${CLANG_WARNINGS}
    )

    if(${target_set_warnings_AS_ERROR})
        set(CLANG_WARNINGS ${CLANG_WARNINGS} -Werror)
        set(GCC_WARNINGS ${GCC_WARNINGS} -Werror)
        set(MSVC_WARNINGS ${MSVC_WARNINGS} /WX)
    endif()

    if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        set(PROJECT_WARNINGS ${MSVC_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        set(PROJECT_WARNINGS ${CLANG_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        set(PROJECT_WARNINGS ${GCC_WARNINGS})
    endif()

    target_compile_options(${target_set_warnings_TARGET} PRIVATE ${PROJECT_WARNINGS})

endfunction(target_set_warnings)
