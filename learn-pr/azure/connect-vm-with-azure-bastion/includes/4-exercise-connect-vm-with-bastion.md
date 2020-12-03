In this unit, you'll create a virtual machine (VM) to act as your internal app VM and deploy Azure Bastion to connect to it.

This exercise is optional. To complete it, you need access to an Azure subscription where you have permissions to create resources like a VM. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.


## Create a resource group

Create a resource group to contain all the resources that you'll create for the exercises.

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. Search for or select **Resource groups**.
1. Select **Add**.
1. Enter the following values for the resource group.

   |Field |Value |
   |---------|---------|
   |Subscription     |  Select your subscription       |
   |Resource group    |  learn-bastion-rg       |
   |Region    |  Choose the region near you       |

1. Select **Review + create** > **Create**.

## Create a VM

Create a Linux VM that's not exposed to the internet.

1. In the [Azure portal](https://portal.azure.com/), search for or select **Virtual machines**.
1. Select **Add** > **Virtual machine**.
1. Enter the following values to the **Basics** page.

   |Field |Value  |
   |---------|---------|
   |Subscription     |    Your subscription     |
   |Resource group    | learn-bastion-rg      |
   |Virtual machine name  |   internalappvm       |
   |Region    | Choose a region near you         |
   |Image     |  Ubuntu Server 18.04 LTS - Gen1       |
   |Username    | azureuser     |
   |SSH public key source    |  Generate new key pair     |
   |Key pair name   | internalappvm_key    |
   |Public inbound ports   |  None    |

   Use the default values for the rest of the fields on this page.

1. Select the **Networking** tab.
1. Change the following values.

   |Field |Value |
   |---------|---------|
   |Public IP    |    None     |
   |Public inbound ports    |  None       |

1. Select **Review + create** > **Create**.
1. Select **Download private key and create resource**.
   :::image type="content" source="../media/4-download-private-key.png" alt-text="Screenshot of the Generate new key pair window with the Download private key button highlighted.":::

Because you created the internal app VM without a public IP, you can't connect to it over the internet. Instead of using a jumpbox VM to connect to the internal app VM, let's use Azure Bastion. 

## Create a subnet for Azure Bastion

Before you can use Azure Bastion, you need to create a subnet on the virtual network that the internal app VM uses.

1. In the [Azure portal](https://portal.azure.com/), select or search for **Resource groups**.
1. Select **learn-bastion-rg**.
1. From the list of resources, select the virtual network **learn bastion-rg-vnet**.
1. Under **Settings**, select **Address space**.
1. Enter an address space with a subnet mask that's /27 or larger, like /26, /25, and so on. An example is 10.0.1.0/24.
1. Select **Save**.
1. Under **Settings**, select **Subnets**.
1. Select **+ Subnet** to add a subnet.
1. Enter the following information to create a subnet.

    :::image type="content" source="../media/4-add-bastion-subnet.png" alt-text="Screenshot of the Add subnet page where the subnet name is AzureBastionSubnet.":::

   |Field  |Name |
   |---------|---------|
   |Name    |  AzureBastionSubnet       |
   |Subnet address range     | The address space you just added, like 10.0.1.0/24  |

   Use the default values for the rest of the fields.

1. Select **OK**.

## Deploy Azure Bastion 

1. In the [Azure portal](https://portal.azure.com/), select or search for **Virtual machines**.
1. Select the virtual machine **internalappvm**.
1. Select **Connect** > **Bastion** > **Use Bastion**.

   :::image type="content" source="../media/4-connect-bastion.png" alt-text="Screenshot of the Connect page and Bastion tab, with the Use Bastion button.":::
1. Review and use the default values like the Azure Bastion resource name, subnet, and the option to create a new public IP address.

   :::image type="content" source="../media/4-operations-bastion.png" alt-text="Screenshot of the Connect using Azure Bastion page with fields filled out by default, like Azure Bastion resource name, subnet, and create new public IP address.":::
1. Select **Create**.

Wait a few minutes for the Azure Bastion resource to be created.
 
## Connect to the internal app VM

1. After the Azure Bastion resource is created, you're prompted to enter credentials to connect to the VM.
1. Enter the username **azureuser**.
1. Select **SSH Private Key from local file**. 
1. For **Local file**, select the **internalappvm_key.ppe** file that you downloaded when you created the VM.

   :::image type="content" source="../media/4-ready-to-connect.png" alt-text="Screenshot of the Azure Bastion connection page with the user name and local file fields populated.":::

1. Select **Connect**.
1. In the remote shell, enter Linux commands like the following command that updates the system.

   :::image type="content" source="../media/4-ubuntu-session.png" alt-text="Screenshot of a browser that shows an Ubuntu terminal session.":::

   ```bash
   sudo apt-get -y update
   ```

1. When you're finished, enter `exit`.

The next time you want to connect to the internal app VM, go to the virtual machine, select **Bastion**, and enter your credentials.