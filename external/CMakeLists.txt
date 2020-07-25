# --------------------------------------------------------------------------------
#                                 Linalg
# --------------------------------------------------------------------------------
add_library(${LINALG_LIB} INTERFACE)
target_include_directories(${LINALG_LIB} INTERFACE ${LINALG_LIB})

# --------------------------------------------------------------------------------
#                                 Loguru
# --------------------------------------------------------------------------------
file(GLOB LOGURU_SOURCES
    "loguru/*.cpp"
)
add_library(${LOGURU_LIB} STATIC ${LOGURU_SOURCES})
target_include_directories(${LOGURU_LIB} PUBLIC ${LOGURU_LIB})
if(NOT WIN32)
    target_link_libraries(${LOGURU_LIB} PUBLIC pthread dl)
endif()

# --------------------------------------------------------------------------------
#                                 Celero
# --------------------------------------------------------------------------------
if (USE_BENCHMARKS)
    add_subdirectory(Celero)
endif()
