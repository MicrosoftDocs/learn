Virtual machines are an excellent way to reduce costs versus the investments that are necessary for physical hardware. However, each virtual machine is still limited to a single operating system. If you want to run multiple instances of an application on a single host machine, containers are an excellent choice.

[Azure Container Instances](/azure/container-instances/container-instances-overview) are a fast and simple way to run a container on Azure. Scenarios for using Azure Container Instance include simple applications, task automation, and build jobs.

### Things to know about Azure Container Instances

Azure Container Instances offers many benefits, including fast startup, per second billing, and persistent storage. These benefits make Azure Container Instances a great compute solution to support new workloads and migrate data by using the lift and shift pattern.  

:::image type="content" source="../media/select-azure-container-instances.png" alt-text="Flowchart that shows the decision tree for selecting Azure Container Instances to build new workloads and to support lift and shift migrations." border="false":::

- Azure Container Instances enables fast startup. You can launch containers in seconds for immediate access to applications.

- Azure Container Instances implements per second billing. You incur costs only while your container is running.

- Azure Container Instances supports custom sizes for your containers. You can specify exact values for CPU cores and memory and avoid costs for unused resources.

- Container Instances offers persistent storage. Azure Files shares can be mounted directly to a container to retrieve and persist state.

- Container Instances can be used with Linux and Windows. Schedule both Windows and Linux containers using the same API.

#### Container groups

The top-level resource in Azure Container Instances is the _container group_. A container group is a collection of containers that get scheduled on the same host machine. The containers in a container group share a lifecycle, resources, local network, and storage volumes.

:::image type="content" source="../media/container-groups.png" alt-text="Diagram that shows container groups with access from DNS on port 80 and Azure files on port 1433." border="false":::

Multi-container groups are useful when you want to divide a single functional task into several container images. These images can then be delivered by different teams and have separate resource requirements. Some example scenarios include:
- A container serving a web application and a container pulling the latest content from source control.
- An application container and a logging container. The logging container collects the logs and metrics output by the main application and writes them to long-term storage.
- An application container and a monitoring container. The monitoring container periodically makes a request to the application to ensure it's running and responding correctly, and raises alerts as needed.
- A front-end container and a back-end container. The frontend might serve a web application with the backend running a service to retrieve data.

### Things to consider when using Azure Container Instances

When you work with Azure Container Instances, there are several recommended security practices.

- **Use a private registry**. Containers are built from images that are stored in one or more repositories. These repositories can belong to a public registry or to a private registry. An example of a private registry is the [Docker Trusted Registry](https://docs.docker.com/datacenter/dtr/), which can be installed on-premises or in a virtual private cloud. Another example is [Azure Container Registry](/azure/container-registry/) that can be used to build, store, and manage container images and artifacts. 

- **Ensure image integrity throughout the lifecycle**. Part of managing security throughout the container lifecycle is to ensure the integrity of the container images. Images with vulnerabilities, even minor, shouldn't be allowed to run in a production environment. Keep the number of production images small to ensure they can be managed effectively.

- **Monitor container resource activity**. Monitor your resource activity, like files, network, and other resources that your containers access. Monitoring resource activity and consumption are useful both for performance monitoring and as a security measure.

## Compare Azure Container Instances to Azure Virtual Machines

The following table compares how important features are supported in Azure Container Instances and Azure Virtual Machines. As you review the following features, consider what features and support are required for the Tailwind Traders infrastructure compute solution.

| Compare | Azure Container Instances | Azure Virtual Machines |
| --- | --- | --- |
| **Isolation** | Container Instances typically provide lightweight isolation from the host and other containers, but doesn't provide as strong a security boundary as a virtual machine.| A virtual machine provides complete isolation from the host operating system and other virtual machines. Isolation is useful when a strong security boundary is critical, such as hosting apps from competing companies on the same server or cluster. |
| **Operating system** | Container Instances runs the user mode portion of an operating system and can be tailored to contain just the needed services for your application. This configuration results in fewer system resources being utilized.| Each virtual machine runs a complete operating system. Azure Virtual Machines typically requires more system resources than Container Instances, such as CPU, memory, and storage. |
| **Deployment** | Container Instances deploy individual containers by using Docker via the command line. Multiple containers are deployed by using an orchestrator such as Azure Kubernetes Service.| You can deploy individual virtual machines by using Windows Admin Center or Hyper-V Manager. Multiple virtual machines can be deployed by using PowerShell or System Center Virtual Machine Manager. |
| **Persistent storage** | Container Instances use Azure Disks for local storage for a single node, or Azure Files (SMB shares) for storage shared by multiple nodes or servers. | With Azure Virtual Machines, you can use a virtual hard disk (VHD) for local storage for a single virtual machine, or an SMB file share for storage shared by multiple servers. |
| **Fault tolerance** | If a cluster node fails in Azure Container Instances, any containers running on it are rapidly recreated by the orchestrator on another cluster node. | A virtual machine can fail over to another server in a cluster with the operating system of the virtual machine restarting on the new server. |