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
# fin du frames.yml
for i in range(int(args.lenght/0.05)):
    f.write("v_field"+str(i+1)+": \n")
    f.write("\tref: \"head_2_link\"\n")
    f.write("\tpos: ["+str(0.2+i*0.05)+", 0.0, 0.0]\n")


f.close()

print("python done...")
