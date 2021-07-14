Recall that our company processes video content on Windows VMs. A new city has contracted us to process their traffic cameras, but it's a model we've not worked with before. We need to create a new Windows VM and install some proprietary codecs so we can begin processing and analyzing their images.

## Create a new Windows virtual machine

We can create Windows VMs with the Azure portal, Azure CLI, or Azure PowerShell. The easiest approach is the portal because it walks you through the required information and provides hints and helpful messages when creating a VM.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. Select the **See more in Marketplace** link next to *Popular offers*. This option displays all available images in the Azure Marketplace.

    Select **Microsoft** as the filter value in the *Publisher* filter options. In the search box, enter **Windows Server**, and then press <kbd>Enter</kbd>.

    :::image type="content" source="../media/3-marketplace-search.png" border="true" alt-text="Screenshot showing the virtual machine image search options.":::

1. The result shows several *Windows Server*-related images. Select the **Windows Server** image.

    :::image type="content" source="../media/3-marketplace-windows-server.png" border="true" alt-text="Screenshot showing the virtual machine image search result that highlights the Windows Server option.":::

    The **Windows Server** pane appears.

1. There are several Windows Server versions we can select from to create our VM. In the **Select a plan** dropdown list, select the **[smalldisk] Windows Server 2019 Datacenter** option.

1. Select **Create** to start configuring the VM.

## Configure the VM settings

The VM creation experience in the portal is presented in a *wizard* format to walk you through all the configuration areas for the VM. Selecting **Next** will take you to the next configurable section. However, you can move between the tabs running across the top that identify each section.

The **Create a virtual machine** pane appears.

:::image type="content" source="../media/3-azure-portal-create-vm.png" border="true" alt-text="Screenshot showing the virtual machine creation experience in the Azure portal.":::

### Configure basic VM settings

> [!NOTE]
> As you change settings and tab out of each free-text field, Azure will validate each value automatically, and place a green check mark next to it when it validates. You can hover over error indicators to get more information about issues it discovers.

> [!NOTE]
> It's a best practice to standardize your resource names so you can easily identify their purpose. Windows VM names are a bit limited - they must be between 1 and 15 characters, cannot contain non-ASCII or special characters, and must be unique in the current resource group.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | **Project details** |
    | Subscription | Concierge Subscription (the subscription that should be billed for VM hours). |
    | Resource Group | Select ***<rgn>[sandbox resource group name]</rgn>*** |
    | **Instance details** |
    | Virtual machine name | Enter a name for your VM, such as **test-vp-vm2** (for Test Video Processor VM #2) |
    | Region | Select a region close to you from the following locations. |
    | Availability options | Select **No infrastructure redundancy required**. This option is used to ensure the VM is highly available by grouping multiple VMs together a set to deal with planned or unplanned maintenance events or outages. |
    | Image | Ensure the image is set to "Windows Server 2019 Datacenter - Gen1". You can open the dropdown list to see all the options available. |
    | Size | The **Size** field is not directly editable and has a DS1 default size. Select the **See all sizes** link to explore other VM sizes. The resulting dialog box allows you to filter based on # of CPUs, Name, and Disk Type. Select **Standard DS1 v2** (normally the default) when you are done. That will give the VM 1 CPU and 3.5 GB of memory. |
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
    > You can also just slide the view to the left to get back to the VM settings as it opened a new window off to the right, and slid the window over to view it.

## Configure disks for the VM

1. Select **Next : Disks**.

1. On the **Disks** tab, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | **Disk options** |
    | OS disk type | Select *Premium SSD* |
    | Encryption type | Select the *(Default) Encryption at-rest with a platform-managed key* from the dropdown list. |
    | **Data disks** |
    | Select **Create and attach a new disk** link. The **Create a new disk** pane appears. | Accept all the default values for the following settings: *Name*; *Source type*; *Size*; *Encryption type*; and *Enable shared disk*. Note that here is where we could use a snapshot, or Storage Blob to create a VHD. Select **OK** to create the disk, and go back to the **Data disks** section. |

    ![Screenshot showing the configure disks section for the VM.](../media/3-configure-disks.png)

1. Under **Data disks**, there should now be a new disk in the first row.

    ![Screenshot showing the newly added disk in the VM.](../media/3-new-disk.png)

## Configure the network

1. Select **Next : Networking**.

1. In a production system, where we already have other components, we'd want to utilize an _existing_ virtual network. That way our VM can communicate with the other cloud services in our solution. If there isn't one defined in this location yet, we can create it here and configure the:
    - **Subnet**: First subnet to subdivide the address space - it must fit within the defined address space. After the VNet is created, you can add additional subnets.
    - **Public IP**: Overall IPV4 space available to this network.

1. On the **Networking** tab, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | **Network interface** |
    | Virtual network | Let's change the default ranges to use the `172.xxx` IP address space. Select the **Create new** link. The **Create virtual network** pane appears. |

1. Enter the following values for each field.

    | Field | Value |
    |---------|---------|
    | **Address space** |
    | Address range | Enter `172.16.0.0/16` to give it the full range of addresses. |
    | **Subnets** |
    | Subnet name | Set as *default*. |
    | Address range | Enter `172.16.1.0/24` to give it 256 IP addresses of the space. |

1. Select **OK**.

> [!NOTE]
> By default, Azure will create a virtual network, network interface, and public IP for your VM. It's not trivial to change the networking options after the VM has been created so always double-check the network assignments on services you create in Azure.

## Finish configuring the VM and create the image

The rest of the options have reasonable defaults and there's no need to change any of them. You can explore the other tabs if you like. The individual options have an `(i)` icon next to them that will show a help bubble to explain the option. This is a great way to learn about the various options you can use to configure the VM.

1. Select **Review + create**. The system will validate your options, and give you details about the VM being created.

1. Select **Create** to create and deploy the VM. The Azure dashboard will show the VM that's being deployed. This may take several minutes.

While that's deploying, let's look at what we can do with this VM.
