Referring to our scenario, let's say that you've decided to work on an Ubuntu DSVM. To do so, you'll specify its configuration and create a resource in your resource group.

## Create a DSVM by using the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account that you activated the sandbox with.

1. Select the **Create a resource** option in the upper-left corner of the portal page. The Azure Marketplace pane opens.

    :::image type="content" source="../media/azure-portal-create-resource-page.png" alt-text="Screenshot that shows Azure Marketplace Get Started page.":::

    As you can see, there are many selectable options. We want to create a DSVM running on Ubuntu.

1. In the **Search the Marketplace** search bar, enter *Data Science*. Select the **Data Science Virtual Machine - Ubuntu 20.04** option. The **Data Science Virtual Machine - Ubuntu 20.04** pane appears.

    :::image type="content" source="../media/azure-portal-marketplace-ubuntu-data-science-virtual-machine.png" alt-text="Screenshot that shows the create resource page for a Data Science Virtual Machine - Ubuntu 20.04.":::

1. Select **Create**. The **Create a virtual machine** pane appears. Notice the wizard-based approach that we can use to configure the VM.

### Configure the VM

1. To configure the basic parameters of our Ubuntu virtual machine, in the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Project details**| |
    | Subscription | *Concierge Subscription* |
    | Resource group | Select <rgn>[sandbox resource group name]</rgn>. This group is the sandbox resource group. |
    | **Instance details**| |
    | Virtual machine name | Enter *test-ubuntu-dsvm* |
    | Region | Select a region near you. It should be the same as the resource group. |
    | Availability options | No infrastructure redundancy required |
    | Image | Data Science Virtual Machine - Ubuntu 20.04 - X64 Gen2 |
    | VM architecture | x64 |
    | Security type | Standard |
    | Size | Standard_DS1_v2. If that's not the selected value: <br> - Select **See all sizes** link. <br> - Enter **DS1\_** in the search box. <br> - Select the **DS1\_v2** row. <br> - Select that size and return to the configuration screen. |
    | **Administrator account**| |
    | Authentication type | Password |
    | Username | Enter a string from 1 to 64 characters long. |
    | Password | Enter a strong password. |

    :::image type="content" source="../media/azure-portal-create-virtual-machine-settings.png" alt-text="Screenshot that shows the details filled out for VM configuration.":::

1. You can explore several other tabs to see the settings that you can influence during the VM creation. On the **Disks** tab, for example, you can specify your data disks. After you finish exploring, select **Review + create** to review and validate the settings.

1. On the review screen, verify that all the settings are the way you want them. Select **Create**.

1. You can monitor the deployment through the **Notifications** panel. Select the icon on the top toolbar to show or hide the panel.

1. The VM deployment process takes a few minutes to finish. A notification will inform you that the deployment succeeded. Select **Go to resource** to go to the VM overview page.

1. You can see all the information and configuration options for your newly created DSVM. One of the pieces of information is the **Public IP address** value. Make note of this IP address, because you'll need it to connect.

    :::image type="content" source="../media/azure-portal-virtual-machine-overview-pane.png" alt-text="Screenshot that shows the VM overview page.":::

Congratulations! By performing a few steps, you deployed a DSVM running on Linux. Now let's connect to it.
