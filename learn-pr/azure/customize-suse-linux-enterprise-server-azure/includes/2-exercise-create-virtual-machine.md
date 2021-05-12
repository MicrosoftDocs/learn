The most straightforward way to create a new VM in Azure is to use the Azure portal because it walks you through the required information and provides hints and helpful messages during the creation. The following steps walk through the process at a high level: 

1. Sign in to your Azure portal
1. On the Azure portal menu or from the Home page, under Azure services, select Virtual machines. Alternatively, you can enter Virtual machines in the top search box, and press Enter to get the virtual pane. 
1. In the top menu bar, select Add > Virtual machine. The Create a virtual machine pane appears. Choose Pay-as-you-go option 
1. In the Basics tab:

  - Choose your Subscription and Resource group
  - Name your virtual machine and select your region
  - Choose the SUSE Enterprise Linux option for your image
  - Choose the size for your VM
  - Select the SSH public key for your authentication type
  - Use an existing key or generate a new pair
  - Press next to customize your VM, or press Review + create to deploy your SLES VM

5. In the Disks tab:

  - Select your OS disk type
  - Set the ecyrption type (default works fine)
  - Add your data disks
  - Select OK to create the disk.
  - The Disks section should reappear on the Create a virtual machine pane and you’ll see a new disk in the first row. 

6. In the Networking tab, it is fine to accept the setting default values for this exercise.
1. Finish configuring the VM and creating the image by selecting Review + create.
1. After the system validates your options, and gives you details about the VM being created, select Create to create and deploy the VM. The Azure dashboard will show the VM that's being deployed. This may take several minutes.
1. From the Azure portal, select Go to resource and the Overview pane to see the VM you just created  
1. Get the public IP address of the VM and ssh into your machine.

TODO images