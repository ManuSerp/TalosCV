#!/bin/bash




echo 'Launching tracking siamese network...'
echo 'Configuring python path...'

#adding pysot to python path

export PYTHONPATH=/home/manu/Documents/Projet/RECH/pysot:$PYTHONPATH
echo 'done'
echo 'Loading models...'



#going to demo directory



cd /home/manu/Documents/Projet/RECH/Tracking/TalosCV
echo 'done'

#launching tracking with zoo model train up to 180 fps

echo 'launching...'
## WIP    A PLACER LES MODELS DANS MON GIT SINON CA MARCHERA PAS
python src/tracking.py  --config experiments/siamrpn_alex_dwxcorr/config.yaml    --snapshot experiments/siamrpn_alex_dwxcorr/model.pth


echo 'Demo terminated'