The Data Science Virtual Machine (DSVM) is a virtual machine that runs on the Azure cloud platform. There are DSVM images for:

- Windows Server 2019
- Ubuntu Server 20.04 LTS

You can run the DSVM on different Azure virtual machine series and sizes. Common choices for the DSVM are:

| Common series | Use case |
| --- | --- |
| General purpose | Balanced CPU/memory ratios |
| Memory-optimized E series | In-memory data analytics |
| N-series GPU compute | Machine learning experimentation and inferencing |

N-series virtual machines feature the NVIDIA Tesla accelerated platform and NVIDIA GRID 2.0 technology. The DSVM tools and libraries that can use GPU acceleration are preconfigured with the appropriate drivers and library versions.

## How the Data Science Virtual Machine works

After you've specified an operating system and hardware platform, Azure creates the virtual machine and related resources. The related resources include such things as a storage account and a network security group.

When you start the virtual machine, Azure restores the image to the specified hardware type, and starts the operating system. You can then connect, as you learn how to do in this module. After you're connected, you use the virtual machine in the same way you'd use any other machine. After you're done, you shut down the machine by using either the operating system facilities or the Azure portal.

Your charges are based on the type of hardware (compute power, RAM, and storage) that you specified. You're charged only for time that the virtual machine is running, at a half-minute granularity.

## When to use the Data Science Virtual Machine

The goal of the DSVM is a friction-free, preconfigured environment for data science and machine learning. The experience is familiar and usable by data professionals of all skill levels.

Instead of rolling out a comparable workspace on your own, you can provision a DSVM. That choice can save you days or even *weeks* on the processes of installation, configuration, and package management. After your DSVM is allocated, you can immediately begin working on your data science project.

## Sample use cases

The DSVM is a good fit for several use cases.

### Moving data science workloads to the cloud

The DSVM provides a baseline configuration for data science teams. This configuration ensures that all the data scientists on a team have a consistent setup with which to verify experiments and promote collaboration. It also lowers costs by reducing the sysadmin burden. This burden reduction saves on the time needed to evaluate, install, and maintain software packages for advanced analytics.

### Data science training and education

Enterprise trainers and educators who teach data science classes usually provide a virtual machine image. The image ensures that students have a consistent setup and that the samples work predictably.

The DSVM creates an on-demand environment with a consistent setup that eases the support and compatibility challenges. Cases where these environments need to be built frequently, especially for shorter training classes, benefit substantially.

### On-demand elastic capacity for large-scale projects

Data science hackathons/competitions, or large-scale data modeling and exploration require scaled-out hardware capacity, typically for short duration. The DSVM can help replicate the data science environment quickly on demand. These replicated environments can then run on high-powered computing resources as your scenario demands.

### Short-term experimentation and evaluation

You can use the DSVM to evaluate or learn new data science tools. The DSVM has samples and walkthroughs preinstalled.

### Deep learning with GPUs

In the DSVM, your training models can use deep learning algorithms on hardware that's based on GPUs. By taking advantage of the VM scaling capabilities of the Azure platform, the DSVM helps you use GPU-based hardware in the cloud.

You can switch to a GPU-based VM when you're training large models, or when you need high-speed computations while keeping the same OS disk. You can choose any of the N series GPU-enabled virtual machine SKUs with the DSVM. Azure free accounts don't support GPU-enabled virtual machine SKUs.

The DSVM is configured with the proper drivers, framework versions and configurations, and GPU tools for those tools and frameworks that support GPU acceleration. If you use Python, there are several conda environments configured to avoid confusion. For instance, PyTorch and TensorFlow are in separate environments.

You can also deploy the Ubuntu or Windows edition of the DSVM to an Azure virtual machine that isn't based on GPUs. In this case, all the deep learning frameworks fall back to the CPU model.

Our scenario, where you're investigating bank data to help predict trends, touches on several of these use cases: collaboration, capacity, and exploration. You decide that an Ubuntu DSVM is a good choice, because it allows you to use familiar tools like CRAN-R and your existing data disk. And it doesn't require you to invest in learning new technologies until you've worked with your data for a while.
