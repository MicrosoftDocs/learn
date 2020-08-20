Running virtual machines in Azure uses a shared hardware platform, managed by Microsoft, which isolates your workloads from being visible by any other Azure customer. In some scenarios, organizations may have regulatory compliance which requires them to be the only customer using the physical machine which is hosting their virtual machines. This is possible with Azure Dedicated Hosts.

### Benefits of Azure Dedicated Host
+ Visibility into, and control over, the server infrastructure running your Azure VMs.
+ Helps address compliance requirements by deploying your workloads on an isolated server.
+ Lets you choose the number of processors, server capabilities, VM series and VM sizes within the same host.

### Availability considerations for Dedicated Hosts
Once a dedicated host is provisioned, Azure assigns it to the physical server in Microsoft's cloud datacenter. For high availability, you can provision multiple hosts in a *host group* and deploy your virtual machines across them. VMs on dedicated hosts can also take advantage of *maintenace control* - allowing you to skip regular platform updates scheduled by Microsoft and apply them at a time of your choosing, within a 35 day rolling window.

### Pricing considerations
Customers are charged per dedicated hosts, regardless of how many virtual machines are deployed to it. The host price is set based on the VM family, type (hardware size) and region. Software licensing, storage and network usage are billed separately from the host and VMs. For more information see [Azure Dedicated Host pricing](https://aka.ms/ADHPricing).

<div style="background:yellow;">
TODO: Graphics? 
</div>

