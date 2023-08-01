
A private endpoint is a network interface that uses a private IP address from your virtual network. This network interface connects you privately and securely to a service that's powered by Azure Private Link. By enabling a private endpoint, you're bringing the service into your virtual network.

The service could be an Azure service such as:<br>

 -  Azure Storage<br>
 -  Azure Cosmos DB
 -  Azure SQL Database
 -  Your own service, using Private Link service.

## Private endpoint properties

:::image type="content" source="../media/private-endpoint-properties-example-1c0d28c3.jpg" alt-text="Screenshot showing private endpoint properties.":::
 As you're creating private endpoints, consider the following:

 -  Private endpoints enable connectivity between the customers from the same:
    
    
     -  Virtual network
     -  Regionally peered virtual networks
     -  Globally peered virtual networks
     -  On-premises environments that use VNP or Express Route.
     -  Services that are powered by Private Link
 -  Network connections can be initiated only by clients that are connecting to the private endpoint. Service providers don't have a routing configuration to create connections into service customers. Connections can be established in a single direction only.
 -  A read-only network interface is *automatically created* for the lifecycle of the private endpoint. The interface is assigned a dynamic private IP address from the subnet that maps to the private-link resource. The value of the private IP address remains unchanged for the entire lifecycle of the private endpoint.
 -  The private endpoint must be deployed in the same region and subscription as the virtual network.
 -  The private-link resource can be deployed in a different region than the one for the virtual network and private endpoint.
 -  Multiple private endpoints can be created with the same private-link resource. For a single network using a common DNS server configuration, the recommended practice is to use a single private endpoint for a specified private-link resource. Use this practice to avoid duplicate entries or conflicts in DNS resolution.
 -  Multiple private endpoints can be created on the same or different subnets within the same virtual network. There are limits to the number of private endpoints you can create in a subscription.
 -  The subscription that contains the private link resource must be registered with the Microsoft network resource provider. The subscription that contains the private endpoint must also be registered with the Microsoft network resource provider.

You can create private endpoints only on a General Purpose v2 (GPv2) storage account.

## Network security of private endpoints

When you use private endpoints, traffic is secured to a private-link resource. The platform validates network connections, allowing only those that reach the specified private-link resource. To access more subresources within the same Azure service, more private endpoints with corresponding targets are required. In the case of Azure Storage, for instance, you would need separate private endpoints to access the *file* and *blob* subresources.

Private endpoints provide a privately accessible IP address for the Azure service, but do not necessarily restrict public network access to it. All other Azure services require additional access controls, however. These controls provide an extra network security layer to your resources, providing protection that helps prevent access to the Azure service associated with the private-link resource.<br>

Private endpoints support network policies. Network policies enable support for Network Security Groups (NSG), User Defined Routes (UDR), and Application Security Groups (ASG).
