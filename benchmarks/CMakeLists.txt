if(ENABLE_BENCHMARKS)
    # ---- Sources ----

    set(BENCHMARK_SOURCES   "main.cc")

    # ---- Target ----

    set(BENCHMARK_MAIN      "${PROJECT}_benchmarks")
    add_executable(${BENCHMARK_MAIN} ${BENCHMARK_SOURCES})

    # ---- Settings ----

    if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        set(BENCHMARK_FLAGS "/Ox")
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        set(BENCHMARK_FLAGS "-O3")
    else()
        set(BENCHMARK_FLAGS "")
    endif()

    target_compile_options(${BENCHMARK_MAIN} PUBLIC ${BENCHMARK_FLAGS})
    target_compile_features(${BENCHMARK_MAIN} PUBLIC cxx_std_17)
    target_link_libraries(${BENCHMARK_MAIN} PUBLIC ${LIBRARY_NAME})
    target_link_libraries(${BENCHMARK_MAIN} PUBLIC ${CONAN_LIBS_CELERO})
    target_set_warnings(TARGET ${MAIN} ENABLE OFF AS_ERROR OFF)
endif()