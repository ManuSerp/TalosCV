# Utilisation de Gazebo dans le docker et avec ROS à l'exterieur
quelques infos sur le docker.

Pour le lancer :
./run_docker.sh -it --name tiago registry.gitlab.inria.fr/locolearn/docker_talos/inria_wbc_pal:tiago -c terminator

(terminator pour ouvrir un terminal)

Puis dans le docker:
cd catkin_ws
catkin_make --only-pkg-with-deps tiago_controller

# lancer Gazebo avec Tiago dans terminator:

roslaunch tiago_gazebo tiago_gazebo.launch public_sim:=true robot:=steel

# Lancer notre controleur (dans un autre terminal mais dans le meme docker : Terminator permet de facilement ajouter des terminaux) :

roslaunch tiago_controller tiago_controller.launch

Normalement le robo devrait bouger un peu le bras dans Gazebo.

Il faut :

- prendre un docker tiago
- dans catkin_ws/src faire un clone de https://gitlab.inria.fr/locolearn/tiago_controller
- cd catkin_ws
- source devel/setup.bash
- catkin_make

Cela devrait compiler

Pour lancer, suivre le README (le mieux est de “split” la fenêtre de terminator en 4 terminaux) :

- faire le source de devel/setup.bash dans chaque terminal
- lancer Gazebo dans un terminal (roslaunch etc.)
- laisser le robot commencer à bouger dans Gazebo
- dans un autre terminal : roslaunch tiago_controller tiago_controller.launch
- le robot devrait se mettre en position et ensuite accepter les topics / services

Il y a deux modes :

- 1 traj : le robot va à une trajectoire en un certain nombre de secondes
- 2 tracking : le robot va le plus vite au point demandé, mais limité à 2.5 cm de distance (pour éviter que le robot bouge trop vite)

Pour changer de mode, il y a deux services (voir le README).
Pour bouger en trajectoire, c’est un service
Pour bouger en tracking, c’est un topic sur lequel il faut publier

Le noeud publie les positions du “end-effector” (EE) et de la tête (avec un quaternion pour exprimer la rotation).

Pour accéder au docker de l’extérieur :

- il faut d’abord trouver l’IP du docker (généralement 172.17.0.1 ou .2)
  - dans le docker, installer ifconfig : apt-get install net-tools
  - puis ifconfig -a et regarder le champ ‘inet’ de docker0
- à l’extérieur du docker :
  - export ROS_MASTER_URI=http://172.17.0.1:11311 (changer l’IP)
  - export ROS_IP=172.17.0.1:11311
    Normalement un rostopic list en dehors du docker devrait lister les topics (si tout tourne dans le docker bien sûr).

Avec cela, cela devrait être possible de faire bouger le robot avec le contrôleur en simulation mais aussi en vrai (cela marche bien sur le vrai robot).
