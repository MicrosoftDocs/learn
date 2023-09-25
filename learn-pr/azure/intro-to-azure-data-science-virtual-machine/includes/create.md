## Activate the Learn sandbox

Use the **Activate sandbox** button in this module to activate the Learn sandbox. The activation creates an Azure resource group, a container for resources that relate to a single project domain. This resource group is available for an hour. Use the resource group to create a Data Science Virtual Machine, connect to it, and run programs.

## Create a Data Science Virtual Machine

After you've decided to use a DSVM to explore your domain, you need to decide whether you'd prefer Windows Server 2019 or Ubuntu Server 20.04 LTS as the operating system. You should also plan what hardware and network resources you'd like the DSVM to use.

## Operating system choices

There are two DSVM images:

* Windows Server 2019
* Ubuntu Server 20.04 LTS

Both images contain various tools for data science and deep learning. If you're a Python programmer, you can use Visual Studio Code or PyCharm to program PyTorch, TensorFlow, and ONNX. If you use R, there's CRAN-R. C#, TypeScript, and F# users can use Visual Studio Code. On the Windows image, they can use Visual Studio to program ML.NET and SQL Server to store and retrieve their data.

Jupyter is installed on both machines with multiple language kernels. On the Ubuntu image, JupyterHub is installed to provide multiuser access.

## Processor, RAM, and disk choices

Azure virtual machines come in various sizes, grouped by type:

| Type | Characteristics |
| - |- |
| General purpose | Balanced CPU-to-memory ratio. |
| GPU | Single or multiple GPUs. Best fit for statistical machine learning training and inferencing. |
| Memory optimized | High memory-to-CPU ratio. Good for in-memory analytics. |
| Storage optimized | High disk and I/O throughput. Good for big data. |
| High-performance compute | Powerful CPU machines. Good for tools with no GPU support. |
| Compute optimized | High CPU-to-memory ratio. Probably not a good fit for data science. GPU or high-performance compute is a preferred type.|

The DSVMs are preconfigured with the drivers, library versions, and configurations to take advantage of GPU processing if it's available.

Within a type, machines are typically associated with a letter-based series. For instance, GPU sizes typically begin with an "N": NC6, NC12s v3, NC24, NV12, and so on.

Before you create a DSVM, you should decide on a storage strategy. You can install the OS on a Premium SSD, a Standard SSD, or a Standard HDD. In addition, you can either create or attach to one or more data disks. Again, you can choose the hard-drive technology, trading off the higher speed of SSDs versus their cost per gigabyte.

You can resize your DSVM as your requirements change. For instance, you might choose a general-purpose or memory-optimized size when data acquisition and understanding are your primary focus, but resize to a GPU offering when modeling becomes the bottleneck.
