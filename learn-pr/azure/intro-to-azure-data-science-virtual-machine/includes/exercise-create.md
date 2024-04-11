Referring to our scenario, let's say that you decided to work on an Ubuntu Data Science Virtual Machine (DSVM). You first specify its configuration, and then create a resource in your resource group.

## Create a DSVM by using the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same account that you used to activate the sandbox.

1. Select the **Create a resource** option in the upper-left corner of the portal page. The Azure Marketplace pane opens.

    :::image type="content" source="../media/azure-portal-create-resource-page.png" alt-text="Screenshot that shows the Azure Marketplace Get Started page.":::

    We have many options available. We want to create a DSVM running on Ubuntu.

1. In the **Search services and marketplace** search bar, enter *Data Science*. Select the **Data Science Virtual Machine - Ubuntu 20.04** option. The **Data Science Virtual Machine - Ubuntu 20.04** pane appears.

    :::image type="content" source="../media/azure-portal-marketplace-ubuntu-data-science-virtual-machine.png" alt-text="Screenshot that shows the create resource page for a Data Science Virtual Machine - Ubuntu 20.04.":::

1. Select **Create**. The **Create a virtual machine** pane appears. We can use the wizard-based technique to configure the Virtual Machine (VM).

### Configure the VM

1. To configure the basic parameters of our Ubuntu virtual machine, enter these values for each setting in the **Basics** tab:

    | Setting | Value |
    | --- | --- |
    | **Project details**| |
    | Subscription | *Concierge Subscription* |
    | Resource group | Select <rgn>[sandbox resource group name]</rgn> as the sandbox resource group |
    | **Instance details**| |
    | Virtual machine name | Enter *test-ubuntu-dsvm* |
    | Region | Select a region near you. It should match the resource group. |
    | Availability options | No infrastructure redundancy required |
    | Image | Data Science Virtual Machine - Ubuntu 20.04 - X64 Gen2 |
    | VM architecture | x64 |
    | Security type | Standard |
    | Size | Standard_DS1_v2. If that's not the selected value: <br> - Select **See all sizes** link. <br> - Enter **DS1\_** in the search box. <br> - Select the **DS1\_v2** row. <br> - Select that size and return to the configuration screen. |
    | **Administrator account**| |
    | Authentication type | Password |
    | Username | Enter a string from 1 to 64 characters long |
    | Password | Enter a strong password |

    :::image type="content" source="../media/azure-portal-create-virtual-machine-settings.png" alt-text="Screenshot showing the details filled out for VM configuration.":::

1. You can explore the other tabs, to see the settings that you can configure during the VM creation. For example, you can specify your data disks on the **Disks** tab. After you finish your exploration, select **Review + create** to review and validate the settings.

1. On the review screen, verify that you configured all the settings the way you want. Select **Create**.

1. You can monitor the deployment through the **Notifications** panel. Select the icon on the top toolbar to show or hide the panel.

1. The VM deployment process takes a few minutes to finish. A notification informs you that the deployment succeeded. Select **Go to resource** to go to the VM overview page.

1. You can see all the information and configuration options for your newly created DSVM. The **Public IP address** value is an important part of this information. Make note of this IP address value, because you need it to connect.

    :::image type="content" source="../media/azure-portal-virtual-machine-overview-pane.png" alt-text="Screenshot that shows the VM overview page.":::

Congratulations! You deployed a DSVM running on Linux with a few steps. Now let's connect to it.