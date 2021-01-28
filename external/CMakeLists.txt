# ---- Linalg ----

set(LIBRARY_INCLUDES "linalg/")
add_library(linalg INTERFACE)
target_include_directories(linalg SYSTEM INTERFACE ${LIBRARY_INCLUDES})
target_set_warnings(TARGET linalg ENABLE OFF AS_ERROR OFF)

# ---- Loguru ----

file(GLOB LOGURU_SOURCES "loguru/loguru.cpp")
add_library(loguru STATIC ${LOGURU_SOURCES})
target_include_directories(loguru PUBLIC loguru)
if(UNIX)
    target_link_libraries(loguru PUBLIC pthread dl)
endif()
target_set_warnings(TARGET loguru ENABLE OFF AS_ERROR OFF)
