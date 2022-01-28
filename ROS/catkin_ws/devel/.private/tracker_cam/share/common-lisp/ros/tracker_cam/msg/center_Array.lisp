; Auto-generated. Do not edit!


(cl:in-package tracker_cam-msg)


;//! \htmlinclude center_Array.msg.html

(cl:defclass <center_Array> (roslisp-msg-protocol:ros-message)
  ((data
    :reader data
    :initarg :data
    :type (cl:vector cl:integer)
   :initform (cl:make-array 2 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass center_Array (<center_Array>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <center_Array>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'center_Array)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tracker_cam-msg:<center_Array> is deprecated: use tracker_cam-msg:center_Array instead.")))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <center_Array>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tracker_cam-msg:data-val is deprecated.  Use tracker_cam-msg:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <center_Array>) ostream)
  "Serializes a message object of type '<center_Array>"
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <center_Array>) istream)
  "Deserializes a message object of type '<center_Array>"
  (cl:setf (cl:slot-value msg 'data) (cl:make-array 2))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i 2)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<center_Array>)))
  "Returns string type for a message object of type '<center_Array>"
  "tracker_cam/center_Array")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'center_Array)))
  "Returns string type for a message object of type 'center_Array"
  "tracker_cam/center_Array")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<center_Array>)))
  "Returns md5sum for a message object of type '<center_Array>"
  "8c6cd32143779d63a1fc14cd80d5fe67")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'center_Array)))
  "Returns md5sum for a message object of type 'center_Array"
  "8c6cd32143779d63a1fc14cd80d5fe67")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<center_Array>)))
  "Returns full string definition for message of type '<center_Array>"
  (cl:format cl:nil "int32[2] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'center_Array)))
  "Returns full string definition for message of type 'center_Array"
  (cl:format cl:nil "int32[2] data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <center_Array>))
  (cl:+ 0
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <center_Array>))
  "Converts a ROS message object to a list"
  (cl:list 'center_Array
    (cl:cons ':data (data msg))
))
