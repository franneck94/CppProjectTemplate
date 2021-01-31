# Sources
set (APP_SOURCES "main.cc")

# Executable
add_executable(${MAIN} ${APP_SOURCES})

# Main Executable
target_link_libraries(${MAIN} PUBLIC ${LIBRARY_NAME})
target_include_directories(${MAIN} PUBLIC ${PROJECT_BINARY_DIR})
target_compile_features(${LIBRARY_NAME} PUBLIC cxx_std_17)
target_set_warnings(TARGET ${MAIN} ENABLE OFF AS_ERROR OFF)
