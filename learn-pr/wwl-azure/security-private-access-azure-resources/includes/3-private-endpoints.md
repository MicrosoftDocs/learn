A private endpoint is a network interface that uses a private IP address from your virtual network. This network interface connects you privately and securely to a service that's powered by Azure Private Link. By enabling a private endpoint, you're bringing the service into your virtual network.

The service could be an Azure service such as:<br>

 -  Azure Storage<br>
 -  Azure Cosmos DB
 -  Azure SQL Database
 -  Your own service, using Private Link service.

## Private endpoint properties

A private endpoint specifies the following properties:

| **Property**               | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Name                       | A unique name within the resource group.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Subnet                     | The subnet to deploy, where the private IP address is assigned.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| Private-link resource      | The private-link resource to connect by using a resource ID or alias, from the list of available types. A unique network identifier is generated for all traffic that's sent to this resource.                                                                                                                                                                                                                                                                                                                                                                                                                               |
| Target subresource         | The subresource to connect. Each private-link resource type has various options to select based on preference.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| Connection approval method | Automatic or manual. Depending on the Azure role-based access control permissions, your private endpoint can be approved automatically. If you're connecting to a private-link resource without Azure role based permissions, use the manual method to allow the owner of the resource to approve the connection.                                                                                                                                                                                                                                                                                                            |
| Request message            | You can specify a message for requested connections to be approved manually. This message can be used to identify a specific request.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| Connection status          | A read-only property that specifies whether the private endpoint is active. Only private endpoints in an approved state can be used to send traffic. More available states:  *Approved*: The connection was automatically or manually approved and is ready to be used.  *Pending*: The connection was created manually and is pending approval by the private-link resource owner.  *Rejected*: The connection was rejected by the private-link resource owner.  *Disconnected*: The connection was removed by the private-link resource owner. The private endpoint becomes informative and should be deleted for cleanup. |

As you're creating private endpoints, consider the following:

 -  Private endpoints enable connectivity between the customers from the same:<br>
     -  Virtual network<br>
     -  Regionally peered virtual networks
     -  Globally peered virtual networks
     -  On-premises environments that use VPN or Express Route
     -  Services that are powered by Private Link
 -  Network connections can be initiated only by clients that are connecting to the private endpoint. Service providers don't have a routing configuration to create connections into service customers. Connections can be established in a single direction only.
 -  A read-only network interface is automatically created for the lifecycle of the private endpoint. The interface is assigned a dynamic private IP address from the subnet that maps to the private-link resource. The value of the private IP address remains unchanged for the entire lifecycle of the private endpoint.<br>
 -  The private endpoint must be deployed in the same region and subscription as the virtual network.<br>
 -  The private-link resource can be deployed in a different region than the one for the virtual network and private endpoint.<br>
 -  Multiple private endpoints can be created with the same private-link resource. For a single network using a common DNS server configuration, the recommended practice is to use a single private endpoint for a specified private-link resource. Use this practice to avoid duplicate entries or conflicts in DNS resolution.<br>
 -  Multiple private endpoints can be created on the same or different subnets within the same virtual network. There are limits to the number of private endpoints you can create in a subscription.<br>
 -  The subscription that contains the private link resource must be registered with the Microsoft network resource provider. The subscription that contains the private endpoint must also be registered with the Microsoft network resource provider.<br>

## Network security of private endpoints

When you use private endpoints, traffic is secured to a private-link resource. The platform validates network connections, allowing only those that reach the specified private-link resource. To access more subresources within the same Azure service, more private endpoints with corresponding targets are required. In the case of Azure Storage, for instance, you would need separate private endpoints to access the file and blob subresources.

Private endpoints provide a privately accessible IP address for the Azure service, but do not necessarily restrict public network access to it. All other Azure services require additional access controls, however. These controls provide an extra network security layer to your resources, providing protection that helps prevent access to the Azure service associated with the private-link resource.<br>

Private endpoints support network policies. Network policies enable support for Network Security Groups (NSG), User Defined Routes (UDR), and Application Security Groups (ASG).

Over a private-endpoint connection, a private-link resource owner can:

 -  Review all private-endpoint connection details.<br>
 -  Approve a private-endpoint connection. The corresponding private endpoint is enabled to send traffic to the private-link resource.
 -  Reject a private-endpoint connection. The corresponding private endpoint is updated to reflect the status.
 -  Delete a private-endpoint connection in any state. The corresponding private endpoint is updated with a disconnected state to reflect the action. The private-endpoint owner can delete only the resource at this point.

## Access to a private-link resource using approval workflow

You can connect to a private-link resource by using the following connection approval methods:

**Automatically approve**: Use this method when you own or have permissions for the specific private-link resource. The required permissions are based on the private-link resource type in the following format:<br>

`Microsoft.<Provider>/<resource_type>/privateEndpointConnectionsApproval/action`<br>

**Manually request**: Use this method when you don't have the required permissions and want to request access. An approval workflow is initiated. The private endpoint and later private-endpoint connections are created in a *Pending* state. The private-link resource owner is responsible to approve the connection. After it's approved, the private endpoint is enabled to send traffic normally, as shown in the following approval workflow diagram:<br>

:::image type="content" source="../media/private-link-workflow-2f1e37e7.png" alt-text="Diagram showing an example of a private link platform as a service workflow.":::


Over a private-endpoint connection, a private-link resource owner can:

 -  Review all private-endpoint connection details.<br>
 -  Approve a private-endpoint connection. The corresponding private endpoint is enabled to send traffic to the private-link resource.
 -  Reject a private-endpoint connection. The corresponding private endpoint is updated to reflect the status.
 -  Delete a private-endpoint connection in any state. The corresponding private endpoint is updated with a disconnected state to reflect the action. The private-endpoint owner can delete only the resource at this point.

> [!NOTE]
> Only private endpoints in an *Approved* state can send traffic to a specified private-link resource.

## Connect by using an alias

An alias is a unique moniker that's generated when a service owner creates a private-link service behind a standard load balancer. Service owners can share this alias offline with consumers of your service.

The consumers can request a connection to a private-link service by using either the resource Uniform Resource Identifier (URI) or the alias. To connect by using the alias, create a private endpoint by using the manual connection approval method. To use the manual connection approval method, set the manual request parameter to True during the private-endpoint create flow.

> [!NOTE]
> This manual request can be auto approved if the consumer's subscription is allow-listed on the provider side.

## DNS configuration

The DNS settings that you use to connect to a private-link resource are important. Existing Azure services might already have a DNS configuration you can use when you're connecting over a public endpoint. To connect to the same service over private endpoint, separate DNS settings, often configured via private DNS zones, are required. Ensure that your DNS settings are correct when you use the fully qualified domain name (FQDN) for the connection. The settings must resolve to the private IP address of the private endpoint.

The network interface associated with the private endpoint contains the information that's required to configure your DNS. The information includes the FQDN and private IP address for a private-link resource.

## Limitations

The following information lists the known limitations to the use of private endpoints:

## Static IP address

| **Limitation**                                         | **Description**                                                                                                                           |
| ------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Static IP address configuration currently unsupported. | Azure Kubernetes Service (AKS)<br>Azure Application Gateway<br>HDInsight<br>Recovery Services Vaults<br>Third party Private Link services |

## Network security group

| **Limitation**                                                                          | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| --------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Effective routes and security rules unavailable for private endpoint network interface. | Effective routes and security rules won't be displayed for the private endpoint NIC in the Azure portal.                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| NSG flow logs unsupported.                                                              | NSG flow logs unavailable for inbound traffic destined for a private endpoint.                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| No more than 50 members in an Application Security Group.                               | Fifty is the number of IP Configurations that can be tied to each respective ASG that's coupled to the NSG on the private endpoint subnet. Connection failures may occur with more than 50 members.                                                                                                                                                                                                                                                                                                                                              |
| Destination port ranges supported up to a factor of 250 K.                              | Destination port ranges are supported as a multiplication SourceAddressPrefixes, DestinationAddressPrefixes, and DestinationPortRanges.<br><br>Example inbound rule:<br>One source \* one destination \* 4K portRanges = 4K Valid<br>10 sources \* 10 destinations \* 10 portRanges = 1 K Valid<br>50 sources \* 50 destinations \* 50 portRanges = 125 K Valid<br>50 sources \* 50 destinations \* 100 portRanges = 250 K Valid<br>100 sources \* 100 destinations \* 100 portRanges = 1M Invalid, NSG has too many sources/destinations/ports. |
| Source port filtering is interpreted as \*                                              | Source port filtering isn't actively used as valid scenario of traffic filtering for traffic destined to a private endpoint.                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Feature unavailable in select regions.                                                  | Currently unavailable in the following regions:<br>West India<br>Australia Central 2<br>South Africa West<br>Brazil Southeast<br>All Government regions<br>All China regions                                                                                                                                                                                                                                                                                                                                                                     |

## NSG more considerations

 -  Outbound traffic denied from a private endpoint isn't a valid scenario, as the service provider can't originate traffic.
 -  The following services may require all destination ports to be open when using a private endpoint and adding NSG security filters:<br>
     -  Azure Cosmos DB<br>

## UDR

| **Limitation**                         | **Description**                                                                                                                                                     |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| SNAT is recommended always.            | Due to the variable nature of the private endpoint data-plane, it's recommended to SNAT traffic destined to a private endpoint to ensure return traffic is honored. |
| Feature unavailable in select regions. | Currently unavailable in the following regions:<br>West India<br>Australia Central 2<br>South Africa West<br>Brazil Southeast                                       |

## Application security group

| **Limitation**                         | **Description**                                                                                                               |
| -------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| Feature unavailable in select regions. | Currently unavailable in the following regions:<br>West India<br>Australia Central 2<br>South Africa West<br>Brazil Southeast |
