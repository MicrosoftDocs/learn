Hardware virtualization has made it possible to run multiple isolated instances of operating systems concurrently on the same physical hardware. Containers represent the next stage in the virtualization of computing resources.

Container-based virtualization allows you to virtualize the operating system. This approach lets you run multiple applications within the same instance of an operating system, while maintaining isolation between the applications. The containers within a virtual machine provide functionality similar to that of virtual machines within a physical server.

### Things to know about containers versus virtual machines

To better understand container-based virtualization, let's compare containers and virtual machines.

| Compare | Containers | Virtual machines | 
| --- | --- | --- |
| **Isolation** | A container typically provides lightweight isolation from the host and other containers, but a container doesn't provide as strong a security boundary as a virtual machine. | A virtual machine provides complete isolation from the host operating system and other virtual machines. This separation is useful when a strong security boundary is critical, such as hosting apps from competing companies on the same server or cluster. |
| **Operating system** | Containers run the user mode portion of an operating system and can be tailored to contain just the needed services for your app. This approach helps you use fewer system resources. | Virtual machines run a complete operating system including the kernel, which requires more system resources (CPU, memory, and storage). |
| **Deployment** | You can deploy individual containers by using Docker via the command line. You can deploy multiple containers by using an orchestrator such as Azure Kubernetes Service. | You can deploy individual virtual machines by using Windows Admin Center or Hyper-V Manager. You can deploy multiple virtual machines by using PowerShell or System Center Virtual Machine Manager. |
| **Persistent storage** | Containers use Azure Disks for local storage for a single node, or Azure Files (SMB shares) for storage shared by multiple nodes or servers. | Virtual machines use a virtual hard disk (VHD) for local storage for a single machine, or an SMB file share for storage shared by multiple servers. |
| **Fault tolerance** | If a cluster node fails, any containers running on the node are rapidly recreated by the orchestrator on another cluster node. | Virtual machines can fail over to another server in a cluster, where the virtual machine's operating system restarts on the new server. |

### Things to consider when using containers

Containers offer several advantages over physical and virtual machines. Review the following benefits and consider how you can implement containers for the internal apps for your company.

- **Consider flexibility and speed**. Gain increased flexibility and speed when developing and sharing your containerized application code.

- **Consider testing**. Choose containers for your configuration to allow for simplified testing of your apps.

- **Consider app deployment**. Implement containers to gain streamlined and accelerated deployment of your apps.

- **Consider workload density**. Support higher workload density and improve your resource utilization by working with containers.