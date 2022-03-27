# Sources and Headers
set(LIBRARY_SOURCES "my_lib.cc")
set(LIBRARY_HEADERS "my_lib.h")
set(LIBRARY_INCLUDES "./")

# MyLib Library
add_library(${LIBRARY_NAME} ${LIBRARY_SOURCES} ${LIBRARY_HEADERS})
target_include_directories(${LIBRARY_NAME} PUBLIC ${LIBRARY_INCLUDES})
target_link_libraries(${LIBRARY_NAME} PUBLIC
    ${JSON_LIB})
target_set_warnings(TARGET ${LIBRARY_NAME} ENABLE OFF AS_ERROR OFF)

if(${ENABLE_LTO})
target_enable_lto(${LIBRARY_NAME} optimized)
endif()
