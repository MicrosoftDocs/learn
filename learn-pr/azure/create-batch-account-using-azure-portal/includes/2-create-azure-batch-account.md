Azure Batch runs large-scale applications efficiently in the cloud. You can schedule compute-intensive tasks and dynamically adjust resources for your solution without managing infrastructure. Azure Batch can create and manage a pool of compute nodes (virtual machines), install the application you want to run, and schedule jobs to run on the compute nodes.

Azure Batch can be used as a platform service to build SaaS application or client application where large-scale execution is required. For example, you can build a service with Batch to run a Monte Carlo simulation for a financial services company or a service to process many images.

## How Azure Batch works

As shown in the graphic below, a typical real-world scenario for Azure Batch will require data and application files. The Batch workflow begins by uploading the data and application files to an Azure storage account. Based on the demand, you create a Batch pool with as many as Windows or Linux virtual compute nodes as needed. If the demand increases, compute nodes can be auto scaled.

:::image type="content" source="../media/2-diagram-1.png" alt-text="A diagram outlining how a service can use Batch as its compute platform behind-the-scenes, and how Batch interacts with other Azure services, like storage.":::

The diagram above is best understood by thinking of it in two parts: (1) your service/application and (2) Batch as the compute platform behind it. Your service uses Azure as the platform for both completing computationally-intensive work via Batch and retrieving results via Azure storage. Behind the scenes, pools---the resources which jobs and tasks are executed on---are a collection of virtual machines. Batch uses Azure storage to (A) fetch applications or data needed to complete a task on a virtual machine and (B) write task output. Your service/application can monitor job and task progress via Batch APIs and retrieve results from Azure storage once jobs and tasks are completed.

## Create an Azure Batch pool in a virtual network

To run a Batch job, we need to add a pool to our Batch account. A pool contains compute nodes, which are required to run your Batch job. Compute nodes are virtual machines that process the tasks which comprise a job. At the time of creation, you can specify the number, size and operating system of nodes based on the demand.

The Batch service needs to communicate to a Batch node agent that runs on each pool node. For example, the service instructs the node agent to run a task, stop a task, or get the files for a task. Communication with the pool node agent is enabled by one or more load-balancers, the number of which depends on the number of nodes in a pool. The load-balancer forwards the communication to the desired pool node, with each node being addressed by a unique port number. By default, the load-balancers have public IP addresses associated with them. It is also possible to remotely access pool nodes via RDP or SSH, which are enabled by default. Again, communication is via the load-balancer endpoints.

When you create an Azure Batch pool, you can provision the pool in a subnet of a specified Azure virtual network (VNet). Compute nodes in a pool can communicate with each other in order to multi-instance tasks without requiring a separate VNet. By default, endpoints with public IP addresses are used to communicate with Batch accounts, Batch pools, and pool nodes.

## Azure Virtual Network and subnets

Virtual networks (VNets) are the fundamental building block for your private network in Azure. VNet enables many types of Azure resources, such as Azure Virtual Machines (VM), to securely communicate each other, the internet and on-premises networks. VNet is similar to a traditional network that you'd operate in your own data center, but brings with it the additional benefits of Azure's infrastructure such as scale, availability and isolation.

VNet enables Azure resources to securely communicate with each other, the internet, and on-premises networks. Key scenarios that you can accomplish with a virtual network include: communication of Azure resources with the internet, communication between Azure resources, communication with on-premises resources, filtering network traffic, routing network traffic, and integration with Azure services.

A subnet is a range of IP addresses in the VNet. You can divide a VNet into multiple subnets for organization and security. When you setup a VNet, you specify the topology, including the available address spaces and subnets. If the VNet is to be connected to other VNet or on-premises networks, you must select address ranges that don't overlap.

There is no security boundary between subnets, so VMs in each of these subnets can talk to one another. However, you can set up Network Security Groups (NSGs), which allow you to control the traffic flow to and from subnets and VMs.

## Batch account private endpoints

Azure Private Link enables access to Azure PaaS Services and Azure hosted customer-owned/partner services over a private endpoint in your virtual network. Private Link restricts access to a Batch account from within the virtual network or from any peered virtual network. Resources mapped to Private Link are also accessible on-premises over private peering through VPN or Azure ExpressRoute.

To use private endpoints, a Batch account needs to be configured appropriately when created; public network access configuration must be disabled. Once created, private endpoints can be created and associated with the Batch account.

By default, a private endpoint is an ARM resource. An ARM template defines the infrastructure and configuration that are required for deployment, without writing a sequence of programming commands. ARM template deployment helps to create the virtual network, the web app, the private endpoint and the private DNS zone.
