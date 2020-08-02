add_executable(${MAIN} "main.cc")
target_link_libraries(${MAIN} PUBLIC ${LIBRARY_NAME})
target_compile_features(${MAIN} PUBLIC cxx_std_17)
