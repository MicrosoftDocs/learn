Recall that your company processes video content on Windows VMs. A new city has contracted to process their traffic cameras, but it's a model you have not worked with before. You need to create a new Windows VM and install some proprietary codecs so you can begin processing and analyzing their images.

## Create a new Windows virtual machine

You can create Windows VMs with the Azure portal, Azure CLI, or Azure PowerShell. The easiest approach is the portal because it walks you through the required information and provides hints and helpful messages when creating a VM.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. On the Azure portal, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In *Search services and marketplace* search box, enter **Windows Server** and press <kbd>Enter</kbd>.

1. To the right of the search box, select the filter *Publisher name:* **All** and enter **Microsoft**, and then press <kbd>Enter</kbd>.
 
    :::image type="content" source="../media/3-marketplace-search.png" border="true" alt-text="Screenshot showing virtual machine image options.":::

1. The result shows several *Windows Server*-related images. Select the **Windows Server** Virtual Machine images.

    :::image type="content" source="../media/3-marketplace-windows-server.png" border="true" alt-text="Screenshot showing the virtual machine image search result that highlights the Windows Server option.":::

    The **Windows Server** pane appears.

1. There are several Windows Server options to choose from to create your VM. In the **Select a plan** dropdown list, scroll to the bottom and select **[smalldisk] Windows Server 2019 Datacenter**.

1. Select **Create** to open the **Create a virtual machine** pane.

## Configure the VM settings

Azure presents a *wizard* to walk you through all the configuration sections for the VM. You can select **Next** or **Previous** to move from one configuration section to another, or you can select any tab in the horizontal menu to move to a configuration section.

The **Create a virtual machine** pane appears.

:::image type="content" source="../media/3-azure-portal-create-vm.png" border="true" alt-text="Screenshot showing **Basics** tab of the **Create a virtual machine** pane.":::

### Configure basic VM settings

> [!NOTE]
> As you change settings in a field, Azure will validate each value and place a green check mark next to a validated field, or red error indicator below the field. You can hover over an error indicator to get more information about a validation issue.

> [!NOTE]
> It's a best practice to standardize your resource names so you can easily identify their purpose. Windows VM names are a bit limited - they must be between 1 and 15 characters, cannot contain non-ASCII or special characters, and must be unique in the current resource group.

1. On the **Basics** tab, select or enter the following values.

    | Setting | Value |
    |---------|---------|
    | **Project details** |
    | Subscription | Concierge Subscription (the subscription that should be billed for VM hours). |
    | Resource Group | Select ***<rgn>[sandbox resource group name]</rgn>***. |
    | **Instance details** |
    | Virtual machine name | Enter a name for your VM, such as **test-vp-vm2** (for Test Video Processor VM #2). |
    | Region | Select a region close to you from the global regions listed below this table. |
    | Availability options | Select **No infrastructure redundancy required**. This option is used to ensure the VM is highly available by grouping multiple VMs together a set to deal with planned or unplanned maintenance events or outages. |
    | Image | Select **Windows Server 2019 Datacenter - Gen1** from the dropdown list. |
    | Size | The **Size** field is not directly editable and has a DS1 default size. Select **See all sizes** to explore other VM sizes. The resulting dialog box allows you to filter based on # of CPUs, Name, and Disk Type. Select **Standard DS1 v2** (normally the default), which will give the VM 1 CPU and 3.5 GB of memory. |
    | **Administrator account** |
    | Username | Enter a username you will use to sign in to the VM. |
    | Password | Enter a password that's at least 12 characters long. It must have three of the following: one lower case character, one uppercase character, one number, and one special character that is not '\\' or '-'. Use something you will remember or write it down, as you will need it later. |
    | Confirm password | Confirm your password. |
    | **Inbound port rules** |
    | Public inbound ports | Select **Allow selected ports**. Because this is a Windows VM, we want to be able to access the desktop using RDP. |
    | Select inbound ports | Select **RDP (3389)** from the dropdown list. As the note in the UI indicates, we can also adjust the network ports after we create the VM. |
    | | |

   [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

    > [!TIP]
    > You can use the horizonal scroll bar to slide the view to the left to get back to the VM settings, which had opened a new pane to the right.

## Configure disks for the VM

1. Select **Next : Disks**.

1. On the **Disks** pane, select or enter the following values.

    | Setting | Value |
    |---------|---------|
    | **Disk options** |
    | OS disk type | Select **Premium SSD**. |
    | SSE encryption type | Select **(Default) Encryption at-rest with a platform-managed key**. |
    | **Data disks** |
    | Select **Create and attach a new disk** link. The **Create a new disk** pane appears. | Accept all the default values for the following settings: *Name*; *Source type*; *Size*; *SSE encryption type*; and *Enable shared disk*. Note that this is where you could use a snapshot, or Storage Blob to create a VHD. Select **OK**. |

    ![Screenshot showing the configure disks section for the VM.](../media/3-configure-disks.png)

1. Under **Data disks**, there should now be a new disk in the first row.

    ![Screenshot showing the newly added disk in the VM.](../media/3-new-disk.png)

## Configure the network

1. Select **Next : Networking**.

   In a production system, where we already have other components, we'd want to utilize an _existing_ virtual network. That way our VM can communicate with the other cloud services in our solution. If there isn't one defined in this location yet, we can create it here and configure the:
    - **Subnet**: First subnet to subdivide the address space - it must fit within the defined address space. After the VNet is created, you can add additional subnets.
    - **Public IP**: Overall IPV4 space available to this network.

1. On the **Networking** tab, let's change some of the settings.

    | Setting | Value |
    |---------|---------|
    | **Network interface** |
    | Virtual network | Let's change the default ranges to use the `172.xxx` IP address space. Select the **Create new** link. |
    
    The **Create virtual network** pane appears.

1. On the **Create virtual network pane** select or enter the following values.

    | Field | Value |
    |---------|---------|
    | **Address space** |
    | Select *Address range* | In the empty field enter `172.16.0.0/16` to give the adress space a full range of addresses. If another address range row exists, select it so that it is deleted. |
    | **Subnets** |
    | Select *Subnet name* | In empty field, enter *default*. If a different setting exists for default, delete it|
    | Address range | Enter `172.16.1.0/24` to give it 256 IP addresses of the space. |

1. Select **OK**.

> [!NOTE]
> By default, Azure will create a virtual network, network interface, and public IP for your VM. It's not trivial to change networking options after the VM has been created so always double-check the network assignments on services you create in Azure.

## Finish configuring the VM and create the image

On the **Create a virtual machine** pane, the rest of the tabs have reasonable defaults and there's no need to change any of them. You can explore the other tabs if you like. Each field has an `(i)` icon next to it that, if selected will show additional details about that configuration setting. This is a great way to learn about the various settings you can use to configure the VM.

1. Select **Review + create**. The system will validate your options, and give you details about the VM being created.

1. Select **Create** to create and deploy the VM. The Azure dashboard will show the VM that's being deployed. This may take several minutes.

While that's deploying, let's look at what we can do with this VM.
