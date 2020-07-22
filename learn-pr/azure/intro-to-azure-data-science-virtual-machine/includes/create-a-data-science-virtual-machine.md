Once you have decided to use a Data Science Virtual Machine to explore your domain, you need to decide whether you'd prefer Windows Server 2019 or Ubuntu Server 18.04 LTS as the operating system. Additionally, you should plan what hardware and network resources you'd like the Data Science Virtual Machine to use. 

This should show the name of the Sandboxed RG: <rgn>[sandbox resource group name]</rgn>

Go to [portal.azure.com](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true)


## Data Science Virtual Machine Operating System choices 

There are two Data Science Virtual Machine images:

* Windows Server 2019
* Ubuntu Server 18.04 LTS

Both machines contain a variety of tools for data science and deep learning.

TODO: Maybe even a Venn diagram... 

| Windows Server 2019   only                        | Both Machines                                        | Ubuntu Server 18.04 LTS only           |
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

### Software only available on Ubuntu Server 18.04 LTS

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

Azure virtual machines come in a variety of sizes, grouped by type:

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

Before you create a Data Science Virtual Machine, you should decide on a storage strategy. You can choose to install the OS on a Premium SSD, a Standard SSD, or a Standard HDD. In addition, you will be able to choose to create or attach to one or more data disks. Again, you can choose the hard-drive technology, trading off the higher speed of SSDs versus their cost per gigabyte. 

You may resize your Data Science Virtual Machine as your requirements change. For instance, you might choose a General Purpose or Memory Optimized size when Data Acquisition & Understanding are your primary focus, but resize to a GPU offering when Modeling becomes the bottleneck. 

## Create a Data Science VM with the Azure portal

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with

1. Click on the **Create a resource** option in the top-left corner of the portal page. The Azure Marketplace pane will open

    ![Screenshot that shows the Azure Marketplace with create a resource highlighted](../media/create-new-resource.png)

    As you can see, there are many selectable options. We want to create a Data Science Virtual Machine running on Ubuntu.

1. Use the **Search the Marketplace** search bar to find "Data Science". You will see a list of options. Select the option that reads **Data Science Virtual Machine - Ubuntu 18.04** as shown below

    ![A screenshot showing Search the Marketplace with Data Science Virtual Machine Ubuntu Server 18.04 LTS highlighted.](../media/search-dsvm.png)

1. The pane that opens is the **Create a virtual machine** page. Notice the wizard-based approach we can use to configure the VM

### Configure the VM

We need to configure the basic parameters of our Ubuntu virtual machine. 

1. Use the following values on the **Basics** tab.
    - The **Subscription** should be set to _Concierge Subscription_

    - The **Resource Group** should be set to <rgn>[sandbox resource group name]</rgn>

    - Enter the **Virtual machine name** as _test-ubuntu-dsvm_

    - Select a **Region** close to you from the following list
        [!include[](../../../includes/azure-sandbox-regions-note-friendly.md)]

    - For **Availability options**, choose _No infrastructure redundancy required_

    - The **Image** should be the _Data Science Virtual Machine - Ubuntu 18.04_ option we selected from the Marketplace

    - Check to make sure the **Size** of the VM set as _Standard\_DS1\_v2_
    - Change the **Authentication Type** to _Password_
    - Choose and record a **Username** and strong **Password** 
    
    ![Screenshot showing the Create a VM screen with details filled out](../media/create-new-resource.png)

2. There are several other tabs you can explore to see the settings you can influence during the VM creation, particularly the **Disks** tab, where you can specify your data disk(s). Once you're finished exploring, click **Review + create** to review and validate the settings.

1. On the review screen, Azure will validate your settings. Verify all the settings are set the way you want, and then click **Create**.

1. You can monitor the deployment through the **Notifications** panel. Click the icon in the top toolbar to show or hide the panel.

1. The VM deployment process takes a few minutes to complete. You'll receive a notification informing you that the deployment succeeded. Click on the **Go to resource** button to go to the VM overview page.

1. Here you can see all the information and configuration options for your newly created Data Science Virtual Machine. One of the pieces of information is the **Public IP address**.

    ![Screenshot showing the VM overview page with the public IP address to the VM highlighted.](../media/dsvm-summary-started-in-portal.png)

1. Securing access 

Congratulations! With a few steps, you deployed a Data Science Virtual Machine running on Linux. Let's connect to it. 
