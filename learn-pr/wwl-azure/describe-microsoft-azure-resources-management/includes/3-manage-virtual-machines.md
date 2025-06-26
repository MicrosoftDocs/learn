Creating a virtual machine (VM) is often one of the first instances of working with cloud compute. It allows you to have a familiar environment (Windows or Linux), but operate in the cloud.

Unlike traditional, on-premises computers, updating or changing the configuration for many settings on a virtual machine is easily accomplished from the Azure portal. Let’s take a look at managing a Linux virtual machine in the Azure portal.

You can access many of the management features from the VM blade that appears when you select the name of the VM from your list of resources.

##Overview blade
From the overview blade, you can quickly start, stop, or restart your VM. You can also connect to your VM if it’s already running.

:::image type="content" source="../media/virtual-machine-overview.png" alt-text="Screenshot of the virtual machine overview blade.":::

The current VM status (running, stopped), operating system, networking information, and infrastructure information are all also available from the overview blade. Many of the settings are linked and you can change configuration by clicking on the linked items.

For example, if you need to change the resource group the VM is assigned to, selecting **move** next to **resource group** takes you to a new screen to reassign the VM to a new resource group.

This unit highlights some of the other blades as well. However, you’re encouraged to take some time to familiarize yourself with all of them, even if they’re not covered in this unit.

Let’s also cover some of the other blades, such as:
* Activity log
* Tags
* Networking
* Settings
* Availability + scale

##Activity log
The activity log provides a quick history of the VM’s activity. You can change filters to change what information displays in the report, such as adjusting the *timespan* to include a broader history report to look at trends.

:::image type="content" source="../media/virtual-machine-activity-log.png" alt-text="Screenshot of the virtual machine activity log blade.":::

##Tags
Recall that In Azure, **tags** can be used to track metadata on subscriptions, resource groups, or resources. The tags blade on a specific virtual machine provides a location to manage tags for this specific VM. It can be useful to apply tags at the VM level if you’re adding custom tags for custom reporting. For example, if this machine primarily functions as a web host, you could add a tag of **Purpose** with a value of **web host**.

:::image type="content" source="../media/virtual-machine-tags.png" alt-text="Screenshot of the virtual machine tags blade.":::

By tagging resources, you can run reports on them to better track usage across specific use cases.
##Networking
The networking blade lets you handle many types of networking related tasks. From configuring load balances to swapping subnets or changing network security groups, if it’s networking related, you can likely accomplish it from the **networking** blade.

###Changing a subnet
For example, if you have one subnet that’s focused strictly for production web hosting, and another subnet that you use just for testing updates before they’re pushed to live, you can move a virtual machine between subnets to keep metrics correct and networks fulfilling their purpose.

Changing a VM’s subnet is done at the **Network interface / IP configuration** level. The easiest way to access the network interface is simply selecting it from the **network settings** blade.

:::image type="content" source="../media/virtual-machine-network-interface.png" alt-text="Screenshot of the virtual machine network settings blade with the network interface highlighted.":::

On the **IP configurations** blade, changing the subnet is as simple as selecting a different subnet from the dropdown and **Apply** the updated settings. You can also add a load balancer from this screen, if one is already created.

:::image type="content" source="../media/virtual-machine-networking-subnet.png" alt-text="Screenshot of the virtual machine network interface settings blade with the subnets expanded and highlighted for the IP settings. ":::

> [!NOTE]
>Changing networking settings, such as swapping subgroups, may require a restart of the virtual machine.

###Load balancing
Recall that a load balancer helps distribute network traffic across multiple destinations or hosts.

From the **load balancing** sub under **Networking**, you can add a load balancer to help your virtual network perform more efficiently.

:::image type="content" source="../media/virtual-machine-networking-load-balancer.png" alt-text="Screenshot of the virtual machine networking blade with the load balancing selected. ":::

To add a load balancer:
* Select **Add load balancing**
* Choose between an existing load balancer or creating a new one
* If creating a new one, select the type of load balancing
* Configure the load balancer and create it.

:::image type="content" source="../media/create-load-balancer.png" alt-text="Screenshot of the virtual machine networking blade showing the create screen for creating a load balancer.":::

> [!NOTE]
> Necessary settings for the load balancer are pulled from the virtual machine (such as resource group and network security group).

##Settings
The settings area of the menu let’s you control things such as the disks associated with the virtual machine and resource locks, and you can view things like information on the operating system and configuration information.

###Disks
In the **disks** menu, you can view and swap the operating system or storage disks. For example, if you wanted to upgrade the machine to a newer version of the operating system, and you already had the image configured exactly how you want, you could simply **Swap OS disk** instead of creating a new VM or doing a complete reinstall on this VM.

Similarly, if you need to add more disk storage, you can **Create and attach a new disk** or **Attach existing disks** to VM. This could be handy if you’re transitioning a VM from development to production and you want to quickly swap the data disk.

:::image type="content" source="../media/virtual-machine-disks.png" alt-text="Screenshot of the virtual machine disks area, showing the Swap OS disk and Create and attach new disk options.":::

You can also select either your OS disk or you storage disk to see more information about that disk.

> [!NOTE]
> Swapping the OS disk requires a virtual machine restart. You can add a data disk without having to restart the virtual machine.

###Locks
Recall that you can use delete locks and read-only locks to prevent anyone from deleting a resource or changing a resource without first removing the lock.

Imagine you have a fleet of VMs and you know that soon many of them will be deleted to decrease your cloud footprint. Adding a delete lock onto key VMs that need to be protected will help avoid them being accidentally deleted.

:::image type="content" source="../media/virtual-machine-delete-lock.png" alt-text="Screenshot of the virtual machine settings area, showing a delete lock configured and ready to be applied.":::

##Availability + scale
Recall that Azure enables both vertical (VM capability) and horizontal (number of VMs) scaling. Both of these types of scaling are accomplished in the **Availability + scale** section of the menu.

###Size
The **Size** submenu provides vertical scaling capabilities. You can scale the VM up, increasing the computing power or memory, or down, decrease the computing power or memory, by selecting the **NEW** VM size and resizing the VM.

:::image type="content" source="../media/virtual-machine-vertical-scaling.png" alt-text="Screenshot of the virtual machine Availability + scale menu with the Size submenu selected to vertically scale a VM.":::

> [!NOTE]
> Resizing a VM requires a machine restart if the machine is running. Additionally, it’s possible you’ll have more resizing options if you shut the machine down before attempting to change the VM size.

###Availability + scaling
The ***Availability + scaling*** submenu provides access to setting up scaling groups and availability sets. Recall that scaling groups will automatically add or remove VMs based on predefined thresholds for VM load. As increased load is encountered, more VMs will be brought on line. Similarly, as load drops, VMs will be taken off-line to save costs and resources.

Additionally, recall that availability sets help prevent failure by keeping VMs in fault domains and update domains. This helps prevent all of your VMs being updated at the same time or all failing if one fault domain fails.

##Keep exploring virtual machines
There are other menu and submenus available within the virtual machine blade of Azure. Keep exploring to see what other things you can find.

For example, under **Operations\Auto-shutdown** you can configure a VM to shut down at the same time every day. You can even configure a notification when it happens.

Under **Backup + disaster recovery** you can establish a backup cadence, create restore points, and configure disaster recovery options to configure disaster recovery to a different availability zone or region.