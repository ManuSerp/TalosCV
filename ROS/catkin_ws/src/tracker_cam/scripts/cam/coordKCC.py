def center(bbox):
    return [bbox[0]+bbox[2]//2,bbox[1]+bbox[3]//2]    


def angleCenter(bbox,cam_angle_hz=57,cam_angle_vt=57,fen_size=(640,480)):
    centre=center(bbox)
    return [(centre[0]*2*cam_angle_hz/fen_size[0])-cam_angle_hz,-(centre[1]*2*cam_angle_vt/fen_size[1])+cam_angle_vt]
