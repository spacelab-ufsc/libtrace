find_package(PkgConfig REQUIRED)
pkg_check_modules(CMOCKA REQUIRED IMPORTED_TARGET cmocka)

add_executable(circular_buffer_test
    circular_buffer_test.c
    ../src/circular_buffer.c
)

target_link_libraries(circular_buffer_test
    PRIVATE PkgConfig::CMOCKA
)

target_include_directories(circular_buffer_test
    PRIVATE ../src
)
