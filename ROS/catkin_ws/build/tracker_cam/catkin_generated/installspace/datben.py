#!/usr/bin/env python3
from __future__ import print_function
from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image, PointCloud2

import cv2
import rospy
import sys
import sensor_msgs.point_cloud2 as pc2
from ast import Is


import roslib
roslib.load_manifest('tracker_cam')


class image_converter:

    def __init__(self):
        print('ini')

        self.received = False

        self.dist_sub = rospy.Subscriber(
            "/xtion/depth_registered/points", PointCloud2, self.maj_depthimage)

    def maj_depthimage(self, data):
        self.received = True

    def master(self):

        if self.received == True:
            print("ay")


def main(args):
    rospy.init_node('datben', anonymous=True)

    ic = image_converter()
    print('debug')
    rate = rospy.Rate(50)
    while not rospy.is_shutdown():

        ic.master()

        rate.sleep()

    cv2.destroyAllWindows()


if __name__ == '__main__':
    main(sys.argv)
