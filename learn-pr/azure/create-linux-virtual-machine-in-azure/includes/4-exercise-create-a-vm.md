Recall that our goal is to move an existing Linux server running Apache to Azure. We'll start by creating an Ubuntu Linux server.

## Create a new Linux virtual machine

We can create Linux VMs with the Azure portal, the Azure CLI, or Azure PowerShell. The easiest approach when you are starting with Azure is to use the portal because it walks you through the required information and provides hints and helpful messages during the creation:

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, under **Azure services**, select **Virtual machines**. Alternatively, you can enter *Virtual machines* in the top search box, and press <kbd>Enter</kbd>. The **Virtual machines** pane appears.

1. In the top menu bar, select **Create > Virtual machine**. The **Create a virtual machine** pane appears.

## Configure the VM settings, add data disks for the VM, and configure the network

The VM creation experience in the portal is presented in a wizard format to walk you through all the configuration areas for the VM. Selecting **Next** takes you to the next configurable tab. However, you can move between the tabs at will by selecting them in the sub menu.

:::image type="content" source="../media/3-azure-portal-create-vm.png" alt-text="Screenshot of the Azure portal showing Create a virtual machine pane for an Ubuntu Server machine." lightbox="../media/3-azure-portal-create-vm.png#lightbox":::

After you complete all the required options (identified with red asterisks), you can skip the remainder of the wizard experience, and start creating the VM by selecting **Review + create** at the bottom of the wizard.

Remember that these instructions use the sandbox. If you're using another Azure portal account, you may need to adapt some details accordingly.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Project details** |
    | Subscription | Concierge Subscription (the sandbox subscription should be selected by default).  |
    | Resource group | Select **<rgn>[sandbox resource group name]</rgn>**. |
    | **Instance details** |
    | Virtual machine name | Enter a name for your web server VM, such as **test-web-eus-vm1**. This indicates the environment (**test**), the role (**web**), location (**East US**), service (**vm**), and instance number (**1**). It's considered best practice to standardize your resource names, so you can quickly identify their purpose. Linux VM names must be between 1 and 64 characters and be comprised of numbers, letters, and dashes. |
    | Region | Select a location close to you. See the information below this table for available regions. |
    | Availability options | Select **No infrastructure redundancy required**. This option can be used to ensure the VM is highly available by grouping multiple VMs together as a set to deal with planned or unplanned maintenance events or outages. For this exercise we will not need this service. |
    | Image | From the dropdown list, select **Ubuntu Server 18.04 LTS - Gen1** |
    | Size | Standard D2s v3. This option gives you two vCPUs with 8 GB of RAM. |
    | **Administrator account** |
    | Authentication type | SSH public key |
    | Username | Enter a name you'll use to sign in with SSH. Make a note of it. |
    | SSH public key source | Use existing public key |
    | Key pair name | Paste the SSH key from your public key file you created in the previous unit. It should look similar to the example shown in unit 3 with no additional whitespace or line-feed characters. |

    <!-- Resource selection -->  
    [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Next: Disks** to open the **Disks** tab.

1. On the **Disks** pane, enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Disk options** |
    | OS disk type | Premium SSD |
    | Encryption type | (Default) Encryption at-rest with a platform-managed key |
    | **Data disks** | *Recall that we will get an OS disk (/dev/sda) and a temporary disk (/dev/sdb). Here, we'll add a data disk as well.* |
    | Create and attach a new disk | Select the link. The **Create a new disk** pane appears. Accept all the default settings. Notice that source type is where you could use a snapshot or Azure Blob Storage to create a VHD.

1. Select **OK** to create the disk. The **Disks** pane re reappears on the **Create a virtual machine** pane.

    A new disk appears in the first row.

    :::image type="content" source="../media/3-new-disk.png" alt-text="Screenshot of the Azure portal showing the newly created data disk line for the VM creation process." lightbox="../media/3-new-disk.png":::

1. Select **Next: Networking** to move to the **Networking** tab.

1. On the **Networking** pane, accept all the default values for each setting.

    In a production environment where we already have other components, you'd want to use an _existing_ virtual network. That way, your VM can communicate with the other cloud services in your solution. If there wasn't one defined in this location yet, you could create it here and configure the:
    - **Subnet**: The first subnet to subdivide the address space - it must fit within the defined address space. After the VNet is created, you could add additional subnets.
    - **Public IP**: The overall IPv4 space available to this network.

    By default, Azure creates a virtual network, network interface, and public IP for your VM. It's not trivial to change the networking options after the VM has been created, so always double-check the network assignments on services you create in Azure. For this exercise, the defaults should work fine.

    The rest of the options in the wizard have reasonable defaults, and there's no need to change any of them. You can explore the other tabs if you like. The individual options have an `(i)` icon next to them that will show a help tip to explain the option. This is a great way to learn about the various options you can use to configure the VM.

1. Finish configuring the VM and creating the image by selecting **Review + create**.

1. After the system validates your options, and gives you details about the VM being created, select **Create** to create and deploy the VM. The Azure dashboard will show the VM that's being deployed. This may take several minutes.

While it's deploying, let's consider what we can do with this VM.
