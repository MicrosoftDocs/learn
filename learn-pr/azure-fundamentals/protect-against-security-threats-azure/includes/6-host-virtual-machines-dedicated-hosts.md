On Azure, virtual machines (VMs) run on shared hardware that's managed by Microsoft. Although the underlying hardware is shared, your VM workloads are isolated from workloads being run by other Azure customers.

However, some organizations must follow regulatory compliance that requires them to be the only customer using the physical machine that hosts their virtual machines. [Azure Dedicated Host](https://azure.microsoft.com/services/virtual-machines/dedicated-host/?azure-portal=true) provides dedicated physical servers to host your Azure VMs for Windows and Linux.

## What are the benefits of Azure Dedicated Host?

Azure Dedicated Host:

* Gives you visibility into, and control over, the server infrastructure running your Azure VMs.
* Helps address compliance requirements by deploying your workloads on an isolated server.
* Lets you choose the number of processors, server capabilities, VM series, and VM sizes within the same host.

## Availability considerations for Dedicated Host

After a dedicated host is provisioned, Azure assigns it to the physical server in Microsoft's cloud datacenter.

For high availability, you can provision multiple hosts in a *host group* and deploy your virtual machines across this group. VMs on dedicated hosts can also take advantage of *maintenance control*, which enables you to control when regular maintenance updates occur, within a 35 day rolling window.

## Pricing considerations

You are charged per dedicated host, independent of how many virtual machines you deploy to it. The host price is based on the VM family, type (hardware size), and region.

Software licensing, storage, and network usage are billed separately from the host and VMs. For more information. see [Azure Dedicated Host pricing](https://aka.ms/ADHPricing/?azure-portal=true).
