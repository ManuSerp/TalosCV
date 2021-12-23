;; Auto-generated. Do not edit!


(when (boundp 'tiago_controller::move)
  (if (not (find-package "TIAGO_CONTROLLER"))
    (make-package "TIAGO_CONTROLLER"))
  (shadow 'move (find-package "TIAGO_CONTROLLER")))
(unless (find-package "TIAGO_CONTROLLER::MOVE")
  (make-package "TIAGO_CONTROLLER::MOVE"))
(unless (find-package "TIAGO_CONTROLLER::MOVEREQUEST")
  (make-package "TIAGO_CONTROLLER::MOVEREQUEST"))
(unless (find-package "TIAGO_CONTROLLER::MOVERESPONSE")
  (make-package "TIAGO_CONTROLLER::MOVERESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass tiago_controller::moveRequest
  :super ros::object
  :slots (_pose _duration _use_orientation _use_position _task_name ))

(defmethod tiago_controller::moveRequest
  (:init
   (&key
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    ((:duration __duration) 0.0)
    ((:use_orientation __use_orientation) nil)
    ((:use_position __use_position) nil)
    ((:task_name __task_name) "")
    )
   (send-super :init)
   (setq _pose __pose)
   (setq _duration (float __duration))
   (setq _use_orientation __use_orientation)
   (setq _use_position __use_position)
   (setq _task_name (string __task_name))
   self)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:duration
   (&optional __duration)
   (if __duration (setq _duration __duration)) _duration)
  (:use_orientation
   (&optional (__use_orientation :null))
   (if (not (eq __use_orientation :null)) (setq _use_orientation __use_orientation)) _use_orientation)
  (:use_position
   (&optional (__use_position :null))
   (if (not (eq __use_position :null)) (setq _use_position __use_position)) _use_position)
  (:task_name
   (&optional __task_name)
   (if __task_name (setq _task_name __task_name)) _task_name)
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ;; float32 _duration
    4
    ;; bool _use_orientation
    1
    ;; bool _use_position
    1
    ;; string _task_name
    4 (length _task_name)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;; float32 _duration
       (sys::poke _duration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _use_orientation
       (if _use_orientation (write-byte -1 s) (write-byte 0 s))
     ;; bool _use_position
       (if _use_position (write-byte -1 s) (write-byte 0 s))
     ;; string _task_name
       (write-long (length _task_name) s) (princ _task_name s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; float32 _duration
     (setq _duration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _use_orientation
     (setq _use_orientation (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _use_position
     (setq _use_position (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _task_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _task_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass tiago_controller::moveResponse
  :super ros::object
  :slots ())

(defmethod tiago_controller::moveResponse
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass tiago_controller::move
  :super ros::object
  :slots ())

(setf (get tiago_controller::move :md5sum-) "bd8ad08e16c09384d95325007ea8433d")
(setf (get tiago_controller::move :datatype-) "tiago_controller/move")
(setf (get tiago_controller::move :request) tiago_controller::moveRequest)
(setf (get tiago_controller::move :response) tiago_controller::moveResponse)

(defmethod tiago_controller::moveRequest
  (:response () (instance tiago_controller::moveResponse :init)))

(setf (get tiago_controller::moveRequest :md5sum-) "bd8ad08e16c09384d95325007ea8433d")
(setf (get tiago_controller::moveRequest :datatype-) "tiago_controller/moveRequest")
(setf (get tiago_controller::moveRequest :definition-)
      "geometry_msgs/Pose pose
float32 duration
bool use_orientation
bool use_position
string task_name

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
---
")

(setf (get tiago_controller::moveResponse :md5sum-) "bd8ad08e16c09384d95325007ea8433d")
(setf (get tiago_controller::moveResponse :datatype-) "tiago_controller/moveResponse")
(setf (get tiago_controller::moveResponse :definition-)
      "geometry_msgs/Pose pose
float32 duration
bool use_orientation
bool use_position
string task_name

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
---
")



(provide :tiago_controller/move "bd8ad08e16c09384d95325007ea8433d")


