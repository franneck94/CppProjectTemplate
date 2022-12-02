function(add_cmake_format_target)
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
    message("CMAKE_FILES: ${CMAKE_FILES}")
    find_program(CMAKE_FORMAT cmake-format)
    if(CMAKE_FORMAT)
        message("---> CMAKE_FORMAT FOUND")
        set(FORMATTTING_COMMANDS)
        foreach(cmake_file ${CMAKE_FILES})
            list(
                APPEND
                FORMATTTING_COMMANDS
                COMMAND
                cmake-format
                -c
                ${CMAKE_SOURCE_DIR}/.cmake-format.yaml
                -i
                ${cmake_file})
        endforeach()
        add_custom_target(
            run_cmake_format
            COMMAND ${FORMATTTING_COMMANDS}
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
    else()
        message("---> CMAKE_FORMAT NOT FOUND")
    endif()
endfunction()

# iwyu, clang-tidy and cppcheck
function(add_tool_to_target target)
    get_target_property(TARGET_SOURCES ${target} SOURCES)
    list(
        FILTER
        TARGET_SOURCES
        INCLUDE
        REGEX
        "\.*\.\(cc|h|cpp|hpp\)")

    if(ENABLE_INCLUDE_WHAT_YOU_USE)
        find_program(INCLUDE_WHAT_YOU_USE include-what-you-use)
        if(INCLUDE_WHAT_YOU_USE)
            add_custom_target(
                ${target}_iwyu
                COMMAND python ${CMAKE_SOURCE_DIR}/tools/iwyu_tool.py -p
                        ${CMAKE_BINARY_DIR} ${TARGET_SOURCES}
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
        else()
            message("---> INCLUDE_WHAT_YOU_USE NOT FOUND")
        endif()
    endif()

    if(ENABLE_CPPCHECK)
        find_program(CPPCHECK cppcheck)
        if(CPPCHECK)
            message("---> Added Cppcheck for Target: ${target}")
            add_custom_target(
                ${target}_cppcheck
                COMMAND
                    ${CPPCHECK} ${TARGET_SOURCES} --enable=all
                    --suppress=unusedFunction, --suppress=unmatchedSuppression,
                    --suppress=missingIncludeSystem, --suppress=toomanyconfigs,
                    --project=${CMAKE_BINARY_DIR}/compile_commands.json
                    -i${CMAKE_BINARY_DIR}/ -i${CMAKE_SOURCE_DIR}/external/
                USES_TERMINAL)
        else()
            message("---> CPPCHECK NOT FOUND")
        endif()
    endif()

    if(ENABLE_CLANG_TIDY)
        find_program(CLANGTIDY clang-tidy)
        if(CLANGTIDY)
            message("---> Added Clang Tidy for Target: ${target}")
            add_custom_target(
                ${target}_clangtidy
                COMMAND
                    ${CMAKE_SOURCE_DIR}/tools/run-clang-tidy.py
                    ${TARGET_SOURCES}
                    -config-file=${CMAKE_SOURCE_DIR}/.clang-tidy
                    -extra-arg-before=-std=${CMAKE_CXX_STANDARD}
                    -header-filter="\(src|app\)\/*.\(h|hpp\)"
                    -p=${CMAKE_BINARY_DIR}
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                USES_TERMINAL)
        else()
            message("---> CLANGTIDY NOT FOUND")
        endif()
    endif()

    if(ENABLE_CLANG_FORMAT)
        find_program(CLANGFORMAT clang-format)
        if(CLANGFORMAT)
            message("---> Added Clang Format for Target: ${target}")
            add_custom_target(
                ${target}_clangformat
                COMMAND ${CMAKE_SOURCE_DIR}/tools/run-clang-format.py
                        ${TARGET_SOURCES} --in-place
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                USES_TERMINAL)
        else()
            message("---> CLANGFORMAT NOT FOUND")
        endif()
    endif()
endfunction()
