cmake_minimum_required(VERSION 3.13 FATAL_ERROR)
project(tiago_controller)


option(TIAGO_MSGS_ONLY "Build only the messages" ON)

if (${TIAGO_MSGS_ONLY} STREQUAL "ON")

message("tiago_controller: building only the messages") 

find_package(catkin REQUIRED COMPONENTS
  std_msgs
  message_generation
  std_srvs
  geometry_msgs
)

add_service_files(
  FILES
  move.srv
)


generate_messages(
  DEPENDENCIES
  std_msgs
  geometry_msgs
)

else()


find_package(inria_wbc REQUIRED)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
  hardware_interface
  pluginlib
  controller_interface
  message_generation
  std_srvs
  geometry_msgs
)

add_service_files(
  FILES
  move.srv
)


generate_messages(
  DEPENDENCIES
  std_msgs
  geometry_msgs
)



catkin_package(CATKIN_DEPENDS 
  roscpp 
  std_msgs 
  std_srvs
  hardware_interface 
  pluginlib 
  controller_interface 
  message_runtime
  geometry_msgs
)


add_library(tiago_joint_controller SHARED 
  src/joint_controller.cpp # ros_control controller (using inria_wbc)
  src/behavior_move.cpp # inria_wbc behavior
)

target_compile_options(tiago_joint_controller PRIVATE -Wno-shadow)
target_compile_features(tiago_joint_controller PUBLIC cxx_std_11)
target_link_options(tiago_joint_controller PRIVATE "LINKER:--no-as-needed")

target_include_directories(tiago_joint_controller
 PUBLIC
   ${catkin_INCLUDE_DIRS}
   ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_link_libraries(tiago_joint_controller
  PUBLIC
    ${catkin_LIBRARIES}
    inria_wbc::inria_wbc
)

SET_TARGET_PROPERTIES(tiago_joint_controller  PROPERTIES LINK_FLAGS -Wl,-no-as-needed)

install(TARGETS tiago_joint_controller
   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(FILES controller_plugins.xml
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})

install(DIRECTORY include/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/include)

install(DIRECTORY launch/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch)

install(DIRECTORY config/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/config)


endif()

