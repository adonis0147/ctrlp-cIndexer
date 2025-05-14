cmake_minimum_required(VERSION 3.28)
project(cIndexer)

find_package(Python COMPONENTS Interpreter Development)

file(GLOB SOURCE_FILES cIndexer/*.cc)

include_directories(
	${Python_INCLUDE_DIRS}
)

add_library(${PROJECT_NAME} SHARED ${SOURCE_FILES})
target_link_libraries(${PROJECT_NAME} ${Python_LIBRARIES})

if(MSVC)
	set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".pyd")
else(MSVC)
	set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")
	set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".so")
	add_definitions(-Wno-write-strings)
endif(MSVC)
