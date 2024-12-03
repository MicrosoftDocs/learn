Now that you know the basics of Azure Service Fabric, let's see how it works. We'll look at the ideas behind creating a cluster, developing and deploying workloads, and integrating with other Azure services.

## Creating a Service Fabric cluster

As discussed in the previous unit, there are two cluster models in Azure Service Fabric: *standard* and *managed*. While the differences between the two models primarily lie in how they're managed, the creation processes are also slightly different.

You have two options when you create a Service Fabric cluster. You either use the Azure portal or Azure Resource Manager templates. During creation, you configure basic information such as:

- The Service Fabric cluster name
- Username and password for your cluster's administrator account
- Initial number of virtual machines

The initial number of virtual machines is handled differently between the standard and managed models. In the standard cluster model, this is called the *initial virtual machine scale set capacity*. For production scenarios, the initial virtual machine scale set capacity is five or greater. For testing purposes, less than five is acceptable. For the managed cluster model, you determine the initial number of virtual machines through the *cluster SKU*. There are two options: basic and standard. Basic provides three initial virtual machines, while standard provides five. Similar to the standard cluster model, standard is recommended for production scenarios, and basic is only recommended for testing purposes.

Unless specified, the Azure service creation workflow creates a Service Fabric cluster using default configuration for scaling, authentication, networking and monitoring. Creating a Service Fabric cluster typically takes 10-15 minutes. Once complete, access and management of your cluster can be done through the Azure portal, Azure CLI, or through the Service Fabric Explorer.

>[!NOTE]
> Due to the abstracted nature of the managed cluster, some properties that can be modified in the standard cluster model aren't exposed to the user in the managed cluster model.

## How workloads are developed and deployed in Service Fabric

Service Fabric supports a wide range of popular development tools and environments.

### Development tools

Service Fabric Tools included in Azure Development workload in Visual Studio.

The Microsoft Azure Service Fabric SDK supports both Windows and Linux development environments.

Service Fabric offers various productive programming models, including guest executables, containers, and Reliable Services and Actors.

You can develop in various languages, including .NET Core 2.0, C#, and Java.

### Deployment tools

You can deploy workloads to your cluster using PowerShell, Azure Resource Manager and ARM templates, Azure CLI, Azure portal, and Docker Compose.  

## Azure Service integration

Service Fabric allows you to integrate with many Azure service offerings.

For example, you can set up continuous integration and deployment to your nodes using Azure Pipelines. You can also use Azure Monitor to monitor cluster and container infrastructure events.
