# Sources
set(BENCHMARK_SOURCES "main.cc")

# Target
add_executable(${BENCHMARK_MAIN} ${BENCHMARK_SOURCES})

# Settings
target_compile_features(${BENCHMARK_MAIN} PUBLIC cxx_std_17)
target_link_libraries(${BENCHMARK_MAIN} PUBLIC ${LIBRARY_NAME})
target_link_libraries(${BENCHMARK_MAIN} PUBLIC ${CONAN_LIBS_CELERO})
