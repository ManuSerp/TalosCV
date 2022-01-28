#!/usr/bin/env python
from __future__ import print_function
from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image

import cv2
import rospy
import sys
from ast import Is

from tiago_controller.srv import move


import roslib
roslib.load_manifest('tracker_cam')


class image_converter:

    def __init__(self):
        print('ini')
        self.depth_image = None
        self.bridge = CvBridge()
        self.received = False
        self.var = True
        self.dist_sub = rospy.Subscriber(
            "/camera/depth/image", Image, self.maj_depthimage)

    def maj_depthimage(self, data):

        try:

            self.depth_image = self.bridge.imgmsg_to_cv2(
                data)  # inspect the matrix
            # print(depth_image)
            self.received = True

        except CvBridgeError as e:
            print(e)

    def master(self):

        if self.received == True and self.var:

            cv2.imshow("Image window", self.depth_image)
            print(self.depth_image)
            self.var = False

            cv2.waitKey(3)


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
