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

echo_and_run cd "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/src/rbx1/rbx1_nav"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/lib/python3/dist-packages:/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/rbx1_nav/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/rbx1_nav" \
    "/home/manu/anaconda3/bin/python3" \
    "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/src/rbx1/rbx1_nav/setup.py" \
     \
    build --build-base "/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/build/rbx1_nav" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install" --install-scripts="/home/manu/Documents/Projet/RECH/Tracking/TalosCV/ROS/catkin_ws/install/bin"
