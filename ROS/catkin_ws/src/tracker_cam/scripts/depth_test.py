#!/usr/bin/env python
from __future__ import print_function
from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image, PointCloud2

import cv2
import rospy
import sys
import sensor_msgs.point_cloud2 as pc2
from ast import Is

from tiago_controller.srv import move


import roslib
roslib.load_manifest('tracker_cam')


def toGrid(l):
    res = [[0 for z in range(640)] for i in range(480)]
    x, y = 0, 0
    for p in l:

        res[y][x] = p
        if x < 639:
            x = x+1
        else:
            x = 0
            y = y+1

    return res


class image_converter:

    def __init__(self):
        print('ini')
        self.depth_image = None
        self.bridge = CvBridge()
        self.received = False
        self.var = True
        self.dist_sub = rospy.Subscriber(
            "/xtion/depth_registered/points", PointCloud2, self.maj_depthimage)

    def maj_depthimage(self, data):

        try:

            arr = pc2.read_points(
                data, skip_nans=False, field_names=("x", "y", "z"))  # inspect the matrix (y,z,x) dans mon referentiel parcours de gauche a droite je pense

            l = []
            for p in arr:
                l.append(p)

            res = toGrid(l)
            self.depth_image = res
            self.received = True

        except CvBridgeError as e:
            print(e)

    def master(self):

        if self.received == True and self.var:

            print(self.depth_image[0][0])


def main(args):
    rospy.init_node('depth_printer_ws', anonymous=True)

    ic = image_converter()
    print('debug')
    rate = rospy.Rate(50)
    while not rospy.is_shutdown():

        ic.master()

        rate.sleep()

    cv2.destroyAllWindows()


if __name__ == '__main__':
    main(sys.argv)
