INCLUDE(ExternalProject)

message("CMAKE_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}")
ExternalProject_Add(
    EasyCL-external
    STAMP_DIR ${CMAKE_BINARY_DIR}/EasyCL/stamp
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/EasyCL
    PREFIX ${CMAKE_BINARY_DIR}/EasyCL
    CMAKE_CACHE_ARGS 
    -DBUILD_TESTS:BOOL=OFF
    -DPROVIDE_LUA_ENGINE:BOOL=OFF
    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}
    -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo
    )

ADD_LIBRARY(EasyCL SHARED IMPORTED)
ADD_DEPENDENCIES(EasyCL EasyCL-external)
#SET(EASYCL_INCLUDE_DIRS ${CMAKE_INSTALL_PREFIX}/include/deepcl ${CMAKE_INSTALL_PREFIX}/include/easycl )
SET(EASYCL_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/src/EasyCL ${CMAKE_CURRENT_SOURCE_DIR}/src/EasyCL/thirdparty/clew/include )
SET(EASYCL_LIBRARIES ${CMAKE_INSTALL_PREFIX}/lib/${CMAKE_SHARED_LIBRARY_PREFIX}EasyCL${CMAKE_SHARED_LIBRARY_SUFFIX} ${CMAKE_INSTALL_PREFIX}/lib/${CMAKE_SHARED_LIBRARY_PREFIX}clew${CMAKE_SHARED_LIBRARY_SUFFIX})
SET(EASYCL_FOUND ON)

set_property(TARGET EasyCL
 PROPERTY IMPORTED_LOCATION ${EASYCL_LIBRARIES}
)

#set_target_properties(EasyCL PROPERTIES
#  IMPORTED_LOCATION 
#  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "EasyCL;clBLAS;/usr/lib/x86_64-linux-gnu/libjpeg.so"
#  IMPORTED_LOCATION_DEBUG "/home/ubuntu/git/DeepCL/build/libDeepCL.so"
#  IMPORTED_SONAME_DEBUG "libDeepCL.so"
#)

#set_target_properties(EasyCL PROPERTIES
#  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "EasyCL;clBLAS;/usr/lib/x86_64-linux-gnu/libjpeg.so"
#  IMPORTED_LOCATION_DEBUG "/home/ubuntu/git/DeepCL/build/libDeepCL.so"
#  IMPORTED_SONAME_DEBUG "libDeepCL.so"
#)

add_custom_target(easycl_delete_stamp ALL 
  COMMAND ${CMAKE_COMMAND} -E  remove_directory "${CMAKE_BINARY_DIR}/EasyCL/stamp"
)
add_dependencies(EasyCL-external easycl_delete_stamp)

