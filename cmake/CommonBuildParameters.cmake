# BOOST VERSION TO USE
set(BOOST_MAJOR_VERSION "1" CACHE STRING "Boost Major Version")
set(BOOST_MINOR_VERSION "80" CACHE STRING "Boost Minor Version")
set(BOOST_PATCH_VERSION "0" CACHE STRING "Boost Patch Version")
# convenience settings
set(BOOST_VERSION "${BOOST_MAJOR_VERSION}.${BOOST_MINOR_VERSION}.${BOOST_PATCH_VERSION}")
set(BOOST_VERSION_3U "${BOOST_MAJOR_VERSION}_${BOOST_MINOR_VERSION}_${BOOST_PATCH_VERSION}")
set(BOOST_VERSION_2U "${BOOST_MAJOR_VERSION}_${BOOST_MINOR_VERSION}")

# --------------------------------------------------------
# define third party directory
#if (NOT DEFINED THIRDPARTY_DIR)
#  print("Setting default third party directory")
#  set(THIRDPARTY_DIR "${CMAKE_CURRENT_LIST_DIR}/../../thirdparty")
#  ## get absolute path
#  cmake_path(SET THIRDPARTY_DIR NORMALIZE "${THIRDPARTY_DIR}")
#endif()
#
#if (NOT DEFINED THIRDPARTY_BUILD_DIR)
#  print("Setting third party build directory default")
#  set(THIRDPARTY_BUILD_DIR "${THIRDPARTY_DIR}/build/${CMAKE_SYSTEM_NAME}/${CMAKE_BUILD_TYPE}")
#endif()
#
#print("THIRDPARTY BUILD DIR: ${THIRDPARTY_BUILD_DIR}")
#print("THIRDPARTY SRC DIR: ${THIRDPARTY_DIR}")

# --------------------------------------------------------
# Set config of GTest
set(GTest_DIR "${THIRDPARTY_BUILD_DIR}/GTest/lib/cmake/GTest")
set(GTest_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/GTest/include")
find_package(GTest CONFIG REQUIRED)
include_directories(${GTest_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of fmt
set(fmt_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/fmt/include")
set(fmt_DIR "${THIRDPARTY_BUILD_DIR}/fmt/lib/cmake/fmt")
find_package(fmt CONFIG REQUIRED)
include_directories(${fmt_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of soralog
set(soralog_DIR "${THIRDPARTY_BUILD_DIR}/soralog/lib/cmake/soralog")
set(soralog_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/soralog/include")
find_package(soralog CONFIG REQUIRED)
include_directories(${soralog_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of cares
set(c-ares_DIR "${THIRDPARTY_BUILD_DIR}/cares/lib/cmake/c-ares")
set(c-ares_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/cares/include")
# find_package(c-ares CONFIG REQUIRED)
# include_directories(${c-ares_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of yaml-cpp
set(yaml-cpp_DIR "${THIRDPARTY_BUILD_DIR}/yaml-cpp/lib/cmake/yaml-cpp")
set(yaml-cpp_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/yaml-cpp/include")
find_package(yaml-cpp CONFIG REQUIRED)
include_directories(${yaml-cpp_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of protobuf project
if (NOT DEFINED Protobuf_DIR)
    set(Protobuf_DIR "${_THIRDPARTY_BUILD_DIR}/grpc/lib/cmake/protobuf")
endif()
if (NOT DEFINED grpc_INCLUDE_DIR)
    set(grpc_INCLUDE_DIR "${_THIRDPARTY_BUILD_DIR}/grpc/include")
endif()
if (NOT DEFINED Protobuf_INCLUDE_DIR)
    set(Protobuf_INCLUDE_DIR "${grpc_INCLUDE_DIR}/google/protobuf")
endif()

find_package(Protobuf CONFIG REQUIRED )

if (NOT DEFINED PROTOC_EXECUTABLE)
  set(PROTOC_EXECUTABLE "${THIRDPARTY_BUILD_DIR}/grpc/bin/protoc${CMAKE_EXECUTABLE_SUFFIX}")
endif()

set(Protobuf_PROTOC_EXECUTABLE ${PROTOC_EXECUTABLE} CACHE PATH "Initial cache" FORCE)
if(NOT TARGET protobuf::protoc)
  add_executable(protobuf::protoc IMPORTED)
endif()
if(EXISTS "${Protobuf_PROTOC_EXECUTABLE}")
  set_target_properties(protobuf::protoc PROPERTIES
          IMPORTED_LOCATION ${Protobuf_PROTOC_EXECUTABLE})
endif()

# protoc definition #####################################################################################
get_target_property(PROTOC_LOCATION protobuf::protoc IMPORTED_LOCATION)
print("PROTOC_LOCATION: ${PROTOC_LOCATION}")
if ( Protobuf_FOUND )
  message( STATUS "Protobuf version : ${Protobuf_VERSION}" )
  message( STATUS "Protobuf compiler : ${Protobuf_PROTOC_EXECUTABLE}")
endif()
include(${PROJECT_ROOT}/build/cmake/functions.cmake)
include(${PROJECT_ROOT}/cmake/functions.cmake)

set(OPENSSL_DIR "${THIRDPARTY_BUILD_DIR}/openssl/build/${ABI_SUBFOLDER_NAME}" CACHE PATH "Path to OpenSSL install folder")
set(OPENSSL_USE_STATIC_LIBS ON CACHE BOOL "OpenSSL use static libs")
set(OPENSSL_MSVC_STATIC_RT ON CACHE BOOL "OpenSSL use static RT")
set(OPENSSL_ROOT_DIR "${OPENSSL_DIR}" CACHE PATH "Path to OpenSSL install root folder")
set(OPENSSL_INCLUDE_DIR "${OPENSSL_DIR}/include" CACHE PATH "Path to OpenSSL include folder")
set(OPENSSL_INCLUDE_DIR "${OPENSSL_DIR}/include")
set(OPENSSL_LIBRARIES "${OPENSSL_DIR}/lib" CACHE PATH "Path to OpenSSL lib folder")
set(OPENSSL_CRYPTO_LIBRARY ${OPENSSL_LIBRARIES}/libcrypto${CMAKE_STATIC_LIBRARY_SUFFIX} CACHE PATH "Path to OpenSSL crypto lib")
set(OPENSSL_SSL_LIBRARY ${OPENSSL_LIBRARIES}/libssl${CMAKE_STATIC_LIBRARY_SUFFIX} CACHE PATH "Path to OpenSSL ssl lib")
message(OPENSSLINCLUDE:"${OPENSSL_INCLUDE_DIR}")
find_package(OpenSSL REQUIRED)
include_directories(${OPENSSL_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of rocksdb
set(RocksDB_DIR "${THIRDPARTY_BUILD_DIR}/rocksdb/lib/cmake/rocksdb")
set(RocksDB_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/rocksdb/include")
find_package(RocksDB CONFIG REQUIRED)
include_directories(${RocksDB_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of stb
include_directories(${THIRDPARTY_BUILD_DIR}/stb/include)

# --------------------------------------------------------
# Set config of Microsoft.GSL
set(GSL_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/Microsoft.GSL/include")
include_directories(${GSL_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of fmt
set(fmt_DIR "${THIRDPARTY_BUILD_DIR}/fmt/lib/cmake/fmt")
set(fmt_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/fmt/include")
find_package(fmt CONFIG REQUIRED)
include_directories(${fmt_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of spdlog v1.4.2
set(spdlog_DIR "${THIRDPARTY_BUILD_DIR}/spdlog/lib/cmake/spdlog")
set(spdlog_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/spdlog/include")
find_package(spdlog CONFIG REQUIRED)
include_directories(${spdlog_INCLUDE_DIR}
add_compile_definitions("SPDLOG_FMT_EXTERNAL"))

# --------------------------------------------------------
# Set config of soralog
set(soralog_DIR "${THIRDPARTY_BUILD_DIR}/soralog/lib/cmake/soralog")
set(soralog_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/soralog/include")
find_package(soralog CONFIG REQUIRED)
include_directories(${soralog_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of yaml-cpp
# set(yaml-cpp_DIR "${THIRDPARTY_BUILD_DIR}/yaml-cpp/share/cmake/yaml-cpp")
# set(yaml-cpp_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/yaml-cpp/include")
# find_package(yaml-cpp CONFIG REQUIRED)
# include_directories(${yaml-cpp_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of  tsl_hat_trie
set(tsl_hat_trie_DIR "${THIRDPARTY_BUILD_DIR}/tsl_hat_trie/lib/cmake/tsl_hat_trie")
set(tsl_hat_trie_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/tsl_hat_trie/include")
find_package(tsl_hat_trie CONFIG REQUIRED)
include_directories(${tsl_hat_trie_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of Boost.DI
set(Boost.DI_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/Boost.DI/include")
set(Boost.DI_DIR "${THIRDPARTY_BUILD_DIR}/Boost.DI/lib/cmake/Boost.DI")
find_package(Boost.DI CONFIG REQUIRED)
include_directories(${Boost.DI_INCLUDE_DIR})


# Boost should be loaded before libp2p v0.1.2
# --------------------------------------------------------
# Set config of Boost project
set(_BOOST_ROOT "${THIRDPARTY_BUILD_DIR}/boost/build/${CMAKE_SYSTEM_NAME}${ABI_SUBFOLDER_NAME}")
set(Boost_LIB_DIR "${_BOOST_ROOT}/lib")
set(Boost_INCLUDE_DIR "${_BOOST_ROOT}/include/boost-${BOOST_VERSION_2U}")
set(Boost_DIR "${Boost_LIB_DIR}/cmake/Boost-${BOOST_VERSION}")
set(boost_headers_DIR "${Boost_LIB_DIR}/cmake/boost_headers-${BOOST_VERSION}")
set(boost_random_DIR "${Boost_LIB_DIR}/cmake/boost_random-${BOOST_VERSION}")
set(boost_system_DIR "${Boost_LIB_DIR}/cmake/boost_system-${BOOST_VERSION}")
set(boost_filesystem_DIR "${Boost_LIB_DIR}/cmake/boost_filesystem-${BOOST_VERSION}")
set(boost_program_options_DIR "${Boost_LIB_DIR}/cmake/boost_program_options-${BOOST_VERSION}")
set(boost_date_time_DIR "${Boost_LIB_DIR}/cmake/boost_date_time-${BOOST_VERSION}")
set(boost_regex_DIR "${Boost_LIB_DIR}/cmake/boost_regex-${BOOST_VERSION}")
set(boost_atomic_DIR "${Boost_LIB_DIR}/cmake/boost_atomic-${BOOST_VERSION}")
set(boost_chrono_DIR "${Boost_LIB_DIR}/cmake/boost_chrono-${BOOST_VERSION}")
set(boost_log_DIR "${Boost_LIB_DIR}/cmake/boost_log-${BOOST_VERSION}")
set(boost_log_setup_DIR "${Boost_LIB_DIR}/cmake/boost_log_setup-${BOOST_VERSION}")
set(boost_thread_DIR "${Boost_LIB_DIR}/cmake/boost_thread-${BOOST_VERSION}")
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_LIBS ON)
set(Boost_NO_SYSTEM_PATHS ON)
option(Boost_USE_STATIC_RUNTIME "Use static runtimes" ON)


option (SGNS_STACKTRACE_BACKTRACE "Use BOOST_STACKTRACE_USE_BACKTRACE in stacktraces, for POSIX" OFF)
if (SGNS_STACKTRACE_BACKTRACE)
  add_definitions(-DSGNS_STACKTRACE_BACKTRACE=1)
  if (BACKTRACE_INCLUDE)
    add_definitions(-DBOOST_STACKTRACE_BACKTRACE_INCLUDE_FILE=${BACKTRACE_INCLUDE})
  endif()
endif ()

# header only libraries must not be added here
find_package(Boost REQUIRED COMPONENTS date_time filesystem random regex system thread log log_setup program_options)
include_directories(${Boost_INCLUDE_DIRS})

# --------------------------------------------------------
# Set config of SQLiteModernCpp project
set(SQLiteModernCpp_ROOT_DIR "${THIRDPARTY_BUILD_DIR}/SQLiteModernCpp")
set(SQLiteModernCpp_DIR "${SQLiteModernCpp_ROOT_DIR}/lib/cmake/SQLiteModernCpp")
set(SQLiteModernCpp_LIB_DIR "${SQLiteModernCpp_ROOT_DIR}/lib")
set(SQLiteModernCpp_INCLUDE_DIR "${SQLiteModernCpp_ROOT_DIR}/include")

# --------------------------------------------------------
# Set config of SQLiteModernCpp project
set(sqlite3_ROOT_DIR "${THIRDPARTY_BUILD_DIR}/sqlite3")
set(sqlite3_DIR "${sqlite3_ROOT_DIR}/lib/cmake/sqlite3")
set(sqlite3_LIB_DIR "${sqlite3_ROOT_DIR}/lib")
set(sqlite3_INCLUDE_DIR "${sqlite3_ROOT_DIR}/include")

# --------------------------------------------------------
# Set config of cares
set(c-ares_DIR "${THIRDPARTY_BUILD_DIR}/cares/lib/cmake/c-ares" CACHE PATH "Path to c-ares install folder")
set(c-ares_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/cares/include" CACHE PATH "Path to c-ares include folder")

# --------------------------------------------------------
# Set config of libp2p
set(libp2p_DIR "${THIRDPARTY_BUILD_DIR}/libp2p/lib/cmake/libp2p")
set(libp2p_LIBRARY_DIR "${THIRDPARTY_BUILD_DIR}/libp2p/lib")
set(libp2p_INCLUDE_DIR    "${THIRDPARTY_BUILD_DIR}/libp2p/include")
find_package(libp2p CONFIG REQUIRED)
include_directories(${libp2p_INCLUDE_DIR})

# --------------------------------------------------------
# Find and include cares if libp2p have not included it
if (NOT TARGET c-ares::cares_static)
  find_package(c-ares CONFIG REQUIRED)
endif()
include_directories(${c-ares_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of ipfs-lite-cpp
set(ipfs-lite-cpp_DIR "${THIRDPARTY_BUILD_DIR}/ipfs-lite-cpp/cmake/ipfs-lite-cpp")
set(ipfs-lite-cpp_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/ipfs-lite-cpp/include")
set(ipfs-lite-cpp_LIB_DIR "${THIRDPARTY_BUILD_DIR}/ipfs-lite-cpp/lib")
set(CBOR_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/ipfs-lite-cpp/include/deps/tinycbor/src")
find_package(ipfs-lite-cpp CONFIG REQUIRED)
include_directories(${ipfs-lite-cpp_INCLUDE_DIR} ${CBOR_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of ipfs-pubsub
set(ipfs-pubsub_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/ipfs-pubsub/include")
set(ipfs-pubsub_DIR "${THIRDPARTY_BUILD_DIR}/ipfs-pubsub/lib/cmake/ipfs-pubsub")
find_package(ipfs-pubsub CONFIG REQUIRED)
include_directories(${ipfs-pubsub_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of ipfs-bitswap-cpp
set(ipfs-bitswap-cpp_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/ipfs-bitswap-cpp/include")
set(ipfs-bitswap-cpp_DIR "${THIRDPARTY_BUILD_DIR}/ipfs-bitswap-cpp/lib/cmake/ipfs-bitswap-cpp")
find_package(ipfs-bitswap-cpp CONFIG REQUIRED)
include_directories(${ipfs-bitswap-cpp_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of ed25519
set(ed25519_DIR "${THIRDPARTY_BUILD_DIR}/ed25519/lib/cmake/ed25519")
set(ed25519_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/ed25519/include")
find_package(ed25519 CONFIG REQUIRED)
include_directories(${ed25519_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of sr25519-donna
set(sr25519-donna_DIR "${THIRDPARTY_BUILD_DIR}/sr25519-donna/lib/cmake/sr25519-donna")
set(sr25519-donna_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/sr25519-donna/include")
find_package(sr25519-donna CONFIG REQUIRED)
include_directories(${sr25519-donna_INCLUDE_DIR})

# --------------------------------------------------------
# Set RapidJSON config path
set(RapidJSON_DIR "${THIRDPARTY_BUILD_DIR}/rapidjson/lib/cmake/RapidJSON")
set(RapidJSON_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/rapidjson/include")
find_package(RapidJSON CONFIG REQUIRED)
include_directories(${RapidJSON_INCLUDE_DIR})

# --------------------------------------------------------
# Set jsonrpc-lean include path
set(jsonrpc_lean_INCLUDE_DIR "${THIRDPARTY_DIR}/jsonrpc-lean/include")
include_directories(${jsonrpc_lean_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of secp256k1
set(libsecp256k1_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/libsecp256k1/include")
set(libsecp256k1_LIBRARY_DIR "${THIRDPARTY_BUILD_DIR}/libsecp256k1/lib")
set(libsecp256k1_DIR "${THIRDPARTY_BUILD_DIR}/libsecp256k1/lib/cmake/libsecp256k1")
find_package(libsecp256k1 CONFIG REQUIRED)
include_directories(${libsecp256k1_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of xxhash
set(xxhash_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/xxhash/include")
set(xxhash_LIBRARY_DIR "${THIRDPARTY_BUILD_DIR}/xxhash/lib")
set(xxhash_DIR "${THIRDPARTY_BUILD_DIR}/xxhash/lib/cmake/xxhash")
find_package(xxhash CONFIG REQUIRED)
include_directories(${xxhash_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of libssh2
set(Libssh2_DIR "${THIRDPARTY_BUILD_DIR}/libssh2/lib/cmake/libssh2")
set(Libssh2_LIBRARY_DIR "${THIRDPARTY_BUILD_DIR}/libssh2/lib")
set(Libssh2_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/libssh2/include")
find_package(Libssh2 CONFIG REQUIRED)
include_directories(${LIBSSH2_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of AsyncIOManager
set(AsyncIOManager_INCLUDE_DIR "${THIRDPARTY_BUILD_DIR}/AsyncIOManager/include")
set(AsyncIOManager_LIBRARY_DIR "${THIRDPARTY_BUILD_DIR}/AsyncIOManager/lib")
set(AsyncIOManager_DIR "${THIRDPARTY_BUILD_DIR}/AsyncIOManager/lib/cmake/AsyncIOManager")
find_package(AsyncIOManager CONFIG REQUIRED)
include_directories(${AsyncIOManager_INCLUDE_DIR})

# --------------------------------------------------------
# Set config of SuperGenius project
if (NOT DEFINED SUPERGENIUS_SRC_DIR)
  if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/../../SuperGenius/README.md")
    print("Setting default SuperGenius directory")
    set(SUPERGENIUS_SRC_DIR "${CMAKE_CURRENT_LIST_DIR}/../../SuperGenius" CACHE STRING "Default SuperGenius Library")
    ## get absolute path
    cmake_path(SET SUPERGENIUS_SRC_DIR NORMALIZE "${SUPERGENIUS_SRC_DIR}")
  else()
    message( FATAL_ERROR "Cannot find SuperGenius directory required to build" )
  endif()
endif()

set(SuperGenius_DIR "${SUPERGENIUS_SRC_DIR}/build/${CMAKE_SYSTEM_NAME}/${CMAKE_BUILD_TYPE}/SuperGenius/lib/cmake/SuperGenius/")
#set(SuperGenius_DIR "${SUPERGENIUS_SRC_DIR}/.build/SuperGenius/lib/cmake/SuperGenius/")


print("SuperGenius_DIR: ${SuperGenius_DIR}")

find_package(SuperGenius CONFIG REQUIRED)
include_directories(${SuperGenius_INCLUDE_DIR})

# --------------------------------------------------------
include_directories(
        ${PROJECT_ROOT}/include
        ${PROJECT_ROOT}/src
        ${CMAKE_BINARY_DIR}
)

# --------------------------------------------------------
option(BUILD_SHARED_LIBS "Build using shared libraries" OFF)
option(TESTING "Build tests" OFF)
option(BUILD_EXAMPLES "Build examples" OFF)

add_subdirectory(${PROJECT_ROOT}/src ${CMAKE_BINARY_DIR}/src)

# --------------------------------------------------------
if (TESTING)
  # Set config of GTest project
  find_package(GTest CONFIG REQUIRED)
  include_directories(${GTest_INCLUDE_DIR})

  enable_testing()
  #add_subdirectory(${PROJECT_ROOT}/test ${CMAKE_BINARY_DIR}/test)
endif ()

# --------------------------------------------------------
# Build examples

if (BUILD_EXAMPLES)
    add_subdirectory(${PROJECT_ROOT}/example ${CMAKE_BINARY_DIR}/example)
endif ()

# --------------------------------------------------------
# Install targets

install(
  EXPORT GeniusKDFTargets
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/GeniusKDF
  NAMESPACE sgns::
)

# generate the config file that is includes the exports
configure_package_config_file(${PROJECT_ROOT}/cmake/config.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/GeniusKDFConfig.cmake"
  INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/GeniusKDF
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

# generate the version file for the config file
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/GeniusKDFConfigVersion.cmake"
  VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}"
  COMPATIBILITY AnyNewerVersion
)

# install the configuration file
install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/GeniusKDFConfig.cmake
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/GeniusKDF
)

install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/GeniusKDFConfigVersion.cmake
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/GeniusKDF
)
