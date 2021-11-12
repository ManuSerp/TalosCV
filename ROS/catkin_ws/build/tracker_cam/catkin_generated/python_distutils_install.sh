#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/src/tracker_cam"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/lib/python3/dist-packages:/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tracker_cam/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tracker_cam" \
    "/home/manu/anaconda3/bin/python3" \
    "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/src/tracker_cam/setup.py" \
    egg_info --egg-base /home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tracker_cam \
    build --build-base "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/tracker_cam" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install" --install-scripts="/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/bin"
