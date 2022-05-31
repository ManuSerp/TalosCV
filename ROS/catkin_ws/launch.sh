#!/bin/bash
echo '---------------------------------------------------------------------------------------'
source ./devel/setup.bash



if [ $1 = 'man' ]
then
    
    echo 'ROS TRACKING SCRIPT LAUNCHER'
    echo '1 - Tracking webcam'
    echo '3 - Tracking xtion, use robot or docker as paramater'
    echo '6 - tracking for the robot, use robot or docker as paramater'
    echo '7 - depth from pcl, use robot or docker as paramater'
    echo ' cmp for catkin # available as an option for the previous programs'
    echo ' to make depth works well, launch first depth printer and then tracking xtion'
    echo '--------------------------------------------------------------------------------'
    echo '8 - doublecam'
    echo '10 - order robot 2 cam'
    
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

