# Sources and Headers
set(LIBRARY_SOURCES
    "my_lib.cc")
set(LIBRARY_HEADERS
    "my_lib.h")
set(LIBRARY_INCLUDES
    "./"
    "${CMAKE_BINARY_DIR}/configured_files/include")

# MyLib Library
add_library(${LIBRARY_NAME} STATIC
    ${LIBRARY_SOURCES}
    ${LIBRARY_HEADERS})
target_include_directories(${LIBRARY_NAME} PUBLIC
    ${LIBRARY_INCLUDES})
target_link_libraries(${LIBRARY_NAME} PRIVATE
    nlohmann_json)

if (${ENABLE_WARNINGS})
    target_set_warnings(TARGET ${LIBRARY_NAME} ENABLE ON AS_ERROR OFF)
endif()

if(${ENABLE_LTO})
    target_enable_lto(${LIBRARY_NAME} optimized)
endif()
