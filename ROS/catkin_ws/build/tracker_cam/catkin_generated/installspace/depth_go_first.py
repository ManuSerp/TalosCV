#!/usr/bin/env python3
from __future__ import print_function
from cam.coordKCC import mapper


import roslib
roslib.load_manifest('tracker_cam')
from tracker_cam.msg import center_Array

import sys
import rospy
import cv2
import sensor_msgs.point_cloud2 as pc2
from geometry_msgs.msg import Pose

from std_msgs.msg import String
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError
def dist_pt(x,y,pt):
    return (pt[0]-x)**2  +(pt[2]-y)**2

def list_locater(x,y,L):
    min=L[0]
    d=dist_pt(x,y,min)
    for pt in L:
        nd=dist_pt(x,y,pt)
        if nd<d:
            min=pt
    return min

class image_converter:

  def __init__(self):
    print('ini')
    self.first = False
    self.depth_image = None
    self.centerPT = None
    self.head=None

    self.bridge = CvBridge()
    self.center = rospy.Subscriber("/trcCenter",Pose,self.maj_center)
    self.dist_sub = rospy.Subscriber("/xtion/depth/image",Image,self.maj_depthimage)
    self.pose_head=rospy.Subscriber("/tiago_controller/head_pose",Pose,self.get_head)

    
  


  def maj_depthimage(self,data):

    print('callback depth image')
    try:
        
        self.depth_image = self.bridge.imgmsg_to_cv2(data) #inspect the matrix
        #print(depth_image)
        self.first=True

    except CvBridgeError as e:
      print(e)


  def maj_center(self,data):
    self.centerPT=[int(data.position.x),int(data.position.y)]
  def get_head(self,data):
    print('callback head')
    self.head=data
  def master(self):  
    print('callback master')

    if self.centerPT != None and self.first and self.head != None:
    

      cv2.imshow("Image window", self.depth_image)
      
      print(self.centerPT)
      print(self.head)

      dst=self.depth_image[self.centerPT[1]][self.centerPT[0]]
      print(dst)


      


      cv2.waitKey(3)

  def trc(self,pose,duration,orientation,position,task):
    rospy.wait_for_service('tiago_controller/move')
    try:
      mv = rospy.ServiceProxy('tiago_controller/move', move)
      mr=Pose()
      mr.position.x=pose[0]
      mr.position.y=pose[1]
      mr.position.z=pose[2]

      mv(mr,duration,orientation,position,task)
      return 1
    except rospy.ServiceException as e:
        print("Service call failed: %s"%e)    

    
def main(args):
  rospy.init_node('depth_printer_w', anonymous=True)

  ic = image_converter()
  print('debug')
  rate = rospy.Rate(50)
  while not rospy.is_shutdown():

    ic.master()
    
    rate.sleep()
  
  cv2.destroyAllWindows()

if __name__ == '__main__':
    main(sys.argv)
