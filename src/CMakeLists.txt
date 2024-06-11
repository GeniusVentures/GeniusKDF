
add_library(GeniusKDF STATIC
KDFGenerator/KDFGenerator.cpp)

set_target_properties(GeniusKDF PROPERTIES PUBLIC_HEADER "KDFGenerator/KDFGenerator.hpp")
target_link_libraries(GeniusKDF PUBLIC
    Boost::boost
)

target_include_directories(GeniusKDF PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

sgnus_install(GeniusKDF)
