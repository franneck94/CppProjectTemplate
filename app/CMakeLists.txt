# Sources
set (APP_SOURCES "main.cc")

# Executable
add_executable(${EXECUTABLE_NAME} ${APP_SOURCES})

# Main Executable
target_link_libraries(${EXECUTABLE_NAME} PUBLIC ${LIBRARY_NAME})
target_include_directories(${EXECUTABLE_NAME} PUBLIC ${PROJECT_BINARY_DIR})
target_compile_features(${LIBRARY_NAME} PUBLIC cxx_std_17)
target_set_warnings(TARGET ${EXECUTABLE_NAME} ENABLE OFF AS_ERROR OFF)
