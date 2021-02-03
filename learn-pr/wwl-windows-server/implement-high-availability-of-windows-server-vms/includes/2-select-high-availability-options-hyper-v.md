High availability is one of the primary requirements of business-critical workloads. Considering dominance of virtualization technologies, it is critical to ensure that high availability provisions extend to the Hyper-V platform.

## What are high-availability options for Hyper-V VMs?

To provide high availability for Hyper-V VMs and the services hosted within VMs, you can choose to:

- Implement VMs as a clustered role (host clustering).
- Implement clustering inside VMs (guest clustering).
- Use Network Load Balancing (NLB) inside VMs.

In this unit, you'll learn about the first two of these methods. NLB will be covered next.

### Host clustering

When implementing host clustering, you create a failover cluster consisting of nodes running the Hyper-V server role. With a Hyper-V cluster in place, you can configure VMs as highly available clustered resources. This way, you implement failover clustering protection at the Hyper-V host level. Effectively, the guest operating system and its workloads don't have to be cluster-aware. Some examples of workloads that are not cluster-aware include Windows Server-based print server or custom, in-house developed business application.

In case the cluster node that hosts a highly-available VM fails unexpectedly, another node will automatically restart or resume that VM. In case of a planned maintenance event that affects the node availability, you can move the VM to another node gracefully, in a controlled manner.

### Guest clustering

You configure failover clustering of Hyper-V VMs similarly to failover clustering of physical servers. To start, you provision two or more VMs and configure them as nodes of a failover cluster. While it is possible to implement this scenario by using a single Hyper-V host, such configuration is suitable only for a development or test environment.

For production environments, you should deploy VMs across separate Hyper-V host computers that are part of a separate failover cluster. With failover clustering implemented at both the host and VM levels, your workloads benefit from two levels of protection.

Implementing guest clustering warrants some additional considerations:

- The application or service you intend to protect must be failover cluster–aware. With many Microsoft apps, such as Microsoft SQL Server and Microsoft Exchange Server, you can take advantage of their built-in support for Windows Server failover clustering. If such support isn't available, you might be able to implement a custom solution that relies on generic cluster roles, such as Generic Service, Generic Script, or Generic Application.
- To implement shared virtual disks for Hyper-V VMs, you can use Fibre Channel- or Internet Small Computer System Interface (iSCSI)-based storage. Hyper-V supports virtual hard disk (VHD) Sets, which facilitate this type of configuration.
- You should deploy multiple network adapters on the host computers and the VMs. When using iSCSI-based storage, you should set up a separate network connection dedicated for iSCSI traffic.
