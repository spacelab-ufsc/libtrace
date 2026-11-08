# Usage: cmake -B build/x86 -DCMAKE_TOOLCHAIN_FILE=cmake/x86.cmake [-DCROSS_COMPILE=i686-elf-]

set(CMAKE_SYSTEM_NAME      Generic)
set(CMAKE_SYSTEM_PROCESSOR i686)

set(LT_X86_PREFIXES i686-elf- x86_64-elf-)

if(NOT DEFINED CROSS_COMPILE)
	set(_lt_prefix "")
	foreach(_p IN LISTS LT_X86_PREFIXES)
		find_program(_lt_gcc_${_p} ${_p}gcc)
		if(_lt_gcc_${_p})
			set(_lt_prefix ${_p})
			break()
		endif()
	endforeach()
	if(_lt_prefix STREQUAL "")
		message(STATUS "x86: no cross toolchain found (tried: ${LT_X86_PREFIXES}), using host gcc")
	endif()
	set(CROSS_COMPILE "${_lt_prefix}" CACHE STRING "Toolchain prefix (e.g. i686-elf-)")
endif()

# try_compile() re-reads this file without the cache
list(APPEND CMAKE_TRY_COMPILE_PLATFORM_VARIABLES CROSS_COMPILE)

set(CMAKE_C_COMPILER ${CROSS_COMPILE}gcc)
set(CMAKE_AR         ${CROSS_COMPILE}ar)
set(CMAKE_RANLIB     ${CROSS_COMPILE}ranlib)

set(CMAKE_C_FLAGS_INIT "-march=i686 -m32")

# No target runtime to link test executables
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
