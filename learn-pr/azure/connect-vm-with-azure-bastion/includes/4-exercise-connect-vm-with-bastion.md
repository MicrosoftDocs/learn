In this unit, you'll create a virtual machine (VM) to act as your internal app VM and deploy Azure Bastion to connect to it.
   
## Set up your environment

Create a Linux VM that's not exposed to the internet.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. Search for or select **Virtual machines**.
1. Select **Add** > **Virtual machine**.
1. Enter the following values to the **Basics** page.

   |Field |Value  |
   |---------|---------|
   |Subscription     |    Concierge Subscription     |
   |Resource group    |  <rgn>[Sandbox resource group name]</rgn>      |
   |Virtual machine name  |   internalappvm       |
   |Region    | Choose a region near you.         |
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
   :::image type="content" source="../media/4-download-private-key.png" alt-text="Screenshot of the generate new key pair windows with the ":::

## Try to connect to the internal app VM

<!--This section isn't right/doesn't work. Can't connect using cloud shell. They'd have to use local app.-->
Let's try connecting to the internal app VM over the internet.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), go to **Virtual machines**.
1. Select the VM you created, **internalappvm**.
1. Select **Connect** > **SSH**.
1. Under step 4, copy the command to the clipboard.
1. Open Azure Cloud Shell and select **Bash**. 
1. Paste the command from your clipboard into the Azure Cloud Shell. Edit the private key path placeholder so that it points to the private key file you downloaded. <!-- This doesn't work. I think you'd have to run bash or some tool locally and connect to Azure that way to be able to see local file.-->It should look something like the following example with a different IP address:

    ```bash
    ssh azureuser@10.0.0.6
    ```

1. You should get a message that looks like the following message:

    ```bash
    ssh: connect to host 10.0.0.6 port 22: Connection timed out
    ```

Because you created the internal app VM without a public IP, you can't connect to it over the internet. Instead of using a jumpbox VM to connect to the internal app VM, let's use Azure Bastion. 

## Create subnet for Azure Bastion

Before you can use Azure Bastion, you need to create a subnet on the virtual network used by the internal app VM.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select or search for **Resource groups**.
1. Select resource group <rgn>[sandbox resource group name]</rgn>.
1. From the list of resources, select the virtual network.
1. Under **Settings**, select **Address space**.
1. Enter an address space with a subnet mask that's /27 or larger, like /26, /25, and so on, such as  10.0.1.0/24.
1. Select **Save**.
1. Under **Settings**, select **Subnets**.
1. Select **+ Subnet** to add a subnet.
1. Enter the following information to create a subnet.

   |Field  |Name |
   |---------|---------|
   |Name    |  AzureBastionSubnet       |
   |Subnet address range     | The address space you just added  like 10.0.1.0/24  |

1. Select **OK**.

## Deploy Bastion 

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select or search for **Virtual machines**.
1. Select virtual machine **internalappvm**.
1. Select **Connect** > **Bastion** > **Use Bastion**.

   :::image type="content" source="../media/4-connect-bastion.png" alt-text="Screenshot of the Connect > Bastion page that shows the Use Bastion button.":::
1. Review and use the defaults values like the Bastion resource name, subnet, and to create a new public IP address.

   :::image type="content" source="../media/4-operations-bastion.png" alt-text="Screenshot of the Connect using Azure Bastion page with fields filled out by default like Bastion resource name, subnet, and create new public IP address.":::
1. Select **Create**.

Wait a few minutes for the Bastion resource to be created.
 
## Connect to the internal app VM

1. After the Bastion resource is created, you're prompted to enter credentials to connect to the VM.

   :::image type="content" source="../media/4-ready-to-connect.png" alt-text="Screenshot":::
1. Enter the username **azureuser**.
1. Select **SSH Private Key from local file**. 
1. For **Local file**, select the **internalappvm_key.ppe** file you downloaded when you created the VM.
1. Select **Connect**.
1. In the remote shell, enter Linux commands like the following command that updates the system.

   :::image type="content" source="../media/4-ubuntu-session.png" alt-text="Screenshot of a browser that shows an Ubuntu terminal session.":::

   ```bash
   sudo apt-get -y update
   ```

1. When you're finished, type `exit`.

Next time you want to connect to the internal app VM, go to the virtual machine, select **Bastion**, and enter your credentials.