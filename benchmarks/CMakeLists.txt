# List all files containing benchmarks. (Change as needed)
set(BENCHFILES        # All .cc files in benchmarks/
    main.cc
)

set(BENCH_MAIN bench_tests)  # Default name for benchmark executable (change if you wish).
set(BENCH_RUNNER_PARAMS "")  # Any arguemnts to feed the benchmark runner (change as needed).

# --------------------------------------------------------------------------------
#                         Make Benchmarks (no change needed).
# --------------------------------------------------------------------------------
if (USE_BENCHMARKS)
    add_executable(${BENCH_MAIN} ${BENCHFILES})
    target_link_libraries(${BENCH_MAIN} PUBLIC ${LIBRARY_NAME})
    target_link_libraries(${BENCH_MAIN} PUBLIC ${CELERO_LIB})
endif()
