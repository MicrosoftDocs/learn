### Prerequisites for the lab

 1. **Microsoft Azure Account**: You will need a valid and active Azure account for this lab. If you do not have one, you can sign up for a [free trial](https://azure.microsoft.com/en-us/free/)

    * If you are a Visual Studio Active Subscriber, you are entitled for a $50-$150 credit per month. You can refer to this [link](https://azure.microsoft.com/en-us/pricing/member-offers/msdn-benefits-details/) to find out more including how to activate and start using your monthly Azure credit.

    * If you are not a Visual Studio Subscriber, you can sign up for the FREE [Visual Studio Dev Essentials](https://www.visualstudio.com/dev-essentials/) program to create **Azure free account** (includes 1 year of free services, $200 for 1st month).

    * If you are a student, you can sign up for a free [Azure for Students](https://aka.ms/azure4students) account to get $100 in free Azure credits + a year of free services, with no credit card required. 

1. An [Xfce](https://xfce.org/) remote-desktop client such as [X2Go](https://wiki.x2go.org/doku.php/download:start)


### Exercise 1: Create an Ubuntu Data Science VM

The Data Science Virtual Machine for Linux is a virtual-machine image that simplifies getting started with data science. Multiple tools are already built, installed, and configured in order to get you up and running quickly. The NVIDIA GPU driver, [NVIDIA CUDA](https://developer.nvidia.com/cuda-downloads), and [NVIDIA CUDA Deep Neural Network](https://developer.nvidia.com/cudnn) (cuDNN) library are also included, as are [Jupyter](http://jupyter.org/), several sample Jupyter notebooks, and [TensorFlow](https://www.tensorflow.org/). All pre-installed frameworks are GPU-enabled but work on CPUs as well. In this exercise, you will create an instance of the Data Science Virtual Machine for Linux on Azure.

1. Open the [Azure Portal](https://portal.azure.com) in your browser. If asked to log in, do so using your Microsoft account.

1. Click **+ Create a resource** in the menu on the left side of the portal, and then type "data science" (without quotation marks) into the search box. Select **Data Science Virtual Machine for Linux (Ubuntu)** from the results list.

    ![Finding the Ubuntu Data Science VM](../images/new-data-science-vm.png)

    _Finding the Ubuntu Data Science VM_

1. Take a moment to review the list of tools included in the VM. Then click **Create** at the bottom of the blade.

1. Fill in the "Basics" blade as shown below. Provide a password that's at least 12 characters long containing a mix of uppercase letters, lowercase letters, numbers and special characters. *Be sure to remember the user name and password that you enter, because you will need them later in the lab.*

    ![Entering basic information about the VM](../images/create-data-science-vm-1.png)

    _Entering basic settings_

1. In the "Choose a size" blade, select **DS1_V2 Standard**, which provides a low-cost way to experiment with Data Science VMs. Then click the **Select** button at the bottom of the blade.

    ![Choosing a VM size](../images/create-data-science-vm-2.png)

    _Choosing a VM size_

1. In the "Settings" blade, check **SSH (22)** in the list of inbound ports so clients can connect to the VM using the [Secure Shell](https://en.wikipedia.org/wiki/Secure_Shell) (SSH) protocol on port 22. Then click **OK**.

    ![Creating the VM](../images/create-data-science-vm-3.png)

    _Creating the VM_

1. In the "Create" blade, take a moment to review the options you selected for the VM, and click **Create** to start the VM creation process.

    ![Creating the VM](../images/create-data-science-vm-4.png)

    _Creating the VM_

1. Click **Resource groups** in the menu on the left side of the portal. Then click the "data-science-rg" resource group.

    ![Opening the resource group](../images/open-resource-group.png)

    _Opening the resource group_

1. Wait until "Deploying" changes to "Succeeded" indicating that DSVM and supporting Azure resources have been created. Deployment typically takes 5 minutes or less. Periodically click **Refresh** at the top of the blade to refresh the deployment status.

    ![Monitoring the deployment status](../images/deployment-succeeded.png)

    _Monitoring the deployment_

Once the deployment has completed, proceed to the next exercise.