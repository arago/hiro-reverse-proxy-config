# -*- coding: utf-8 -*-

cmake_minimum_required(VERSION 2.8.10)

set(tmp_subdir "_tmp")
set(rpm_name "hiro-reverse-proxy-config")
set(rpm_desc "arago GmbH HIRO Reverse Proxy Config")
set(rpm_target_dir "/")

# set RPM arch:
set(rpm_arch "noarch")


#
# get version variables from environment
# 
if(NOT DEFINED ENV{HIRO_RPM_VERSION})
  message("env var HIRO_RPM_VERSION not set")
  return()
endif()
if(NOT DEFINED ENV{HIRO_RPM_RELEASE})
  message("env var HIRO_RPM_RELEASE not set")
  return()
endif()

message("----------------------------------------")
message("building version: $ENV{HIRO_RPM_VERSION}-$ENV{HIRO_RPM_RELEASE}")
message("for: ${rpm_arch}")
message("----------------------------------------")

# set name/versions
SET(CPACK_PACKAGE_NAME ${rpm_name})
SET(CPACK_PACKAGE_VERSION_MAJOR $ENV{HIRO_RPM_VERSION})
SET(CPACK_PACKAGE_VERSION_MINOR $ENV{HIRO_RPM_RELEASE})
SET(CPACK_PACKAGE_VERSION_PATCH "0")
SET(CPACK_PACKAGE_DESCRIPTION ${rpm_desc})
# and corresponding RPM stuff, too
SET(CPACK_RPM_PACKAGE_URL "https://www.arago.co")
SET(CPACK_RPM_PACKAGE_SUMMARY "${rpm_desc}")
SET(CPACK_RPM_PACKAGE_NAME ${rpm_name})
SET(CPACK_RPM_PACKAGE_VERSION $ENV{HIRO_RPM_VERSION})
SET(CPACK_RPM_PACKAGE_ARCHITECTURE ${rpm_arch})
SET(CPACK_RPM_PACKAGE_RELEASE $ENV{HIRO_RPM_RELEASE})
SET(CPACK_RPM_PACKAGE_LICENSE "Proprietary")
SET(CPACK_RPM_PACKAGE_GROUP "Applications/Other")
SET(CPACK_RPM_PACKAGE_VENDOR "arago GmbH")
SET(CPACK_RPM_PACKAGE_DESCRIPTION "${CPACK_PACKAGE_DESCRIPTION}")
SET(CPACK_PACKAGE_FILE_NAME "${rpm_name}-$ENV{HIRO_RPM_VERSION}-$ENV{HIRO_RPM_RELEASE}.${rpm_arch}")
message("build ${CPACK_PACKAGE_FILE_NAME}")
#
SET(CPACK_RPM_PACKAGE_REQUIRES "nginx")

SET(CPACK_GENERATOR "RPM")
SET(CPACK_RPM_PACKAGE_DEBUG "0")

# set basedir from current path
# every path specification will be done relative to this
#execute_process(COMMAND pwd
#			OUTPUT_VARIABLE basedir
#			OUTPUT_STRIP_TRAILING_WHITESPACE)
#set(builddir "${basedir}/${tmp_subdir}")
#file(MAKE_DIRECTORY "${builddir}")
#message("using builddir ${builddir}")

# the following strange looking lines will ensure that
# unwanted directories won't become part of package
set(CPACK_RPM_SPEC_MORE_DEFINE "%define ignore \#
%define _tmppath %{_topdir}/tmp"
)

set(CPACK_RPM_USER_FILELIST
"%ignore /etc"
"%ignore /etc/nginx"
"%ignore /etc/nginx/conf.d"
"%config(noreplace) /etc/nginx/conf.d/*"
)
SET(CPACK_INSTALLED_DIRECTORIES
    "${PROJECT_SOURCE_DIR}/conf.d" "/etc/nginx/conf.d"
)

# set postinstall script
SET(CPACK_RPM_POST_INSTALL_SCRIPT_FILE "${PROJECT_SOURCE_DIR}/postinstall.sh")
#SET(CPACK_RPM_PRE_UNINSTALL_SCRIPT_FILE "${basedir}/preuninstall.sh")

# now process CPACK settings
INCLUDE(CPack)
