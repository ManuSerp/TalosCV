#!/bin/bash
echo '---------------------------------------------------------------------------------------'
source ./devel/setup.bash
echo 'ROS TRACKING SCRIPT LAUNCHER'
echo '1 - Tracking webcam'
echo '2 - Xtion feed'
echo '3 - Tracking webcam'
echo '$?'
read varname




if [ $varname = 1 ]
then
    
    echo ' launching Tracking webcam'
    rosrun tracker_cam tracking.py --config src/tracker_cam/experiments/siamrpn_alex_dwxcorr/config.yaml    --snapshot src/tracker_cam/experiments/siamrpn_alex_dwxcorr/model.pth
    
fi

if [ $varname =  2 ] 
then
    
    echo 'launching Xtion feed'
    rosrun tracker_cam test.py
    

fi    

if [ $varname =  3 ] 
then
    
    echo 'launching tracking xtion'
    rosrun tracker_cam tracking_from_cam.py --config src/tracker_cam/experiments/siamrpn_alex_dwxcorr/config.yaml --snapshot src/tracker_cam/experiments/siamrpn_alex_dwxcorr/model.pth

    

fi  


echo '--------------------------------------------------------------------------------'
echo 'oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo'
echo '--------------------------------------------------------------------------------'




