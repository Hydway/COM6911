# How to run the project on HPC

#### Apply for GPU usage permission

[Request access to Computer Science nodes in University of Sheffield HPC clusters (google.com)](https://docs.google.com/forms/d/e/1FAIpQLSfIT2mqAw3l3HAqTJ3HsThiaKT7HYb04MqyLST9vYARspRO6A/viewform)

#### Use ssh to enter ShARC

```
ssh $USER@sharc.shef.ac.uk  # Use lowercase for your username, without `$`
```

After entering ShARC, **do not** need to use `qrshx` or other commands to enter a node, you can use the `qsub` command to directly submit the task to HPC, and HPC will assign it to the appropriate node automatically according to the resources you request.

#### Put the PACS dataset in the root directory of the project

```
RootDir
└───Data
│   └───PACS
│       └───art_painting
│       	│   file1.jpg
│       	│   file2.jpg
│   		│   ...
|    	└───cartoon   
│   		│	file1.jpg
│   		│	...
```

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

#### Enter the `script` folder and submit `run.sh` to HPC

`run.sh`: The MLDG algorithm is selected, only 1 epoch will be  trained, the training time is short, and it can be used as a test.

`run_all.sh`: The DIFEX algorithm and 7 sets of hyperparameters are selected, and each set was trained for 120 epochs.

```bash
cd script

qsub run.sh
# qsub run_all.sh
```

> Notice:
>
> What would you do if you wanted to make changes to `run.sh`? Download it to a personal computer, edit it and upload it to HPC?
>
> If your personal computer uses Windows system, then don't do this! The encoding format of the `.sh` script edited by the Windows system will be modified, so that it cannot run normally in the Linux system, so please edit `run.sh` directly in the Linux/Mac environment!

#### Appendix: Explanation of each parameter in the `.sh` file

```bash
#!/bin/bash
#$ -N GPU_test # name of the task
#$ -l gpu=1 # apply for a GPU
#$ -P rse # submit to the DGX-1
#$ -q rse.q # submit to the DGX-1
#$ -l h_rt=6:00:00  # time needed in hours:mins:secs
#$ -l rmem=18G # size of memory requested
#$ -o ../output/run_with_gpu.txt  # This is where your output and errors are logged
#$ -j y # normal and error outputs into a single file (the file above)
#$ -M youremail@shef.ac.uk # notify you by email, remove this line if you don't want to be notified
#$ -m ea # email you when it finished or aborted
#$ -cwd # run job from current directory
```
