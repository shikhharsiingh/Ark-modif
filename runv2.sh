#!/bin/bash
#SBATCH --job-name=SwinV2_base_Ark_finetune

#SBATCH -N 1            # number of nodes
#SBATCH -c 8            # number of cores 
#SBATCH -t 7-00:00:00   # time in d-hh:mm:ss
#SBATCH -p general      # partition 
#SBATCH -q public       # QOS
#SBATCH --gpus=a100:4
#SBATCH -o %x_%j.out # file to save job's STDOUT (%j = JobId)
#SBATCH -e %x_%j.err # file to save job's STDERR (%j = JobId)
#SBATCH --mail-type=ALL # Send an e-mail when a job starts, stops, or fails
#SBATCH --mail-user=ssiingh@asu.edu

#SBATCH --export=NONE   # Purge the job-submitting shell environment

module load mamba/latest
source activate ml10 
cd /scratch/ssiingh/JLiangLab/Ark-modif
python main_ark.py --workers 16 --data_set MIMIC --data_set CheXpert --data_set ChestXray14 --data_set RSNAPneumonia --data_set VinDrCXR --data_set Shenzhen --opt sgd --warmup-epochs 20  --lr 0.3 --batch_size 200 --model swinv2_base --init imagenet  --pretrain_epochs 200  --test_epoch 10 --pretrained_weights https://github.com/SwinTransformer/storage/releases/download/v1.0.0/swin_base_patch4_window7_224_22kto1k.pth --momentum_teacher 0.9  --projector_features 1376 --img_size 256 --resume True