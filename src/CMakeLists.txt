# ---- Sources ----

set(LIBRARY_SOURCES  "my_lib.cc")
set(LIBRARY_INCLUDES "${PROJECT_SOURCE_DIR}/include/")
set(LIBRARY_HEADERS  "${PROJECT_SOURCE_DIR}/include/my_lib.h")

# ---- Target ----

add_library(${LIBRARY_NAME} ${LIBRARY_SOURCES} ${LIBRARY_HEADERS})
target_include_directories(${LIBRARY_NAME} PUBLIC ${LIBRARY_INCLUDES})
target_link_libraries(${LIBRARY_NAME} PUBLIC linalg)
target_link_libraries(${LIBRARY_NAME} PUBLIC loguru)
target_compile_features(${LIBRARY_NAME} PUBLIC cxx_std_17)
target_set_warnings(TARGET ${LIBRARY_NAME} ENABLE ON AS_ERROR OFF)
