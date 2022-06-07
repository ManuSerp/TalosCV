#!/usr/bin/env python3
from __future__ import print_function
from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image, PointCloud2
from cam.coordKCC import realCoord, log, isMoving, transfoAng
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
        self.received3 = False
        self.head = None

        if args.setup == "docker":
            self.setup = "camera"
        elif args.setup == "robot":
            self.setup = "xtion"

        # subscribe to the topic of first camera
        self.sub1 = rospy.Subscriber("/clouded_xtion", Pose, self.maj1)
        # subscribe to the topic of second camera
        self.sub2 = rospy.Subscriber("/clouded_"+args.setup, Pose, self.maj2)
        self.pose_head = rospy.Subscriber(
            "/tiago_controller/head_pose", Pose, self.get_head)
        # publish the choosed spatial position of the target
        self.pub = rospy.Publisher("clouded_final", Pose, queue_size=10)

    def maj1(self, data):
        print("maj1")
        self.cam1 = data
        self.received1 = True

    def maj2(self, data):
        print("maj2")
        self.cam2 = data
        self.received2 = True

    def get_head(self, data):
        self.head = data
        self.received3 = True

    def master(self):  # the main function of the node

        if self.received1 and self.received2 and self.received3:
            head_p = [self.head.position.x,
                      self.head.position.y, self.head.position.z]
            cam1 = [self.cam1.position.x,
                    self.cam1.position.y, self.cam1.position.z]
            spz1 = realCoord(cam1, head_p)

            # la vas falloit la transfo de la cam2

            # A changer -40deg H 0.666m tiago:28 par 33
            #spz2 = realCoord(self.cam2, head_p)
            cam2 = [self.cam2.position.x,
                    self.cam2.position.y, self.cam2.position.z]
            spz2 = transfoAng(cam2, 40*math.pi/180)

            print("----------------------------------------------------")
            print("debug:")
            print(spz1)
            print(spz2)

            if isMoving(spz1, spz2, 0.05):
                # publish the choosed spatial position of the target
                p_spz2 = Pose()
                p_spz2.position.x = spz2[0]
                p_spz2.position.y = spz2[1]
                p_spz2.position.z = spz2[2]

                self.pub.publish(p_spz2)
            else:
                p_spz1 = Pose()
                p_spz1.position.x = spz1[0]
                p_spz1.position.y = spz1[1]
                p_spz1.position.z = spz1[2]
                self.pub.publish(spz1)

        else:
            print("waiting for data...")
            print(self.received1, self.received2)


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
