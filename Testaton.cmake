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

set(_TESTATON_TEST_LIST)

FOREACH(subdir ${SUBDIRS}) # Iterate over subdirectories and create tests for each .cpp
  file(GLOB_RECURSE tests "${subdir}/*.cpp")

  FOREACH(test ${tests})
    string(REGEX REPLACE ".*/(.*).cpp" "\\1" target_name ${test})
    set(target "${subdir}_${target_name}")

    # add_executable("${target}" ${test})
    list(APPEND _TESTATON_TEST_LIST ${test})
  ENDFOREACH()
ENDFOREACH()

create_test_sourcelist(Test_sources unit_tests.cpp ${_TESTATON_TEST_LIST})
add_executable(unit_tests ${Test_sources})

target_link_libraries(unit_tests PRIVATE ${testaton_deps})

foreach(test ${_TESTATON_TEST_LIST})
  get_filename_component(TName ${test} NAME_WE)
  add_test(NAME ${TName} COMMAND unit_tests ${TName})
endforeach()