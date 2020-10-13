On Azure, virtual machines (VMs) run on shared hardware that Microsoft manages. Although the underlying hardware is shared, your VM workloads are isolated from workloads that other Azure customers run.

Some organizations must follow regulatory compliance that requires them to be the only customer using the physical machine that hosts their virtual machines. [Azure Dedicated Host](https://azure.microsoft.com/services/virtual-machines/dedicated-host/?azure-portal=true) provides dedicated physical servers to host your Azure VMs for Windows and Linux.

Here's a diagram that shows how virtual machines relate to dedicated hosts and host groups. A *dedicated host* is mapped to a physical server in an Azure datacenter. A *host group* is a collection of dedicated hosts.

:::image type="content" source="../media/6-dedicated-hosts.png" alt-text="A diagram that shows the relationship among virtual machines, dedicated hosts, and host groups." border="false":::

## What are the benefits of Azure Dedicated Host?

Azure Dedicated Host:

* Gives you visibility into, and control over, the server infrastructure that's running your Azure VMs.
* Helps address compliance requirements by deploying your workloads on an isolated server.
* Lets you choose the number of processors, server capabilities, VM series, and VM sizes within the same host.

## Availability considerations for Dedicated Host

After a dedicated host is provisioned, Azure assigns it to the physical server in Microsoft's cloud datacenter.

For high availability, you can provision multiple hosts in a *host group* and deploy your virtual machines across this group. VMs on dedicated hosts can also take advantage of *maintenance control*. This feature enables you to control when regular maintenance updates occur, within a 35-day rolling window.

## Pricing considerations

You're charged per dedicated host, independent of how many virtual machines you deploy to it. The host price is based on the VM family, type (hardware size), and region.

Software licensing, storage, and network usage are billed separately from the host and VMs. For more information. see [Azure Dedicated Host pricing](https://aka.ms/ADHPricing/?azure-portal=true).
