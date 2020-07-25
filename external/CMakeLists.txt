# --------------------------------------------------------------------------------
#                                 LinAlg
# --------------------------------------------------------------------------------
add_library(linalg INTERFACE)
target_include_directories(linalg INTERFACE linalg)
target_compile_features(linalg INTERFACE "cxx_std_${CXX_STD}")
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
target_compile_features(loguru INTERFACE "cxx_std_${CXX_STD}")

# --------------------------------------------------------------------------------
#                                 Celero
# --------------------------------------------------------------------------------
if (USE_BENCHMARKS)
    add_subdirectory(Celero)
endif()
