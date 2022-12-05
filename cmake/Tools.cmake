function(add_cmake_format_target)
    if(NOT ${ENABLE_CMAKE_FORMAT})
        return()
    endif()
    set(ROOT_CMAKE_FILES "${CMAKE_SOURCE_DIR}/CMakeLists.txt")
    file(GLOB_RECURSE CMAKE_FILES_TXT "*/CMakeLists.txt")
    file(GLOB_RECURSE CMAKE_FILES_C "cmake/*.cmake")
    list(
        FILTER
        CMAKE_FILES_TXT
        EXCLUDE
        REGEX
        "${CMAKE_SOURCE_DIR}/(build|external)/.*")
    set(CMAKE_FILES ${ROOT_CMAKE_FILES} ${CMAKE_FILES_TXT} ${CMAKE_FILES_C})
    find_program(CMAKE_FORMAT cmake-format)
    if(CMAKE_FORMAT)
        message("==> Added Cmake Format")
        set(FORMATTING_COMMANDS)
        foreach(cmake_file ${CMAKE_FILES})
            list(
                APPEND
                FORMATTING_COMMANDS
                COMMAND
                cmake-format
                -c
                ${CMAKE_SOURCE_DIR}/.cmake-format.yaml
                -i
                ${cmake_file})
        endforeach()
        add_custom_target(
            run_cmake_format
            COMMAND ${FORMATTING_COMMANDS}
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
    else()
        message("==> CMAKE_FORMAT NOT FOUND")
    endif()
endfunction()

function(add_clang_format_target)
    if(NOT ${ENABLE_CLANG_FORMAT})
        return()
    endif()
    find_package(Python3 COMPONENTS Interpreter)
    if(NOT ${Python_FOUND})
        return()
    endif()
    file(GLOB_RECURSE CMAKE_FILES_CC "*/*.cc")
    file(GLOB_RECURSE CMAKE_FILES_CPP "*/*.cpp")
    file(GLOB_RECURSE CMAKE_FILES_H "*/*.h")
    file(GLOB_RECURSE CMAKE_FILES_HPP "*/*.hpp")
    set(CPP_FILES
        ${CMAKE_FILES_CC}
        ${CMAKE_FILES_CPP}
        ${CMAKE_FILES_H}
        ${CMAKE_FILES_HPP})
    list(
        FILTER
        CPP_FILES
        EXCLUDE
        REGEX
        "${CMAKE_SOURCE_DIR}/(build|external)/.*")
    find_program(CLANGFORMAT clang-format)
    if(CLANGFORMAT)
        message("==> Added Clang Format")
        add_custom_target(
            run_clang_format
            COMMAND
                ${Python3_EXECUTABLE}
                ${CMAKE_SOURCE_DIR}/tools/run-clang-format.py ${CPP_FILES}
                --in-place
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            USES_TERMINAL)
    else()
        message("==> CLANGFORMAT NOT FOUND")
    endif()
endfunction()

# iwyu, clang-tidy and cppcheck
function(add_linter_tool_to_target target)
    if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        message(
            "==> Cppcheck, IWYU and Clang-Tidy Targets do not work with MSVC")
        return()
    endif()
    get_target_property(TARGET_SOURCES ${target} SOURCES)
    list(
        FILTER
        TARGET_SOURCES
        INCLUDE
        REGEX
        ".*.(cc|h|cpp|hpp)")

    if(ENABLE_CPPCHECK)
        find_program(CPPCHECK cppcheck)
        if(CPPCHECK)
            message("==> Added Cppcheck for Target: ${target}")
            add_custom_target(
                ${target}_cppcheck
                COMMAND
                    ${CPPCHECK} ${TARGET_SOURCES} --enable=all
                    --suppress=unusedFunction --suppress=unmatchedSuppression
                    --suppress=missingIncludeSystem --suppress=toomanyconfigs
                    --project=${CMAKE_BINARY_DIR}/compile_commands.json
                    -i${CMAKE_BINARY_DIR}/ -i${CMAKE_SOURCE_DIR}/external/
                USES_TERMINAL)
        else()
            message("==> CPPCHECK NOT FOUND")
        endif()
    endif()

    find_package(Python3 COMPONENTS Interpreter)
    if(NOT ${Python_FOUND})
        message("==> Python3 needed for IWYU and Clang-Tidy")
        return()
    endif()

    if(ENABLE_INCLUDE_WHAT_YOU_USE)
        if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
            find_program(INCLUDE_WHAT_YOU_USE include-what-you-use)
            if(INCLUDE_WHAT_YOU_USE)
                add_custom_target(
                    ${target}_iwyu
                    COMMAND
                        ${Python3_EXECUTABLE}
                        ${CMAKE_SOURCE_DIR}/tools/iwyu_tool.py -p
                        ${CMAKE_BINARY_DIR} ${TARGET_SOURCES}
                    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
            else()
                message("==> INCLUDE_WHAT_YOU_USE NOT FOUND")
            endif()
        else()
            message("==> INCLUDE_WHAT_YOU_USE NEEDS CLANG COMPILER")
        endif()
    endif()

    if(ENABLE_CLANG_TIDY)
        find_program(CLANGTIDY clang-tidy)
        if(CLANGTIDY)
            message("==> Added Clang Tidy for Target: ${target}")
            add_custom_target(
                ${target}_clangtidy
                COMMAND
                    ${Python3_EXECUTABLE}
                    ${CMAKE_SOURCE_DIR}/tools/run-clang-tidy.py
                    ${TARGET_SOURCES}
                    -config-file=${CMAKE_SOURCE_DIR}/.clang-tidy
                    -extra-arg-before=-std=${CMAKE_CXX_STANDARD}
                    -header-filter="\(src|app\)\/*.\(h|hpp\)"
                    -p=${CMAKE_BINARY_DIR}
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                USES_TERMINAL)
        else()
            message("==> CLANGTIDY NOT FOUND")
        endif()
    endif()
endfunction()

function(add_clang_tidy_msvc_to_target target)
    if(NOT
       CMAKE_CXX_COMPILER_ID
       MATCHES
       "MSVC")
        return()
    endif()
    if(ENABLE_CLANG_TIDY)
        message("==> Added MSVC ClangTidy (VS GUI only) for: ${target}")
        set_target_properties(
            ${target} PROPERTIES VS_GLOBAL_EnableMicrosoftCodeAnalysis false)
        set_target_properties(
            ${target} PROPERTIES VS_GLOBAL_EnableClangTidyCodeAnalysis true)
    endif()
endfunction(add_clang_tidy_msvc_to_target)
