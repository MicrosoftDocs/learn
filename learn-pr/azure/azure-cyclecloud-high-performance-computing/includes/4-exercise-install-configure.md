Azure CycleCloud is a Linux-based web application, which you can install and use in any location with connectivity to Azure. The simplest, Microsoft-recommended way of setting it up is by deploying an Azure VM based on a preconfigured Azure Marketplace image. 

Imagine you want to simplify provisioning a new HPC cluster into your company's Azure subscription by leveraging Azure CycleCloud. You'll also want to ensure that the cluster you deploy in Azure will match, as closely as possible, the architecture and software stack of the existing on-premises cluster. To accomplish these objectives, you will follow the Microsoft recommendation and use an Azure Marketplace-based image to deploy Azure CycleCloud on an Azure VM.

<!-- SME or CE: To remove references to Contoso, I changed the above paragraph. Feel free to delete this comment as I feel comfortable with my changes. It used to be: "Recall that you wanted to simplify provisioning a new HPC cluster into the Contoso's Azure subscription by leveraging Azure CycleCloud. You also want to ensure that the cluster you deploy in Azure will match, as closely as possible, the architecture and software stack of the existing on-premises cluster. To accomplish these objectives, you will follow the Microsoft recommendation and use an Azure Marketplace-based image to deploy Azure CycleCloud on an Azure VM."-->

## Deploy an Azure CycleCloud Azure VM

You'll start by deploying an Azure VM hosting the Azure CycleCloud application by using its Azure Marketplace image. 

1. From your computer, start any Azure portal-compatible web browser, navigate to [the Azure portal](https://portal.azure.com) and, when prompted, authenticate with a Microsoft account or an Azure Active Directory (Azure AD) account that has the Contributor or Owner role in the Azure subscription you are using in this module.

    > [!NOTE]
    > The Azure portal is available from the latest versions of Microsoft Edge, Google Chrome, Mozilla Firefox, and Apple Safari. 

1. In the Azure portal, use the **Search resources, services, and docs** text box at the top of the portal interface to search for **Azure CycleCloud**. 
1. In the list of results, in the **Marketplace** section, select the **Azure CycleCloud** entry.
1. On the **Azure CycleCloud** blade, accept the default plan and select **Create**.

    :::image type="content" source="../media/u4-cyclecloud-create-marketplace.png" alt-text="The screenshot depicts the Create blade of Azure CycleCloud create blade in the Azure portal." border="false":::

1. On the **Basics** tab of the **Create a virtual machine** blade, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Subscription | select the name of the Azure subscription you are using in this module |
    | Resource group | select **Create new**, in the **Name** text box, type **cyclecloud-rg**, and select **OK** |
    | Virtual machine name | type **cyclecloud-vm** |
    | Region | select the name of any Azure regions where you can provision Azure VMs and which is close to your location |
    | Availability options | **no infrastructure redundancy required** |
    | Image | accept the default selection matching the marketplace image you chose in the previous step |
    | Azure Spot instance | leave the checkbox unselected |
    | Size | select **See all sizes**, on the **Select a VM size** blade, select the **Standard E4s v3** entry, and click **Select** |

    > [!NOTE]
    > CycleCloud requires 8 GB of RAM and at least four vCPU cores.

    :::image type="content" source="../media/u4-cyclecloud-create-basics1.png" alt-text="The screenshot depicts the upper section of the Basics tab of Create a virtual machine blade in the Azure portal." border="false":::

    | Setting | Value |
    | --- | --- |
    | Authentication type | select the **SSH public key** option |
    | Username | type **cc-admin** |
    | SSH public key source | ensure that the **Generate new key pair** option is selected |
    | Key pair name | type **cc-ssh-keys** |

    :::image type="content" source="../media/u4-cyclecloud-create-basics2.png" alt-text="The screenshot depicts the lower section of the Basics tab of Create a virtual machine blade in the Azure portal." border="false":::

    > [!NOTE]
    > Azure provides the ability to automatically generate an SSH key pair and allows you to store it for future use. 

1. Select **Next: Disks >** and, on the **Disks** tab of the **Create a virtual machine** blade, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | OS disk type | ensure that the **Premium SSD** entry is selected |
    | Host caching for data disk | ensure that the **Read-only** entry is selected |

1. Select **Next: Networking >**, on the **Networking** tab of the **Create a virtual machine** blade, directly below the **Virtual network** drop-down list, select **Create new**, on the **Create virtual network** blade, note that, by default, the address space is set to **/16**, with a single subnet of **/24** size. 
1. On the **Create virtual network** blade, select **Discard** to proceed with the default settings, without making any changes.

    > [!NOTE]
    > The default configuration aligns with the recommended approach that involves creating a designated subnet for the CycleCloud Azure VM. 

1. Back on the **Networking** tab of the **Create a virtual machine** blade, review the default settings without making any changes, and note that the VM image includes predefined Network Security Group rules.
1. Select **Next: Management >** and, on the **Management** tab of the **Create a virtual machine** blade, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Enable basic plan for free | if enabled, clear the checkbox |
    | Boot diagnostics | ensure that the **Enable with managed storage account (recommended)** option is selected |
    | System assigned managed identity | select the checkbox |  

1. Select **Review + Create** configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Preferred e-mail address | type the email address associated with your user account |
    | Preferred phone number | type the phone number associated with your user account |

1. On the **Review + Create** tab of the **Create a virtual machine** blade, select **Create**.
1. In the **Generate new key pair** pop-up window, select **Download private key and create resource**. This will automatically download the **.pem** file containing the private key to your computer. 

    > [!NOTE]
    > Wait for the installation to complete. This should take about 1 minute.

1. On the deployment blade, select **Go to resource** to navigate to the **cyclecloud-vm** blade.

## Connect to the Azure CycleCloud Azure VM

After you deployed the Azure CycleCloud web application to an Azure VM, you can connect to it via the public IP address assigned to the network interface of that VM. Once connected, you will be prompted to complete an initial setup of the web application. During that initial setup, you will define the application authentication settings. We recommend that you use the same username and SSH key pair which you chose when deploying the underlying Azure VM. However, note that the SSH key pair you define here provides authentication to cluster nodes.

1. On your computer, in the web browser window displaying the **cyclecloud-vm** blade in the Azure portal, in the **Essentials** section, take a note of the value of the public IP address assigned to the network adapter of the **cyclecloud-vm** Azure VM. You will need it later in this task.
1. In the **Essentials** section, select the link **cyclecloud-rg** to navigate to the **cyclecloud-rg** blade of the resource group hosting the CycleCloud Azure VM resources.
1. On the **cyclecloud-rg** resource group blade, in the list of resources, select the **cc-ssh-keys** entry. 
1. On the **cc-ssh-keys** blade, note the value of the public key and record it. You will need it later in this task.

    :::image type="content" source="../media/u4-cyclecloud-public-key.png" alt-text="The screenshot depicts the Essentials section of the cc-ssh-keys blade, including the Public key entry in the Azure portal." border="false":::

1. On your computer, open another browser window and navigate to the **https://<IP_address>** URL, replacing the **<IP_address>** placeholder with the public IP address you identified in the previous step. If prompted, confirm that you want to connect to the target Azure VM.

    > [!NOTE]
    > Your browser will likely display the message about the connection not being private and warn you about connecting to that IP address. This is expected, since you are connecting to the target server by using a self-signed certificate and the URL you are connecting to does not match the subject name of the certificate.

1. On the **Welcome to Azure CycleCloud!** page of the setup wizard, in the **Site Name** text box, type **contoso-lab** and select **Next**.
1. On the **Azure CycleCloud License** page of the setup wizard, select the checkbox **I agree to the Azure CycleCloud Software License Agreement** and select **Next**.
1. On the last page of the Azure CycleCloud setup wizard, configure the following settings and select **Done**:

    | Setting | Value |
    | --- | --- |
    | User ID | type **cc-admin** |
    | Name | type the name of your account associated with the target subscription | 
    | Password | type **Pa55w.rd1234** |
    | Confirm | type **Pa55w.rd1234** |
    | SSH Public Key | paste the value of the public SSH key you recorded earlier in this task |

    > [!NOTE]
    > The user ID and the SSH public key do not have to be the same as those you specified when deploying the Azure VM, but we recommend that you use the same value for the simplicity sake.

## Add an Azure subscription to Azure CycleCloud

In order to manage resources in your Azure subscription, Azure CycleCloud requires a certain level of permissions. The simplest option to address this requirement is to assign the Contributor Role in the subscription to the Azure VM hosting the CycleCloud application, as long as you enabled the system-assigned managed identity for that Azure VM. Since you configured this setting during the Azure VM deployment in the first task of this exercise, this is the approach you will take. 

> [!NOTE]
> CycleCloud does not require all permissions associated with the Contributor role. You have the option of defining a custom, more restrictive Role Based Access Control role and assigning it to the Azure VM hosting the CycleCloud application. This allows you to apply the principle of least privilege. For details, refer to Microsoft Docs.

1. On your computer, switch to the web browser window displaying the Azure portal, and use the **Search resources, services, and docs** text box at the top of the portal interface to search for **Subscriptions**.
1. On the **Subscriptions** blade, select the entry representing the Azure subscription you are using for exercises in this module.
1. On the blade displaying the Azure subscription, in the vertical menu on the left side, select **Access control (IAM)**.
1. On the **Access control (IAM)** blade, select **+ Add** and, in the drop-down menu, select **Add role assignment**.
1. On the  **Add role assignment** blade, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Role | select the **Contributor** entry |
    | Assign access to | select the **Virtual Machine** entry |
    | Select | type **cyclecloud-vm** |

1. In the list of results, select the entry representing the **cyclecloud-vm** Azure VM and select **Save**.
1. In the web browser window displaying the Azure portal, and use the **Search resources, services, and docs** text box at the top of the portal interface to search for **Storage accounts**.
1. On the **Storage accounts** blade, select **+ New**.
1. On the **Basics** tab of the **Create storage account** blade, configure the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Subscription | select the name of the Azure subscription you are using in this module |
    | Resource group | select the **cyclecloud-rg** entry |
    | Storage account name | type any globally unique name between 3 and 24 in length consisting of letters and digits, starting with a letter |
    | Location | select the name of the Azure region in which you intend to deploy your clusters |
    | Performance | select the **Standard** option |
    | Redundancy | select the **Locally redundant storage (LRS)** entry |

1. On the **Basics** tab of the **Create storage account** blade, select **Review + Create**, wait for the validation process to complete, and select **Create**.

    > [!NOTE]
    > Wait for the storage account provisioning to complete. This should take about 1 minute.

1. On your computer, switch to the web browser window displaying the Azure CycleCloud web application. 
1. In the **Add Subscription** pop-up window, in the **Subscription Name** text box, type a descriptive name of your Azure subscription and select **Validate Credentials**.

    > [!NOTE]
    > In case the validation fails, you might have to wait a few minutes for the role assignments to take effect and then repeat this step.

1. In the **Add Subscription** pop-up window, in the **Default Location** drop-down list, select the name of the Azure region in which you created the storage account earlier in this task.
1. In the **Add Subscription** pop-up window, in the **Storage account** drop-down list, select the name of the storage account you created earlier in this task.

    :::image type="content" source="../media/u4-cyclecloud-add-subscription-succeeded.png" alt-text="The screenshot depicts the Add Subscription pop-up window in front of the Azure CycleCloud web application." border="false":::

1. In the **Add Subscription** pop-up window, select **Save**.
1. On the **Subscriptions** page of the Azure CycleCloud web application, select the entry representing the newly added subscription and review its settings.

    :::image type="content" source="../media/u4-cyclecloud-subscription-created.png" alt-text="The screenshot depicts the Subscriptions page of the Azure CycleCloud web application, with the entry representing the newly added subscription." border="false":::

Congratulations! You successfully completed the first exercise of this module. In this exercise, you deployed an Azure CycleCloud Azure VM, connect to it, and used it to add an Azure subscription to Azure CycleCloud.
