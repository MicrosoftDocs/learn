
# What is the Azure Data Science Virtual Machine for Linux and Windows?

The Data Science Virtual Machine (Data Science Virtual Machine) is a VM that runs in the Azure cloud platform. There are Data Science Virtual Machine images for:

- Windows Server 2019
- Ubuntu Server 18.04 LTS LTS

You can choose to run the Data Science Virtual Machine on a variety of Azure virtual machine sizes. General purpose sizes offer balanced CPU-memory ratios, while in-memory data analytics can benefit from the memory-optimized E-series, and ML experiments are likely to run significantly faster on the N-series GPU sizes. N-series virtual machines feature the NVIDIA Tesla accelerated platform and NVIDIA GRID 2.0 technology. The Data Science Virtual Machine tools and libraries that can exploit GPU acceleration are pre-configured with the appropriate drivers and library versions. 

## Why choose the Data Science Virtual Machine?

The goal of the Data Science Virtual Machine is to provide data professionals of all skill levels and across industries with a friction-free, preconfigured data science environment. Instead of rolling out a comparable workspace on your own, you can provision a Data Science Virtual Machine. That choice can save you days or even _weeks_ on the installation, configuration, and package management processes. After your Data Science Virtual Machine has been allocated, you can immediately begin working on your data science project.

## Sample Use Cases

Below, we illustrate some common use cases for Data Science Virtual Machine customers.

### Moving data science workloads to the cloud

The Data Science Virtual Machine provides a baseline configuration for data science teams that want replace their local desktops with a managed cloud desktop, ensuring that all the data scientists on a team have a consistent setup with which to verify experiments and promote collaboration. It also lowers costs by reducing the sysadmin burden. This burden reduction saves on the time needed to evaluate, install, and maintain software packages for advanced analytics.

### Data science training and education

Enterprise trainers and educators who teach data science classes usually provide a virtual machine image. The image ensures that students have a consistent setup and that the samples work predictably. 

The Data Science Virtual Machine creates an on-demand environment with a consistent setup that eases the support and incompatibility challenges. Cases where these environments need to be built frequently, especially for shorter training classes, benefit substantially.

### On-demand elastic capacity for large-scale projects

Data science hackathons/competitions or large-scale data modeling and exploration require scaled-out hardware capacity, typically for short duration. The Data Science Virtual Machine can help replicate the data science environment quickly on demand, on scaled-out servers that allow experiments that  high-powered computing resources can run.

### Custom compute power for Azure Notebooks

[Azure Notebooks](https://docs.microsoft.com/azure/notebooks/azure-notebooks-overview) is a free hosted service to develop, run, and share Jupyter notebooks in the cloud with no installation. The free service  tier is limited to 4 GB of memory and 1 GB of data. 

To release all limits, you can attach a Notebooks project to a Data Science Virtual Machine or any other VM running on a Jupyter server. If you sign in to Azure Notebooks with an account by using Azure Active Directory (such as a corporate account), Notebooks automatically shows Data Science Virtual Machines in any subscriptions associated with that account. You can [attach a Data Science Virtual Machine to Azure Notebooks](https://docs.microsoft.com/azure/notebooks/configure-manage-azure-notebooks-projects.md#compute-tier) to expand the available compute power.

### Short-term experimentation and evaluation

You can use the Data Science Virtual Machine to evaluate or learn new data science tools, especially by going through some of our published samples and walkthroughs.


### Deep learning with GPUs

In the Data Science Virtual Machine, your training models can use deep learning algorithms on hardware that's based on graphics processing units (GPUs). By taking advantage of the VM scaling capabilities of the Azure platform, the Data Science Virtual Machine helps you use GPU-based hardware in the cloud according to your needs. You can switch to a GPU-based VM when you're training large models, or when you need high-speed computations while keeping the same OS disk. You can choose any of the N series GPU enabled virtual machine SKUs with Data Science Virtual Machine. Please note Azure free accounts do not support GPU enabled virtual machine SKUs.

The Windows editions of the Data Science Virtual Machine comes pre-installed with GPU drivers, frameworks, and GPU versions of deep learning frameworks. On the Linux edition, deep learning on GPUs is enabled on the Ubuntu Data Science Virtual Machines. 

You can also deploy the Ubuntu or Windows editions of the Data Science Virtual Machine to an Azure virtual machine that isn't based on GPUs. In this case, all the deep learning frameworks will fall back to the CPU mode.