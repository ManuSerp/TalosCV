#!/bin/bash
echo '---------------------------------------------------------------------------------------'
source ./devel/setup.bash



if [ $1 = 'man' ]
then
    
    echo 'ROS TRACKING SCRIPT LAUNCHER'
    echo '1 - Tracking webcam'
    echo '2 - Xtion feed'
    echo '3 - Tracking xtion'
    echo '4 - depth webcam with servo'
    echo '5 - depth webcam without servo'
    echo ' cmp for catkin # available as an option for the previous programs'
    echo ' to make depth works well, launch first depth printer and then tracking xtion'
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

if [ $1 =  2 ]
then
    
    if [ $2 = 'cmp' ]
    then
        
        catkin build tracker_cam
        
    fi
    
    echo 'launching Xtion feed'
    rosrun tracker_cam test.py
    
    
fi

if [ $1 =  3 ]
then
    if [ $2 = 'cmp' ]
    then
        
        catkin build tracker_cam
        
    fi
    
    echo 'launching tracking xtion'
    rosrun tracker_cam tracking_from_cam.py --config src/tracker_cam/experiments/siamrpn_alex_dwxcorr/config.yaml --snapshot src/tracker_cam/experiments/siamrpn_alex_dwxcorr/model.pth
    
    
    
fi

if [ $1 =  4 ]
then
    if [ $2 = 'cmp' ]
    then
        
        catkin build tracker_cam
        
    fi
    echo 'launching distance_printer with servo'
    rosrun tracker_cam distance_printer.py
    
    
    
fi
if [ $1 =  5 ]
then
    if [ $2 = 'cmp' ]
    then
        
        catkin build tracker_cam
        
    fi
    echo 'depth printer without robot  movements'
    rosrun tracker_cam tracking_cam_wservo.py --config src/tracker_cam/experiments/siamrpn_alex_dwxcorr/config.yaml --snapshot src/tracker_cam/experiments/siamrpn_alex_dwxcorr/model.pth
    
    
    
fi
if [ $1 =  6 ]
then
    if [ $2 = 'cmp' ]
    then
        
        catkin build tracker_cam
        
    fi
    echo 'depth printer without robot  movements'
    rosrun tracker_cam depth_go_first.py --config src/tracker_cam/experiments/siamrpn_alex_dwxcorr/config.yaml --snapshot src/tracker_cam/experiments/siamrpn_alex_dwxcorr/model.pth
    
    
    
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

