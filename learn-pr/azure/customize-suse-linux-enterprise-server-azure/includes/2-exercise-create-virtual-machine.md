A virtual machine (VM) on Azure provides the infrastructure for running your workloads. Recall that your employer needs you to create a new VM for the LAMP stack. Here we will use the Azure portal to create the new VM. The portal walks you through the required information and provides hints and helpful messages during the creation. 

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true)

1. On the Azure portal menu or from the Home page, under Azure services, select Virtual machines. Alternatively, you can enter Virtual machines in the top search box, and press Enter to get the virtual pane.

1. In the top menu bar, select Add > Virtual machine. The Create a virtual machine pane appears.

1. In the Basics tab:

    - Choose the subscription you will be using for this exercise and Resource group
    - Name your virtual machine LAMP_Test_1 and select the closest region
    - Choose the SUSE Enterprise Linux option for your image
    - Choose the smallest size VM
    - Select the SSH public key for your authentication type
    - Generate a new key pair
    - Press next to customize your VM, or press Review + create to deploy your SLES VM

5. In the Disks tab:

    - Select the premium SSD disk type
    - Set the ecyrption type to default
    - Select OK to create the disk
    - The Disks section should reappear on the Create a virtual machine pane and you’ll see a new disk in the first row

    :::image type="content" source="../media/create-data-disks.png" alt-text="Screenshot of the Data Disks section of the VM creation screen in the Azure portal.":::

6. In the Networking tab, it is fine to accept the setting default values for this exercise.

1. Finish configuring the VM and creating the image by selecting Review + create.

1. After the system validates your options, and gives you details about the VM being created, select Create to create and deploy the VM. The Azure dashboard will show the VM that's being deployed. This may take several minutes.

1. From the Azure portal, select Go to resource and the Overview pane to see the VM you just created  

1. Get the public IP address of the VM and ssh into your machine.

    :::image type="content" source="../media/launch-virtual-machine-ssh.png" alt-text="Screenshot of launching SUSE SLES Azure V M using s s h.":::
