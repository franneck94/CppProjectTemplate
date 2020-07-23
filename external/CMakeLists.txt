add_library(linalg INTERFACE)
target_include_directories(linalg INTERFACE linalg)

add_library(loguru STATIC loguru/loguru.cpp)
target_include_directories(loguru PUBLIC loguru)
