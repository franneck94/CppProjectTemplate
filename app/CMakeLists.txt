set (APP_SOURCES "main.cc")

add_executable(${EXECUTABLE_NAME} ${APP_SOURCES})

target_link_libraries(${EXECUTABLE_NAME} PUBLIC
    ${LIBRARY_NAME}
    nlohmann_json::nlohmann_json
    fmt::fmt
    spdlog::spdlog
    cxxopts::cxxopts)

if (${ENABLE_WARNINGS})
    target_set_warnings(TARGET ${EXECUTABLE_NAME} ENABLE ON AS_ERROR OFF)
endif()

add_target_static_analyers(${EXECUTABLE_NAME})
