#!/usr/bin/env python
from __future__ import print_function
from cam.coordKCC import spatialization,isMoving,realCoord

import roslib
roslib.load_manifest('tracker_cam')
from tracker_cam.msg import center_Array
from tiago_controller.srv import move

import sys
import rospy
import message_filters
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
    print('initialization')
    self.first =False
    self.previous=None
    self.bridge = CvBridge()
    print("subscribing")
    self.center = message_filters.Subscriber("trcCenter",center_Array)
    self.dist_sub=message_filters.Subscriber("/camera/depth/image",Image)       #/xtion/depth_registered/image_raw pr robot

    self.pose_head=message_filters.Subscriber("/tiago_controller/head_pose",Pose)

    print("synchronizing")
    self.ts = message_filters.ApproximateTimeSynchronizer([self.center, self.dist_sub,self.pose_head], 10, 0.5, allow_headerless=True)
    self.ts.registerCallback(self.callback)

  def callback(self,data1,data2,data3):  
    print('callback')
    try:
        
        depth_image = self.bridge.imgmsg_to_cv2(data2) #inspect the matrix
        #print(depth_image)
        self.first=True

    except CvBridgeError as e:
      print(e)

  
    

    
    if self.first==True:
      cv2.imshow("Image window", depth_image)
      
      
      dst=depth_image[data1.data[1]][data1.data[0]]
      spz =spatialization(data1.data,dst)
      print("referentiel cam") #
      print(spz)
      print("referetneil du robot:")
      spz = realCoord(spz,data3.position)
      print(spz)
      if self.previous == None:
        self.previous=spz
        print("move")
        self.trc(spz,1,False,True,"ee")

      if isMoving(self.previous,spz):

        print("move")
        self.trc(spz,1,False,True,"ee")
        self.previous=spz


      


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
  rospy.init_node('image_converter', anonymous=True)

  ic = image_converter()
  print('debug')
  try:
    print('debug')
    rospy.spin()
  except KeyboardInterrupt:
    print("Shutting down")
  cv2.destroyAllWindows()

if __name__ == '__main__':
    main(sys.argv)



