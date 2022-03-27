set (APP_SOURCES "main.cc")

add_executable(${EXECUTABLE_NAME} ${APP_SOURCES})

target_link_libraries(${EXECUTABLE_NAME} PUBLIC ${LIBRARY_NAME})
target_set_warnings(TARGET ${EXECUTABLE_NAME} ENABLE OFF AS_ERROR OFF)
