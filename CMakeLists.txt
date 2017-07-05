cmake_minimum_required(VERSION 3.7)
project(e2guardian VERSION 4.1.1)

set(CMAKE_CXX_STANDARD 11)
include(GNUInstallDirs)

# Path settings
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib-static)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Include config
include(E2GConfig)

# Libs
find_package(PkgConfig)
find_package(Threads)
find_package(ZLIB REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(PCREPOSIX REQUIRED)
find_package(BIND REQUIRED)

set(LIBS_INCLUDE_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${ZLIB_INCLUDE_DIRS}
    ${OPENSSL_INCLUDE_DIR}
    ${PCRE_INCLUDE_DIR}
    ${BIND_INCLUDE_DIR}
)
set(LIBS_LIBRARIES "${CMAKE_THREAD_LIBS_INIT};${ZLIB_LIBRARIES};${OPENSSL_LIBRARIES};${PCREPOSIX_LIBRARIES};${BIND_LIBRARY}")

# Compiler settings
set(GENERAL_WARNING_FLAGS "-Wall -Wno-unused-variable -Wno-unused-function")
set(GENERAL_DEBUG_FLAGS "-g3 -O0 -fvar-tracking-assignments")
set(GENERAL_RELEASE_FLAGS "-mtune=native -O2 -fomit-frame-pointer")
set(GENERAL_COMPILER_FLAGS "-fPIC -pthread -pipe -fstack-protector-strong --param=ssp-buffer-size=4")

set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS} ${GENERAL_WARNING_FLAGS} ${GENERAL_COMPILER_FLAGS} ${FFMPEG_DEFINITIONS} ${SWSCALE_DEFINITIONS}")
set(CMAKE_CXX_FLAGS_DEBUG "${GENERAL_DEBUG_FLAGS}")
set(CMAKE_CXX_FLAGS_RELEASE "${GENERAL_RELEASE_FLAGS}")

# Source file globbing
file(GLOB_RECURSE SOURCE_FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/include/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp"
    )

# Source glob exclusions
list(FILTER SOURCE_FILES EXCLUDE REGEX "(.*)/CH.cpp")
list(FILTER SOURCE_FILES EXCLUDE REGEX "(.*)/contentscanners/avastdscan.cpp")
list(FILTER SOURCE_FILES EXCLUDE REGEX "(.*)/contentscanners/kavdscan.cpp")

# Create static library
add_library(e2guardian-static STATIC ${SOURCE_FILES})
target_apply_e2g_conf(e2guardian-static)
target_include_directories(e2guardian-static PUBLIC ${LIBS_INCLUDE_DIRS})
target_link_libraries(e2guardian-static PUBLIC ${LIBS_LIBRARIES})
set_target_properties(e2guardian-static PROPERTIES OUTPUT_NAME e2guardian-static)

# Create executable
add_executable(e2guardian ${SOURCE_FILES})
target_apply_e2g_conf(e2guardian)
target_include_directories(e2guardian PUBLIC ${LIBS_INCLUDE_DIRS})
target_link_libraries(e2guardian PUBLIC e2guardian-static)
set_target_properties(e2guardian PROPERTIES OUTPUT_NAME e2guardian)

# Install
install(TARGETS
        e2guardian-static
        e2guardian
        ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
        )

# Dummy target for CLion
file(GLOB SRC_FILES ${PROJECT_SOURCE_DIR}/src/*.cpp)
add_executable(dummy ${SRC_FILES})
target_include_directories(dummy PRIVATE ${PROJECT_SOURCE_DIR}/src)

# Configure and make
add_custom_target(e2guardian-autotool
        COMMAND bash autogen.sh
        COMMAND bash configure --bindir=${PROJECT_BINARY_DIR}/bin --libdir=${PROJECT_BINARY_DIR}/lib '--prefix=/usr' '--enable-clamd=yes' '--with-proxyuser=e2guardian' '--with-proxygroup=e2guardian' '--sysconfdir=/etc' '--localstatedir=/var' '--enable-icap=yes' '--enable-commandline=yes' '--enable-email=yes' '--enable-ntlm=yes' '--enable-trickledm=yes' '--mandir=${prefix}/share/man' '--infodir=${prefix}/share/info' 'CXXFLAGS=-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security' 'LDFLAGS=-Wl,-z,relro' 'CPPFLAGS=-D_FORTIFY_SOURCE=2' 'CFLAGS=-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security' '--enable-pcre=yes' '--enable-dnsauth=yes' '--with-filedescriptors=1000' '--enable-sslmitm'
        COMMAND make -j 4
        COMMAND cp src/e2guardian ${PROJECT_BINARY_DIR}/e2guardian
        COMMAND make clean
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
)