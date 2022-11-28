if(ENABLE_CCACHE)
    find_program(CCACHE_FOUND ccache)
    if(CCACHE_FOUND)
        set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
        set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
    else()
        message("Ccache not found.")
    endif()
endif()

# Clang Tidy for "all" build
if(ENABLE_CLANG_TIDY)
    if(CMake_SOURCE_DIR STREQUAL CMake_BINARY_DIR)
        message(FATAL_ERROR "CMake_RUN_CLANG_TIDY requires an out-of-source build!")
    endif()
    find_program(CLANG_TIDY_BIN NAMES clang-tidy)
    if(NOT CLANG_TIDY_BIN)
        message(WARNING "CMake_RUN_CLANG_TIDY is ON but clang-tidy is not found!")
        set(CMAKE_CXX_CLANG_TIDY "" CACHE STRING "" FORCE)
        endif()

    set(CLANGTIDY_EXTRA_ARGS_BEFORE
        "--extra-arg-before=-std=${CMAKE_CXX_STANDARD}")

    # Clang Tidy while Building
    set(CMAKE_CXX_CLANG_TIDY
        "${CLANG_TIDY_BIN}"
        ${CLANGTIDY_EXTRA_ARGS_BEFORE}
        ${CLANGTIDY_EXTRA_ARGS})
endif()

# iwyu, clang-tidy and cppcheck for certain targets
function(add_target_static_analyers target)
  get_target_property(TARGET_SOURCES ${target} SOURCES)
  # Include only cc/cpp files
  # message(BEFORE: ${SOURCES}  -- ${TARGET_SOURCES})
  list(FILTER TARGET_SOURCES INCLUDE REGEX \.*\.\(cc|h|cpp|hpp\))
  # message(AFTER: ${SOURCES}  -- ${TARGET_SOURCES})

  if(ENABLE_INCLUDE_WHAT_YOU_USE)
    find_program(INCLUDE_WHAT_YOU_USE include-what-you-use)
    if(INCLUDE_WHAT_YOU_USE)
        add_custom_target(${target}_iwyu
        COMMAND ${CMAKE_SOURCE_DIR}/tools/iwyu_tool.py
            -p ${CMAKE_BINARY_DIR}
            ${TARGET_SOURCES}
            --
            -Xiwyu --quoted_includes_first
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        USES_TERMINAL
        )
    else()
        message("INCLUDE_WHAT_YOU_USE NOT FOUND")
    endif()
  endif()

  if(ENABLE_CPPCHECK)
    find_program(CPPCHECK cppcheck)
    if(CPPCHECK)
        # TO DO: Analyzes all files from compilation database rather than just the TARGET_SOURCES
        add_custom_target(${target}_cppcheck
        COMMAND ${CPPCHECK}
            ${TARGET_SOURCES}
            --inline-suppr
            --enable=all
            --project=${CMAKE_BINARY_DIR}/compile_commands.json
            -i${CMAKE_BINARY_DIR}/
            -i${CMAKE_SOURCE_DIR}/external/
        USES_TERMINAL
        )
    else()
        message("CPPCHECK NOT FOUND")
    endif()
  endif()

  if(ENABLE_CLANG_TIDY)
    find_program(CLANGTIDY clang-tidy)
    if(CLANGTIDY)
        get_target_property(TARGET_SOURCES ${target} SOURCES)

        add_custom_target(${target}_clangtidy
        COMMAND ${CMAKE_SOURCE_DIR}/tools/run-clang-tidy.py
            ${TARGET_SOURCES}
            -config-file=${CMAKE_SOURCE_DIR}/.clang-tidy
            -extra-arg-before=-std=${CMAKE_CXX_STANDARD}
            -header-filter="\(src|app\)\/*.\(h|hpp\)"
            -p=${CMAKE_BINARY_DIR}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        USES_TERMINAL
        )
    else()
        message("CLANGTIDY NOT FOUND")
    endif()
  endif()

  if(ENABLE_CLANG_FORMAT)
    find_program(CLANGFORMAT clang-format)
    if(CLANGFORMAT)
        get_target_property(TARGET_SOURCES ${target} SOURCES)

        add_custom_target(${target}_clangformat
        COMMAND ${CMAKE_SOURCE_DIR}/tools/run-clang-format.py
            ${TARGET_SOURCES}
            --in-place
            -style=${CMAKE_SOURCE_DIR}/.clang-format
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        USES_TERMINAL
        )
    else()
        message("CLANGFORMAT NOT FOUND")
    endif()
  endif()
endfunction()
