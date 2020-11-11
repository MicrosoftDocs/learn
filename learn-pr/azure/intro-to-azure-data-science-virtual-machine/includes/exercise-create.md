Referring to our scenario, let's say that you've decided to work on an Ubuntu Data Science Virtual Machine. To do so, you'll specify its configuration and create a resource in your resource group.

## Create a Data Science Virtual Machine by using the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) by using the same account that you activated the sandbox with.

1. Select the **Create a resource** option in the upper-left corner of the portal page. The Azure Marketplace pane opens.

    ![Screenshot that shows Azure Marketplace with the option for creating a resource highlighted.](../media/create-new-resource.png)

    As you can see, there are many selectable options. We want to create a Data Science Virtual Machine running on Ubuntu.

1. Use the **Search the Marketplace** search bar to find "Data Science." In the list, select the **Data Science Virtual Machine - Ubuntu 18.04** option.

    ![Screenshot that shows a search box with Data Science Virtual Machine Ubuntu Server 18.04 highlighted.](../media/search-dsvm.png)

1. The pane that opens is the **Create a virtual machine** page. Notice the wizard-based approach that we can use to configure the VM.

### Configure the VM

We need to configure the basic parameters of our Ubuntu virtual machine. 

1. Use the following values on the **Basics** tab:
    - Set **Subscription** to **Concierge Subscription**.

    - Set **Resource Group** to <rgn>[sandbox resource group name]</rgn>. (This is the sandbox resource group.)

    - Enter **Virtual machine name** as **test-ubuntu-dsvm**.

    - The **Region** value should be the same as that of the resource group. 

    - For **Availability options**, choose **No infrastructure redundancy required**.

    - The **Image** value should be the **Data Science Virtual Machine - Ubuntu 18.04** option that you selected from Azure Marketplace.

    - The **Size** value of the VM should be **Standard_DS1_v2**. If that's not the selected value:
        1. Select **Choose size**.
        1. Enter **DS1\_** in the search box.
        1. Choose the **DS1\_v2** row.
        1. Click **Select** to choose that size and return to the configuration screen.

    - Change **Authentication Type** to **Password**.
    - Choose and record a username for **Username** and a strong password for **Password**.  
    
    ![Screenshot that shows the details filled out for V M configuration.](../media/create-new-resource.png)

2. You can explore several other tabs to see the settings that you can influence during the VM creation. On the **Disks** tab, for example, you can specify your data disks. After you're finished exploring, select **Review + create** to review and validate the settings.

1. On the review screen, verify that all the settings are the way you want them. Then select **Create**.

1. You can monitor the deployment through the **Notifications** panel. Select the icon on the top toolbar to show or hide the panel.

1. The VM deployment process takes a few minutes to finish. A notification will inform you that the deployment succeeded. Select the **Go to resource** button to go to the VM overview page.

1. You can see all the information and configuration options for your newly created Data Science Virtual Machine. One of the pieces of information is the **Public IP address** value. Make note of this IP address, because you'll need it to connect.

    ![Screenshot that shows the VM overview page with the public I P address to the V M highlighted.](../media/dsvm-summary-started-in-portal.png)

Congratulations! With a few steps, you deployed a Data Science Virtual Machine running on Linux. Now let's connect to it. 
