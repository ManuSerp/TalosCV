#!/bin/bash
echo '---------------------------------------------------------------------------------------'
source ./devel/setup.bash
echo 'ROS TRACKING SCRIPT LAUNCHER'
echo '1 - Tracking webcam'
echo '2 - Xtion feed'
echo '3 - Tracking webcam'
echo '4 - depth webcam'
echo ' cmp for catkin'






if [ $1 = 1 ]
then
    
    echo ' launching Tracking webcam'
    rosrun tracker_cam tracking.py --config src/tracker_cam/experiments/siamrpn_alex_dwxcorr/config.yaml    --snapshot src/tracker_cam/experiments/siamrpn_alex_dwxcorr/model.pth
    
fi

if [ $1 =  2 ] 
then
    
    echo 'launching Xtion feed'
    rosrun tracker_cam test.py
    

fi    

if [ $1 =  3 ] 
then
    
    echo 'launching tracking xtion'
    rosrun tracker_cam tracking_from_cam.py --config src/tracker_cam/experiments/siamrpn_alex_dwxcorr/config.yaml --snapshot src/tracker_cam/experiments/siamrpn_alex_dwxcorr/model.pth

    

fi  

if [ $1 =  4 ] 
then
    catkin build
    echo 'launching distance_printer'
    rosrun tracker_cam distance_printer.py

    

fi  

if [ $1 =  5 ] 
then
    catkin build
    echo 't3'
    rosrun tracker_cam test3.py

    

fi  

if [ $1 =  'cmp' ] 
then
    catkin build
  
    

fi  


echo '--------------------------------------------------------------------------------'
echo '--------------------------------------------------------------------------------'
echo '--------------------------------------------------------------------------------'




