import argparse
parser = argparse.ArgumentParser(description='Cone BUILDER')
parser.add_argument('--lenght', default=1.0, type=float, help='lenght of cone')
parser.add_argument('--ratio', default=0.5, type=float, help='ratio of cone')
args = parser.parse_args()
print("PYTHON CONE BUILDER...")
print("Lenght = "+str(args.lenght))
print("Ratio = "+str(args.ratio))
f = open("gen/frames.yml", "w")

# debut du frames.yml
f.write("# virtual frames\n")
f.write("v_torso_1: \n")
f.write("  ref: \"torso_lift_link\"\n")
f.write("  pos: [0.0, 0.0, -0.2]\n")
f.write("v_torso_2: \n")
f.write("  ref: \"torso_lift_link\"\n")
f.write("  pos: [0.0, 0.0, -0.4]\n")
f.write("v_head: \n")
f.write("  ref: \"head_2_link\"\n")
f.write("  pos: [0.04, 0.05, 0.0]\n")
# fin du header frames.yml
for i in range(int((args.lenght-0.15)/0.05)):
    f.write("v_field"+str(i+1)+": \n")
    f.write("  ref: \"head_2_link\"\n")
    f.write("  pos: [%.2f, 0.0, 0.0]\n" % (0.2+i*0.05))
# fin du frames.yml
f.close()
f = open("gen/tasks.yml", "w")


# debut de tasks.yml
f.write("sc-elbow:\n")
f.write("  type: self-collision\n")
f.write("  tracked: arm_4_link\n")
f.write("  radius: 0.1\n")
f.write("  avoided:\n")
f.write("    base_link: 0.330\n")
f.write("    torso_lift_link: 0.25\n")
f.write("    v_torso_1: 0.2\n")
f.write("    v_torso_2: 0.2\n")
f.write("    v_head: 0.15\n")
# fin header
for i in range(int((args.lenght-0.15)/0.05)):
    a = "%.2f" % ((0.2+i*0.05)*args.ratio)
    f.write("    v_field"+str(i+1)+": "+a+"\n")
# fin loop
f.write("  weight: 1000\n  kp: 50.0\n  kd: 500.0\n  m: 0.2\n  margin: 0.02\n")

f.close()
print("python done...")
