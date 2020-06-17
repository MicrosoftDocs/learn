Once you have decided to use a Data Science Virtual Machine to explore your domain, you need to decide whether you'd prefer Windows Server 2019 or Ubuntu 18.04 as the operating system. Additionally, you should plan what hardware and network resources you'd like the DSVM to use. 

## Data Science Virtual Machine Operating System choices 

There are two Data Science Virtual Machine images:

* Windows Server 2019
* Ubuntu 18.04

Both machines contain a variety of tools for data science and deep learning.

TODO: Maybe even a Venn diagram... 

| Windows Server 2019   only                        | Both Machines                                        | Ubuntu 18.04 only           |
|---------------------------------------------------|------------------------------------------------------|-----------------------------|
|        .NET Framework                             |        Apache Drill                                  |        Atom                 |
| AdlCopy (Azure Data Lake   Storage)               | Apache Spark (standalone)                            | Blob FUSE driver            |
| AzCopy                                            | Azure CLI                                            | CatBoost                    |
| Azure Cosmos DB Data Migration Tool             | Azure Machine Learning Python and R SDKs and samples | Dlib                        |
| Microsoft Edge Browser                            | Azure SDK                                            | Docker (TODO: Check!)       |
| Microsoft Office ProPlus with shared activation | Azure Storage Explorer                               | Emacs                       |
| Nano                                              | CUDA                                                 | H2O                         |
| Notepad++                                         | cuDNN                                                | Horovod                     |
| Power BI Desktop                                  | Git and Git Bash                                     | Intel MKL                   |
| SQL Server Integration Service                    | Julia                                                | IntelliJ IDEA               |
| SQL Server Management Studio                      | Jupyter Notebook server with kernels for: <br/> Python <br/> R <br/> Julia <br/> Python Spark <br/> R Spark <br/> Scala Spark           | JupyterHub / JupyterLab     |
| Visual Studio 2019 Community Edition            | Node.js                                              | LightGBM                    |
|                                                   | NVidia System Management Interface                   | Nccl                        |
|                                                   | OpenJDK                                              | ONNX Runtime (TODO: Check!) |
|                                                   | PyCharm Community Edition                            | OpenCV (TODO: Check!)       |
|                                                   | Python with miniconda environments preinstalled      | Rattle                      |
|                                                   | PyTorch                                              | RStudio Server              |
|                                                   | R with CRAN-R popular packages preinstalled           | Squirrel SQL                |
|                                                   | RStudio Desktop                                      | Vim                         |
|                                                   | SQL Server 2019 Developer   Edition                  |                             |
|                                                   | Tensorflow 2 / Keras                                 |                             |
|                                                   | Visual Studio Code                                   |                             |
|                                                   | Vowpal Wabbit                                        |                             |
|                                                   | XGBoost                                              |                             |

### Software available on both machines

Apache Drill
Apache Spark (standalone)
Azure CLI
Azure Machine Learning Python and R SDKs and samples
Azure SDK
Azure Storage Explorer
CUDA 
cuDNN
Git and Git Bash
Julia
Jupyter Notebook server with kernels for:
    - Julia
    - PySpark
    - Python
    - Python 3 Spark - HDInsight
    - R
    - R Spark - HDInsight
    - Scala Spark - HDInsight
Node.js
NVidia System Management Interface
OpenJDK
PyCharm Community Edition
Python with miniconda environments preinstalled
PyTorch
R with CRAN-R popular packages preinstalled
RStudio Desktop
SQL Server 2019 Developer Edition
Tensorflow 2 / Keras
Visual Studio Code
Vowpal Wabbit
XGBoost

### Software only available on Windows Server 2019

.NET Framework
AdlCopy (Azure Data Lake Storage)
AzCopy
Azure Cosmos DB Data Migration Tool
Microsoft Edge Browser
Microsoft Office ProPlus with shared activation
Nano
Notepad++
Power BI Desktop
SQL Server Integration Service
SQL Server Management Studio
Visual Studio 2019 Community Edition

### Software only available on Ubuntu 18.04

Atom
Blob FUSE driver
CatBoost
Dlib
Docker (TODO: Check!)
Emacs
H2O
Horovod
Intel MKL
IntelliJ IDEA
JupyterHub / JupyterLab
LightGBM
Nccl
ONNX Runtime (TODO: Check!)
OpenCV (TODO: Check!)
Rattle
RStudio Server
Squirrel SQL
Vim

## Processor, RAM, and Disk Choices

tk wrong-o Once you've decided on the size of a virtual machine, you cannot change it. You may add storage, but you may not change the processors, RAM, or operating system disk.

Configurations come in six major type:

| Type | Characteristics |
| - |- |
| General purpose | Balanced CPU-to-memory ratio. |
| GPU | Single or multiple GPUs. Best fit for statistical ML training and inferencing. |
| Memory optimized | High memory-to-CPU ratio. Good for in-memory analytics. |
| Storage optimized | High disk and IO throughput. Good for Big Data. |
| High performance compute | Powerful CPU machines. Good for tools with no GPU support. |
| Compute optimized | High CPU-to-memory ratio. Probably not a good fit for data science. Prefer 'GPU' or 'High performance compute'.|

The Data Science Virtual Machines are preconfigured with the drivers, library versions, and configurations to take advantage of GPU processing if it's available.

Within a type, machines are typically associated with a letter-based series. For instance, GPU sizes typically begin with an 'N': NC6, NC12s v3, NC24, NV12, and so forth. For more, see [Virtual Machines Pricing](https://azure.microsoft.com/pricing/details/virtual-machines/).

Before you create a DSVM, you should decide on a storage strategy. You can choose to install the OS on a Premium SSD, a Standard SSD, or a Standard HDD. In addition, you will be able to choose to create or attach to one or more data disks. Again, you can choose the hard-drive technology, trading off the higher speed of SSDs versus their cost per gigabyte. 

## Azure portal

Now that you've decided what operating system, VM size, and disk options you want, you can create the DSVM using the Azure portal. The portal is an easy-to-use browser-based user interface to create and manage all your Azure resources. For example, you can set up a new database, increase the compute power of your virtual machines, and monitor your monthly costs. It's also a great learning tool, since you can survey all available resources and use guided wizards to create the ones you need.

Once you're signed in, you're presented with two main areas. The first is a menu with  options to help you create resources, monitor resources, and manage billing. The second is the home page that shows some of the most commonly used services. You'll most likely find the portal the most comfortable option to use when you start using Azure.

### Create an Azure VM with the Azure portal

Let's assume you want to create a VM running an Ubuntu server. Setting up a site isn't difficult, but there are a couple of things to keep in mind. You need to install and configure an operating system, configure a website, install a database, and worry about things like firewalls. We're going to cover creating VMs in the next few modules, but let's create one here to see how easy it is. We won't go through all the options - check out one of the **Create a VM** module to get complete details on each option.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.



1. Click on the **Create a resource** option in the top-left corner of the portal page. The Azure Marketplace pane will open.

    ![Screenshot that shows the Azure Marketplace with create a resource highlighted](../media/3-create-new-resource.png)

    As you can see, there are many selectable options. We want to create a VM running an Ubuntu server. VMs are Azure compute resources, so select the **Compute** option on the available list and then search for Ubuntu VM images. You can click **See All** to get the full list.

1. Use the **Search the Marketplace** search bar to find "Ubuntu Server". You see a list of options. Select the option that reads **Ubuntu Server 18.04 LTS** as shown below.

    ![A screenshot showing Search the Marketplace with Ubuntu Server 18.04 LTS highlighted.](../media/3-search-vm-image.png)

1. The pane that opens next presents licensing information for the image we're about to use. Click **Create**.

1. You're presented with the **Create virtual machine** page. Notice the wizard-based approach we can use to configure the VM.

### Configure the VM

We need to configure the basic parameters of our Ubuntu virtual machine. If some of the options at this point are unfamiliar to you, that's OK. We're going to discuss all of these options in a future module. You're welcome to copy the values used here.

1. Use the following values on the **Basics** tab.
    - The **Subscription** should be set to _Concierge Subscription_.

    - The **Resource Group** should be set to <rgn>[sandbox resource group name]</rgn>.

    - Enter the **Virtual machine name** as _test-ubuntu-cus-vm_.

    - Select a **Region** close to you from the following list.
        [!include[](../../../includes/azure-sandbox-regions-note-friendly.md)]

    - For **Availability options**, choose _No infrastructure redundancy required_.

    - The **Image** should be the _Ubuntu Server 18.04 LTS_ option we selected from the Marketplace.

    - Check to make sure the **Size** of the VM set as _Standard D2s V3_.

    - For the **Authentication type**, switch to **Password**. Enter a username and password.

    ![Screenshot showing the Create a VM screen with details filled out](../media/3-create-vm-1.png)

2. There are several other tabs you can explore to see the settings you can influence during the VM creation. Once you're finished exploring, click **Review + create** to review and validate the settings.

3. On the review screen, Azure will validate your settings. You might need to supply some additional information based on the requirements of the image creator. Verify all the settings are set the way you want, and then click **Create** to deploy and create the VM.

4. You can monitor the deployment through the **Notifications** panel. Click the icon in the top toolbar to show or hide the panel.

    ![A screenshot showing th Monitor the deployment progress](../media/3-deploying.png)

5. The VM deployment process takes a few minutes to complete. You'll receive a notification informing you that the deployment succeeded. Click on the **Go to resource** button to go to the VM overview page.

    ![Screenshot showing a successful deployment of the Ubuntu image](../media/3-deployment-succeeded.png)

6. Here you can see all the information and configuration options for your newly created Ubuntu VM. One of the pieces of information is the **Public IP address**.

    ![Screenshot showing the VM overview page with the public IP address to the VM highlighted.](../media/3-public-ip-address.png)

7. By default, Ubuntu Server 18.04 LTS image doesn't install any reachable public services on the public IP address. However, recall that when you enabled password authentication in an earlier step, the UI also gave an option to enable SSH. SSH allows you to connect to your VM via the public IP using any SSH client.

Congratulations! With a few steps, you deployed a VM that runs Linux. Let's explore some other ways we could have created a VM.
