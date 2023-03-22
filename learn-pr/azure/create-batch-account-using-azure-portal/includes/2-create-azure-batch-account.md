Azure Batch runs large-scale applications efficiently in the cloud. You can schedule compute-intensive tasks and dynamically adjust resources for your solution without managing infrastructure. Azure Batch can create and manage a pool of compute nodes (virtual machines, or VMs), install the application that you want to run, and schedule jobs to run on the compute nodes.

You can use Azure Batch to build a software as a service (SaaS) application or client application where large-scale execution is required. For example, you can use Batch to build a service that runs a Monte Carlo simulation for a financial services company or a service to process many images.

## How Azure Batch works

As shown in the following diagram, a typical real-world scenario for Azure Batch requires data and application files. The Batch workflow begins with uploading the data and application files to an Azure storage account. Based on the demand, you create a Batch pool with as many Windows or Linux virtual compute nodes as needed. If the demand increases, compute nodes can be autoscaled.

:::image type="content" source="../media/2-diagram-1.png" alt-text="A diagram that outlines how a service can use Batch as its compute platform, and how Batch interacts with other Azure services, like Azure Storage.":::

You can think of the diagram in two parts: 

- Your service
- Batch as the compute platform behind it 

Your service uses Azure as the platform for both completing computationally intensive work via Batch and retrieving results via Azure Storage. Behind the scenes, pools are collections of virtual machines. Pools are the resources that jobs and tasks are executed on. 

Batch uses Azure Storage to fetch applications or data needed to complete a task on a virtual machine and then write task output. Your service can monitor jobs and task progress via Batch APIs. Your service can then retrieve results from Azure Storage after jobs and tasks are completed.

## Creation of an Azure Batch pool in a virtual network

To run a Batch job, you need to add a pool to your Batch account. A pool contains compute nodes, which are required to run your Batch job. Compute nodes are virtual machines that process the tasks that compose a job. At the time of creation, you can specify the number, size, and operating system of nodes based on the demand.

The Batch service needs to communicate to a Batch node agent that runs on each pool node. For example, the service instructs the node agent to run a task, stop a task, or get the files for a task. One or more load balancers enable communication with the pool node agent. The number of load balancers depends on the number of nodes in a pool. 

A load balancer forwards the communication to the desired pool node. Each node is addressed by a unique port number. By default, the load balancers have public IP addresses associated with them. 

It's also possible to remotely access pool nodes via RDP or SSH, which are enabled by default. Again, communication is via the load-balancer endpoints.

When you create an Azure Batch pool, you can provision the pool in a subnet of a specified Azure virtual network. Compute nodes in a pool can communicate with each other to multi-instance tasks without requiring a separate virtual network. By default, endpoints with public IP addresses are used to communicate with Batch accounts, Batch pools, and pool nodes.

## Azure virtual networks and subnets

A virtual network is the fundamental building block for your private network in Azure. Virtual networks enable many types of Azure resources, such as virtual machines, to securely communicate each other, the internet, and on-premises networks. 

A virtual network is similar to a traditional network that you'd operate in your own datacenter. But it brings more benefits of the Azure infrastructure, such as scale, availability, and isolation.

Key scenarios that you can accomplish with a virtual network include: 

- Communication of Azure resources with the internet
- Communication between Azure resources
- Communication with on-premises resources
- Filtering network traffic
- Routing network traffic
- Integration with Azure services

A subnet is a range of IP addresses in the virtual network. You can divide a virtual network into multiple subnets for organization and security. When you set up a virtual network, you specify the topology, including the available address spaces and subnets. If the virtual network will be connected to other virtual network or on-premises networks, you must select address ranges that don't overlap.

There's no security boundary between subnets, so VMs in each subnet can talk to one another. But you can set up network security groups, which allow you to control the traffic flow to and from subnets and VMs.
