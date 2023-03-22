# How to run the project on HPC

We cannot run our compiled GPU code on the worked node as it has no GPUs or CUDA driver. Instead we must submit the execution of the GPU accelerated CUDA program via the ShARC job submission system (`qsub`). 

In addition, I optimized the bash script so that it can be more perfectly adapted to HPC, but the hyperparameters in bash need to be further optimized in future experiments.

Here are the steps about 'how to run this project on HPC':

#### Create a virtual environment called `dgml`：

```bash
module load apps/python/conda
conda create -n dgml python=3.9.1
```

#### Activate the environment

```bash
source activate dgml
```

#### Install necessary packages using `pip`

```bash
pip install Numpy
...
...
```

#### Enter the `script` folder and submit `run.sh` to run on

```bash
cd script

# qsub run.sh
qsub -l gpu=1 -b y ./run.sh
```

> Notice:
>
> What would you do if you wanted to make changes to `run.sh`? Download it to a personal computer, edit it and upload it to HPC?
>
> If your personal computer uses Windows system, then don't do this! The encoding format of the `.sh` script edited by the Windows system will be modified, so that it cannot run normally in the Linux system, so please edit `run.sh` directly in the Linux/Mac environment!

#### Appendix: my `run.sh` file

This file is just an experiment, please use more algorithms and epochs to train the model in the future.

```bash
#!/bin/bash
#$ -l gpu=1
#$ -l h_rt=6:00:00  # time needed in hours:mins:secs
#$ -pe smp 4 # number of cores requested
#$ -l rmem=8G # size of memory requested
#$ -o Output/out.txt  # This is where your output and errors are logged
#$ -j y # normal and error outputs into a single file (the file above)
#$ -M youremail@shef.ac.uk # notify you by email, remove this line if you don't want to be notified
#$ -m ea # email you when it finished or aborted
#$ -cwd # run job from current directory

module load libs/CUDA
module load apps/python/conda

source activate dgml

python ../train.py --data_dir ../Data/PACS/ --max_epoch 2 --net resnet18 --task img_dg --output ../output/ --test_envs 2 --dataset PACS --algorithm MLDG --mldg_beta 10
```

.