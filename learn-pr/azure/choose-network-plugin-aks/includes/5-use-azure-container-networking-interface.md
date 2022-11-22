Azure CNI is a more configurable networking option, and is better suited to production environments for several reasons:

* Reduced latency.
* Rapid-scaling capability through Virtual Nodes with Azure Container Instances.
* Directly addressable pods make connectivity from services running outside the cluster simple.
* More network topologies and features are supported.

You may also opt to use Azure CNI for development environments if one or more of the features are necessary for your use case. For example, if Windows Server-based nodes are required, Azure CNI must be used for both development and production clusters. Bear in mind, this choice will introduce the need for more IP address space planning.

Like with kubenet, when using Azure CNI the Azure platform can automatically create and configure the virtual network resources when you create an AKS cluster, or you can manually create and configure the virtual network resources and attach to those resources at creation time. Making changes to Azure-managed network resources is unsupported.
