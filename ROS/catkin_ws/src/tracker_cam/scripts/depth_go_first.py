#!/usr/bin/env python
from __future__ import print_function
import roslib
import argparse
import math
from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image
from std_srvs.srv import Empty
from geometry_msgs.msg import Pose
import cv2
import rospy
import sys
import time
from ast import Is
from cam.coordKCC import spatialization, isMoving, realCoord
from tiago_controller.srv import move


parser = argparse.ArgumentParser(description='depth master node')
parser.add_argument('--setup', default="docker", type=str,
                    help='docker if you use a docker with openni2 driver else robot')
args = parser.parse_args()

roslib.load_manifest('tracker_cam')


def dist_pt(x, y, pt):
    return (pt[0]-x)**2 + (pt[2]-y)**2


def list_locater(x, y, L):
    min = L[0]
    d = dist_pt(x, y, min)
    for pt in L:
        nd = dist_pt(x, y, pt)
        if nd < d:
            min = pt
    return min


class image_converter:

    def __init__(self):
        print('initialisation...')
        self.first = False
        self.depth_image = None
        self.centerPT = None
        self.pcl = None
        self.head = None
        self.go = False
        if args.setup == "docker":
            self.setup = "camera"
        elif args.setup == "robot":
            self.setup = "xtion"

        self.bridge = CvBridge()
        self.center = rospy.Subscriber("/trcCenter", Pose, self.maj_center)
        self.dist_sub = rospy.Subscriber(
            "/"+self.setup+"/depth/image", Image, self.maj_depthimage)
        self.pose_head = rospy.Subscriber(
            "/tiago_controller/head_pose", Pose, self.get_head)
        self.pose_ee = rospy.Subscriber(
            "/tiago_controller/ee_pose", Pose, self.get_ee)
        self.pcl = rospy.Subscriber(
            "/clouded", Pose, self.get_pcl)
        self.pub = rospy.Publisher(
            "/tiago_controller/ee_target", Pose, queue_size=10)

        # mode
        self.mode = "traj"
        self.reach = False
        self.aim = None
        self.ee_pose = None
        self.traj_mode()

    def get_pcl(self, data):
        self.pcl = [data.position.x, data.position.y, data.position.z]

    def get_ee(self, data):
        self.ee_pose = [data.position.x, data.position.y, data.position.z]

    def maj_depthimage(self, data):

        try:

            self.depth_image = self.bridge.imgmsg_to_cv2(
                data)  # inspect the matrix
            # print(depth_image)
            self.first = True

        except CvBridgeError as e:
            print(e)

    def maj_center(self, data):
        self.centerPT = [int(data.position.x), int(data.position.y)]

    def get_head(self, data):
        self.head = data

    def master(self):

        if self.centerPT != None and self.first and self.head != None and self.ee_pose != None:

            cv2.imshow("Image window", self.depth_image)

            dst = self.depth_image[self.centerPT[1]][self.centerPT[0]]
            if math.isnan(dst):
                print("NAN ERROR")

            if not self.go and not math.isnan(dst):

                self.go = True
                head_p = [self.head.position.x,
                          self.head.position.y, self.head.position.z]

                spz = spatialization(self.centerPT, dst)
                print("TRAJECTORY INIT")
                print("referentiel cam")
                print(spz)
                print("pcl:")
                print(self.pcl)
                print("referentiel robot:")
                spz = realCoord(spz, head_p)
                print(spz)
                self.aim = spz
                print("move to track pos")
                self.trc(spz, 5, False, True, "ee")
                time.sleep(5)

            if self.go and not math.isnan(dst):
                if not self.reach:
                    self.reach = True
                    self.track_mode()
                    print("TRACK MODE ARMED")

                elif self.mode == 'track':

                    head_p = [self.head.position.x,
                              self.head.position.y, self.head.position.z]
                    spz = spatialization(self.centerPT, dst)
                    print("referentiel cam")
                    print(spz)
                    print("referentiel du robot:")
                    spz = realCoord(spz, head_p)
                    print(spz)
                    self.aim = spz
                    print("move tracking")

                    trk = Pose()
                    trk.position.x = spz[0]
                    trk.position.y = spz[1]
                    trk.position.z = spz[2]
                    trk.orientation = self.head.orientation

                    self.pub.publish(trk)

            cv2.waitKey(3)

    def track_mode(self):
        rospy.wait_for_service('tiago_controller/tracking_mode')
        try:
            mv = rospy.ServiceProxy('tiago_controller/tracking_mode', Empty)

            mv()
            self.mode = 'track'

            return 1
        except rospy.ServiceException as e:
            print("Service call failed: %s" % e)

    def traj_mode(self):
        rospy.wait_for_service('tiago_controller/traj_mode')
        try:
            mv = rospy.ServiceProxy('tiago_controller/traj_mode', Empty)

            mv()
            self.mode = 'traj'

            return 1
        except rospy.ServiceException as e:
            print("Service call failed: %s" % e)

    def trc(self, pose, duration, orientation, position, task):
        rospy.wait_for_service('tiago_controller/move')
        try:
            mv = rospy.ServiceProxy('tiago_controller/move', move)
            mr = Pose()
            mr.position.x = pose[0]
            mr.position.y = pose[1]
            mr.position.z = pose[2]

            mv(mr, duration, orientation, position, task)
            return 1
        except rospy.ServiceException as e:
            print("Service call failed: %s" % e)


def main(args):

    rospy.init_node('depth_master', anonymous=True)

    print("version: "+args.setup)

    ic = image_converter()

    print('looping...')
    rate = rospy.Rate(50)
    while not rospy.is_shutdown():

        ic.master()

        rate.sleep()

    cv2.destroyAllWindows()


if __name__ == '__main__':
    main(sys.argv)
