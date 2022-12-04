set(APP_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/main.cc")

add_executable(${EXECUTABLE_NAME} ${APP_SOURCES})

target_link_libraries(
    ${EXECUTABLE_NAME}
    PUBLIC ${LIBRARY_NAME}
           nlohmann_json::nlohmann_json
           fmt::fmt
           spdlog::spdlog
           cxxopts::cxxopts)

target_set_warnings(
    TARGET
    ${EXECUTABLE_NAME}
    ENABLE
    ${ENABLE_WARNINGS}
    AS_ERRORS
    ${ENABLE_WARNINGS_AS_ERRORS})
add_tool_to_target(${EXECUTABLE_NAME})

if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    add_clang_tidy_msvc_to_target(${EXECUTABLE_NAME})
endif()
