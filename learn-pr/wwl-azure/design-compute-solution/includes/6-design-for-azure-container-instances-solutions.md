:::image type="content" source="../media/select-azure-container-instances.png" alt-text="Flowchart to select Azure Container Instances.":::

 

Virtual machines are an excellent way to reduce costs versus the investments that are necessary for physical hardware. However, each virtual machine is still limited to a single operating system. If you want to run multiple instances of an application on a single host machine, containers are an excellent choice.

[Azure Container Instances](/azure/container-instances/container-instances-overview) are a fast and simple way to run a container on Azure. Azure Container Instance scenarios include simple applications, task automation, and build jobs. Here are some benefits of containers. 

- **Fast startup**. Launch containers in seconds.

- **Per second billing**. Incur costs only while the container is running.

- **Hypervisor-level security**. Isolate your application as completely as it would be in a VM.

- **Custom sizes**. Specify exact values for CPU cores and memory.

- **Persistent storage**. Mount Azure Files shares directly to a container to retrieve and persist state.

- **Linux and Windows**. Schedule both Windows and Linux containers using the same API.

### What are container groups?

The top-level resource in Azure Container Instances is the container group. A container group is a collection of containers that get scheduled on the same host machine. The containers in a container group share a lifecycle, resources, local network, and storage volumes.

:::image type="content" source="../media/container-groups.png" alt-text="Container groups use DNS and access files.":::


Multi-container groups are useful in cases where you want to divide a single functional task into several container images. These images can then be delivered by different teams and have separate resource requirements. Example usage could include:

- A container serving a web application and a container pulling the latest content from source control.

- An application container and a logging container. The logging container collects the logs and metrics output by the main application and writes them to long-term storage.

- An application container and a monitoring container. The monitoring container periodically makes a request to the application to ensure that it's running and responding correctly and raises an alert if it's not.

- A front-end container and a back-end container. The front end might serve a web application, with the back end running a service to retrieve data.

### Security considerations for container instances

When working with container instances, consider these security best practices.

- **Use a private registry.** Containers are built from images that are stored in one or more repositories. These repositories can belong to a public registry or to a private registry. An example of a private registry is the [Docker Trusted Registry](https://docs.docker.com/datacenter/dtr/), which can be installed on-premises or in a virtual private cloud. Another example is [Azure Container Registry](/azure/container-registry/)  to build, store, and manage container images and artifacts. 

- **Ensure the integrity of images throughout the lifecycle.** Part of managing security throughout the container lifecycle is to ensure the integrity of the container images. Images with vulnerabilities, even minor, shouldn’t be allowed to run in a production environment. Keep the number of production images small to ensure that they can be managed effectively.

- **Monitor container resource activity**. Monitor your resource activity, like files, network, and other resources that your containers access. Monitoring resource activity and consumption is useful both for performance monitoring and as a security measure.

> [!TIP]
> Read more about [Security considerations for container instances - Azure Container Instances | Microsoft Docs](/azure/container-instances/container-instances-image-security)

 

### When to choose containers instead of virtual machines


| **Feature**| **Containers**| **Virtual Machines** |
| - | - | - |
| Isolation| Typically provides lightweight isolation from the host and other containers but doesn't provide as strong a security boundary as a virtual machine.| Provides complete isolation from the host operating system and other VMs. Isolation is useful when a strong security boundary is critical, such as hosting apps from competing companies on the same server or cluster. |
| Operating system| Runs the user mode portion of an operating system and can be tailored to contain just the needed services for your app, using fewer system resources.| Runs a complete operating system. Typically, requires more system resources (CPU, memory, and storage). |
| Deployment| Deploy individual containers by using Docker via command line; deploy multiple containers by using an orchestrator such as Azure Kubernetes Service.| Deploy individual VMs by using Windows Admin Center or Hyper-V Manager; deploy multiple VMs by using PowerShell or System Center Virtual Machine Manager. |
| Persistent storage| Use Azure Disks for local storage for a single node, or Azure Files (SMB shares) for storage shared by multiple nodes or servers.| Use a virtual hard disk (VHD) for local storage for a single VM, or an SMB file share for storage shared by multiple servers. |
| Fault tolerance| If a cluster node fails, any containers running on it are rapidly recreated by the orchestrator on another cluster node.| VMs can fail over to another server in a cluster, with the VM's operating system restarting on the new server. |