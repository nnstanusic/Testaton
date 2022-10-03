# Testaton
A simple CMake testing wrapper


# Add to CMake project 

In the root CMakeLists.txt add
```CMake
enable_testiing()
```

and in your test folder add

```CMake
include(FetchContent)

FetchContent_Declare(
	testaton
	GIT_REPOSITORY https://github.com/nnstanusic/Testaton.git
	GIT_TAG main
	BUILD_COMMAND ""
)

FetchContent_MakeAvailable(testaton)

set(testaton_deps <LIBRARIES YOU WANT TO LINK TO EACH cpp file>)
include(${testaton_SOURCE_DIR}/Testaton.cmake)
```

All test_case.cpp files should be simple main function returing either EXIT_SUCCESS or EXIT_FAILURE. 
Tests can be grouped into folders.
