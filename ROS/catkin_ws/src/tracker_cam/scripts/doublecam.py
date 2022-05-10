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

parser = argparse.ArgumentParser(description='doublecam_node')
parser.add_argument('--setup', default="docker", type=str,
                    help='docker if you use a docker with openni2 driver else robot')
args = parser.parse_args()


class pos_selector:

    def __init__(self):
        print('initialization...')
        self.cam1 = None
        self.cam2 = None
        self.bridge = CvBridge()
        self.received1 = False
        self.received2 = False

        if args.setup == "docker":
            self.setup = "camera"
        elif args.setup == "robot":
            self.setup = "xtion"

        # subscribe to the topic of first camera
        self.sub1 = rospy.Subscriber("/clouded1", Pose, self.maj1)
        # subscribe to the topic of second camera
        self.sub2 = rospy.Subscriber("/clouded2", Pose, self.maj2)

        # publish the choosed spatial position of the target
        self.pub = rospy.Publisher("clouded_final", Pose, queue_size=10)

    def maj1(self, data):
        self.cam1 = data
        self.received2 = True

    def maj2(self, data):
        self.cam2 = data
        self.received2 = True

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
    rospy.init_node('doublecam', anonymous=True)
    print("version: "+args.setup)

    ic = pos_selector()
    print('emitting cooordinate from the two cam... ')
    rate = rospy.Rate(50)
    while not rospy.is_shutdown():

        ic.master()

        rate.sleep()

    cv2.destroyAllWindows()


if __name__ == '__main__':
    main()
