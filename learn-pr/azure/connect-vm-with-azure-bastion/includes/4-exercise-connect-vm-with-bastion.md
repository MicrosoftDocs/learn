In this unit, you'll create a virtual machine (VM) to act as your internal app VM and deploy Azure Bastion to connect to it.
   
## Set up your environment

Create a Linux VM that's not exposed to the internet.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. Select **Cloud Shell** from the menu bar in the upper right.
1. Select **Bash**.
1. Run the following command to generate an SSH key pair:

   ```bash
   ssh-keygen -t rsa -b 4096
   ```

2. Select the *Enter* key to accept the default location to store the key pair.

3. Enter an SSH passphrase that you'll remember. You'll need this passphrase later when you connect to the VM.
1. Run the following commands to set the username and resource group values.

    ```bash
    USERNAME=azureuser
    RESOURCEGROUP= <rgn>[Sandbox resource group name]</rgn>
    ```

1. Run the following command to create a virtual machine (VM) with no public IP address.

    ```azurecli
    az vm create \
      --resource-group $RESOURCEGROUP \
      --name internalappvm \
      --admin-username $USERNAME \
      --image UbuntuLTS \
      --public-ip-address "" \
      --generate-ssh-keys \
      --verbose
    ```

1. Run the following command to get the SSH key.

    ```bash
    cat ~/.ssh/id_rsa.pub
    ```

1. Copy and save SSH key to use later.

## Try to connect to the internal app VM

Let's try connecting to the internal app VM over the internet.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), go to **Virtual machines**.
1. Select the VM you created, **internalappvm**.
1. Select **Connect** > **SSH**.
1. Under step 4, copy the command to the clipboard.
1. Paste the command from your clipboard into the Azure Cloud Shell. Delete the -i flag and the private key path placeholder. It should look something like the following example with a different IP address:

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
1. Under **Settings**, select **Subnets**.
1. Select **+ Subnet** to add a subnet.
<!--Do you have to add address space?! What am I doing wrong here?-->
1. Enter the following information to create a subnet.

   |Field  |Name |
   |---------|---------|
   |Name    |  AzureBastionSubnet       |
   |Address range     | Use a subnet mask that's /27 or larger like /26, /25 and so on like  10.0.1.0/24.   |

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
1. Select **SSH Private Key**. 
1. Paste in the SSH private key you copied. 
1. Add `-----BEGIN RSA PRIVATE KEY-----` and `-----END RSA PRIVATE KEY-----` around the SSH key.
1. Expand the **Advanced** section.
1. Enter the **SSH Passphrase** you used when you created the SSH key.
1. Select **Connect**.
1. In the remote shell, enter Linux commands like `ps` or `ls`.
1. When you are finished, type `exit`.

Next time you want to connect to the internal app VM, go to the virtual machine, and select **Connect** > **Bastion** > **Use Bastion**.