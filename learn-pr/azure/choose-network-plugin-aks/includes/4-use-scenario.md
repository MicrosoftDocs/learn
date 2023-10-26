Now that you'd established the pros and cons for the decision criteria, it's best to go over some scenarios.

## Development

Accommodating the development of several features in a limited IP address space can be challenging. Kubenet is designed with the conservation of address space in mind, making it a great choice for development or experimental environments.

If one or more of the following aren't true, you consider opting for a development environment using Azure CNI networking:

* Experimental or in-development features don't need the rapid scaling capabilities that Virtual Nodes with Azure Container Instances provide.
* Minor latency in the environment, caused by an extra hop for pod communication, is acceptable.
* The operational overhead of maintaining route tables and UDRs in the development environment is acceptable.
* The development environment will make use of Linux-based node pools only.

With kubenet, the Azure platform can automatically create and configure the virtual network resources when you create an AKS cluster, or you can manually create and configure the virtual network resources and attach to those resources at creation time. Making changes to Azure-managed network resources is unsupported.

Bear in mind that there are several factors that prevent kubenet from being an acceptable networking option for production.

## Production

Instead, Azure CNI is a more configurable networking option, and suited for production environments for several reasons:

* Reduced latency.
* Rapid-scaling capability through Virtual Nodes with Azure Container Instances.
* Directly addressable pods make connectivity from services running outside the cluster simple.
* More network topologies and features are supported.

You may also opt to use Azure CNI for development environments if one or more of the features are necessary for your use case. For example, if Windows Server-based nodes are required, Azure CNI must be used for both development and production clusters. Bear in mind, this choice will introduce the need for more IP address space planning.

Like with kubenet, when using Azure CNI the Azure platform can automatically create and configure the virtual network resources when you create an AKS cluster, or you can manually create and configure the virtual network resources and attach to those resources at creation time. Making changes to Azure-managed network resources is unsupported.
