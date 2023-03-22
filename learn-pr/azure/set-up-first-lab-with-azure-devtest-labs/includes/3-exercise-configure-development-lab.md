A lab in Azure DevTest Labs represents a collection of settings to quickly and repeatably create virtualized computing environments.

For your eCommerce company, you decide to create a lab for the development team. Developers need a Windows- or Linux-based virtual machine. Your organization standardizes on the most recent versions of Ubuntu Server and Windows Server. To reduce cost, all VMs should be shut down daily at 7pm.

In this exercise, you'll use the Azure portal to create an Azure DevTest Labs resource with settings to accommodate the needs from the development team and IT organization.

During the process, you'll:

- Create an Azure DevTest Labs resource with an auto shutdown schedule and no public environments.
- Configure the lab to only include supported VM marketplace images.

## Create a DevTest Labs resource

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. Enter **DevTest Labs** in the search text box at the top of the page, and then select **DevTest Labs** from the list of services.

1. On the **DevTest Labs** page, select **+ Create**.

1. On the **Create DevTest Labs** page, under the **Basic Settings** tab, provide the following information:

    |Setting  |Value |Description  |
    |---------|---------|---------|
    |Subscription     | Concierge subscription | The lab must belong to a resource group. Here you select the Azure subscription to which the resource group belongs. |
    |Resource group     | Select <rgn>[Sandbox resource group]</rgn> | The resource group to which the lab will belong. All Azure resources must belong to a resource group. |
    |Lab name     | *Enter a unique name*| Enter the name of your lab. The name must be unique within the subscription. |
    |Location     | Accept default value | The geographical region where the lab will be hosted. |
    |Public environments     | Off | A public environment repository contains a list of curated Azure Resource Manager templates. The development team uses a virtual machine. |

    Because the development team only uses VMs and no ARM-based resources for their development activities, you'll disable **public environments**.

    :::image type="content" source="../media/portal-create-basic-settings.png" alt-text="Screenshot that shows the basic settings tab when creating an Azure DevTest Labs resource.":::

1. On the **Auto-shutdown** tab, provide the following information:

    |Setting  |Value |Description  |
    |---------|---------|---------|
    |Enabled     | On | Shut down all lab VMs at a specific time during the day or night. |
    |Scheduled shutdown     | 7:00:00 PM | The time of day at which all lab VMs are shut down. You can change this setting at any time.  |
    |Time zone     | *Select your time zone*| Select a suitable time zone. |
    |Send notification before auto-shutdown     | No | When the VMs are shut down, Azure DevTest Labs can send a notification by email or invoke a web hook.  |

    :::image type="content" source="../media/portal-create-auto-shutdown.png" alt-text="Screenshot that shows the auto shutdown tab when creating an Azure DevTest Labs resource.":::

1. Select **Review + Create** to go to the review pane, and then select **Create**. The portal shows the deployment pane, where you can view the status of your deployment.

## Verify the resource creation

1. In the Azure portal, enter **DevTest Labs** in the search text box, and then select **DevTest Labs** from the list of services.

    :::image type="content" source="../media/search-devtest-labs.png" alt-text="Screenshot that shows the search box in the Azure portal to search Azure DevTest Labs resources.":::

1. In the list of labs, you should see your Azure DevTest Labs resource.

    :::image type="content" source="../media/devtest-labs-list.png" alt-text="Screenshot that shows the list of Azure DevTest Labs resources.":::

## Specify allowed images for creating VMs

1. On the home page of your Azure DevTest Labs resource, select **Configuration and policies**.

    :::image type="content" source="../media/configuration-policies-menu.png" alt-text="Screenshot that shows the configuration & policies menu for Azure DevTest Labs.":::

1. On the **Configuration and policies** pane, under **Virtual machine bases**, select **Marketplace images**.

    :::image type="content" source="../media/marketplace-images-menu.png" alt-text="Screenshot that shows the marketplace images settings menu for Azure DevTest Labs.":::

1. Select **No** for **Allow all Azure Marketplace images as virtual machine base images**.

    :::image type="content" source="../media/marketplace-images-allow-all.png" alt-text="Screenshot that shows the DevTest Labs settings for allowing all marketplace images.":::

1. Select the most recent versions of **Ubuntu Server** and **Windows Server** from the list, and then select **Save**.

    You should see the VM base images you selected at the top of the list:

    :::image type="content" source="../media/portal-select-marketplace-images.png" alt-text="Screenshot that shows how to select Azure Marketplace images for a lab." lightbox="../media/portal-select-marketplace-images.png":::

You've now created an Azure DevTest Labs resource and configured it to match the needs of the developers and the IT organization. With this lab, users can create lab VMs using a list of allowed base images. To save costs, the VMs will automatically shut down at a specific time of the day.
