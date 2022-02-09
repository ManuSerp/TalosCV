#!/usr/bin/env python

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

from __future__ import print_function

from cam.coordKCC import angleCenter
from pysot.tracker.tracker_builder import build_tracker
from pysot.models.model_builder import ModelBuilder
from pysot.core.config import cfg
import importlib
from glob import glob
import numpy as np
import torch
import argparse
import os
from cv_bridge import CvBridge, CvBridgeError
from sensor_msgs.msg import Image
from geometry_msgs.msg import Pose
from std_msgs.msg import String
import cv2
import time
import rospy
import sys
from tracker_cam.msg import center_Array

import roslib
roslib.load_manifest('tracker_cam')


torch.set_num_threads(1)

parser = argparse.ArgumentParser(description='tracking node')
parser.add_argument('--config', type=str, help='config file')
parser.add_argument('--snapshot', type=str, help='model name')
parser.add_argument('--video_name', default='', type=str,
                    help='videos or image files')
parser.add_argument('--setup', default="docker", type=str,
                    help='docker if you use a dcoker with openni2 driver else robot')
args = parser.parse_args()


class image_converter:

    def __init__(self):
        # load config
        print("load config")
        cfg.merge_from_file(args.config)
        cfg.CUDA = torch.cuda.is_available() and cfg.CUDA
        self.device = torch.device('cuda' if cfg.CUDA else 'cpu')

        # create model
        print("create model")
        self.model = ModelBuilder()

        # load model
        print("load model")
        self.model.load_state_dict(torch.load(args.snapshot,
                                              map_location=lambda storage, loc: storage.cpu()))
        self.model.eval().to(self.device)

        # build tracker
        print("build tracker")
        self.tracker = build_tracker(self.model)
        # ROS config
        if args.setup == "docker":
            self.setup = "camera"
        elif args.setup == "robot":
            self.setup = "xtion"

        print("setup: "+self.setup)

        self.run = 0
        self.first_frame = True
        self.bridge = CvBridge()
        # /xtion/rgb/image_raw pr robot camera pr gazebo
        self.image_sub = rospy.Subscriber(
            "/"+self.setup+"/rgb/image_raw", Image, self.callback)
        self.pub = rospy.Publisher("trcCenter", Pose, queue_size=10)
        self.cpt = 0
        self.flt = 4

    def callback(self, data):
        try:
            frame = self.bridge.imgmsg_to_cv2(data, "bgr8")
        except CvBridgeError as e:
            print(e)

        if self.cpt == self.flt:
            self.compute_frame(frame)
            self.cpt = 0
        else:
            self.cpt = self.cpt+1

    def compute_frame(self, frame):
        if self.first_frame:
            if self.run > 3:

                try:
                    print('first_frame')
                    init_rect = cv2.selectROI(
                        'xtion_feed_roi', frame, False, False)
                    cv2.destroyAllWindows()
                    self.first_frame = False
                except:
                    exit()

                self.tracker.init(frame, init_rect)
            else:
                print(self.run)
                self.run = self.run+1

        else:
            s = time.time()
            outputs = self.tracker.track(frame)
            if 'polygon' in outputs:

                polygon = np.array(outputs['polygon']).astype(np.int32)

                cv2.polylines(frame, [polygon.reshape((-1, 1, 2))],
                              True, (0, 255, 0), 3)
                mask = ((outputs['mask'] > cfg.TRACK.MASK_THERSHOLD * 255))
                mask = mask.astype(np.uint8)
                mask = np.stack([mask, mask*255, mask]).transpose(1, 2, 0)
                frame = cv2.addWeighted(frame, 0.77, mask, 0.23, -1)
            else:
                bbox = list(map(int, outputs['bbox']))

                cv2.rectangle(frame, (bbox[0], bbox[1]),
                              (bbox[0]+bbox[2], bbox[1]+bbox[3]),
                              (0, 255, 0), 3)

                # affichage des angles
                angle = angleCenter(bbox)
                print(angle[2])

                test = Pose()
                test.position.x = angle[2][0]
                test.position.y = angle[2][1]

                self.pub.publish(test)
                font = cv2.FONT_HERSHEY_SIMPLEX
                cv2.putText(frame, 'HZ:' + str(int(angle[0]))+'deg VT:'+str(int(angle[1]))+'deg', (10, 40),  font, 1,    (0, 255, 0),
                            2,
                            cv2.LINE_4)

                # fin angles
            e = time.time()
            print(e-s)
            cv2.imshow('xtion_feed', frame)
            cv2.waitKey(40)


def main(args):
    ic = image_converter()
    rospy.init_node('image_tracker', anonymous=True)
    try:
        rospy.spin()
    except KeyboardInterrupt:
        print("Shutting down")
    cv2.destroyAllWindows()


if __name__ == '__main__':
    main(args)
