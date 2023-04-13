You've migrated your existing app and database servers for your ERP system to Azure as VMs. Now, to reduce your costs and administrative requirements, you're considering using some Azure platform as a service (PaaS) services. Storage services will hold certain large file assets, such as engineering diagrams. These engineering diagrams have proprietary information, and must remain secure from unauthorized access. These files must only be accessible from specific systems.

In this unit, you'll look at how to use virtual network service endpoints for securing supported Azure services.

## What is a virtual network service endpoint?

Use virtual network service endpoints to extend your private address space in Azure by providing a direct connection to your Azure services. Service endpoints let you secure your Azure resources to only your virtual network. Service traffic will remain on the Azure backbone, and doesn't go out to the internet.

:::image type="content" source="../media/service-endpoint-e15a99ae.png" alt-text="image showing web server, database server, and service endpoint within a v-net. A link is shown to from the service endpoint to Azure storage outside the v-net.":::

By default, Azure services are all designed for direct internet access. All Azure resources have public IP addresses, including PaaS services such as Azure SQL Database and Azure Storage. Because these services are exposed to the internet, anyone can potentially access your Azure services.

Service endpoints can connect certain PaaS services directly to your private address space in Azure, so they act like they’re on the same virtual network. Use your private address space to access the PaaS services directly. Adding service endpoints doesn't remove the public endpoint. It simply provides a redirection of traffic.

## Preparing to Implement Service Endpoints

To enable a Service Endpoint, you must do the following two things:

 -  Turn off public access to the service.
 -  Add the Service Endpoint to a virtual network.

When you enable a Service Endpoint, you restrict the flow of traffic, and enable your Azure VMs to access the service directly from your private address space. Devices cannot access the service from a public network. On a deployed VM vNIC, if you look at Effective routes, you'll notice the Service Endpoint as the Next Hop Type.

This is an example route table, before enabling a Service Endpoint:

| **SOURCE** | **STATE** | **ADDRESS PREFIXES** | **NEXT HOP TYPE** |
|:----------:|:---------:|:--------------------:|:-----------------:|
|  Default   |  Active   |     10.1.1.0/24      |       VNet        |
|  Default   |  Active   |      0.0.0.0./0      |     Internet      |
|  Default   |  Active   |      10.0.0.0/8      |       None        |
|  Default   |  Active   |     100.64.0.0./     |       None        |
|  Default   |  Active   |    192.168.0.0/16    |       None        |

And here's an example route table after you've added two Service Endpoints to the virtual network:

| **SOURCE** | **STATE** |  **ADDRESS PREFIXES**   |       **NEXT HOP TYPE**       |
|:----------:|:---------:|:-----------------------:|:-----------------------------:|
|  Default   |  Active   |       10.1.1.0/24       |             VNet              |
|  Default   |  Active   |       0.0.0.0./0        |           Internet            |
|  Default   |  Active   |       10.0.0.0/8        |             None              |
|  Default   |  Active   |      100.64.0.0./       |             None              |
|  Default   |  Active   |     192.168.0.0/16      |             None              |
|  Default   |  Active   | 20.38.106.0/23, 10 more | VirtualNetworkServiceEndpoint |
|  Default   |  Active   |  20.150.2.0/23, 9 more  | VirtualNetworkServiceEndpoint |

All traffic for the service now is routed to the Virtual Network Service Endpoint and remains internal to Azure.

## Create Service Endpoints

As the network engineer, you're planning to move sensitive engineering diagram files into Azure Storage. The files must only be accessible from computers inside the corporate network. You want to create a virtual network Service Endpoint for Azure Storage to secure the connectivity to your storage accounts.

In the [service endpoint tutorial](/azure/virtual-network/tutorial-restrict-network-access-to-resources) you will learn how to:

- Enable a service endpoint on a subnet
- Use network rules to restrict access to Azure Storage
- Create a virtual network service endpoint for Azure Storage
- Verify that access is denied appropriately

:::image type="content" source="../media/exercise-task-723aea52.png" alt-text="Diagram showing data server accessing Azure storage with service endpoint" lightbox="../media/exercise-task-723aea52.png":::


## Configure service tags

A service tag represents a group of IP address prefixes from a given Azure service. Microsoft manages the address prefixes encompassed by the service tag and automatically updates the service tag as addresses change, minimizing the complexity of frequent updates to network security rules.

You can use service tags to define network access controls on network security groups or Azure Firewall. Use service tags in place of specific IP addresses when you create security rules. By specifying the service tag name, such as API Management, in the appropriate source or destination field of a rule, you can allow or deny the traffic for the corresponding service.

As of March 2021, you can also use Service Tags in place of explicit IP ranges in user defined routes. This feature is currently in Public Preview.

You can use service tags to achieve network isolation and protect your Azure resources from the general Internet while accessing Azure services that have public endpoints. Create inbound/outbound network security group rules to deny traffic to/from Internet and allow traffic to/from AzureCloud or other available service tags of specific Azure services.

:::image type="content" source="../media/service-tags-efcdf95b.png" alt-text="example NSG with service tags" lightbox="../media/service-tags-efcdf95b.png":::


## Available service tags

The following table includes all the service tags available for use in network security group rules.

The columns indicate whether the tag:

 -  Is suitable for rules that cover inbound or outbound traffic.
 -  Supports regional scope.
 -  Is usable in Azure Firewall rules.

By default, service tags reflect the ranges for the entire cloud. Some service tags also allow more granular control by restricting the corresponding IP ranges to a specified region. For example, the service tag Storage represents Azure Storage for the entire cloud, but Storage. WestUS narrows the range to only the storage IP address ranges from the WestUS region. The [following table](/azure/virtual-network/service-tags-overview#available-service-tags) indicates whether each service tag supports such regional scope.

Service tags of Azure services denote the address prefixes from the specific cloud being used. For example, the underlying IP ranges that correspond to the SQL tag value on the Azure Public cloud will be different from the underlying ranges on the Azure China cloud.

If you implement a virtual network Service Endpoint for a service, such as Azure Storage or Azure SQL Database, Azure adds a route to a virtual network subnet for the service. The address prefixes in the route are the same address prefixes, or CIDR ranges, as those of the corresponding service tag.
