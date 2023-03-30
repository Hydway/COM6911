#!/bin/bash
#$ -N GPU_test
#$ -l gpu=1
#$ -P rse
#$ -q rse.q
#$ -l rmem=18G # size of memory requested
#$ -o ../output/run_with_gpu.txt  # This is where your output and errors are logged
#$ -j y # normal and error outputs into a single file (the file above)
#$ -M youremail@shef.ac.uk # notify you by email, remove this line if you don't want to be notified
#$ -m ea # email you when it finished or aborted
#$ -cwd # run job from current directory

module load libs/CUDA
module load apps/python/conda

source activate dgml

python ../train.py --data_dir ../Data/PACS/ --max_epoch 2 --net resnet18 --task img_dg --output ../output/ --test_envs 2 --dataset PACS --algorithm MLDG --mldg_beta 10
