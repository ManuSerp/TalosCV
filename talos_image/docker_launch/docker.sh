#bin/bash!

touch cmd
docker container ps -al >> cmd
node parse.mjs
rm cmd
value=`cat id`
echo "$value"
docker rm $value
rm id

../../../../Tiago/docker_talos-master/pal_docker.sh -it --name tiago registry.gitlab.inria.fr/locolearn/docker_talos/inria_wbc_pal:tiago -c terminator