// Generated by gencpp from file tracker_cam/center_Array.msg
// DO NOT EDIT!


#ifndef TRACKER_CAM_MESSAGE_CENTER_ARRAY_H
#define TRACKER_CAM_MESSAGE_CENTER_ARRAY_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace tracker_cam
{
template <class ContainerAllocator>
struct center_Array_
{
  typedef center_Array_<ContainerAllocator> Type;

  center_Array_()
    : data()  {
      data.assign(0);
  }
  center_Array_(const ContainerAllocator& _alloc)
    : data()  {
  (void)_alloc;
      data.assign(0);
  }



   typedef boost::array<int32_t, 2>  _data_type;
  _data_type data;





  typedef boost::shared_ptr< ::tracker_cam::center_Array_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::tracker_cam::center_Array_<ContainerAllocator> const> ConstPtr;

}; // struct center_Array_

typedef ::tracker_cam::center_Array_<std::allocator<void> > center_Array;

typedef boost::shared_ptr< ::tracker_cam::center_Array > center_ArrayPtr;
typedef boost::shared_ptr< ::tracker_cam::center_Array const> center_ArrayConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::tracker_cam::center_Array_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::tracker_cam::center_Array_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::tracker_cam::center_Array_<ContainerAllocator1> & lhs, const ::tracker_cam::center_Array_<ContainerAllocator2> & rhs)
{
  return lhs.data == rhs.data;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::tracker_cam::center_Array_<ContainerAllocator1> & lhs, const ::tracker_cam::center_Array_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace tracker_cam

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::tracker_cam::center_Array_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::tracker_cam::center_Array_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::tracker_cam::center_Array_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::tracker_cam::center_Array_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::tracker_cam::center_Array_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::tracker_cam::center_Array_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::tracker_cam::center_Array_<ContainerAllocator> >
{
  static const char* value()
  {
    return "8c6cd32143779d63a1fc14cd80d5fe67";
  }

  static const char* value(const ::tracker_cam::center_Array_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x8c6cd32143779d63ULL;
  static const uint64_t static_value2 = 0xa1fc14cd80d5fe67ULL;
};

template<class ContainerAllocator>
struct DataType< ::tracker_cam::center_Array_<ContainerAllocator> >
{
  static const char* value()
  {
    return "tracker_cam/center_Array";
  }

  static const char* value(const ::tracker_cam::center_Array_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::tracker_cam::center_Array_<ContainerAllocator> >
{
  static const char* value()
  {
    return "int32[2] data\n"
;
  }

  static const char* value(const ::tracker_cam::center_Array_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::tracker_cam::center_Array_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.data);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct center_Array_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::tracker_cam::center_Array_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::tracker_cam::center_Array_<ContainerAllocator>& v)
  {
    s << indent << "data[]" << std::endl;
    for (size_t i = 0; i < v.data.size(); ++i)
    {
      s << indent << "  data[" << i << "]: ";
      Printer<int32_t>::stream(s, indent + "  ", v.data[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // TRACKER_CAM_MESSAGE_CENTER_ARRAY_H
