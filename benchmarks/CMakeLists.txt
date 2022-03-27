set(BENCHMARK_SOURCES "main.cc")

add_executable(${BENCHMARK_MAIN}
    ${BENCHMARK_SOURCES})

target_link_libraries(${BENCHMARK_MAIN} PUBLIC
    ${LIBRARY_NAME}
    ${CONAN_LIBS_CELERO})
