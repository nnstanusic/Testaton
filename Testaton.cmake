MACRO(SUBDIRLIST result curdir)
  FILE(GLOB children RELATIVE ${curdir} ${curdir}/*)
  SET(dirlist "")

  FOREACH(child ${children})
    IF(IS_DIRECTORY ${curdir}/${child})
      LIST(APPEND dirlist ${child})
    ENDIF()
  ENDFOREACH()

  SET(${result} ${dirlist})
ENDMACRO()

SUBDIRLIST(SUBDIRS ${CMAKE_CURRENT_SOURCE_DIR})

FOREACH(subdir ${SUBDIRS}) # Iterate over subdirectories and create tests for each .cpp
  file(GLOB_RECURSE tests "*.cpp")

  FOREACH(test ${tests})
    string(REGEX REPLACE ".*/(.*).cpp" "\\1" target_name ${test})

    add_executable(${target_name} ${test})
    target_link_libraries(${target_name} PRIVATE ${testaton_deps})
    add_test(NAME "${subdir};${target_name}" COMMAND ${target_name})
    message(STATUS "Adding test: ${test}")
  ENDFOREACH()
ENDFOREACH()
