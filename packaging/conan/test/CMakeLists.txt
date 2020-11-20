cmake_minimum_required(VERSION 3.8)
project(test)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

add_executable(test test.cpp)
target_compile_features(test PUBLIC cxx_std_17)
target_link_libraries (test ${CONAN_LIBS})
