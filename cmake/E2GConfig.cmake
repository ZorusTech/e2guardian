include(TestBigEndian)

set(E2G_CONFIG_DEFINITIONS "")

macro(e2g_conf_define DEF)
    set(EXTRA_ARGS ${ARGN})

    list(LENGTH EXTRA_ARGS NUM_EXTRA_ARGS)
    if(${NUM_EXTRA_ARGS} GREATER 0)
        list(GET EXTRA_ARGS 0 DEF_VAL)
        list(APPEND E2G_CONFIG_DEFINITIONS "-D${DEF}=${DEF_VAL}")
    else()
        list(APPEND E2G_CONFIG_DEFINITIONS "-D${DEF}")
    endif()
endmacro(e2g_conf_define)

macro(e2g_conf_undef DEF)
    list(APPEND E2G_CONFIG_DEFINITIONS "-U${DEF}")
endmacro(e2g_conf_undef)

if(CMAKE_BUILD_TYPE MATCHES DEBUG)
    e2g_conf_define(DGDEBUG)
else()
    e2g_conf_undef(DGDEBUG)
endif()

# DG_CONFIGURE_OPTIONS
e2g_conf_define(DG_CONFIGURE_OPTIONS "\"\"")

# Proxy user
set(PROXY_USER "nobody" CACHE STRING "Name of proxy user")
e2g_conf_define(__PROXYUSER "\"${PROXY_USER}\"")

# Proxy group
set(PROXY_GROUP "nobody" CACHE STRING "Name of proxy group")
e2g_conf_define(__PROXYGROUP "\"${PROXY_GROUP}\"")

# Pid dir
set(PID_DIR "/${CMAKE_INSTALL_LOCALSTATEDIR}/run" CACHE STRING "Path for pid file")
e2g_conf_define(__PIDDIR "\"${PID_DIR}\"")

# Log dir
set(LOG_DIR "/${CMAKE_INSTALL_LOCALSTATEDIR}/log/${PROJECT_NAME}" CACHE STRING "Path for pid file")
e2g_conf_define(__LOGLOCATION "\"${LOG_DIR}\"")

# Conf dir
set(CONF_DIR "${PROJECT_NAME}" CACHE STRING "Path for pid file")
e2g_conf_define(__CONFDIR "\"/${CMAKE_INSTALL_SYSCONFDIR}/${CONF_DIR}\"")

# Conf dir
e2g_conf_define(__DATADIR "\"/${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}\"")

# Conf file
e2g_conf_define(__CONFFILE "\"/${CMAKE_INSTALL_SYSCONFDIR}/${PROJECT_NAME}.conf\"")

# Orgin ip support
option(ENABLE_ORIG_IP "Define to enable original destination IP checking" OFF)
if(ENABLE_ORIG_IP)
    e2g_conf_define(ENABLE_ORIG_IP)
endif()

# Define to enable AvastD content scanner 
# e2g_conf_define(ENABLE_AVASTD)

# Define to enable ClamD content scanner 
e2g_conf_define(ENABLE_CLAMD)

# Define to enable command-line content scanner 
e2g_conf_define(ENABLE_COMMANDLINE)

# Define to enable email reporting 
e2g_conf_define(ENABLE_EMAIL)

# Define to enable fancy download manager 
e2g_conf_define(ENABLE_FANCYDM)

# Define to enable ICAP content scanner 
e2g_conf_define(ENABLE_ICAP)

# Define to enable KAVD content scanner 
# e2g_conf_define(ENABLE_KAVD)

# Define to enable NTLM auth plugin 
e2g_conf_define(ENABLE_NTLM)

# Define to enable original destination IP checking 
# e2g_conf_define(ENABLE_ORIG_IP)

# Define to enable backtrace on segmentation fault 
# e2g_conf_define(ENABLE_SEGV_BACKTRACE)

# Define to enable trickle download manager 
e2g_conf_define(ENABLE_TRICKLEDM)

# Define to allow DANS_MAXFD to exceed FD_SETSIZE 
# e2g_conf_define(FD_SETSIZE_OVERIDE)

# Define to 1 if you have the <arpa/inet.h> header file. 
e2g_conf_define(HAVE_ARPA_INET_H 1)

# Define to 1 if you have the `backtrace' function. 
# e2g_conf_define(HAVE_BACKTRACE 1)

# Define to 1 if you have the <byteswap.h> header file. 
e2g_conf_define(HAVE_BYTESWAP_H 1)

# Define to 1 if you have the `dup2' function. 
e2g_conf_define(HAVE_DUP2 1)

# Define to 1 if you have the <fcntl.h> header file. 
e2g_conf_define(HAVE_FCNTL_H 1)

# Define to 1 if you have the `fork' function. 
e2g_conf_define(HAVE_FORK 1)

# Define to 1 if you have the `gettimeofday' function. 
e2g_conf_define(HAVE_GETTIMEOFDAY 1)

# Define to 1 if you have the <grp.h> header file. 
e2g_conf_define(HAVE_GRP_H 1)

# Define to 1 if you have the `iconv' function. 
e2g_conf_define(HAVE_ICONV 1)

# Define to 1 if you have the <inttypes.h> header file. 
e2g_conf_define(HAVE_INTTYPES_H 1)

# Define to 1 if you have the <limits.h> header file. 
e2g_conf_define(HAVE_LIMITS_H 1)

# Define to 1 if you have the <locale.h> header file. 
e2g_conf_define(HAVE_LOCALE_H 1)

# Define to 1 if you have the <memory.h> header file. 
e2g_conf_define(HAVE_MEMORY_H 1)

# Define to 1 if you have the `memset' function. 
e2g_conf_define(HAVE_MEMSET 1)

# Define to 1 if you have the <netdb.h> header file. 
e2g_conf_define(HAVE_NETDB_H 1)

# Define to 1 if you have the <netinet/in.h> header file. 
e2g_conf_define(HAVE_NETINET_IN_H 1)

# Define to enable PCRE support 
e2g_conf_define(HAVE_PCRE)

# Define to 1 if you have the <pthread.h> header file. 
e2g_conf_define(HAVE_PTHREAD_H 1)

# Define to 1 if you have the <pwd.h> header file. 
e2g_conf_define(HAVE_PWD_H 1)

# Define to 1 if you have the `regcomp' function. 
# e2g_conf_define(HAVE_REGCOMP 1)

# Define to 1 if you have the `select' function. 
e2g_conf_define(HAVE_SELECT 1)

# Define to 1 if you have the `seteuid' function. 
e2g_conf_define(HAVE_SETEUID 1)

# Define to 1 if you have the `setgid' function. 
e2g_conf_define(HAVE_SETGID 1)

# Define to 1 if you have the `setlocale' function. 
e2g_conf_define(HAVE_SETLOCALE 1)

# Define to 1 if you have the `setreuid' function. 
e2g_conf_define(HAVE_SETREUID 1)

# Define to 1 if you have the `setuid' function. 
e2g_conf_define(HAVE_SETUID 1)

# Define to 1 if you have the <stdint.h> header file. 
e2g_conf_define(HAVE_STDINT_H 1)

# Define to 1 if you have the <stdlib.h> header file. 
e2g_conf_define(HAVE_STDLIB_H 1)

# Define to 1 if you have the `strerror' function. 
e2g_conf_define(HAVE_STRERROR 1)

# Define to 1 if you have the <strings.h> header file. 
e2g_conf_define(HAVE_STRINGS_H 1)

# Define to 1 if you have the <string.h> header file. 
e2g_conf_define(HAVE_STRING_H 1)

# Define to 1 if you have the `strstr' function. 
e2g_conf_define(HAVE_STRSTR 1)

# Define to 1 if you have the `strtol' function. 
e2g_conf_define(HAVE_STRTOL 1)

# Define to 1 if you have the <syslog.h> header file. 
e2g_conf_define(HAVE_SYSLOG_H 1)

# Define to 1 if you have the <sys/epoll.h> header file. 
e2g_conf_define(HAVE_SYS_EPOLL_H 1)

# Define to 1 if you have the <sys/poll.h> header file. 
e2g_conf_define(HAVE_SYS_POLL_H 1)

# Define to 1 if you have the <sys/resource.h> header file. 
e2g_conf_define(HAVE_SYS_RESOURCE_H 1)

# Define to 1 if you have the <sys/socket.h> header file. 
e2g_conf_define(HAVE_SYS_SOCKET_H 1)

# Define to 1 if you have the <sys/stat.h> header file. 
e2g_conf_define(HAVE_SYS_STAT_H 1)

# Define to 1 if you have the <sys/time.h> header file. 
e2g_conf_define(HAVE_SYS_TIME_H 1)

# Define to 1 if you have the <sys/types.h> header file. 
e2g_conf_define(HAVE_SYS_TYPES_H 1)

# Define to 1 if you have the <sys/un.h> header file. 
e2g_conf_define(HAVE_SYS_UN_H 1)

# Define to 1 if you have the `umask' function. 
e2g_conf_define(HAVE_UMASK 1)

# Define to 1 if you have the <unistd.h> header file. 
e2g_conf_define(HAVE_UNISTD_H 1)

# Define to 1 if you have the `vfork' function. 
e2g_conf_define(HAVE_VFORK 1)

# Define to 1 if you have the <vfork.h> header file. 
# e2g_conf_define(HAVE_VFORK_H 1)

# Define to 1 if `fork' works. 
e2g_conf_define(HAVE_WORKING_FORK 1)

# Define to 1 if `vfork' works. 
e2g_conf_define(HAVE_WORKING_VFORK 1)

# Define to 1 if you have the <zlib.h> header file. 
e2g_conf_define(HAVE_ZLIB_H 1)

# Define if type "off_t" is a typedef of another type for which String already has a constructor 
e2g_conf_define(OFFT_COLLISION 1)

# Name of package 
e2g_conf_define(PACKAGE "\"${PROJECT_NAME}\"")

# Define to the address where bug reports for this package should be sent. 
e2g_conf_define(PACKAGE_BUGREPORT "\"\"")

# Define to the full name of this package. 
e2g_conf_define(PACKAGE_NAME "\"${PROJECT_NAME}\"")

# Define to the full name and version of this package. 
e2g_conf_define(PACKAGE_STRING "\"${PROJECT_NAME} ${PROJECT_VERSION}\"")

# Define to the one symbol short name of this package. 
e2g_conf_define(PACKAGE_TARNAME "\"${PROJECT_NAME}\"")

# Define to the home page for this package. 
e2g_conf_define(PACKAGE_URL "\"\"")

# Define to the version of this package. 
e2g_conf_define(PACKAGE_VERSION "\"${PROJECT_VERSION}\"")

# Define to enable DNS auth plugin 
e2g_conf_define(PRT_DNSAUTH)

# Define to 1 if you have the ANSI C header files. 
e2g_conf_define(STDC_HEADERS 1)

# Version number of package 
e2g_conf_define(VERSION "\"${PROJECT_VERSION}\"")

# Define WORDS_BIGENDIAN to 1 if your processor stores words with the most
# significant byte first (like Motorola and SPARC, unlike Intel).
test_big_endian(IS_BIG_ENDIAN)
if(IS_BIG_ENDIAN)
    e2g_conf_define(WORDS_BIGENDIAN 1)
else()
    e2g_conf_undef(WORDS_BIGENDIAN)
endif()

# Define to enable SSL cert
e2g_conf_define(__SSLCERT)

# Define to enable SSL MITM
e2g_conf_define(__SSLMITM)

macro(target_apply_e2g_conf TARGET)
    target_compile_options(${TARGET} PUBLIC ${E2G_CONFIG_DEFINITIONS})
endmacro(target_apply_e2g_conf)
