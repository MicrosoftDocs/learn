Suppose you run a photo-sharing site with data stored on Azure virtual machines (VMs) running SQL Server and custom applications. You want to make the following adjustments:

- You need to change the disk cache settings on a VM.
- You want to add a new data disk to the VM with caching enabled.

You've decided to make these changes through the Azure portal.

In this exercise, we'll walk through making the changes to a VM just described. First, let's sign in to the portal and create a VM.

## Create a virtual machine

In this step, we're going to create a VM.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

1. _Windows Server 2016 VM_ should be in the list of **Popular** Marketplace elements. If not, search for *Windows Server 2016 DataCenter* using the search box on the top.

1. Select the Windows VM, and then select **Create** to start the VM creation process. The **Create a virtual machine** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting  | Value  |
    |----------|--------|
    | **Project details** |
    | Subscription | Concierge Subscription |
    | Resource group | **<rgn>[sandbox resource group name]</rgn>** |
    | **Instance details** |
    | Virtual machine name | **fotoshareVM** |
    | Region | See the following list |
    | Image | **Windows Server 2016 Datacenter** |
    | Size | Leave the default **DS1 v2** which gives you a single CPU and 3.5 GB of memory. That's fine for this example. |
    | **Administrator account** |
    | Username | Enter unique username for admin account on the new VM. |
    | Password/Confirm password | Enter unique password for admin account on the new VM. |

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Leave the defaults for the remaining tabs and fields, and select **Review + create**.

1. After reviewing your new VM settings, select **Create** to start the deploying your new VM.

VM creation can take a few minutes as it creates all the various resources (storage, network interface, and so on) to support the VM. Wait until the VM has deployed before continuing with the exercise.

## View OS disk cache status in the portal

After our VM is deployed, we can confirm the caching status of the OS disk using the following steps:

1. Select the **fotoshareVM** resource to open the VM details in the portal. Alternatively, you can select **All resources**, and then select your VM, **fotoshareVM**.

1. In the left menu pane, under **Settings**, select **Disks**.

1. On the **Disks** pane, the VM has one disk, the OS disk. Its cache type is currently set to the default value of **Read/write**.

![Screenshot of the Azure portal showing the Disks section of a VM pane, with the OS disk shown and set to Read-only caching.](../media/4-os-disk-rw.PNG)

## Change the cache settings of the OS disk in the portal

1. On the **Disks** pane, select **Edit** in the upper left of the screen.

1. Change the **HOST CACHING** value for the OS disk to **Read-only** using the dropdown list, and then select **Save** in the upper left of the screen.

1. This update can take some time. The reason is that changing the cache setting of an Azure disk detaches and reattaches the target disk. If it's the operating system disk, the VM is also restarted. When the operation completes, you'll get a notification saying the VM disks have been updated.

1. After completion, the OS disk cache type is set to **Read-only**.

Let's move on to data disk cache configuration. To configure a disk, we'll need first to create one.

## Add a data disk to the VM and set caching type

1. Back on the **Disks** view of our VM in the portal, select **Add data disk**. An error immediately appears in the **Name** field, prompting us that the field can't be empty. We don't have a data disk yet, so let's create one.

1. Click in the **Name** list, and then select **Create disk**.

1. In the **Create managed disk** pane, in the **Name** box, enter **fotoshareVM-data**.

1. Under **Resource group**, select **Use existing**, and select _<rgn>[sandbox resource group name]</rgn>_.

1. Note the defaults for the remaining fields:
    - Premium SSD
    - 1023 GB in size
    - In the same location as the VM (not changeable).
    - IOPS limit - 5000
    - Throughput limit (MB/s) - 200

1. Select **Create** at the bottom of the pane.

    Wait until the disk has been created before continuing.

1. Change the **Host caching** value for our new data disk to **Read-only** using the dropdown list (it might be set already), and then select **Save** in the upper left of the pane.

    Wait for the VM to finish updating the new data disk. After completion, you will have a new data disk on your VM.

In this exercise, we used the Azure portal to configure caching on a new VM, change cache settings on an existing disk, and configure caching on a new data disk. The following screenshot shows the final configuration.

![Screenshot showing the OS disk and new data disk in the Disks section of our VM pane, with both disks set to Read-only caching.](../media/disks-final-config-portal.PNG)
