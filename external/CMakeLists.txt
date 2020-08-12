# LinAlg
set(LIBRARY_INCLUDES "linalg/")
add_library(${LIBRARY_LINALG} INTERFACE)
target_include_directories(${LIBRARY_LINALG} SYSTEM INTERFACE ${LIBRARY_INCLUDES})
target_set_warnings(TARGET ${LIBRARY_LINALG} ENABLE OFF AS_ERROR OFF)

# Loguru
file(GLOB LOGURU_SOURCES "loguru/*.cpp")
add_library(${LIBRARY_LOG} STATIC ${LOGURU_SOURCES})
target_include_directories(${LIBRARY_LOG} PUBLIC loguru)
if(UNIX)
    target_link_libraries(${LIBRARY_LOG} PUBLIC pthread dl)
endif()
target_set_warnings(TARGET ${LIBRARY_LOG} ENABLE OFF AS_ERROR OFF)

# Celero
if(USE_BENCHMARKS)
    add_subdirectory(Celero)
    target_set_warnings(TARGET celero ENABLE OFF AS_ERROR OFF)
    add_library(${LIBRARY_BENCH} ALIAS celero)
endif()
