#!/usr/bin/env python3
from __future__ import print_function

import roslib
roslib.load_manifest('tracker_cam')
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
    self.first =True

    self.bridge = CvBridge()
    self.image_sub = message_filters.Subscriber("/camera/rgb/image_raw",Image)
    #self.dist_sub=message_filters.Subscriber("/camera/depth_registered/points",pc2.PointCloud2)
    self.dist_sub=message_filters.Subscriber("/camera/depth_registered/image_raw",Image)

    
    self.ts = message_filters.ApproximateTimeSynchronizer([self.image_sub, self.dist_sub], 10, 0.1, allow_headerless=True)
    self.ts.registerCallback(self.callback)

  def callback(self,data1,data2):  
    try:
        cv_image = self.bridge.imgmsg_to_cv2(data1, "bgr8")
        depth_image = self.bridge.imgmsg_to_cv2(data2, "mono8")

    except CvBridgeError as e:
      print(e)

    (rows,cols,channels) = cv_image.shape
    #gen = pc2.read_points_list(data2,skip_nans=True,field_names=("x", "y", "z")) 
    #print(list_locater(0,0,gen))
    
    

    font = cv2.FONT_HERSHEY_SIMPLEX  
    cv2.putText(cv_image, 'none', (10, 40),  font, 1,    (0, 255, 0),                  
                  2, 
                 cv2.LINE_4)
    font = cv2.FONT_HERSHEY_SIMPLEX  
    cv2.putText(depth_image, 'none', (10, 40),  font, 1,    (0, 255, 0),                  
                  2, 
                 cv2.LINE_4)             

    cv2.imshow("Image window", cv_image)
    cv2.imshow("Image window", depth_image)

    cv2.waitKey(3)

    
def main(args):
  rospy.init_node('image_converter', anonymous=True)

  ic = image_converter()
  try:
    rospy.spin()
  except KeyboardInterrupt:
    print("Shutting down")
  cv2.destroyAllWindows()

if __name__ == '__main__':
    main(sys.argv)


