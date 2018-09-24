Recall that our company processes video content on Windows VMs. A new city has contracted us to process their traffic cameras, but it's a model we've not worked with before. We need to create a new Windows VM and install some proprietary codecs so we can begin processing and analyzing their images.

<!-- Activate the sandbox -->
[!include[](../../../includes/azure-sandbox-activate.md)]

## Create a new Windows virtual machine

We can create Windows VMs with the Azure portal, Azure CLI, or Azure PowerShell. The easiest approach is the portal because it walks you through the required information and provides hints and helpful messages during the creation of the VM.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Click **Create a resource** in the upper left corner of the Azure portal.

1. In the search box, enter  **Windows Server 2016 Datacenter**  and then click on the link with the same title in the presented list.

1. Click the **Create** button to start configuring the VM.

## Configure the VM settings

The VM creation experience in the portal is presented in a "wizard" format to walk you through all the configuration areas for the VM. Clicking the "Next" button will take you to the next configurable section. However, you can move between the sections at will with the tabs running across the top that identify each section.

![Screenshot showing the create a virtual machine experience in the Azure portal.](../media/3-azure-portal-create-vm.png)

Once you fill in all the required options (identified with red stars), you can skip the remainder of the wizard experience and start creating the VM through the **Review + Create** button at the bottom.

We'll start with the **Basics** section.

### Configure basic VM settings

> [!NOTE]
> As you change settings and tab out of each free-text field, Azure will validate each value automatically and place a green check mark next to it when it's good. You can hover over error indicators to get more information on issues it discovers.

1. Select the **Subscription** that should be billed for VM hours.

1. For **Resource group**, choose "**<rgn>[sandbox resource group name]</rgn>**".

1. In the **INSTANCE DETAILS** section, enter a name for your VM, such as **test-vp-vm2** (for Test Video Processor VM #2).
    - It's best practice to standardize your resource names so you can easily identify their purpose. Windows VM names are a bit limited - they must be between 1 and 15 characters, cannot contain non-ASCII or special characters, and must be unique in the current resource group.

1. Select a region close to you from the locations below.

   [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Leave **Availability options** as "None". This option is used to ensure the VM is highly available by grouping multiple VMs together a set to deal with planned or unplanned maintenance events or outages.

1. Ensure the image is set to "Windows Server 2016 Datacenter". You can open the drop-down list to see all the options available.

1. The **Size** field is not directly editable and has a DS1 default size. Click the **Change size** link to explore other VM sizes. The resulting dialog allows you to filter based on # of CPUs, Name, and Disk Type. Select "Standard DS1 v2" (normally the default) when you are done. That will give the VM 1 CPU and 3.5 GB of memory.

    > [!TIP]
    > You can also just slide the view to the left to get back to the VM settings as it opened a new window off to the right and slid the window over to view it.

1. In the **ADMINISTRATOR ACCOUNT** section, set the **Username** field to a username you will use to sign in to the VM.

1. In the **Password** field, enter a password that's at least 12 characters long. It must have three of the following: one lower case character, one uppercase character, one number, and one special character that is not '\\' or '-'. Use something you will remember or write it down, you will need it later.

1. Confirm the **password**.

1. In the **INBOUND PORT RULES** section, open the list and choose _Allow selected ports_. Since this is a Windows VM, we want to be able to access the desktop using RDP. Scroll the list if necessary until you find RDP (3389) and select it. As the note in the UI indicates, we can also adjust the network ports after we create the VM.

    ![Screenshot showing the drop-down for opening the port for RDP access on the Windows VM.](../media/3-open-ports.png)

## Configure Disks for the VM

1. Click **Next** to move to the Disks section.

    ![Screenshot showing the configure disks section for the VM.](../media/3-configure-disks.png)

1. Choose "Premium SSD" for the **OS disk type**.

1. Use managed disks so we don't have to work with storage accounts. You can flip the switch in the GUI to see the difference in information that Azure needs if you like.

### Create a data disk

Recall we will get an OS disk (C:) and Temporary disk (D:). Let's add a data disk as well.

1. Click the **Create and attach a new disk** link in the **DATA DISKS** section.

    ![Screenshot showing the new VM disk creation dialog in the portal.](../media/3-add-data-disk.png)

1. You can take all the defaults: Premium SSD, 1023 GB, and None (empty disk); although notice that here is where we could use a snapshot, or Storage Blob to create a VHD.

1. Click **OK** to create the disk and go back to the **DATA DISKS** section.

1. There should now be a new disk in the first row.

    ![Screenshot showing the newly added disk in the VM.](../media/3-new-disk.png)

## Configure the Network

1. Click **Next** to move to the Networking section.

1. In a production system where we already have other components, we'd want to utilize an _existing_ virtual network. That way our VM can communicate with the other cloud services in our solution. If there isn't one defined in this location yet, we can create it here and configure the:
    - **Address space**: the overall IPV4 space available to this network.
    - **Subnet range**: the first subnet to subdivide the address space - it must fit within the defined address space. Once the VNet is created you can add additional subnets.

1. Let's change the default ranges to use the `172.xxx` IP address space. Click **Create New** under Virtual Network.
    - Change the **Address space** field to be `172.16.0.0/16` to give it the full range of addresses
    - Change the **Subnet range** field to be `172.16.1.0/24` to give it 256 IP addresses of the space.

1. Click **OK**.

> [!NOTE]
> By default, Azure will create a virtual network, network interface, and public IP for your VM. It's not trivial to change the networking options after the VM has been created so always double-check the network assignments on services you create in Azure.

## Finish configuring the VM and create the image

The rest of the options have reasonable defaults and there's no need to change any of them. You can explore the other tabs if you like. The individual options have an `(i)` icon next to them that will show a help bubble to explain the option. This is a great way to learn about the various options you can use to configure the VM.

1. Click the **Review + create** button at the bottom of the panel.

1. The system will validate your options and give you details about the VM being created.

1. Click **Create** to create and deploy the VM. The Azure dashboard will show the VM that's being deployed. This may take several minutes.

While that's deploying, let's look at what we can do with this VM.