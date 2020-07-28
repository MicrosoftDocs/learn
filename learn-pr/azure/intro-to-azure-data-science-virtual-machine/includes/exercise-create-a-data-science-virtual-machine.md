Referring to our scenario, let's say that you've decided to work on an Ubuntu Data Science Virtual Machine. To do so, you'll specify its configuration and create a resource in your Resource Group.

## Create a Data Science VM with the Azure portal

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with

1. Click on the **Create a resource** option in the top-left corner of the portal page. The Azure Marketplace pane will open

    ![Screenshot that shows the Azure Marketplace with create a resource highlighted](../media/create-new-resource.png)

    As you can see, there are many selectable options. We want to create a Data Science Virtual Machine running on Ubuntu.

1. Use the **Search the Marketplace** search bar to find "Data Science". you'll see a list of options. Select the option that reads **Data Science Virtual Machine - Ubuntu 18.04** as shown below

    ![A screenshot showing Search the Marketplace with Data Science Virtual Machine Ubuntu Server 18.04 LTS highlighted.](../media/search-dsvm.png)

1. The pane that opens is the **Create a virtual machine** page. Notice the wizard-based approach we can use to configure the VM

### Configure the VM

We need to configure the basic parameters of our Ubuntu virtual machine. 

1. Use the following values on the **Basics** tab.
    - Set the **Subscription** to _Concierge Subscription_

    - Set the **Resource Group** to <rgn>[sandbox resource group name]</rgn> (this is the Sandbox resource group)

    - Enter the **Virtual machine name** as _test-ubuntu-dsvm_

    - The **Region** should be the same as that of the resource group 

    - For **Availability options**, choose _No infrastructure redundancy required_

    - The **Image** should be the _Data Science Virtual Machine - Ubuntu 18.04_ option you selected from the Marketplace

    - The **Size** of the VM should be _Standard\_DS1\_v2_. If that is not the value selected:
        1. Select **Choose size** 
        1. Enter `DS1\_` in the search box
        1. Choose the `DS1\_v2` row
        1. Click **Select** to choose that size and return to the configuration screen

    - Change the **Authentication Type** to _Password_
    - Choose and record a **Username** and strong **Password** 
    
    ![Screenshot showing the Create a VM screen with details filled out](../media/create-new-resource.png)

2. There are several other tabs you can explore to see the settings you can influence during the VM creation, particularly the **Disks** tab, where you can specify your data disk(s). Once you're finished exploring, click **Review + create** to review and validate the settings.

1. On the review screen, Azure will validate your settings. Verify all the settings are set the way you want, and then click **Create**.

1. You can monitor the deployment through the **Notifications** panel. Click the icon in the top toolbar to show or hide the panel.

1. The VM deployment process takes a few minutes to complete. You'll receive a notification informing you that the deployment succeeded. Click on the **Go to resource** button to go to the VM overview page.

1. Here you can see all the information and configuration options for your newly created Data Science Virtual Machine. One of the pieces of information is the **Public IP address**. Make note of this IP address, as you will need it to connect.

    ![Screenshot showing the VM overview page with the public IP address to the VM highlighted.](../media/dsvm-summary-started-in-portal.png)

Congratulations! With a few steps, you deployed a Data Science Virtual Machine running on Linux. Now let's connect to it. 
