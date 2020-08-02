if (USE_BENCHMARKS)
    set(BENCHFILES main.cc)
    set(BENCH_MAIN "${NAME}_benchmarks")
    set(BENCH_RUNNER_PARAMS "-O3")

    # cd build
    # cmake .. -DCMAKE_BUILD_TYPE=Release -DUSE_BENCHMARKS=On
    # make BenchAndLog_benchmarks
    add_executable(${BENCH_MAIN} ${BENCHFILES})
    target_compile_options(${BENCH_MAIN} PUBLIC ${TEST_RUNNER_PARAMS})
    target_compile_features(${BENCH_MAIN} PUBLIC cxx_std_17)
    target_link_libraries(${BENCH_MAIN} PUBLIC ${LIBRARY_NAME})
    target_link_libraries(${BENCH_MAIN} PUBLIC ${LIBRARY_BENCH})
endif()
