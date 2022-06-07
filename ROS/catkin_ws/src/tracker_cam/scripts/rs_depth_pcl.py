#!/usr/bin/env python
from __future__ import print_function
from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image, PointCloud2
from cam.coordKCC import log
from image_geometry import PinholeCameraModel

import cv2
import rospy
import sys
from geometry_msgs.msg import Pose
import argparse
import sensor_msgs.point_cloud2 as pc2
from sensor_msgs.msg import CameraInfo
from ast import Is
import math

from tiago_controller.srv import move


import roslib
roslib.load_manifest('tracker_cam')

parser = argparse.ArgumentParser(description='pcl_node')
parser.add_argument('--setup', default="xtion", type=str,
                    help='docker if you use a docker with openni2 driver else robot')
args = parser.parse_args()


def dist(a, b):
    return (abs(a[0]-b[0])**2+abs(a[1]-b[1])**2)**0.5


def locate_indice(aim, pix_list):
    aim[0] = 1280-aim[0]
    indice = 0
    min = dist(aim, pix_list[0])
    for i in range(len(pix_list)):
        if dist(aim, pix_list[i]) < min:
            min = dist(aim, pix_list[i])
            indice = i
    return indice


class image_converter:

    def __init__(self):
        print('initialization...')
        self.depth_image = None
        self.pixl = None
        self.bridge = CvBridge()
        self.received = False
        self.var = True
        self.aim = None
        self.setup = args.setup
        self.rs_model = PinholeCameraModel()
        self.rs_model.fromCameraInfo(rospy.wait_for_message(
            "/camera/depth/camera_info", CameraInfo))

        if args.setup == "xtion":

            self.dist_sub = rospy.Subscriber(
                "/"+self.setup+"/depth_registered/points", PointCloud2, self.maj_depthimage)  # subscribe to the topic of the depth image
        else:
            self.dist_sub = rospy.Subscriber(
                "/"+self.setup+"/depth/color/points", PointCloud2, self.maj_depthimage)
        # subscribe to the topic of the center of the target
        self.tr_sub = rospy.Subscriber(
            "/trcCenter_"+self.setup, Pose, self.maj_center)
        # publish the spatial position of the target
        self.pub = rospy.Publisher("clouded_"+self.setup, Pose, queue_size=10)

    def toPix(self, l):
        ret = []
        for x in l:
            ret.append(self.rs_model.project3dToPixel(x))
        return ret

    def maj_center(self, data):  # update the aim of the target

        self.aim = [int(data.position.x), int(data.position.y)]

    def maj_depthimage(self, data):  # update the depth image

        try:

            arr = pc2.read_points(
                data, skip_nans=True, field_names=("x", "y", "z"))  # inspect the matrix (y,z,x) dans mon referentiel parcours de gauche a droite je pense

            l = []

            for p in arr:
                l.append(p)
                res = l

            self.depth_image = res
            self.pixl = self.toPix(res)

            self.received = True

        except CvBridgeError as e:
            print(e)

    def master(self):  # the main function of the node

        if self.received == True and self.var and self.aim != None:
            x_transfo = (1280-self.aim[0])/860.6
            y_transfo = (720-self.aim[1])/471.7
            indice = locate_indice([x_transfo, y_transfo], self.pixl)
            pcl = self.depth_image[indice]
            print(self.pixl[indice])
            print([x_transfo, y_transfo])
            print(pcl)

            # vas de angle bas droite a haut gauche mid a 430.3 235.85 etallonage pixers a faire
            #print(self.rs_model.project3dToPixel([0.5, -0.2, 1]))

            # if not math.isnan(pcl[0]):
            #     toTrans = Pose()
            #     toTrans.position.x = pcl[2]
            #     toTrans.position.y = -pcl[0]
            #     toTrans.position.z = -pcl[1]
            #     self.pub.publish(toTrans)
            #     print(toTrans)
            # else:
            #     print("no depth")
            #     print(pcl)
        else:
            print("wait")
            print(self.received)
            print("/"+self.setup+"/depth_registered/points")


def main():
    rospy.init_node('depth_printer_'+args.setup, anonymous=True)
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
