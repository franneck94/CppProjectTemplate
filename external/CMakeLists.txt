add_library(${LIBRARY_LINALG} INTERFACE)
target_include_directories(${LIBRARY_LINALG} INTERFACE linalg)
target_set_warnings(${LIBRARY_LINALG})

file(GLOB LOGURU_SOURCES
    "loguru/*.cpp"
)
add_library(${LIBRARY_LOG} STATIC ${LOGURU_SOURCES})
target_include_directories(${LIBRARY_LOG} PUBLIC loguru)
if(NOT WIN32)
    target_link_libraries(${LIBRARY_LOG} PUBLIC pthread dl)
endif()
target_set_warnings(${LIBRARY_LOG})

if (USE_BENCHMARKS)
    add_subdirectory(Celero)
    target_set_warnings(Celero)
endif()