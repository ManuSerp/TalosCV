#!/usr/bin/env python3
from __future__ import print_function

import roslib
roslib.load_manifest('tracker_cam')
from tracker_cam.msg import center_Array

import sys
import rospy
import message_filters
import cv2
import sensor_msgs.point_cloud2 as pc2
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
    self.first =False

    self.bridge = CvBridge()
    self.center = message_filters.Subscriber("trcCenter",center_Array)
    self.dist_sub=message_filters.Subscriber("/camera/depth/image",Image)

    
    self.ts = message_filters.ApproximateTimeSynchronizer([self.center, self.dist_sub], 10, 0.5, allow_headerless=True)
    self.ts.registerCallback(self.callback)

  def callback(self,data1,data2):  
    print('callback')
    try:
        
        depth_image = self.bridge.imgmsg_to_cv2(data2) #inspect the matrix
        #print(depth_image)
        self.first=True

    except CvBridgeError as e:
      print(e)

  
    

    #gen = pc2.read_points_list(data2,skip_nans=True,field_names=("x", "y", "z")) 
    #print(list_locater(0,0,gen))
    
    

  

    # cv2.imshow("Image window", cv_image)
    if self.first==True:
      cv2.imshow("Image window", depth_image)
      print(data1)


    cv2.waitKey(3)

    
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



