function(add_git_submodule relative_dir)
    find_package(Git REQUIRED)

    if (NOT EXISTS ${CMAKE_SOURCE_DIR}/${relative_dir}/CMakeLists.txt)
        execute_process(COMMAND ${GIT_EXECUTABLE}
            submodule update --init --recursive -- ${CMAKE_SOURCE_DIR}/${relative_dir}
            WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})
    endif()

    if (EXISTS ${CMAKE_SOURCE_DIR}/${relative_dir}/CMakeLists.txt)
        message("Adding: ${relative_dir}/CMakeLists.txt")
        add_subdirectory(${CMAKE_SOURCE_DIR}/${relative_dir})
    else()
        message("Could not add: ${relative_dir}/CMakeLists.txt")
    endif()
endfunction(add_git_submodule)
