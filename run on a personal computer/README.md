# How to run the project on a personal computer

The feasibility of the method was verified in this experiment.

Note: Running on a private computer will consume a lot of resources and may lead to some unexpected situations.

## （Windows）Increase the virtual memory of the disk

First, determine which disk `python` is installed on in your current environment. If it is installed on a location other than the `C:/` drive, you need to increase the virtual memory on that disk:

`System Properties - Advanced - Performance - Settings - Advanced - Virtual Memory - Change`

## Download dataset

The dataset we are using `PACS` already exists on a shared disk, here are two different way to download them:

1. Using the university's computers to download.

2. For your convenience, I have uploaded them to our [Google Cloud Drive](https://drive.google.com/drive/folders/1-E0XdVc9xot46zcPe0rwOklLQ6kMb1vI?usp=sharing).

Remember the location of the downloaded data for subsequent use.

## Code Environment

This experiment is recommended to use the environment introduced by the original author: [jindongwang/docker - Docker Image | Docker Hub](https://hub.docker.com/r/jindongwang/docker)

However, I have verified that the environment I am using is also able to run the project successfully, here is my code environment (just for testing, we need to discuss and standardize the version of the environment before formally developing the project)

```sh
Environment:
        Python: 3.10.7
        PyTorch: 1.13.0+cu117
        Torchvision: 0.14.0+cu117
        CUDA: 11.7
        CUDNN: 8500
        NumPy: 1.23.3
        PIL: 9.2.0
```

## Run the code

> In the original author's script (`script/run.sh`), 8 algorithms and multiple epochs were used to train this model. The purpose of this run is to verify the feasibility of the method, so into the first algorithm was selected for 1 epoch of training for the demonstration.

Go to the root directory (the directory where train.py is stored) in bash and run the following code:

*Note: Replace the `< >` with your own content.*

```sh
python train.py --data_dir <The path to your data> --max_epoch 1 --net resnet18 --task img_dg --output <Output Directory> --test_envs 2 --dataset PACS --algorithm MLDG --mldg_beta 10
```

If everything goes well, you will get the following output:

```sh
=======hyper-parameter used========
==========================================
algorithm:MLDG
alpha:1
anneal_iters:500
batch_size:32
beta:1
beta1:0.5
bottleneck:256
checkpoint_freq:3
classifier:linear
data_file:
dataset:PACS
data_dir:data/PACS/
dis_hidden:256
disttype:2-norm
gpu_id:0
groupdro_eta:1
inner_lr:0.01
lam:1
layer:bn
lr:0.01
lr_decay:0.75
lr_decay1:1.0
lr_decay2:1.0
lr_gamma:0.0003
max_epoch:1
mixupalpha:0.2
mldg_beta:10.0
mmd_gamma:1
momentum:0.9
net:resnet18
N_WORKERS:4
rsc_f_drop_factor:0.3333333333333333
rsc_b_drop_factor:0.3333333333333333
save_model_every_checkpoint:False
schuse:False
schusech:cos
seed:0
split_style:strat
task:img_dg
tau:1
test_envs:[2]
output:/train_output/test
weight_decay:0.0005
steps_per_epoch:100
domains:['art_painting', 'cartoon', 'photo', 'sketch']
img_dataset:{'office': ['amazon', 'dslr', 'webcam'], 'office-caltech': ['amazon', 'dslr', 'webcam', 'caltech'], 'office-home': ['Art', 'Clipart', 'Product', 'Real_World'], 'PACS': ['art_painting', 'cartoon', 'photo', 'sketch'], 'dg5': ['mnist', 'mnist_m', 'svhn', 'syn', 'usps'], 'VLCS': ['Caltech101', 'LabelMe', 'SUN09', 'VOC2007']}
input_shape:(3, 224, 224)
num_classes:7
domain_num:4

===========start training===========
manually descrease lr
===========epoch 0===========
total_loss:21.0422
train_acc:0.1481,valid_acc:0.1478,target_acc:0.1192
total cost time: 103.3309
valid acc: 0.1478
DG result: 0.1192
```