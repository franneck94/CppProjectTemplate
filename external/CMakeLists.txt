# --------------------------------------------------------------------------------
#                                 LinAlg
# --------------------------------------------------------------------------------
add_library(linalg INTERFACE)
target_include_directories(linalg INTERFACE linalg)
# --------------------------------------------------------------------------------
#                                 Loguru
# --------------------------------------------------------------------------------
file(GLOB LOGURU_SOURCES
    "loguru/*.cpp"
)
add_library(loguru STATIC ${LOGURU_SOURCES})
target_include_directories(loguru PUBLIC loguru)
if(NOT WIN32)
    target_link_libraries(loguru PUBLIC pthread dl)
endif()

# --------------------------------------------------------------------------------
#                                 Celero
# --------------------------------------------------------------------------------
if (USE_BENCHMARKS)
    add_subdirectory(Celero)
endif()
