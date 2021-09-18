# Linalg
set(LIBRARY_INCLUDES "linalg/")
add_library(linalg INTERFACE)
target_include_directories(linalg SYSTEM INTERFACE ${LIBRARY_INCLUDES})

# Loguru
set(LOGURU_SOURCES "loguru/loguru.cpp")
set(LOGURU_HEADERS "loguru/loguru.hpp")
set(LOGURU_INCLUDES "loguru/")
add_library(loguru ${LOGURU_SOURCES} ${LOGURU_HEADERS})
target_include_directories(loguru PUBLIC ${LOGURU_INCLUDES})
find_package(Threads)
target_link_libraries(loguru ${CMAKE_THREAD_LIBS_INIT}) # For pthreads
if(NOT WIN32)
    target_link_libraries(loguru dl) # For ldl
endif()
