set (APP_SOURCES "main.cc")

add_executable(${EXECUTABLE_NAME} ${APP_SOURCES})

target_link_libraries(${EXECUTABLE_NAME} PUBLIC ${LIBRARY_NAME})
target_include_directories(${EXECUTABLE_NAME} PUBLIC ${PROJECT_BINARY_DIR})
target_set_warnings(TARGET ${EXECUTABLE_NAME} ENABLE OFF AS_ERROR OFF)
