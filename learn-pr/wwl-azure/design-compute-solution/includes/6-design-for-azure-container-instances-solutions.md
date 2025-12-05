Virtual machines are an excellent way to reduce costs versus the investments that are necessary for physical hardware. However, each virtual machine is still limited to a single operating system. If you want to run multiple instances of an application on a single host machine, containers are an excellent choice.

This video highlights the differences between virtual machines and containers. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=7aa48d3f-4304-4a18-9861-eaf9d4bebd26]


### Things to know about Azure Container Instances

[Azure Container Instances](/azure/container-instances/container-instances-overview) are a fast and simple way to run a container on Azure. Scenarios for using Azure Container Instance include simple applications, task automation, and build jobs.

Azure Container Instances offers many benefits, including fast startup, per second billing, and persistent storage. These benefits make Azure Container Instances a great compute solution to support new workloads and migrate data by using the lift and shift pattern.  

:::image type="content" source="../media/select-azure-container-instances.png" alt-text="Flowchart that shows the decision tree for selecting Azure Container Instances to build new workloads and to support lift and shift migrations." border="false":::

- Azure Container Instances enables fast startup. You can launch containers in seconds for immediate access to applications.

- Azure Container Instances implements per second billing. You incur costs only while your container is running.

- Azure Container Instances supports custom sizes for your containers. You can specify exact values for CPU cores and memory and avoid costs for unused resources.

- Container Instances offers persistent storage. Azure Files shares can be mounted directly to a container to retrieve and persist state.

- Container Instances can be used with Linux and Windows. Schedule both Windows and Linux containers using the same API.

#### Container groups

The top-level resource in Azure Container Instances is the _container group_. A container group is a collection of containers that get scheduled on the same host machine. The containers in a group share a lifecycle, resources, local network, and storage volumes.

:::image type="content" source="../media/container-groups.png" alt-text="Diagram that shows container groups with access from DNS on port 80 and Azure files on port 1433." border="false":::

Multi-container groups are useful when you want to divide a single functional task into several container images. Different teams use these images. Some example scenarios include:
- A container serving a web application and a container pulling the latest content from source control.
- An application container and a logging container. The logging container collects the logs and metrics output by the main application and writes them to long-term storage.
- An application container and a monitoring container. The monitoring container periodically makes a request to the application to ensure it's running and responding correctly, and raises alerts as needed.
- A front-end container and a back-end container. The frontend might serve a web application with the backend running a service to retrieve data.

### Things to consider when using Azure Container Instances

When you work with Azure Container Instances, there are several recommended security practices.

- **Use a private registry**. Containers are built from images that are stored in one or more repositories. These repositories can belong to a public registry or to a private registry. An example of a private registry is the [Docker Trusted Registry](https://docs.docker.com/datacenter/dtr/), which can be installed on-premises or in a virtual private cloud. Another example is [Azure Container Registry](/azure/container-registry/) that can be used to build, store, and manage container images and artifacts. 

- **Ensure image integrity throughout the lifecycle**. Part of managing security throughout the container lifecycle is to ensure the integrity of the container images. Images with vulnerabilities, even minor, shouldn't be allowed to run in a production environment. Keep the number of production images small to ensure they can be managed effectively.

- **Monitor container resource activity**. Monitor your resource activity, like files, network, and other resources that your containers access. Monitoring resource activity and consumption are useful both for performance monitoring and as a security measure.

> [!TIP]
> Learn more about container instances in the [Configure Container Instance](/training/modules/configure-azure-container-instances/) module. 