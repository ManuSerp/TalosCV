rsync -av /home/pal/install/ /home/pal/catkin_ws/devel/
cd /home/pal/catkin_ws/
catkin_make -DCMAKE_BUILD_TYPE=RELEASE
rm -rf *pal*
rosrun pal_deploy deploy.py 192.168.1.162
cp -r devel/* install_pal_deploy/home/pal/deployed_ws/
rsync -avz /home/pal/catkin_ws/install_pal_deploy/home/pal/deployed_ws/ pal@192.168.1.162:/home/pal/deployed_ws
rsync -avz /home/pal/catkin_ws/src/ pal@192.168.1.162:/home/pal/deployed_ws/src

