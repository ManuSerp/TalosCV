
(cl:in-package :asdf)

(defsystem "tiago_controller-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "move" :depends-on ("_package_move"))
    (:file "_package_move" :depends-on ("_package"))
  ))