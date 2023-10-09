
Use this Try-This exercises to get some hands-on experience with Azure.

In this demonstration, we'll configure the Bastion service, virtual machine updates, virtual machine extensions, and disk encryption. Optionally, we'll use RDP to connect to a Windows virtual machine and SSH to connect to a Linux machine.

## Task 1 - Use the Bastion service

> [!NOTE]
> This task requires a virtual machine. If you are doing the next task, virtual machine updates, use a Windows virtual machine and keep the session running.

In this task, we'll configure the Bastion service and connect to a virtual machine with service.

### Configure the Bastion service

1.  In the **Portal** navigate to your Windows virtual machine.
2.  Ensure the virtual machine is **Running**.
3.  Click **Connect** and select **Bastion**.
4.  Click **Use Bastion**. Note installing the service is only required once.
5.  Because you are creating the Bastion service from the target virtual machine, mention that most of the networking information has automatically been filled in. Note the Bastion service will be assigned a public IP address.
6.  To create the Bastion subnet in the virtual network, click **Manage subnet configuration**.
7.  On the virtual network subnet blade, click **+ Subnet**.
8.  On the Add subnet page, type **AzureBastionSubnet** as the subnet name. Note this name can't be changed.
9.  Specify the address range in CIDR notation. For example, **10.1.1.0/27**.
10. Click **Ok**, then click **Create**. It will take a few minutes for the service to deploy.

### Connect to the virtual machine using Bastion

1.  From the target virtual machine’s **Overview** blade, select **Connect** and then **Bastion**
2.  On the **Connect to Bastion** page, enter the virtual machine login credentials.
3.  Notice the checkbox to open the session in a new window.
4.  Click **Connect**. If you receive a message that popup windows are blocked, allow the session.
5.  Once your session is connected, launch the Bastion clipboard access tool palette by selecting the two arrows. The arrows are located on the left center of the session. Explain this copy and paste feature.
6.  In the **Portal**, navigate to the Bastion host and under **Settings** select **Sessions**.
7.  Review the session management experience and the ability to delete a session.
8.  As you have time, review the Bastion components and how this provides a secure way to access your virtual machines.

## Task 2 - Virtual Machine Updates

> [!NOTE]
> This task requires a virtual machine in the **running** state. You may want to enable **Update management** prior to this lesson.

In this task, we'll review virtual machine update management.

1.  In the **Portal**, navigate to your virtual machine.
2.  Under **Operations** select **Update management**.
3.  Select the Azure Log Analytics workspace and Automation account, and then click **Enable**.
4.  Wait for update management to deploy. It can take up to 15 minutes for the deployment and longer for results to be provided.
5.  Select **Missing Updates** and use the **Information link** to open the support article for the update.
6.  Select **Schedule update deployment**.
7.  Review the various options including maintenance windows, reboot options, scheduling, classifications, kbs to include and exclude.
8.  You can view the status for the deployment on the **Update deployments** tab. The available values aren't attempted, succeeded, and failed.

## Task 3 - Virtual Machine Extensions

In this task, we'll install the IaaSAntimalware extension.

1.  In the **Portal**, select your virtual machine.
2.  Under **Settings**, click **Extensions**. Review how extensions are used.
3.  On the **Extensions** page, click **+ Add**.
4.  Scroll through the available extensions and review what extensions are available.
5.  Select **Microsoft Antimalware**. Discuss the features of this extension.
6.  Click **Create**.
7.  On the **Install extension** page use the informational icons to explain **Excluded files and locations**, **Excluded file extensions**, and **Excluded processes**.
8.  Review **Real-time protection** and **Run a scheduled scan**.
9.  Review other options of interest.
10. After the extension is deployed, the extensions page will show the **IaaSAntimalware** extension.

## Task 4 - Disk Encryption

> [!NOTE]
> This task requires a storage account.

In this task, we'll enable disk encryption for a storage account.

### Review encryption key options

1.  In the Portal, access your storage account.
2.  Under **Security + networking,** select **Encryption**.
3.  Review Storage Service Encryption and why it is used.
4.  Review the two types of keys: Microsoft Managed Keys and Customer Managed Keys.
5.  Select **Customer Managed Keys**.

### Create the customer managed key

1.  For **Encryption key** choose **Select from key vault**.
2.  Click **Select a key vault and key**.
3.  You will now create a new key vault. If you already had a key vault you could use that.
4.  For **Key vault** select **Create new**.
     -  Notice the key vault will be created in the same region as the storage account.
     -  Give your key vault a name.
     -  Click **Review + create**.
     -  Once the validation passes, click **Create**.
     -  Wait for the key vault to be created.
5.  You will now create a key in the key vault. If you already had a key you could use that.
6.  On the **Select key from Azure key vault page**, for **Key** select **Create new**.
     -  Review the options for creating a key.
     -  Give your key a name.
     -  Notice the activation and expiration options.
     -  Click **Create**.
7.  Now that you have created a key vault and key, **Select** the key vault and key.
8.  **Save** your changes on the **Encryption** page.
9.  Review the information that is now available: **Current key**, **Automated key rotation**, and **Key version in use**.

### Review the key options

1.  Return to the resource group that includes your storage account.
2.  **Refresh** the page and ensure your new key vault is listed as a resource.
3.  Select the key vault.
4.  Under **Settings** click **Keys**.
5.  Ensure your new key is **Enabled**. Notice the ability to regenerate the key.
6.  Select the key and review the current version information.
7.  Return to the key vault page.
8.  Under **Settings** select **Access policies**.
9.  Under **Current access policies** your storage account will be listed.
10. Notice the drop-downs for **Key Permissions**, **Secret Permissions**, and **Certificate Permissions**.
11. Select **Key Permissions** and notice the properties that are checked (Get, Unwrap key, and Wrap key).

## Task 5 - Use RDP to connect to a Windows VM (optional)

> [!NOTE]
> This task requires a Windows VM with a public IP address. You also need the login credentials for the machine.

In this task, we'll use RDP to connect to a Windows virtual machine.

1.  In the **Portal** navigate to your Windows virtual machine.
2.  Ensure the virtual machine is **Running**.
3.  From the **Overview** blade select **Connect** and then **RDP**.
4.  In the **Connect to virtual machine** page, keep the default options to connect by DNS name over port 3389 and click **Download RDP file**.
5.  Mention that if the VM has a just-in-time policy set, you first need to select the **Request access** button to request access before you can download the RDP file.
6.  Open the downloaded RDP file and then click **Connect**.
7.  In the **Windows Security** window, select **More choices** and then **Use a different account**.
8.  Type the username as localhost\\username, enter password you created for the virtual machine, and then select **OK**.
9.  You may receive a certificate warning during the sign-in process. Select **Yes** or **Continue** to create the connection.
10. Explain how RDP is different from the Bastion service.

## Task 6 - Use SSH to connect to a Linux VM (optional)

> [!NOTE]
> This task requires a Linux VM. Ensure port 22 is open.

In this task, we'll create an SSH private key with PuTTYgen, and then use SSH to connect to a Linux virtual machine.

### Create the SSH Keys

1.  Download the PuTTY tool. This will include PuTTYgen - [https://putty.org/](https://putty.org/).
2.  Once installed, locate and open the **PuTTYgen** program.
3.  In the **Parameters** option group choose **RSA**.
4.  Click the **Generate** button.
5.  Move your mouse around the blank area in the window to generate some randomness.
6.  Copy the text of the **Public key for pasting into authorized keys file**.
7.  Optionally you can specify a **Key passphrase** and then **Confirm passphrase.** You will be prompted for the passphrase when you authenticate to the VM with your private SSH key. Without a passphrase, if someone obtains your private key, they can sign in to any VM or service that uses that key. We recommend you create a passphrase. However, if you forget the passphrase, there is no way to recover it.
8.  Click **Save private key**.
9.  Choose a location and filename and click **Save**. You'll need this file to access the VM.

### Create the Linux machine and assign the public SSH key

1.  In the portal navigate to your Linux machine.
2.  Choose **SSH Public Key** for the **Authentication type** (instead of **Password** ).
3.  Provide a **Username**.
4.  Paste the public SSH key from PuTTY into the **SSH public key** text area. Ensure the key validates with a checkmark.
5.  Create the VM. Wait for it to deploy.
6.  Access the running VM.
7.  From the **Overview** blade, click **Connect**.
8.  Make a note of your login information including user and public IP address.

### Access the server using SSH

1.  Open the **PuTTY** tool.
2.  Enter **username@publicIpAddress** where username is the value you assigned when creating the VM and publicIpAddress is the value you obtained from the Azure portal.
3.  Specify **22** for the **Port**.
4.  Choose **SSH** in the **Connection Type** option group.
5.  Navigate to **SSH** in the Category panel, then click **Auth**.
6.  Click the **Browse** button next to **Private key file for authentication**.
7.  Navigate to the private key file saved when you generated the SSH keys and click **Open**.
8.  From the main PuTTY screen click **Open.**
9.  You will now be connected to your server command line.
10. Explain how SSH is different from the Bastion service.
