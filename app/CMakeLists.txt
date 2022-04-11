set (APP_SOURCES "main.cc")

add_executable(${EXECUTABLE_NAME} ${APP_SOURCES})

target_link_libraries(${EXECUTABLE_NAME} PUBLIC
    ${LIBRARY_NAME}
    fmt::fmt
    spdlog::spdlog_header_only
    nlohmann_json
    ${CONAN_CXXOPTS}
)

if (${ENABLE_WARNINGS})
    target_set_warnings(TARGET ${EXECUTABLE_NAME} ENABLE ON AS_ERROR OFF)
endif()
