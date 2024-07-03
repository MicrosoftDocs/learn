The Data Science Virtual Machine (DSVM) runs on the Azure cloud platform. DSVM images for

- Windows Server 2019
- Ubuntu Server 20.04 LTS

are available. You can run the DSVM on different Azure virtual machine series and sizes. Common choices for the DSVM include:

| Common series | Use case |
| --- | --- |
| General purpose | Balanced CPU/memory ratios |
| Memory-optimized E series | In-memory data analytics |
| N-series GPU compute | Machine learning experimentation and inferencing |

N-series virtual machines feature the NVIDIA Tesla accelerated platform and NVIDIA GRID 2.0 technology. The DSVM tools and libraries that can use GPU acceleration are preconfigured with the appropriate drivers and library versions.

## How the Data Science Virtual Machine works

After you specify an operating system and hardware platform, Azure creates the virtual machine and related resources. The related resources include a storage account and a network security group.

When you start the virtual machine, Azure restores the image to the specified hardware type, and launches the operating system. You can then connect, as shown in this module. After you connect, you use the virtual machine in the same way you'd use any other machine. After you finish, you shut down the machine with either the operating system facilities or the Azure portal.

Your costs and charges are based on the hardware type (compute power, RAM, and storage) that you specified. You're charged only for time that the virtual machine is running, at a half-minute granularity.

## When to use the Data Science Virtual Machine

The goal of the DSVM is a friction-free, preconfigured environment for data science and machine learning. The experience is familiar and usable by data professionals at all skill levels.

Instead of rolling out a comparable workspace on your own, you can set up a DSVM. That choice can save you days or even *weeks* of installation, configuration, and package management time. After your DSVM is allocated, you can immediately begin working on your data science project.

## Sample use cases

The DSVM is a good fit for several use cases.

### Moving data science workloads to the cloud

The DSVM provides a baseline configuration for data science teams. This configuration ensures that all the data scientists on a team have a consistent setup with which to verify experiments and promote collaboration. It also lowers costs through reductions in the sysadmin burden. These reductions shrink the time needed to evaluate, install, and maintain software packages for advanced analytics.

### Data science training and education

Enterprise trainers and educators who teach data science classes usually provide a virtual machine image. The image ensures that students have a consistent setup and that the samples work predictably.

The DSVM creates an on-demand environment with a consistent setup that eases the support and compatibility challenges. Cases where these environments need to be built frequently, especially for shorter training classes, benefit substantially.

### On-demand elastic capacity for large-scale projects

Data science hackathons/competitions, or large-scale data modeling and exploration, require scaled-out hardware capacity, typically for short duration. The DSVM can help replicate the data science environment, quickly and on demand. These replicated environments can then run on high-powered computing resources as your scenario requires.

### Short-term experimentation and evaluation

You can use the DSVM to evaluate or learn new data science tools. The DSVM has samples and walkthroughs already installed.

### Deep learning with GPUs

In the DSVM, your training models can use deep learning algorithms on GPU-based hardware. The DSVM takes advantage of the VM scaling capabilities of the Azure platform, to help you use GPU-based hardware in the cloud.

You can switch to a GPU-based VM when you train large models, or when you need high-speed computations while keeping the same OS disk. You can choose any of the N-series GPU-enabled virtual machine SKUs with the DSVM. Azure free accounts don't support GPU-enabled virtual machine SKUs.

For tools and frameworks that support GPU acceleration, the DSVM is configured with the proper drivers, GPU tools, and framework versions and configurations. If you use Python, several configured conda environments are available, to avoid confusion. For instance, PyTorch and TensorFlow operate in separate environments.

You can also deploy the Ubuntu or Windows edition of the DSVM to an Azure virtual machine that isn't based on GPUs. In this case, all the deep learning frameworks fall back to the CPU model.

Our scenario, where you investigate bank data to help predict trends, touches on several of these use cases: collaboration, capacity, and exploration. You decide that an Ubuntu DSVM is a good choice, because it allows you to use familiar tools like CRAN-R and your existing data disk. Additionally, it doesn't require you to invest in learning new technologies until you work with your data for a while.
