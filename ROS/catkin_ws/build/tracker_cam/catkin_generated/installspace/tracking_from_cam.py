#!/usr/bin/env python3

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

from __future__ import print_function

import roslib
roslib.load_manifest('tracker_cam')
import sys
import rospy
import cv2
from std_msgs.msg import String
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError

import os
import argparse

import torch
import numpy as np
from glob import glob
import importlib

from pysot.core.config import cfg
from pysot.models.model_builder import ModelBuilder
from pysot.tracker.tracker_builder import build_tracker




from cam.coordKCC import angleCenter



torch.set_num_threads(1)

parser = argparse.ArgumentParser(description='tracking demo')
parser.add_argument('--config', type=str, help='config file')
parser.add_argument('--snapshot', type=str, help='model name')
parser.add_argument('--video_name', default='', type=str,
                    help='videos or image files')
args = parser.parse_args()



class image_converter:

  def __init__(self):
    # load config
    cfg.merge_from_file(args.config)
    cfg.CUDA = torch.cuda.is_available() and cfg.CUDA
    self.device = torch.device('cuda' if cfg.CUDA else 'cpu')

    # create model
    self.model = ModelBuilder()

    # load model
    self.model.load_state_dict(torch.load(args.snapshot,
        map_location=lambda storage, loc: storage.cpu()))
    self.model.eval().to(self.device)

    # build tracker
    self.tracker = build_tracker(self.model)


    self.first_frame=True 
    self.bridge = CvBridge()
    self.image_sub = rospy.Subscriber("/camera/rgb/image_raw",Image,self.callback)

    cv2.namedWindow('xtion_feed', cv2.WND_PROP_FULLSCREEN)  


  def callback(self,data):
    try:
      frame = self.bridge.imgmsg_to_cv2(data, "bgr8")
    except CvBridgeError as e:
      print(e)



    if self.first_frame:
            try:
                init_rect = cv2.selectROI('xtion_feed', frame, False, False)
            except:
                exit()
            self.tracker.init(frame, init_rect)
            self.first_frame = False
    else:
            outputs = self.tracker.track(frame)
            if 'polygon' in outputs:

                polygon = np.array(outputs['polygon']).astype(np.int32)
                
                cv2.polylines(frame, [polygon.reshape((-1, 1, 2))],
                              True, (0, 255, 0), 3)
                mask = ((outputs['mask'] >  cfg.TRACK.MASK_THERSHOLD * 255))
                mask = mask.astype(np.uint8)
                mask = np.stack([mask, mask*255, mask]).transpose(1, 2, 0)
                frame = cv2.addWeighted(frame, 0.77, mask, 0.23, -1)
            else:
                bbox = list(map(int, outputs['bbox']))
                
                cv2.rectangle(frame, (bbox[0], bbox[1]),
                              (bbox[0]+bbox[2], bbox[1]+bbox[3]),
                              (0, 255, 0), 3)

                #### affichage des angles
                angle=angleCenter(bbox)
                font = cv2.FONT_HERSHEY_SIMPLEX  
                cv2.putText(frame, 'HZ:' +str(int(angle[0]))+'deg VT:'+str(int(angle[1]))+'deg Dist: ??', (10, 40),  font, 1,    (0, 255, 0),                  
                  2, 
                 cv2.LINE_4)

                 ### fin angles

            cv2.imshow('xtion_feed', frame)
            cv2.waitKey(40)

    

    

def main(args):
  ic = image_converter()
  rospy.init_node('image_converter', anonymous=True)
  try:
    rospy.spin()
  except KeyboardInterrupt:
    print("Shutting down")
  cv2.destroyAllWindows()



if __name__ == '__main__':
    main(args)


