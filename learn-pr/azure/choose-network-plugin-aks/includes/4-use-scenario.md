Now that you've established the pros and cons for the decision criteria, it's best to go over some scenarios.

## Development

Accommodating the development of several features in a limited IP address space can be challenging. Kubenet is designed with the conservation of address space in mind, making it a great choice for development or experimental environments.

If one or more of the following aren't true, you consider opting for a development environment using Azure CNI networking:

* Experimental or in-development features don't need the rapid scaling capabilities that Virtual Nodes with Azure Container Instances provide.
* Minor latency in the environment, caused by an extra hop for pod communication, is acceptable.
* The operational overhead of maintaining route tables and UDRs in the development environment is acceptable.
* The development environment only supports Linux-based node pools.

With kubenet, the Azure platform automatically creates and configures the virtual network resources whenever you create an AKS cluster. You can also manually create and configure the virtual network resources and attach it to those resources at creation time. However, making changes to Azure-managed network resources is unsupported.

## Production

Bear in mind that there are several factors that prevent kubenet from being an acceptable networking option for production. Kubenet shines as a quick method to prototype and test small applications in development. 

Instead, Azure CNI is more suited for production environments for its configurable networking option that includes:

* Reduced latency.
* Rapid-scaling capability through Virtual Nodes with Azure Container Instances.
* Directly addressable pods simplify connectivity to services running outside the cluster.
* Support for advanced network topologies and related features.

You can also opt in to use Azure CNI for development environments if one or more of the features are necessary for your use case. For example, if Windows Server-based nodes are required, Azure CNI must be used for both development and production clusters. Bear in mind, this choice introduces the need for more network topology planning, which requires an expert.
