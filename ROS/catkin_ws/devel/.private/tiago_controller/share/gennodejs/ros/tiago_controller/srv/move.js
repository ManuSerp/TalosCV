// Auto-generated. Do not edit!

// (in-package tiago_controller.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------


//-----------------------------------------------------------

class moveRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pose = null;
      this.duration = null;
      this.use_orientation = null;
      this.use_position = null;
      this.task_name = null;
    }
    else {
      if (initObj.hasOwnProperty('pose')) {
        this.pose = initObj.pose
      }
      else {
        this.pose = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('duration')) {
        this.duration = initObj.duration
      }
      else {
        this.duration = 0.0;
      }
      if (initObj.hasOwnProperty('use_orientation')) {
        this.use_orientation = initObj.use_orientation
      }
      else {
        this.use_orientation = false;
      }
      if (initObj.hasOwnProperty('use_position')) {
        this.use_position = initObj.use_position
      }
      else {
        this.use_position = false;
      }
      if (initObj.hasOwnProperty('task_name')) {
        this.task_name = initObj.task_name
      }
      else {
        this.task_name = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type moveRequest
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.pose, buffer, bufferOffset);
    // Serialize message field [duration]
    bufferOffset = _serializer.float32(obj.duration, buffer, bufferOffset);
    // Serialize message field [use_orientation]
    bufferOffset = _serializer.bool(obj.use_orientation, buffer, bufferOffset);
    // Serialize message field [use_position]
    bufferOffset = _serializer.bool(obj.use_position, buffer, bufferOffset);
    // Serialize message field [task_name]
    bufferOffset = _serializer.string(obj.task_name, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type moveRequest
    let len;
    let data = new moveRequest(null);
    // Deserialize message field [pose]
    data.pose = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [duration]
    data.duration = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [use_orientation]
    data.use_orientation = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [use_position]
    data.use_position = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [task_name]
    data.task_name = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.task_name);
    return length + 66;
  }

  static datatype() {
    // Returns string type for a service object
    return 'tiago_controller/moveRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bd8ad08e16c09384d95325007ea8433d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    geometry_msgs/Pose pose
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new moveRequest(null);
    if (msg.pose !== undefined) {
      resolved.pose = geometry_msgs.msg.Pose.Resolve(msg.pose)
    }
    else {
      resolved.pose = new geometry_msgs.msg.Pose()
    }

    if (msg.duration !== undefined) {
      resolved.duration = msg.duration;
    }
    else {
      resolved.duration = 0.0
    }

    if (msg.use_orientation !== undefined) {
      resolved.use_orientation = msg.use_orientation;
    }
    else {
      resolved.use_orientation = false
    }

    if (msg.use_position !== undefined) {
      resolved.use_position = msg.use_position;
    }
    else {
      resolved.use_position = false
    }

    if (msg.task_name !== undefined) {
      resolved.task_name = msg.task_name;
    }
    else {
      resolved.task_name = ''
    }

    return resolved;
    }
};

class moveResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type moveResponse
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type moveResponse
    let len;
    let data = new moveResponse(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'tiago_controller/moveResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new moveResponse(null);
    return resolved;
    }
};

module.exports = {
  Request: moveRequest,
  Response: moveResponse,
  md5sum() { return 'bd8ad08e16c09384d95325007ea8433d'; },
  datatype() { return 'tiago_controller/move'; }
};
