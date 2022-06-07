#!/bin/bash
echo '---------------------------------------------------------------------------------------'
source ./devel/setup.bash



if [ $1 = 'man' ]
then
    
    echo 'ROS TRACKING SCRIPT LAUNCHER'
    echo '1 - Tracking from webcam'
    echo '3 - Launch the tracker for a specified camera, use the name of the camera as paramater, such as xtion or camera'
    echo '6 - command for the robot, this node order the robot to move, use xtion in case of one camera as paramater, else use final'
    echo '7 - depth from pcl, convert tracked pixels to spatial position, use the name of the camera as paramater, such as xtion or camera'
    echo '8 - doublecam, this node choice betwen two cameras and send them to the controler, use final as parameter'
    echo '10 - order robot 2 cam, in case of two cameras, use final as parameter'
    echo ' cmp for catkin # available as an option for the previous programs'
    echo ' to make depth works well, launch first depth printer and then tracking xtion'
    echo 'exemple: ./launch.sh 3 xtion'
    echo '--------------------------------------------------------------------------------'
    
    
fi



if [ $1 = 1 ]
then
    if [ $2 = 'cmp' ]
    then
        
        catkin build tracker_cam
        
    fi
    echo ' launching Tracking webcam'
    rosrun tracker_cam tracking.py --config src/tracker_cam/experiments/siamrpn_alex_dwxcorr/config.yaml    --snapshot src/tracker_cam/experiments/siamrpn_alex_dwxcorr/model.pth
    
fi


if [ $1 =  3 ]
then
    if [ $3 = 'cmp' ]
    then
        
        catkin build tracker_cam
        
    fi
    
    echo 'launching tracking xtion'
    rosrun tracker_cam tracking_from_cam.py --config src/tracker_cam/experiments/siamrpn_alex_dwxcorr/config.yaml --snapshot src/tracker_cam/experiments/siamrpn_alex_dwxcorr/model.pth --setup $2
    
    
    
fi


if [ $1 =  6 ]
then
    if [ $3 = 'cmp' ]
    then
        
        catkin build tracker_cam
        
    fi
    echo 'robot tracker'
    rosrun tracker_cam depth_go_first.py --setup $2 --margin 0
    
    
    
fi
if [ $1 =  7 ]
then
    if [ $3 = 'cmp' ]
    then
        
        catkin build tracker_cam
        
    fi
    echo 'pcl depth'
    rosrun tracker_cam depth_pcl.py --setup $2
    
    
    
fi
if [ $1 =  8 ]
then
    if [ $3 = 'cmp' ]
    then
        
        catkin build tracker_cam
        
    fi
    echo 'doublecam'
    rosrun tracker_cam doublecam.py --setup $2
    
    
    
fi
if [ $1 =  9 ]
then
    if [ $3 = 'cmp' ]
    then
        
        catkin build tracker_cam
        
    fi
    echo 'rs pcl depth'
    rosrun tracker_cam rs_depth_pcl.py --setup $2
    
    
    
fi
if [ $1 =  10 ]
then
    if [ $3 = 'cmp' ]
    then
        
        catkin build tracker_cam
        
    fi
    echo 'rs pcl depth'
    rosrun tracker_cam go_from_2cam.py --setup $2
    
    
    
fi





if [ $1 =  'cmp' ]
then
    catkin build
    
    
    
fi

echo 'ROS TRACKING SCRIPT LAUNCHER'

echo 'use man to see the list of options'
echo '--------------------------------------------------------------------------------'
echo '--------------------------------------------------------------------------------'
echo '--------------------------------------------------------------------------------'

