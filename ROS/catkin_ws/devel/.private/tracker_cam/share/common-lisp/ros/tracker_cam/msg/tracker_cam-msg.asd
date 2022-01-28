
(cl:in-package :asdf)

(defsystem "tracker_cam-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "center_Array" :depends-on ("_package_center_Array"))
    (:file "_package_center_Array" :depends-on ("_package"))
  ))