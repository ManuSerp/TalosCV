#!/usr/bin/env python
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
    print('ini')
    self.first =False

    self.bridge = CvBridge()
    
    #self.image_sub = rospy.Subscriber("/camera/rgb/image_raw",Image,self.callback1)
    #self.dist_sub=message_filters.Subscriber("/camera/depth_registered/points",pc2.PointCloud2)
    self.dist_sub=rospy.Subscriber("/camera/depth/image",Image,self.callback2)


    
  def callback1(self,data):  
    print('callback1')
    try:
        cv_image = self.bridge.imgmsg_to_cv2(data, "bgr8")
        
        #print(depth_image)
        self.first=True

    except CvBridgeError as e:
      print(e)

    (rows,cols,channels) = cv_image.shape
    

    #gen = pc2.read_points_list(data2,skip_nans=True,field_names=("x", "y", "z")) 
    #print(list_locater(0,0,gen))
    
    

    font = cv2.FONT_HERSHEY_SIMPLEX  
    cv2.putText(cv_image, 'none', (10, 40),  font, 1,    (0, 255, 0),                  
                  2, 
                 cv2.LINE_4)
               

    # cv2.imshow("Image window", cv_image)
    if self.first==True:
      cv2.imshow("Image wazdavsdsdvzindow", cv_image)


    cv2.waitKey(3)

  def callback2(self,data):
      print('callback2')
      try:
        depth_image = self.bridge.imgmsg_to_cv2(data) #inspect the matrix
        print(depth_image)
        self.first=True
    
    

      except CvBridgeError as e:
        print(e)

    # cv2.imshow("Image window", cv_image)
      if self.first==True:
          cv2.imshow("Image wazdazindow", depth_image)


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



