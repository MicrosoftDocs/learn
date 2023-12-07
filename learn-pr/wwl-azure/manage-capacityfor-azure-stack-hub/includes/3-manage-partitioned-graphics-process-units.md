This unit describes which graphics processing unit (GPU) models are supported on an Azure Stack Hub multinode system. You can also find instructions on installing the drivers used with the GPUs. GPU support in Azure Stack Hub enables solutions such as Artificial Intelligence, training, inference, and data visualization. The AMD Radeon Instinct MI25 can be used to support graphic-intensive applications such as Autodesk AutoCAD.

You can choose from three GPU models in the public preview period. They are available in NVIDIA V100, NVIDIA T4, and AMD MI25 GPUs. These physical GPUs align with the following Azure N-Series virtual machine types as follows:

 -  NCv3
 -  NVv4 (AMD MI25)
 -  NCasT4\_v3

Azure Stack Hub GPU support is currently in public preview. This preview version is provided without a service level agreement, and it's not recommended for production workloads. Certain features might not be supported or might have constrained capabilities.

## NCv3

NCv3-series virtual machines are powered by NVIDIA Tesla V100 GPUs. Customers can take advantage of these updated GPUs for traditional HPC workloads such as reservoir modeling, DNA sequencing, protein analysis, Monte Carlo simulations, and others.

|      **Size**       | **vCPU** | **Memory: GiB** | **Temp storage (SSD) GiB** | **GPU** | **GPU memory: GiB** | **Max data disks** | **Max NICs** |
|:-------------------:|:--------:|:---------------:|:--------------------------:|:-------:|:-------------------:|:------------------:|:------------:|
| Standard\_NC6s\_v3  |    6     |       112       |            736             |    1    |         16          |         12         |      4       |
| Standard\_NC12s\_v3 |    12    |       224       |            1474            |    2    |         32          |         24         |      8       |
| Standard\_NC24s\_v3 |    24    |       448       |            2948            |    4    |         64          |         32         |      8       |

## NVv4

The NVv4-series virtual machines are powered by AMD Radeon Instinct MI25 GPUs. With NVv4-series Azure Stack Hub is introducing virtual machines with partial GPUs. This size can be used for GPU accelerated graphics applications and virtual desktops. NVv4 virtual machines currently support only Windows guest operating system.

:::row:::
  :::column:::
    **Size**
  :::column-end:::
  :::column:::
    **vCPU**
  :::column-end:::
  :::column:::
    **Memory: GiB**
  :::column-end:::
  :::column:::
    **Temp storage (SSD) GiB**
  :::column-end:::
  :::column:::
    **GPU**
  :::column-end:::
  :::column:::
    **GPU memory: GiB**
  :::column-end:::
  :::column:::
    **Max data disks**
  :::column-end:::
  :::column:::
    **Max NICs**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Standard\_NV4as\_v4
  :::column-end:::
  :::column:::
    4
  :::column-end:::
  :::column:::
    14
  :::column-end:::
  :::column:::
    88
  :::column-end:::
  :::column:::
    1/8
  :::column-end:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    4
  :::column-end:::
  :::column:::
    2
  :::column-end:::
:::row-end:::


## NCasT4\_v3

:::row:::
  :::column:::
    **Size**
  :::column-end:::
  :::column:::
    **vCPU**
  :::column-end:::
  :::column:::
    **Memory: GiB**
  :::column-end:::
  :::column:::
    **GPU**
  :::column-end:::
  :::column:::
    **GPU memory: GiB**
  :::column-end:::
  :::column:::
    **Max data disks**
  :::column-end:::
  :::column:::
    **Max NICs**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Standard\_NC4as\_T4\_v3
  :::column-end:::
  :::column:::
    4
  :::column-end:::
  :::column:::
    28
  :::column-end:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    16
  :::column-end:::
  :::column:::
    8
  :::column-end:::
  :::column:::
    4
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Standard\_NC8as\_T4\_v3
  :::column-end:::
  :::column:::
    8
  :::column-end:::
  :::column:::
    56
  :::column-end:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    16
  :::column-end:::
  :::column:::
    16
  :::column-end:::
  :::column:::
    8
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Standard\_NC16as\_T4\_v3
  :::column-end:::
  :::column:::
    16
  :::column-end:::
  :::column:::
    112
  :::column-end:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    16
  :::column-end:::
  :::column:::
    32
  :::column-end:::
  :::column:::
    8
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Standard\_NC64as\_T4\_v3
  :::column-end:::
  :::column:::
    64
  :::column-end:::
  :::column:::
    448
  :::column-end:::
  :::column:::
    4
  :::column-end:::
  :::column:::
    64
  :::column-end:::
  :::column:::
    32
  :::column-end:::
  :::column:::
    8
  :::column-end:::
:::row-end:::


## Patch and update, FRU behavior of virtual machines

GPU virtual machines will undergo downtime during operations such as patch and update (PnU) and hardware replacement (FRU) of Azure Stack Hub. The following table goes over the state of the virtual machine as observed during these activities and the manual action that the user can do to make these virtual machines available again post these operations.

:::row:::
  :::column:::
    **Operation**
  :::column-end:::
  :::column:::
    **PnU - Express Update**
  :::column-end:::
  :::column:::
    **PnU - Full Update, OEM update**
  :::column-end:::
  :::column:::
    **FRU**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Virtual machine state
  :::column-end:::
  :::column:::
    Unavailable during and post update without manual start operation.
  :::column-end:::
  :::column:::
    Unavailable during update. Available post update with manual operation
  :::column-end:::
  :::column:::
    Unavailable during update. Available post update with manual operation
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Manual operation
  :::column-end:::
  :::column:::
    If the virtual machine needs to be made available during the update, if there are available GPU partitions, the virtual machine can be restarted from the portal by clicking the Restart button. Restart the virtual machine after the update from the portal using the Restart button.
  :::column-end:::
  :::column:::
    Virtual machine cannot be made available during the update. Post update completion, virtual machine needs to be stop-deallocated using the Stop button and started back up using the "Start" button.
  :::column-end:::
  :::column:::
    Virtual machine cannot be made available during the update.Post update completion, virtual machine needs to be stop-deallocated using the Stop button and started back up using the Start button.
  :::column-end:::
:::row-end:::
