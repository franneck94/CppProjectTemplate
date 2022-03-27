# json
set(JSON_LIB json)
add_library(${JSON_LIB} INTERFACE)
target_include_directories(${JSON_LIB} INTERFACE "json")
target_set_warnings(TARGET ${JSON_LIB} ENABLE OFF AS_ERROR OFF)
