cmake_minimum_required(VERSION 3.10)

project(libtrace VERSION 	 0.0.1
				 DESCRIPTION "A memory-efficient tiny library for event registering"
				 LANGUAGES	 C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
	set(CMAKE_BUILD_TYPE MinSizeRel CACHE STRING "Build type" FORCE)
endif()

file(GLOB LIBTRACE_SOURCES CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/src/*.c)

add_library(trace STATIC ${LIBTRACE_SOURCES})
add_library(libtrace::trace ALIAS trace)

target_include_directories(trace PUBLIC ${PROJECT_SOURCE_DIR}/include)

target_compile_options(trace PRIVATE
	-Wall -Wextra -Wpedantic -Wshadow -Wconversion
	-ffreestanding -fno-common
	-ffunction-sections -fdata-sections
)
