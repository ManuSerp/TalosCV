#!/usr/bin/env python
from __future__ import print_function
from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image, PointCloud2

import cv2
import rospy
import sys
from geometry_msgs.msg import Pose
import argparse
import sensor_msgs.point_cloud2 as pc2
from ast import Is
import math

from tiago_controller.srv import move


import roslib
roslib.load_manifest('tracker_cam')

parser = argparse.ArgumentParser(description='pcl_node')
parser.add_argument('--setup', default="docker", type=str,
                    help='docker if you use a docker with openni2 driver else robot')
args = parser.parse_args()


def toGrid(l):  # convert the list of pixels to a grid (640x480 is the size of the image with the Xtion)
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
        print('initialization...')
        self.depth_image = None
        self.bridge = CvBridge()
        self.received = False
        self.var = True
        self.aim = None

        if args.setup == "docker":
            self.setup = "camera"
        elif args.setup == "robot":
            self.setup = "xtion"

        self.dist_sub = rospy.Subscriber(
            "/"+self.setup+"/depth_registered/points", PointCloud2, self.maj_depthimage)  # subscribe to the topic of the depth image

        # subscribe to the topic of the center of the target
        self.tr_sub = rospy.Subscriber("/trcCenter", Pose, self.maj_center)
        # publish the spatial position of the target
        self.pub = rospy.Publisher("clouded", Pose, queue_size=10)

    def maj_center(self, data):  # update the aim of the target

        self.aim = [int(data.position.x), int(data.position.y)]

    def maj_depthimage(self, data):  # update the depth image

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

    def master(self):  # the main function of the node

        if self.received == True and self.var and self.aim != None:

            pcl = self.depth_image[self.aim[1]][self.aim[0]]
            if not math.isnan(pcl[0]):
                toTrans = Pose()
                toTrans.position.x = pcl[2]
                toTrans.position.y = -pcl[0]
                toTrans.position.z = -pcl[1]
                self.pub.publish(toTrans)


def main():
    rospy.init_node('depth_printer_ws', anonymous=True)
    print("version: "+args.setup)

    ic = image_converter()
    print('emitting cooordinate from pcl... ')
    rate = rospy.Rate(50)
    while not rospy.is_shutdown():

        ic.master()

        rate.sleep()

    cv2.destroyAllWindows()


if __name__ == '__main__':
    main()
