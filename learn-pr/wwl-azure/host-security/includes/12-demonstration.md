Use these Try-This exercises to get some hands-on experience with Azure.

In this demonstration, we will configure the Bastion service, virtual machine updates, virtual machine extensions, and disk encryption. Optionally, we will use RDP to connect to a Windows virtual machine and SSH to connect to a Linux machine.

## Task 1 - Use the Bastion service

> [!NOTE]
> This task requires a virtual machine. If you are doing the next task, virtual machine updates, use a Windows virtual machine and keep the session running.

In this task, we will configure the Bastion service and connect to a virtual machine with service.

### Configure the Bastion service

1. In the **Portal** navigate to your Windows virtual machine.
1. Ensure the virtual machine is **Running**.
1. Click **Connect** and select **Bastion**.
1. Click **Use Bastion**. Note installing the service is only required once.
1. Because you are creating the Bastion service from the target virtual machine, mention that most of the networking information has automatically been filled in. Note the Bastion service will be assigned a public IP address.
1. To create the Bastion subnet in the virtual network, click **Manage subnet configuration**.
1. On the virtual network subnet blade, click **+ Subnet**.
1. On the Add subnet page, type **AzureBastionSubnet** as the subnet name. Note this name cannot be changed.
1. Specify the address range in CIDR notation. For example, **10.1.1.0/27**.
1. Click **Ok**, then click **Create**. It will take a few minutes for the service to deploy.

### Connect to the virtual machine using Bastion

1. From the target virtual machine’s **Overview** blade, select **Connect** and then **Bastion**
1. On the **Connect to Bastion** page, enter the virtual machine login credentials.
1. Notice the checkbox to open the session in a new window.
1. Click **Connect**. If you receive a message that popup windows are blocked, allow the session.
1. Once your session is connected, launch the Bastion clipboard access tool palette by selecting the two arrows. The arrows are located on the left center of the session. Explain this copy and paste feature.
1. In the **Portal**, navigate to the Bastion host and under **Settings** select **Sessions**.
1. Review the session management experience and the ability to delete a session.
1. As you have time, review the Bastion components and how this provides a secure way to access your virtual machines.

## Task 2 - Virtual Machine Updates

> [!NOTE]
> This task requires a virtual machine in the **running** state. You may want to enable **Update management** prior to this lesson.

In this task, we will review virtual machine update management.

1. In the **Portal**, navigate to your virtual machine.
1. Under **Operations** select **Update management**.
1. Select the Azure Log Analytics workspace and Automation account, and then click **Enable**.
1. Wait for update management to deploy. It can take up to 15 minutes for the deployment and longer for results to be provided.
1. Select **Missing Updates** and use the **Information link** to open the support article for the update.
1. Select **Schedule update deployment**.
1. Review the various options including maintenance windows, reboot options, scheduling, classifications, kbs to include and exclude.
1. You can view the status for the deployment on the **Update deployments** tab. The available values are not attempted, succeeded, and failed.

## Task 3 - Virtual Machine Extensions

In this task, we will install the IaaSAntimalware extension.

1. In the **Portal**, select your virtual machine.
1. Under **Settings**, click **Extensions**. Review how extensions are used.
1. On the **Extensions** page, click **+ Add**.
1. Scroll through the available extensions and review what extensions are available.
1. Select **Microsoft Antimalware**. Discuss the features of this extension.
1. Click **Create**.
1. On the **Install extension** page use the informational icons to explain **Excluded files and locations**, **Excluded file extensions**, and **Excluded processes**.
1. Review **Real-time protection** and **Run a scheduled scan**.
1. Review other options of interest.
1. After the extension is deployed, the extensions page will show the **IaaSAntimalware** extension.

## Task 4 - Disk Encryption

> [!NOTE]
> This task requires a storage account.

In this task, we will enable disk encryption for a storage account.

### Review encryption key options

1. In the Portal, access your storage account.
1. Under **Settings** select **Encryption**.
1. Review Storage Service Encryption and why it is used.
1. Review the two types of keys: Microsoft Managed Keys and Customer Managed Keys.
1. Select **Customer Managed Keys**.

### Create the customer managed key

1. For **Encryption key** choose **Select from key vault**.
1. Click **Select a key vault and key**.
1. You will now create a new key vault. If you already had a key vault you could use that.
1. For **Key vault** select **Create new**.
     -  Notice the key vault will be created in the same region as the storage account.
     -  Give your key vault a name.
     -  Click **Review + create**.
     -  Once the validation passes, click **Create**.
     -  Wait for the key vault to be created.
1. You will now create a key in the key vault. If you already had a key you could use that.
1. On the **Select key from Azure key vault page**, for **Key** select **Create new**.
     -  Review the options for creating a key.
     -  Give your key a name.
     -  Notice the activation and expiration options.
     -  Click **Create**.
1. Now that you have created a key vault and key, **Select** the key vault and key.
1. **Save** your changes on the **Encryption** page.
1. Review the information that is now available: **Current key**, **Automated key rotation**, and **Key version in use**.

### Review the key options

1. Return to the resource group that includes your storage account.
1. **Refresh** the page and ensure your new key vault is listed as a resource.
1. Select the key vault.
1. Under **Settings** click **Keys**.
1. Ensure your new key is **Enabled**. Notice the ability to regenerate the key.
1. Select the key and review the current version information.
1. Return to the key vault page.
1. Under **Settings** select **Access policies**.
1. Under **Current access policies** your storage account will be listed.
1. Notice the drop-downs for **Key Permissions**, **Secret Permissions**, and **Certificate Permissions**.
1. Select **Key Permissions** and notice the properties that are checked (Get, Unwrap key, and Wrap key).

## Task 5 - Use RDP to connect to a Windows VM (optional)

> [!NOTE]
> This task requires a Windows VM with a public IP address. You also need the login credentials for the machine.

In this task, we will use RDP to connect to a Windows virtual machine.

1. In the **Portal** navigate to your Windows virtual machine.
1. Ensure the virtual machine is **Running**.
1. From the **Overview** blade select **Connect** and then **RDP**.
1. In the **Connect to virtual machine** page, keep the default options to connect by DNS name over port 3389 and click **Download RDP file**.
1. Mention that if the VM has a just-in-time policy set, you first need to select the **Request access** button to request access before you can download the RDP file.
1. Open the downloaded RDP file and then click **Connect**.
1. In the **Windows Security** window, select **More choices** and then **Use a different account**.
1. Type the username as localhost\\username, enter password you created for the virtual machine, and then select **OK**.
1. You may receive a certificate warning during the sign-in process. Select **Yes** or **Continue** to create the connection.
1. Explain how RDP is different from the Bastion service.

## Task 6 - Use SSH to connect to a Linux VM (optional)

> [!NOTE]
> This task requires a Linux VM. Ensure port 22 is open.

In this task, we will create a SSH private key with PuTTYgen, and then use SSH to connect to a Linux virtual machine.

### Create the SSH Keys

1. Download the PuTTY tool. This will include PuTTYgen - [https://putty.org/](https://putty.org/).
1. Once installed, locate and open the **PuTTYgen** program.
1. In the **Parameters** option group choose **RSA**.
1. Click the **Generate** button.
1. Move your mouse around the blank area in the window to generate some randomness.
1. Copy the text of the **Public key for pasting into authorized keys file**.
1. Optionally you can specify a **Key passphrase** and then **Confirm passphrase.** You will be prompted for the passphrase when you authenticate to the VM with your private SSH key. Without a passphrase, if someone obtains your private key, they can sign in to any VM or service that uses that key. We recommend you create a passphrase. However, if you forget the passphrase, there is no way to recover it.
1. Click **Save private key**.
1. Choose a location and filename and click **Save**. You will need this file to access the VM.

### Create the Linux machine and assign the public SSH key

1. In the portal navigate to your Linux machine.
1. Choose **SSH Public Key** for the **Authentication type** (instead of **Password** ).
1. Provide a **Username**.
1. Paste the public SSH key from PuTTY into the **SSH public key** text area. Ensure the key validates with a checkmark.
1. Create the VM. Wait for it to deploy.
1. Access the running VM.
1. From the **Overview** blade, click **Connect**.
1. Make a note of your login information including user and public IP address.

### Access the server using SSH

1. Open the **PuTTY** tool.
1. Enter **username@publicIpAddress** where username is the value you assigned when creating the VM and publicIpAddress is the value you obtained from the Azure portal.
1. Specify **22** for the **Port**.
1. Choose **SSH** in the **Connection Type** option group.
1. Navigate to **SSH** in the Category panel, then click **Auth**.
1. Click the **Browse** button next to **Private key file for authentication**.
1. Navigate to the private key file saved when you generated the SSH keys and click **Open**.
1. From the main PuTTY screen click **Open.**
1. You will now be connected to your server command line.
1. Explain how SSH is different from the Bastion service.
