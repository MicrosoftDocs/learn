A virtual machine (VM) on Azure provides the infrastructure for running your workloads. Recall that your employer needs you to create a new VM for the LAMP stack. Here, we use the Azure portal to create the new VM. The portal walks you through the required information and provides hints and helpful messages during the creation. 

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true)

1. On the Azure portal menu or from the Home page, under Azure services, select Virtual machines. Alternatively, you can enter Virtual machines in the top search box, and press Enter to get the virtual pane.

1. In the top menu bar, select Add > Virtual machine. The Create a virtual machine pane appears.

1. In the Basics tab:

    - Choose the subscription you want to use for this exercise and Resource group and name it rg-lamp-demo
    - Name your virtual machine vm-lamp-test-1 and select the default Availability option
    - Choose the SUSE Enterprise Linux 15 SP2 + Patching option for your image
    - Leave the Azure Spot instance box unchecked
    - Choose the smallest size VM (Standard_B1s)
    - Select the SSH public key for your authentication type
    - Generate a new key pair and store it on your local machine along with the username
    - Press next to customize your VM, or press Review + create to deploy your SLES VM

5. Select the default options for the Disks and Networking settings


6. Finish configuring the VM and creating the image by selecting Review + create.

1. After the system validates your options, and gives you details about the VM being created, select Create to create and deploy the VM. The Azure dashboard shows the VM that's being deployed. Deployment may take several minutes.

1. From the Azure portal, select Go to resource and the Overview pane to see the VM you just created  
1. Open the connect menu and choose ssh
1. Follow the steps to connect your machine with ssh. If you're using a local Windows machine, you need putty, Windows Subsystem for Linux (WSL), or another software that provides ssh under Windows. If you're using a local Linux machine, open a terminal. 

    :::image type="content" source="../media/launch-virtual-machine-ssh.png" alt-text="Screenshot of launching SUSE SLES Azure V M using s s h.":::
