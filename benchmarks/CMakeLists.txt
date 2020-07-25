cmake_minimum_required(VERSION 3.8.2)

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
    target_link_libraries(${BENCH_MAIN} PUBLIC celero)

    set_target_properties(${BENCH_MAIN} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
    set_target_properties(${BENCH_MAIN} PROPERTIES 
        CXX_STANDARD ${CXX_STD} 
        CXX_STANDARD_REQUIRED ${CXX_STD_REQ}
    )
endif()
