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
f.write("\tref: \"torso_lift_link\"\n")
f.write("\tpos: [0.0, 0.0, -0.2]\n")
f.write("v_torso_2: \n")
f.write("\tref: \"torso_lift_link\"\n")
f.write("\tpos: [0.0, 0.0, -0.4]\n")
f.write("v_head: \n")
f.write("\tref: \"head_2_link\"\n")
f.write("\tpos: [0.04, 0.05, 0.0]\n")
# fin du header frames.yml
for i in range(int((args.lenght-0.15)/0.05)):
    f.write("v_field"+str(i+1)+": \n")
    f.write("\tref: \"head_2_link\"\n")
    f.write("\tpos: [%.2f, 0.0, 0.0]\n" % (0.2+i*0.05))
# fin du frames.yml
f.close()
f = open("gen/tasks.yml", "w")


# debut de tasks.yml
f.write("sc-elbow:\n")
f.write("\ttype: self-collision\n")
f.write("\ttracked: arm_4_link\n")
f.write("\tradius: 0.1\n")
f.write("\tavoided:\n")
f.write("\t\tbase_link: 0.330\n")
f.write("\t\ttorso_lift_link: 0.25\n")
f.write("\t\tv_torso_1: 0.2\n")
f.write("\t\tv_torso_2: 0.2\n")
f.write("\t\tv_head: 0.15\n")
# fin header
for i in range(int((args.lenght-0.15)/0.05)):
    a = "%.2f" % (0.1+i*0.02)
    f.write("\t\tv_field"+str(i+1)+": "+a+"\n")
# fin loop
f.write("\tweight: 1000\n\tkp: 50.0\n\tkd: 500.0\n\tm: 0.2\n\tmargin: 0.02\n")

f.close()
print("python done...")
