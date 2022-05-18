Accommodating the development of several features in a limited IP address space can be challenging. Kubenet is designed with the conservation of address space in mind, making it a great choice for development or experimental environments.

Bear in mind that there are still several factors that can prevent kubenet from being an acceptable networking option. If one or more of the following aren't true, you may want to consider opting for a development environment using Azure CNI networking:

* Experimental or in-development features don't need the rapid scaling capabilities that Virtual Nodes with Azure Container Instances provide.
* Minor latency in the environment, caused by an extra hop for pod communication, is acceptable.
* The operational overhead of maintaining route tables and UDRs in the development environment is acceptable.
* The development environment will make use of Linux-based node pools only.

With kubenet, the Azure platform can automatically create and configure the virtual network resources when you create an AKS cluster, or you can manually create and configure the virtual network resources and attach to those resources at creation time. Making changes to Azure-managed network resources is unsupported.
