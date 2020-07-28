
# What is the Azure Data Science Virtual Machine for Linux and Windows?

The Data Science Virtual Machine (DSVM) is a VM that runs in the Azure cloud platform. There are Data Science Virtual Machine images for:

- Windows Server 2019
- Ubuntu Server 18.04 LTS LTS

You can choose to run the Data Science Virtual Machine on different Azure virtual machine series and sizes. Common choices for the Data Science Virtual Machine are:


| Common series | Use-case | 
| --- | --- | 
| General purpose | Balance CPU-memory ratios |
| Memory-optimized E series | In-memory data analytics | 
| N-series GPU compute | machine learning experimentation and inferencing |

N-series virtual machines feature the NVIDIA Tesla accelerated platform and NVIDIA GRID 2.0 technology. The Data Science Virtual Machine tools and libraries that can exploit GPU acceleration are pre-configured with the appropriate drivers and library versions.

## How the Data Science Virtual Machine works

Once you've specified an operating system and hardware platform, Azure creates the virtual machine and a number of related resources. The related resources include such things as a storage account, a network security group, and so forth. 

When you start the virtual machine, Azure restores the image to the specified hardware type and starts the operating system. You can then connect, as you'll learn how to do in this module. Once connected, you use the virtual machine in the same way you'd use any other machine. After you're done, you shut down the machine, using either the operating system facilities or the Azure portal. 

Your charges are based on the type of hardware (compute power, RAM, and storage) you specified. You are charged only for time the virtual machine is running, at a half-minute granularity.  

## When to use the Data Science Virtual Machine

The goal of the Data Science Virtual Machine is a friction-free, preconfigured data science and machine learning environment. The experience is familiar and usable by data professionals of all skill levels. Instead of rolling out a comparable workspace on your own, you can provision a Data Science Virtual Machine. That choice can save you days or even _weeks_ on the installation, configuration, and package management processes. After your Data Science Virtual Machine has been allocated, you can immediately begin working on your data science project.

## Sample Use Cases

There are several use-cases where the Data Science Virtual Machine is a good fit:

### Moving data science workloads to the cloud

The Data Science Virtual Machine provides a baseline configuration for data science teams, ensuring that all the data scientists on a team have a consistent setup with which to verify experiments and promote collaboration. It also lowers costs by reducing the sysadmin burden. This burden reduction saves on the time needed to evaluate, install, and maintain software packages for advanced analytics.

### Data science training and education

Enterprise trainers and educators who teach data science classes usually provide a virtual machine image. The image ensures that students have a consistent setup and that the samples work predictably. 

The Data Science Virtual Machine creates an on-demand environment with a consistent setup that eases the support and incompatibility challenges. Cases where these environments need to be built frequently, especially for shorter training classes, benefit substantially.

### On-demand elastic capacity for large-scale projects

Data science hackathons/competitions or large-scale data modeling and exploration require scaled-out hardware capacity, typically for short duration. The Data Science Virtual Machine can help replicate the data science environment quickly on demand. These replicated environments can then run on high-powered computing resources as your scenario demands.

### Short-term experimentation and evaluation

You can use the Data Science Virtual Machine to evaluate or learn new data science tools. The Data Science Virtual Machine has samples and walkthroughs pre-installed.

### Deep learning with GPUs

In the Data Science Virtual Machine, your training models can use deep learning algorithms on hardware that's based on graphics processing units (GPUs). By taking advantage of the VM scaling capabilities of the Azure platform, the Data Science Virtual Machine helps you use GPU-based hardware in the cloud. You can switch to a GPU-based VM when you're training large models, or when you need high-speed computations while keeping the same OS disk. You can choose any of the N series GPU enabled virtual machine SKUs with Data Science Virtual Machine. Please note Azure free accounts do not support GPU enabled virtual machine SKUs.

The Data Science Virtual Machine is configured with the proper drivers, framework versions and configurations, and GPU tools for those tools and frameworks that support GPU acceleration. If you use Python, there are several conda environments configured to avoid confusion. For instance, Pythorch and Tensorflow are in separate environments. 

You can also deploy the Ubuntu or Windows editions of the Data Science Virtual Machine to an Azure virtual machine that isn't based on GPUs. In this case, all the deep learning frameworks will fall back to the CPU model.

Our scenario, where you are investigating bank data to help predict trends, touch on several of these use-cases: collaboration, capacity, and exploration. You decide that an Ubuntu Data Science Virtual Machine is a good choice, as it will allow you to use familiar tools like RStudio, your existing data disk, and not require you to invest in learning new technologies until you've worked with your data for awhile. 