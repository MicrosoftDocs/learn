A private endpoint is a network interface that uses a private IP address from your virtual network. This network interface connects you privately and securely to a service that's powered by Azure Private Link. By enabling a private endpoint, you're bringing the service into your virtual network.

The service could be an Azure service such as:<br>

 -  Azure Storage<br>
 -  Azure Cosmos DB
 -  Azure SQL Database
 -  Your own service, using Private Link service.

> [!NOTE]
> You can create private endpoints only on a General Purpose v2 (GPv2) storage account.

## Network security of private endpoints

When you use private endpoints, traffic is secured to a private-link resource. The platform validates network connections, allowing only those that reach the specified private-link resource. To access more subresources within the same Azure service, more private endpoints with corresponding targets are required. In the case of Azure Storage, for instance, you would need separate private endpoints to access the file and blob subresources.

Private endpoints provide a privately accessible IP address for the Azure service, but do not necessarily restrict public network access to it. All other Azure services require additional access controls, however. These controls provide an extra network security layer to your resources, providing protection that helps prevent access to the Azure service associated with the private-link resource.<br>

Private endpoints support network policies. Network policies enable support for Network Security Groups (NSG), User Defined Routes (UDR), and Application Security Groups (ASG). For more information about enabling network policies for a private endpoint, see Manage network policies for private endpoints.

Over a private-endpoint connection, a private-link resource owner can:

 -  Review all private-endpoint connection details.<br>
 -  Approve a private-endpoint connection. The corresponding private endpoint is enabled to send traffic to the private-link resource.
 -  Reject a private-endpoint connection. The corresponding private endpoint is updated to reflect the status.
 -  Delete a private-endpoint connection in any state. The corresponding private endpoint is updated with a disconnected state to reflect the action. The private-endpoint owner can delete only the resource at this point.

## Connect by using an alias

An alias is a unique moniker that's generated when a service owner creates a private-link service behind a standard load balancer. Service owners can share this alias offline with consumers of your service.

The consumers can request a connection to a private-link service by using either the resource URI or the alias. To connect by using the alias, create a private endpoint by using the manual connection approval method. To use the manual connection approval method, set the manual request parameter to True during the private-endpoint create flow.

## DNS configuration

The DNS settings that you use to connect to a private-link resource are important. Existing Azure services might already have a DNS configuration you can use when you're connecting over a public endpoint. To connect to the same service over private endpoint, separate DNS settings, often configured via private DNS zones, are required. Ensure that your DNS settings are correct when you use the fully qualified domain name (FQDN) for the connection. The settings must resolve to the private IP address of the private endpoint.

The network interface associated with the private endpoint contains the information that's required to configure your DNS. The information includes the FQDN and private IP address for a private-link resource.

## Limitations

The following information lists the known limitations to the use of private endpoints:

## Static IP address

| **Limitation**                                         | **Description**                                                                                                                            |
| ------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------ |
| Static IP address configuration currently unsupported. | Azure Kubernetes Service (AKS)<br>Azure Application Gateway<br>HD Insight<br>Recovery Services Vaults<br>Third party Private Link services |

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
