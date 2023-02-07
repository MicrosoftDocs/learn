
An Azure virtual machine gives you the flexibility of virtualization without having to buy and maintain the physical hardware that runs it. However, you still need to maintain the VM by performing tasks, such as configuring, patching, and installing the software that runs on it. This unit gives you information about what you should consider before you create a VM, how you create it, and how you manage it.

Azure virtual machines can be used in various ways. Some examples are:

* **Development and test** – Azure VMs offer a quick and easy way to create a computer with specific configurations required to code and test an application.
* **Applications in the cloud** – Because demand for your application can fluctuate, it might make economic sense to run it on a VM in Azure. You pay for extra VMs when you need them and shut them down when you don’t.
* **Extended datacenter** – Virtual machines in an Azure virtual network can easily be connected to your organization’s network.

## Design considerations for virtual machine creation

There are always a multitude of design considerations when you build out an application infrastructure in Azure. These aspects of a VM are important to think about before you start:

* **Availability**: Azure supports a single instance virtual machine Service Level Agreement of 99.9% provided you deploy the VM with premium storage for all disks. 

* **VM size**: The size of the VM that you use is determined by the workload that you want to run. The size that you choose then determines factors such as processing power, memory, and storage capacity. 

* **VM limits**: Your subscription has default quota limits in place that could impact the deployment of many VMs for your project. The current limit on a per subscription basis is 20 VMs per region. Limits can be raised by filing a [support ticket requesting an increase](/azure/azure-portal/supportability/regional-quota-requests).

* **VM image**: You can either use your own image, or you can use one of the images in the Azure Marketplace.  You can get a list of images in the marketplace by using the `az vm image list` command. See [list popular images](/azure/virtual-machines/linux/cli-ps-findimage#list-popular-images) for more information on using the command.

* **VM disks**: There are two components that make up this area. The type of disks which determines the performance level and the storage account type that contains the disks. Azure provides two types of disks:

    * **Standard disks**: Backed by HDDs, and delivers cost-effective storage while still being performant. Standard disks are ideal for a cost effective dev and test workload.
    
    * **Premium disks**: Backed by SSD-based, high-performance, low-latency disk. Perfect for VMs running production workload.

    And, there are two options for the disk storage:

    * **Managed disks**: Managed disks are the newer and recommended disk storage model and they are managed by Azure. You specify the size of the disk, which can be up to 4 terabytes (TB), and Azure creates and manages both the disk and the storage. You don't have to worry about storage account limits, which makes managed disks easier to scale out than unmanaged discs.

    * **Unmanaged disks**: With unmanaged disks, you’re responsible for the storage accounts that hold the virtual hard disks (VHDs) that correspond to your VM disks. You pay the storage account rates for the amount of space you use. A single storage account has a fixed-rate limit of 20,000 input/output (I/O) operations per second. This means that a storage account is capable of supporting 40 standard VHDs at full utilization. If you need to scale out with more disks, then you'll need more storage accounts, which can get complicated.
 
## Virtual machine extensions

Windows VMs have extensions which give your VM additional capabilities through post deployment configuration and automated tasks. These common tasks can be accomplished using extensions:

* **Run custom scripts**: The Custom Script Extension helps you configure workloads on the VM by running your script when the VM is provisioned.
* **Deploy and manage configurations**: The PowerShell Desired State Configuration (DSC) Extension helps you set up DSC on a VM to manage configurations and environments.
* **Collect diagnostics data**: The Azure Diagnostics Extension helps you configure the VM to collect diagnostics data that can be used to monitor the health of your application.

For Linux VMs, Azure supports [cloud-init](https://cloud-init.io/) across most Linux distributions that support it and works with all the major automation tooling like Ansible, Chef, SaltStack, and Puppet.
