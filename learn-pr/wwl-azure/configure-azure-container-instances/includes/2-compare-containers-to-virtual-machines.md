Hardware virtualization has made it possible to run multiple isolated instances of operating systems concurrently on the same physical hardware. Containers represent the next stage in the virtualization of computing resources. Container-based virtualization allows you to virtualize the operating system. This way, you can run multiple applications within the same instance of an operating system, while maintaining isolation between the applications. This means that containers within a VM provide functionality similar to that of VMs within a physical server. To better understand this concept, it is helpful to compare containers and virtual machines.

:::row:::
  :::column:::
    **Feature**
  :::column-end:::
  :::column:::
    **Containers**
  :::column-end:::
  :::column:::
    **Virtual Machines**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Isolation
  :::column-end:::
  :::column:::
    Typically provides lightweight isolation from the host and other containers but doesn't provide as strong a security boundary as a virtual machine.
  :::column-end:::
  :::column:::
    Provides complete isolation from the host operating system and other VMs. This is useful when a strong security boundary is critical, such as hosting apps from competing companies on the same server or cluster.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Operating system
  :::column-end:::
  :::column:::
    Runs the user mode portion of an operating system and can be tailored to contain just the needed services for your app, using fewer system resources.
  :::column-end:::
  :::column:::
    Runs a complete operating system including the kernel, thus requiring more system resources (CPU, memory, and storage).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Deployment
  :::column-end:::
  :::column:::
    Deploy individual containers by using Docker via command line; deploy multiple containers by using an orchestrator such as Azure Kubernetes Service.
  :::column-end:::
  :::column:::
    Deploy individual VMs by using Windows Admin Center or Hyper-V Manager; deploy multiple VMs by using PowerShell or System Center Virtual Machine Manager.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Persistent storage
  :::column-end:::
  :::column:::
    Use Azure Disks for local storage for a single node, or Azure Files (SMB shares) for storage shared by multiple nodes or servers.
  :::column-end:::
  :::column:::
    Use a virtual hard disk (VHD) for local storage for a single VM, or an SMB file share for storage shared by multiple servers.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Fault tolerance
  :::column-end:::
  :::column:::
    If a cluster node fails, any containers running on it are rapidly recreated by the orchestrator on another cluster node.
  :::column-end:::
  :::column:::
    VMs can fail over to another server in a cluster, with the VM's operating system restarting on the new server.
  :::column-end:::
:::row-end:::


## Container advantages

Containers offer several advantages over physical and virtual machines, including:

 -  Increased flexibility and speed when developing and sharing the application code.
 -  Simplified application testing.
 -  Streamlined and accelerated application deployment.
 -  Higher workload density, resulting in improved resource utilization.
