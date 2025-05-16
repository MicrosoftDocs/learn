Azure CycleCloud is a Linux-based web application, which you can install and use in any location with connectivity to Azure. The simplest, Microsoft-recommended way of setting it up is by deploying an Azure VM based on a preconfigured Azure Marketplace image.

Imagine you want to simplify the provisioning of a new HPC cluster into your company's Azure subscription by using Azure CycleCloud. You also want to ensure that the cluster you deploy in Azure closely matches the architecture and software stack of the existing on-premises cluster. To accomplish these objectives, you follow the Microsoft recommendation and use an Azure Marketplace-based image to deploy Azure CycleCloud on an Azure VM.

In this exercise, you implement Azure CycleCloud by following these tasks:

- Task 1: Deploy an Azure CycleCloud Azure VM
- Task 2: Connect to the Azure CycleCloud Azure VM
- Task 3: Add an Azure subscription to Azure CycleCloud

> [!NOTE]
> To perform this exercise, you need access to an Azure subscription. Deploying the resources referenced in this exercise will result in some costs being incurred by that subscription.

## Task 1: Create a Managed Identity 

Start by creating a Managed Identity.

1. Navigate to [the Azure portal](https://portal.azure.com/?azure-portal=true). When prompted, authenticate with a Microsoft account or a Microsoft Entra account that has the Contributor or Owner role in the Azure subscription that you're using in this module.

1. In the Azure portal search box, search for **Managed Identities**.
   
1. On the **Managed Identities** page, select **+ Create**.
   
1. On the **Basics** tab of the **Create User Assigned Managed Identity** pane, configure the following settings:

    | Setting | Value |
    | --- | --- |
    | Subscription | Select the name of the Azure subscription you're using in this module. |
    | Resource group | Select **Create new**. In the **Name** text box, enter **cyclecloud-rg**, and select **OK**. |
    | Region | Select the name of the Azure region in which you intend to deploy your clusters. |
    | Name | Enter **locker-mi** |

1. On the **Basics** tab of the **Create User Assigned Managed Identity** pane, select **Review + Create**, wait for the validation process to complete, and then select **Create**.

## Task 2: Create a Storage Account

Next, create a storage account and assign the **Storage Blob Data Reader** role to your managed identity.

1. In the web browser window displaying the Azure portal, use the search box to search for **Storage accounts**.

1. On the **Storage accounts** page, select **+ Create**.

1. On the **Basics** tab of the **Create storage account** pane, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Subscription | Select the name of the Azure subscription you're using in this module. |
    | Resource group | Select the **cyclecloud-rg** entry |
    | Storage account name | Enter any globally unique name between 3 and 24 characters in length, consisting of letters and digits, and starting with a letter. |
    | Location | Select the name of the Azure region in which you intend to deploy your clusters. |
    | Performance | Select the **Standard** option. |
    | Redundancy | Select the **Locally redundant storage (LRS)** entry. |

1. On the **Basics** tab of the **Create storage account** pane, select **Review + Create**, wait for the validation process to complete, and then select **Create**.

    > [!NOTE]
    > Wait for the storage account provisioning to complete. This should take about one minute.

1. Once the deployment has finished, select **Go to resource**.

1. On the pane displaying the Azure storage account, in the vertical menu on the left side, select **Access control (IAM)**.
   
1. In the **Access control (IAM)** section, select **+ Add**, and in the drop-down menu, select **Add role assignment**.
   
1. In the **Add role assignment** section, configure the following settings (leave others with their default values):
 
    | Setting | Value |
    | --- | --- |
    | Role | Select the **Storage Blob Data Reader** entry under **Job function roles**. |
    | Assign access to | Select **Managed Identity**. |
    | Select members | Select **User assigned managed identity** in the **Managed Identity** dropdown and **locker-mi** under **Select**. |
 
1. In the list of results, select the entry representing the **locker-mi** Managed Identity, and then select **Select**. Then, select **Review + assign** in the bottom left.


## Task 3: Deploy an Azure CycleCloud Azure VM

Next, deploy an Azure virtual machine that hosts the Azure CycleCloud application by using its Azure Marketplace image.

1. In the Azure portal search box, search for **Azure CycleCloud**.

1. In the list of results, select **Azure CycleCloud** under **Marketplace**.

1. On the **Azure CycleCloud** page, accept the default plan, and select **Create**.

    :::image type="content" source="../media/u4-cyclecloud-create-marketplace.png" alt-text="Screenshot showing the Create section of Azure CycleCloud in the Azure portal." border="false":::

1. On the **Basics** tab of the **Create a virtual machine** page, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Subscription | Select the name of the Azure subscription you're using in this module. |
    | Resource group | Select the **cyclecloud-rg** entry |
    | Virtual machine name | Enter **cyclecloud-vm**. |
    | Region | Select the name of any Azure region that's close to your location where you can provision Azure VMs. |
    | Availability options | **No infrastructure redundancy required** |
    | Security type | **Standard** |
    | Image | Accept the default image selection determined by the marketplace plan you chose in the previous step. |
    | Azure Spot instance | Leave the checkbox unselected. |
    | Size | Select **See all sizes**. On the **Select a VM size** pane, select the **Standard E4s v3** entry, and then enter **Select**. |

    > [!NOTE]
    > CycleCloud requires 8 GB of RAM and at least four vCPU cores.

    :::image type="content" source="../media/u4-cyclecloud-create-basics-1.png" alt-text="Screenshot showing the upper section of the Basics tab of Create a virtual machine section in the Azure portal." border="false":::

    | Setting | Value |
    | --- | --- |
    | Authentication type | Select the **SSH public key** option. |
    | Username | Enter **cc-admin**. |
    | SSH public key source | Ensure that the **Generate new key pair** option is selected, |
    | Key pair name | Enter **cc-ssh-keys**. |

    > [!NOTE]
    > Azure provides the ability to automatically generate an SSH key pair and allows you to store it for future use.

1. Select **Next: Disks >**. On the **Disks** tab of the **Create a virtual machine** pane, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | OS disk type | Ensure that the **Premium SSD** entry is selected. |
    | Host caching for data disk | Ensure that the **Read-only** entry is selected. |

1. Select **Next: Networking >**. On the **Networking** tab of the **Create a virtual machine** pane, directly below the **Virtual network** drop-down list, select **Create new**. In the **Create virtual network** section, by default, the address space is set to **/16**, with a single subnet of **/24** size.

1. In the **Create virtual network** section, select **Discard** to proceed with the default settings, without making any changes.

    > [!NOTE]
    > The default configuration aligns with the recommended approach that involves creating a designated subnet for the CycleCloud Azure VM.

1. On the **Networking** tab of the **Create a virtual machine** section, review the default settings without making any changes, and note that the VM image includes predefined Network Security Group rules.

1. Select **Next: Management >**, and on the **Management** tab of the **Create a virtual machine** section, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Enable basic plan for free | If present and enabled, clear the checkbox. |
    | Enable system assigned managed identity | Select the checkbox. |  

1. Select **Next: Monitoring >**. On the **Monitoring** tab of the **Create a virtual machine** section, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Boot diagnostics | Ensure that the **Enable with managed storage account (recommended)** option is selected. |

1. Select **Review + Create** and configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Preferred email address | Enter the email address associated with your user account. |
    | Preferred phone number | Enter the phone number associated with your user account. |

1. On the **Review + Create** tab of the **Create a virtual machine** section, select **Create**.

1. In the **Generate new key pair** pop-up window, select **Download private key and create resource**. This automatically downloads the **.pem** file containing the private key to your computer.

    > [!NOTE]
    > Wait for the installation to complete. This should take about one minute.

1. In the deployment section, select **Go to resource** to navigate to the **cyclecloud-vm** section.

## Task 4: Connect to the Azure CycleCloud Azure VM

After you deploy the Azure CycleCloud web application to an Azure VM, you can connect to it with the public IP address assigned to the network interface of that VM. After you connect, you'll be prompted to complete an initial setup of the web application. During that initial setup, you define the application authentication settings. We recommend that you use the same username and SSH key pair that you chose when deploying the underlying Azure VM. The SSH key pair you define here provides authentication to cluster nodes.

1. On your computer, in the web browser window displaying the **cyclecloud-vm** page in the Azure portal, in the **Essentials** section, note the value of the public IP address assigned to the network adapter of the **cyclecloud-vm** Azure VM. You need it later in this task.

1. In the **Essentials** section, select the link **cyclecloud-rg** to navigate to the **cyclecloud-rg** pane of the resource group hosting the CycleCloud Azure VM resources.

1. On the **cyclecloud-rg** resource group pane, in the list of resources, select the **cc-ssh-keys** entry.

1. On the **cc-ssh-keys** pane, note the value of the public key and record it. You need it later in this task.

1. On your computer, open another browser window and navigate to the `https://<IP_address>` URL, replacing the **<IP_address>** placeholder with the public IP address you identified in the previous step. If prompted, confirm that you want to connect to the target Azure VM.
    > [!NOTE]
    > Your browser will likely display the message about the connection not being private and warn you about connecting to that IP address. This is expected, because you're connecting to the target server by using a self-signed certificate and the URL you're connecting to doesn't match the subject name of the certificate.

1. On the **Welcome to Azure CycleCloud!** page of the setup wizard, in the **Site Name** text box, enter **contoso-lab**, and select **Next**.

1. On the **Azure CycleCloud License** page of the setup wizard, select the checkbox **I agree to the Azure CycleCloud Software License Agreement**, and then select **Next**.

1. On the last page of the Azure CycleCloud setup wizard, configure the following settings and select **Done**:

    | Setting | Value |
    | --- | --- |
    | User ID | Enter **cc-admin**. |
    | Name | Enter the name of your account associated with the target subscription. |
    | Password | Enter a complex password. |
    | Confirm | Reenter the same complex password. |
    | SSH Public Key | Paste the value of the public SSH key you previously recorded in this task. |

    > [!NOTE]
    > The user ID and the SSH public key don't have to be the same as those you specified when deploying the Azure VM, but we recommend that you use the same value for simplicity.

    > [!NOTE]
    > The **Add Subscription** pop-up window might appear at this point. If so, don't close this window or configure its settings at this stage. You configure these settings in the next exercise.

## Task 5: Add an Azure subscription to Azure CycleCloud

To manage resources in your Azure subscription, Azure CycleCloud requires a certain level of permissions. The simplest option is to assign the Contributor role and the Storage Blob Data Contributor role in the subscription to the system-assigned identity of the Azure VM hosting the CycleCloud application. (Alternatively, you can create a user-assigned identity, associate it with the VM, and use that identity in the steps below.)

> [!NOTE]
> CycleCloud doesn't require all permissions associated with the Contributor role. You have the option of defining a custom, more restrictive RBAC role and assigning it to the Azure VM hosting the CycleCloud application. This allows you to apply the principle of least privilege. For details, refer to [Using Managed Identities with CycleCloud](https://learn.microsoft.com/azure/cyclecloud/how-to/managed-identities?preserve-view=true&view=cyclecloud-8#create-a-custom-role-and-managed-identity-for-cyclecloud).

1. On your computer, switch to the web browser window displaying the Azure portal, and use the search box at the top of the portal interface to search for **Subscriptions**.

1. Select the Azure subscription you're using for exercises in this module.

1. On the pane displaying the Azure subscription, in the vertical menu on the left side, select **Access control (IAM)**.

1. In the **Access control (IAM)** section, select **+ Add**, and in the drop-down menu, select **Add role assignment**.

1. In the **Add role assignment** section, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Role | Select the **Contributor** entry under **Privileged administrator roles**. |
    | Assign access to | Select **Managed Identity**. |
    | Select members | Select **Virtual Machine** in the **Managed Identity** dropdown and **cyclecloud-vm** under **Select**. |

1. In the list of results, select the entry representing the **cyclecloud-vm** Azure VM, and then select **Save**.

1. Once back on the **Access control (IAM)** page, select **+ Add**, and in the drop-down menu, select **Add role assignment** to add another role.

1. In the **Add role assignment** section, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Role | Select the **Storage Blob Data Contributor** entry under **Job function roles**. |
    | Assign access to | Select **Managed Identity**. |
    | Select members | Select **Virtual Machine** in the **Managed Identity** dropdown and **cyclecloud-vm** under **Select**. |

1. In the list of results, select the entry representing the **cyclecloud-vm** Azure VM, and then select **Save**.

1. On your computer, switch to the web browser window displaying the Azure CycleCloud web application.

1. In the **Add Subscription** pop-up window, in the **Subscription Name** text box, enter a descriptive name for your Azure subscription. Next, select **Managed Identity** from the Authentication radio buttons, and then select **Validate Credentials**.

    > [!NOTE]
    > If the validation fails, you might have to wait a few minutes for the role assignments to take effect and then repeat this step.

1. In the **Add Subscription** pop-up window, in the **Default Location** drop-down list, select the name of the Azure region in which you created the storage account previously in this task.

1. In the **Add Subscription** pop-up window, in the **Locker Identity** drop-down list, select the name of the Managed Identity you created previously. In the **Storage account** drop-down list, select the name of the storage account you created previously as well.

    :::image type="content" source="../media/u4-cyclecloud-add-subscription-succeeded.png" alt-text="Screenshot showing the Add Subscription pop-up window in front of the Azure CycleCloud web application." border="false":::

1. In the **Add Subscription** pop-up window, select **Save**.

1. On the **Subscriptions** page of the Azure CycleCloud web application, select the entry representing the newly added subscription, and review its settings.

    :::image type="content" source="../media/u4-cyclecloud-subscription-created.png" alt-text="Screenshot showing the Subscriptions page of the Azure CycleCloud web application, with the entry representing the newly added subscription." border="false":::

    > [!NOTE]
    > Don't delete the resources you deployed in this exercise, since you need them in the next exercise of this module.

Congratulations! You successfully completed the first exercise of this module. In this exercise, you deployed an Azure CycleCloud Azure VM, connected to it, and used it to add an Azure subscription to Azure CycleCloud.
