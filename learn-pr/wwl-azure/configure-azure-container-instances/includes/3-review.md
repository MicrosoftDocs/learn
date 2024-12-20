Containers are becoming the preferred way to package, deploy, and manage cloud applications. There are many options for teams to build and deploy cloud native and containerized applications on Azure. In this unit, we review Azure Container Instances (ACI). 

Azure Container Instances offers the fastest and simplest way to run a container in Azure, without having to manage any virtual machines and without having to adopt a higher-level service. Azure Container Instances is a great solution for any scenario that can operate in isolated containers. 

The following illustration shows a web server container built with Azure Container Instances. The container is running on a virtual machine in a virtual network.

:::image type="content" source="../media/container-overview-0e72c2ba.png" alt-text="Diagram that shows a web server container running on a virtual machine in a virtual network." border="false":::

### Understand container images

All containers are created from container images. A container image is a lightweight, standalone, executable package of software that encapsulates everything needed to run an application. It includes the following components:

- **Code**: The application’s source code.
- **Runtime**: The environment required to execute the application.
- **System tools**: Utilities necessary for the application to function.
- **System libraries**: Shared libraries used by the application.
- **Settings**: Configuration parameters specific to the application.

When you create a container image, it becomes a portable unit that can run consistently across different computing environments. These images are the building blocks for containers, which are instances of these images running at runtime.

### Things to know about Azure Container Instances

Let's review some of the [benefits of using Azure Container Instances](/azure/container-instances/container-instances-overview). As you review these points, think about how you can implement Container Instances for your internal applications.

- **Fast startup times**. Containers can start in seconds without the need to provision and manage virtual machines.

- **Public IP connectivity and DNS names**. Containers can be directly exposed to the internet with an IP address and FQDN (fully qualified domain name).

- **Custom sizes**. Container nodes can be scaled dynamically to match actual resource demands for an application.

- **Persistent storage**. Containers support direct mounting of Azure Files file shares.

- **Linux and Windows containers**. Container Instances can schedule both Windows and Linux containers. Specify the operating system type when you create your container groups.

- **Coscheduled groups**. Container Instances supports scheduling of multi-container groups that share host machine resources.

- **Virtual network deployment**. Container Instances can be deployed into an Azure virtual network.