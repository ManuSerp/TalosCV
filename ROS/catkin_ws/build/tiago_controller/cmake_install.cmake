# Install script for directory: /home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/src/tiago_controller

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install" TYPE PROGRAM FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/_setup_util.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install" TYPE PROGRAM FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/env.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/setup.bash;/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install" TYPE FILE FILES
    "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/setup.bash"
    "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/local_setup.bash"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/setup.sh;/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install" TYPE FILE FILES
    "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/setup.sh"
    "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/local_setup.sh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/setup.zsh;/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install" TYPE FILE FILES
    "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/setup.zsh"
    "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install" TYPE FILE FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/.rosinstall")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tiago_controller/srv" TYPE FILE FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/src/tiago_controller/srv/move.srv")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tiago_controller/cmake" TYPE FILE FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/tiago_controller-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/devel/.private/tiago_controller/include/tiago_controller")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/devel/.private/tiago_controller/share/roseus/ros/tiago_controller")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/devel/.private/tiago_controller/share/common-lisp/ros/tiago_controller")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/devel/.private/tiago_controller/share/gennodejs/ros/tiago_controller")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/home/manu/anaconda3/bin/python3" -m compileall "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/devel/.private/tiago_controller/lib/python3/dist-packages/tiago_controller")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/devel/.private/tiago_controller/lib/python3/dist-packages/tiago_controller")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/tiago_controller.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tiago_controller/cmake" TYPE FILE FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/tiago_controller-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tiago_controller/cmake" TYPE FILE FILES
    "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/tiago_controllerConfig.cmake"
    "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/catkin_generated/installspace/tiago_controllerConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tiago_controller" TYPE FILE FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/src/tiago_controller/package.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tiago_controller" TYPE FILE FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/src/tiago_controller/controller_plugins.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tiago_controller/include" TYPE DIRECTORY FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/src/tiago_controller/include/")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tiago_controller/launch" TYPE DIRECTORY FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/src/tiago_controller/launch/")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tiago_controller/config" TYPE DIRECTORY FILES "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/src/tiago_controller/config/")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/gtest/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tiago_controller/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
