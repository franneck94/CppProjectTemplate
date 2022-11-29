set(APP_SOURCES "main.cc")

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
    AS_ERROR
    ${ENABLE_WARNINGS_AS_ERRORS})
add_tool_to_target(${EXECUTABLE_NAME})
