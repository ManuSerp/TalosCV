;; Auto-generated. Do not edit!


(when (boundp 'tracker_cam::center_Array)
  (if (not (find-package "TRACKER_CAM"))
    (make-package "TRACKER_CAM"))
  (shadow 'center_Array (find-package "TRACKER_CAM")))
(unless (find-package "TRACKER_CAM::CENTER_ARRAY")
  (make-package "TRACKER_CAM::CENTER_ARRAY"))

(in-package "ROS")
;;//! \htmlinclude center_Array.msg.html


(defclass tracker_cam::center_Array
  :super ros::object
  :slots (_data ))

(defmethod tracker_cam::center_Array
  (:init
   (&key
    ((:data __data) (make-array 2 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _data __data)
   self)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:serialization-length
   ()
   (+
    ;; int32[2] _data
    (* 4    2)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32[2] _data
     (dotimes (i 2)
       (write-long (elt _data i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32[2] _data
   (dotimes (i (length _data))
     (setf (elt _data i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     )
   ;;
   self)
  )

(setf (get tracker_cam::center_Array :md5sum-) "8c6cd32143779d63a1fc14cd80d5fe67")
(setf (get tracker_cam::center_Array :datatype-) "tracker_cam/center_Array")
(setf (get tracker_cam::center_Array :definition-)
      "int32[2] data

")



(provide :tracker_cam/center_Array "8c6cd32143779d63a1fc14cd80d5fe67")


