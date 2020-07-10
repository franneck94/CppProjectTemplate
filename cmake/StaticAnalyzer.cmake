if(ENABLE_CPPCHECK)
  if(UNIX)
    find_program(CMAKE_CXX_CPPCHECK NAMES cppcheck)
    if (CMAKE_CXX_CPPCHECK)
        list(
            APPEND CMAKE_CXX_CPPCHECK 
                "--enable=warning"
                "--inconclusive"
                "--force" 
                "--inline-suppr"
                "--suppressions-list=${CMAKE_SOURCE_DIR}/CppCheckSuppressions.txt"
        )
    endif()
  endif()
endif()
