# LinAlg Target
set(LIBRARY_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/linalg")
set(LIBRARY_HEADERS  "${LIBRARY_INCLUDE_DIR}/linalg.h")
add_library(${LIBRARY_LINALG} INTERFACE)
target_include_directories(${LIBRARY_LINALG} SYSTEM INTERFACE 
                           $<BUILD_INTERFACE:${LIBRARY_INCLUDE_DIR}>  
                           $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}>)
target_set_warnings(TARGET ${LIBRARY_LINALG} ENABLE OFF AS_ERROR OFF)

# LinAlg Install
install(TARGETS ${LIBRARY_LINALG}
        EXPORT ${EXPORT_NAME})
install(FILES ${LIBRARY_HEADERS} 
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include)

# Loguru Target
set(LIBRARY_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/loguru")
set(LIBRARY_SOURCES  "${LIBRARY_INCLUDE_DIR}/loguru.cpp")
set(LIBRARY_HEADERS  "${LIBRARY_INCLUDE_DIR}/loguru.hpp")
add_library(${LIBRARY_LOG} SHARED ${LIBRARY_SOURCES} ${LIBRARY_HEADERS})
target_include_directories(${LIBRARY_LOG} PUBLIC
                           $<BUILD_INTERFACE:${LIBRARY_INCLUDE_DIR}>  
                           $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}>)
if(UNIX)
    target_link_libraries(${LIBRARY_LOG} PUBLIC pthread dl)
endif()
target_set_warnings(TARGET ${LIBRARY_LOG} ENABLE OFF AS_ERROR OFF)

# Loguru Install
install(TARGETS ${LIBRARY_LOG}
        EXPORT ${EXPORT_NAME}
        RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
        LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
        ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/static)
install(FILES ${LIBRARY_HEADERS} 
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include)

# Celero Target and Install
if(ENABLE_BENCHMARKS)
    add_subdirectory(Celero)
    target_set_warnings(TARGET celero ENABLE OFF AS_ERROR OFF)
    add_library(${LIBRARY_BENCH} ALIAS celero)
endif()
