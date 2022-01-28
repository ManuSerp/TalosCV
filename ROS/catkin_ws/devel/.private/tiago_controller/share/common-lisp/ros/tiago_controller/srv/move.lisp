; Auto-generated. Do not edit!


(cl:in-package tiago_controller-srv)


;//! \htmlinclude move-request.msg.html

(cl:defclass <move-request> (roslisp-msg-protocol:ros-message)
  ((pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (duration
    :reader duration
    :initarg :duration
    :type cl:float
    :initform 0.0)
   (use_orientation
    :reader use_orientation
    :initarg :use_orientation
    :type cl:boolean
    :initform cl:nil)
   (use_position
    :reader use_position
    :initarg :use_position
    :type cl:boolean
    :initform cl:nil)
   (task_name
    :reader task_name
    :initarg :task_name
    :type cl:string
    :initform ""))
)

(cl:defclass move-request (<move-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <move-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'move-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tiago_controller-srv:<move-request> is deprecated: use tiago_controller-srv:move-request instead.")))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <move-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tiago_controller-srv:pose-val is deprecated.  Use tiago_controller-srv:pose instead.")
  (pose m))

(cl:ensure-generic-function 'duration-val :lambda-list '(m))
(cl:defmethod duration-val ((m <move-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tiago_controller-srv:duration-val is deprecated.  Use tiago_controller-srv:duration instead.")
  (duration m))

(cl:ensure-generic-function 'use_orientation-val :lambda-list '(m))
(cl:defmethod use_orientation-val ((m <move-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tiago_controller-srv:use_orientation-val is deprecated.  Use tiago_controller-srv:use_orientation instead.")
  (use_orientation m))

(cl:ensure-generic-function 'use_position-val :lambda-list '(m))
(cl:defmethod use_position-val ((m <move-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tiago_controller-srv:use_position-val is deprecated.  Use tiago_controller-srv:use_position instead.")
  (use_position m))

(cl:ensure-generic-function 'task_name-val :lambda-list '(m))
(cl:defmethod task_name-val ((m <move-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tiago_controller-srv:task_name-val is deprecated.  Use tiago_controller-srv:task_name instead.")
  (task_name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <move-request>) ostream)
  "Serializes a message object of type '<move-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'duration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'use_orientation) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'use_position) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'task_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'task_name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <move-request>) istream)
  "Deserializes a message object of type '<move-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'duration) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'use_orientation) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'use_position) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'task_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'task_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<move-request>)))
  "Returns string type for a service object of type '<move-request>"
  "tiago_controller/moveRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'move-request)))
  "Returns string type for a service object of type 'move-request"
  "tiago_controller/moveRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<move-request>)))
  "Returns md5sum for a message object of type '<move-request>"
  "bd8ad08e16c09384d95325007ea8433d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'move-request)))
  "Returns md5sum for a message object of type 'move-request"
  "bd8ad08e16c09384d95325007ea8433d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<move-request>)))
  "Returns full string definition for message of type '<move-request>"
  (cl:format cl:nil "geometry_msgs/Pose pose~%float32 duration~%bool use_orientation~%bool use_position~%string task_name~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'move-request)))
  "Returns full string definition for message of type 'move-request"
  (cl:format cl:nil "geometry_msgs/Pose pose~%float32 duration~%bool use_orientation~%bool use_position~%string task_name~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <move-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     4
     1
     1
     4 (cl:length (cl:slot-value msg 'task_name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <move-request>))
  "Converts a ROS message object to a list"
  (cl:list 'move-request
    (cl:cons ':pose (pose msg))
    (cl:cons ':duration (duration msg))
    (cl:cons ':use_orientation (use_orientation msg))
    (cl:cons ':use_position (use_position msg))
    (cl:cons ':task_name (task_name msg))
))
;//! \htmlinclude move-response.msg.html

(cl:defclass <move-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass move-response (<move-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <move-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'move-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tiago_controller-srv:<move-response> is deprecated: use tiago_controller-srv:move-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <move-response>) ostream)
  "Serializes a message object of type '<move-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <move-response>) istream)
  "Deserializes a message object of type '<move-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<move-response>)))
  "Returns string type for a service object of type '<move-response>"
  "tiago_controller/moveResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'move-response)))
  "Returns string type for a service object of type 'move-response"
  "tiago_controller/moveResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<move-response>)))
  "Returns md5sum for a message object of type '<move-response>"
  "bd8ad08e16c09384d95325007ea8433d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'move-response)))
  "Returns md5sum for a message object of type 'move-response"
  "bd8ad08e16c09384d95325007ea8433d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<move-response>)))
  "Returns full string definition for message of type '<move-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'move-response)))
  "Returns full string definition for message of type 'move-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <move-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <move-response>))
  "Converts a ROS message object to a list"
  (cl:list 'move-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'move)))
  'move-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'move)))
  'move-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'move)))
  "Returns string type for a service object of type '<move>"
  "tiago_controller/move")