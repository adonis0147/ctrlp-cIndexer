project(cIndexer)
cmake_minimum_required(VERSION 3.0)

find_package(Python COMPONENTS Interpreter Development)

file(GLOB HEADER_FILES cIndexer/*.h)
file(GLOB SOURCE_FILES cIndexer/*.cc)

include_directories(
	${PYTHON_INCLUDE_DIRS}
)

add_library(${PROJECT_NAME} SHARED ${HEADER_FILES} ${SOURCE_FILES})

if(MSVC)
	set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".pyd")
	target_link_libraries(${PROJECT_NAME} ${PYTHON_LIBRARIES})
else(MSVC)
	set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")
	set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".so")
	add_definitions(--std=c++11 -Wno-write-strings)
	execute_process(COMMAND python-config --cflags OUTPUT_VARIABLE PYTHON_CFLAGS OUTPUT_STRIP_TRAILING_WHITESPACE)
	execute_process(COMMAND python-config --ldflags OUTPUT_VARIABLE PYTHON_LDFLAGS OUTPUT_STRIP_TRAILING_WHITESPACE)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${PYTHON_CFLAGS}")
	set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${PYTHON_LDFLAGS}")
	set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -lpython${Python_VERSION_MAJOR}.${Python_VERSION_MINOR}")
endif(MSVC)

