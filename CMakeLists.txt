cmake_minimum_required(VERSION 3.20)
set(
    CMAKE_TOOLCHAIN_FILE
    "${CMAKE_SOURCE_DIR}/cmake/toolchain/cxx17.cmake"
    CACHE
    FILEPATH
    "Default toolchain"
)
add_definitions(-D_WIN32_WINNT=0x0601)
add_definitions(-DBOOST_BIND_GLOBAL_PLACEHOLDERS)

include(GNUInstallDirs)
project(GeniusKDF C CXX)

if(NOT EXISTS "${CMAKE_TOOLCHAIN_FILE}")
    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    set(CMAKE_CXX_EXTENSIONS OFF)
endif()

include(cmake/functions.cmake)

find_package(Boost.DI CONFIG REQUIRED)
find_package(Boost REQUIRED COMPONENTS date_time filesystem random regex system thread log log_setup program_options)
include_directories(${Boost_INCLUDE_DIRS})

# ---------------------------
# Set version
set(VERSION_STRING 0)
set(SUBVERSION_STRING 1)

# Set source file dir

option(BUILD_SHARED_LIBS "Build shared libraries" OFF)
option(BUILD_APPS "Enable application targets." FALSE)
option(BUILD_EXAMPLES "Enable demonstration targets." FALSE)
option(BUILD_DOCS "Enable documentation targets." FALSE)
set(DOXYGEN_OUTPUT_DIR "${CMAKE_CURRENT_LIST_DIR}/docs" CACHE STRING "Specify doxygen output directory")

option(BUILD_TESTING "Build tests" ON)

if(BUILD_TESTING)
    find_package(GTest CONFIG REQUIRED)
endif()

# -----------------------------------
# Include external plugin need
include_directories(
    ${CMAKE_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/include
)

if (NOT DEFINED THIRDPARTY_DIR)
    message(FATAL_ERROR "THIRDPARTY_DIR is empty")
endif()

include_directories(
    ${CMAKE_SOURCE_DIR}/src
)

include_directories(
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/algebra/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/block/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/codec/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/containers/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/hash/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/kdf/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/mac/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/math/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/marshalling/algebra/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/marshalling/core/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/marshalling/multiprecision/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/marshalling/zk/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/modes/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/multiprecision/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/passhash/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/pbkdf/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/pkpad/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/pubkey/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/random/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/stream/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/threshold/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/vdf/include"
        "${THIRDPARTY_DIR}/zkLLVM/libs/crypto3/libs/zk/include"
        )

add_subdirectory(src)


# Install Headers
install(DIRECTORY "${CMAKE_SOURCE_DIR}/include/" DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}" FILES_MATCHING PATTERN "*.h*")


# Install Targets
set(GeniusKDF_CONFIG_DESTINATION_DIR "lib/cmake/GeniusKDF")
install(EXPORT GeniusKDFTargets
    FILE GeniusKDFTargets.cmake
    DESTINATION ${GeniusKDF_CONFIG_DESTINATION_DIR}
)


include(CMakePackageConfigHelpers)

# generate the config file that is includes the exports
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/GeniusKDFConfig.cmake"
    INSTALL_DESTINATION "lib/cmake/examples"
    NO_SET_AND_CHECK_MACRO
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

# generate the version file for the config file
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/GeniusKDFConfigVersion.cmake"
    VERSION "${VERSION_STRING}.${SUBVERSION_STRING}"
    COMPATIBILITY AnyNewerVersion
)
# install the configuration file
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/GeniusKDFConfig.cmake
    DESTINATION ${GeniusKDF_CONFIG_DESTINATION_DIR}
)