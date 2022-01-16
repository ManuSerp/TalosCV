from math import tan

def center(bbox):
    return [bbox[0]+bbox[2]//2,bbox[1]+bbox[3]//2]    


def angleCenter(bbox,cam_angle_hz=55,cam_angle_vt=45,fen_size=(640,480)):
    centre=center(bbox)
    return [-(centre[0]*2*cam_angle_hz/fen_size[0])+cam_angle_hz,-(centre[1]*2*cam_angle_vt/fen_size[1])+cam_angle_vt,centre]

def mapper(d,max=4):
    return 0

def spatialization(centre,depth,cam_angle_hz=57,cam_angle_vt=57,fen_size=(640,480)):
    angl=[-(centre[0]*2*cam_angle_hz/fen_size[0])+cam_angle_hz,-(centre[1]*2*cam_angle_vt/fen_size[1])+cam_angle_vt] 
    return [depth,tan(angl[0]*3.1418/180)*depth,tan(angl[1]*3.1418/180)*depth] #x,y,z dans gazebo



def isMoving(avt,mtn,floor=0.03):
    rte=[abs(avt[0]-mtn[0]),abs(avt[1]-mtn[1]),abs(avt[2]-mtn[2])]
    for x in rte:
        if x>floor:
            return True

    return False


def realCoord(cam,head): #without head orientation for the moment
    return [cam[0]+head[0],cam[1]+head[1],cam[2]+head[2]]