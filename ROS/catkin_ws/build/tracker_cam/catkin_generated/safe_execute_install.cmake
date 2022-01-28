execute_process(COMMAND "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tracker_cam/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tracker_cam/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
