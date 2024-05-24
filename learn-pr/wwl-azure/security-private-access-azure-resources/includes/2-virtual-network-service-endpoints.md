Virtual Network (VNet) service endpoint provides secure and direct connectivity to Azure services over an optimized route over the Azure backbone network. Endpoints allow you to secure your critical Azure service resources to only your virtual networks. Service Endpoints enables private IP addresses in the VNet to reach the endpoint of an Azure service without needing a public IP address on the VNet.

> [!NOTE]
> Microsoft recommends use of Azure Private Link and private endpoints for secure and private access to services hosted on the Azure platform. Azure Private Link provisions a network interface into a virtual network of your choosing for Azure services such as Azure Storage or Azure SQL. For more information, see [Azure Private Link](/azure/private-link/private-link-overview) and [What is a private endpoint?](/azure/private-link/private-endpoint-overview).

Service endpoints are available for the following Azure services and regions. The *Microsoft.\** resource is in parenthesis. Enable this resource from the subnet side while configuring service endpoints for your service:

## **Generally available**

 -  [Azure Storage](/azure/storage/common/storage-network-security?toc=/azure/virtual-network/toc.json#grant-access-from-a-virtual-network) (*Microsoft.Storage*): Generally available in all Azure regions.
 -  [Azure Storage cross-region service endpoints](/azure/storage/common/storage-network-security?toc=/azure/virtual-network/toc.json#azure-storage-cross-region-service-endpoints) (*Microsoft.Storage.Global*): Generally available in all Azure regions.
 -  [Azure SQL Database](/azure/azure-sql/database/vnet-service-endpoint-rule-overview?toc=%2fazure%2fvirtual-network%2ftoc.json) (*Microsoft.Sql*): Generally available in all Azure regions.
 -  [Azure Synapse Analytics](/azure/azure-sql/database/vnet-service-endpoint-rule-overview?toc=%2fazure%2fvirtual-network%2ftoc.json) (*Microsoft.Sql*): Generally available in all Azure regions for dedicated SQL pools (formerly SQL DW).
 -  [Azure Database for PostgreSQL server](/azure/postgresql/howto-manage-vnet-using-portal?toc=/azure/virtual-network/toc.json) (*Microsoft.Sql*): Generally available in Azure regions where database service is available.
 -  [Azure Database for MySQL server](/azure/mysql/howto-manage-vnet-using-portal?toc=/azure/virtual-network/toc.json) (*Microsoft.Sql*): Generally available in Azure regions where database service is available.
 -  [Azure Database for MariaDB](/azure/mariadb/concepts-data-access-security-vnet) (*Microsoft.Sql*): Generally available in Azure regions where database service is available.
 -  [Azure Cosmos DB](/azure/cosmos-db/how-to-configure-vnet-service-endpoint?toc=/azure/virtual-network/toc.json) (*Microsoft.AzureCosmosDB*): Generally available in all Azure regions.
 -  [Azure Key Vault](/azure/key-vault/general/overview-vnet-service-endpoints) (*Microsoft.KeyVault*): Generally available in all Azure regions.
 -  [Azure Service Bus](/azure/service-bus-messaging/service-bus-service-endpoints?toc=/azure/virtual-network/toc.json) (*Microsoft.ServiceBus*): Generally available in all Azure regions.
 -  [Azure Event Hubs](/azure/event-hubs/event-hubs-service-endpoints?toc=/azure/virtual-network/toc.json) (*Microsoft.EventHub*): Generally available in all Azure regions.
 -  [Azure App Service](/azure/app-service/app-service-ip-restrictions) (*Microsoft.Web*): Generally available in all Azure regions where App service is available.
 -  [Azure Cognitive Services](/azure/ai-services/cognitive-services-virtual-networks?tabs=portal) (*Microsoft.CognitiveServices*): Generally available in all Azure regions where Azure AI services are available.

## Key benefits

Service endpoints provide the following benefits:

 -  Improved security for your Azure service resources: VNet private address spaces can overlap. You can't use overlapping spaces to uniquely identify traffic that originates from your VNet. Service endpoints enable securing of Azure service resources to your virtual network by extending VNet identity to the service. Once you enable service endpoints in your virtual network, you can add a virtual network rule to secure the Azure service resources to your virtual network. The rule addition provides improved security by fully removing public internet access to resources and allowing traffic only from your virtual network.<br>
 -  Optimal routing for Azure service traffic from your virtual network:
     -  Today, any routes in your virtual network that force internet traffic to your on-premises and/or virtual appliances also force Azure service traffic to take the same route as the internet traffic. Service endpoints provide optimal routing for Azure traffic.<br>

    Endpoints always take service traffic directly from your virtual network to the service on the Microsoft Azure backbone network. Keeping traffic on the Azure backbone network allows you to continue auditing and monitoring outbound Internet traffic from your virtual networks, through forced-tunneling, without impacting service traffic. For more information, see [Secure Azure service access from on-premises](/azure/virtual-network/virtual-network-service-endpoints-overview#secure-azure-services-to-virtual-networks)<br>

 -  Simple to set up with less management overhead: You no longer need reserved, public IP addresses in your virtual networks to secure Azure resources through IP firewall. There is no Network Address Translation (NAT) or gateway devices required to set up the service endpoints. You can configure service endpoints through a single selection on a subnet. There's no extra overhead to maintaining the endpoints.<br>

## Limitations

 -  The feature is available only to virtual networks deployed through the Azure Resource Manager deployment model.
 -  Endpoints are enabled on subnets configured in Azure virtual networks. Endpoints can't be used for traffic from your on-premises services to Azure services. For more information, see [Secure Azure service access from on-premises](/azure/virtual-network/virtual-network-service-endpoints-overview#secure-azure-services-to-virtual-networks)
 -  For Azure SQL, a service endpoint applies only to Azure service traffic within a virtual network's region.
 -  For Azure Data Lake Storage (ADLS) Gen 1, the VNet Integration capability is only available for virtual networks within the same region. Also note that virtual network integration for ADLS Gen1 uses the virtual network service endpoint security between your virtual network and Microsoft Entra ID to generate extra security claims in the access token. These claims are then used to authenticate your virtual network to your Data Lake Storage Gen1 account and allow access. The Microsoft.Microsoft Entra ID tag listed under services supporting service endpoints is used only for supporting service endpoints to ADLS Gen 1. Microsoft Entra ID doesn't support service endpoints natively. For more information about Azure Data Lake Store Gen 1 VNet integration, see [Network security in Azure Data Lake Storage Gen1](/azure/data-lake-store/data-lake-store-network-security?toc=/azure/virtual-network/toc.json).
 -  A virtual network can be associated with up to 200 different subscriptions and regions by each supported service with active VNet rules configured.

## Secure Azure services to virtual networks

 -  A virtual network service endpoint provides the identity of your virtual network to the Azure service. Once you enable service endpoints in your virtual network, you can add a virtual network rule to secure the Azure service resources to your virtual network.
 -  Today, Azure service traffic from a virtual network uses public IP addresses as source IP addresses. With service endpoints, service traffic switches to use virtual network private addresses as the source IP addresses when accessing the Azure service from a virtual network. This switch allows you to access the services without the need for reserved, public IP addresses used in IP firewalls.

> [!NOTE]
> With service endpoints, the source IP addresses of the virtual machines in the subnet for service traffic switches from using public IPv4 addresses to using private IPv4 addresses. Existing Azure service firewall rules using Azure public IP addresses will stop working with this switch. Please ensure Azure service firewall rules allow for this switch before setting up service endpoints. You may also experience temporary interruption to service traffic from this subnet while configuring service endpoints.

## Secure Azure service access from on-premises

By default, Azure service resources secured to virtual networks aren't reachable from on-premises networks. If you want to allow traffic from on-premises, you must also allow public (typically, NAT) IP addresses from your on-premises or ExpressRoute. You can add these IP addresses through the IP firewall configuration for Azure service resources.

ExpressRoute: If you're using [ExpressRoute](/azure/expressroute/expressroute-introduction?toc=/azure/virtual-network/toc.json) for public peering or Microsoft peering from your premises, you'll need to identify the NAT IP addresses that you're using. For public peering, each ExpressRoute circuit uses two NAT IP addresses, by default, applied to Azure service traffic when the traffic enters the Microsoft Azure network backbone. For Microsoft peering, the NAT IP addresses are either customer provided or provided by the service provider. To allow access to your service resources, you must allow these public IP addresses in the resource IP firewall setting. To find your public peering ExpressRoute circuit IP addresses, [open a support ticket with ExpressRoute](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview) via the Azure portal. For more information about NAT for ExpressRoute public and Microsoft peering, see [ExpressRoute NAT requirements](/azure/expressroute/expressroute-nat?toc=/azure/virtual-network/toc.json#nat-requirements-for-azure-public-peering).

:::image type="content" source="../media/virtual-network-service-endpoints-d0502250.png" alt-text="Diagram showing how to secure Azure service resources from on-premises networks.":::
<br>

## Configuration

 -  Configure service endpoints on a subnet in a virtual network. Endpoints work with any type of compute instances running within that subnet.
 -  You can configure multiple service endpoints for all supported Azure services (Azure Storage or Azure SQL Database, for example) on a subnet.
 -  For Azure SQL Database, virtual networks must be in the same region as the Azure service resource. For all other services, you can secure Azure service resources to virtual networks in any region.
 -  The virtual network where the endpoint is configured can be in the same or different subscription than the Azure service resource. For more information on permissions required for setting up endpoints and securing Azure services, see [Provisioning](/azure/virtual-network/virtual-network-service-endpoints-overview#provisioning).
 -  For supported services, you can secure new or existing resources to virtual networks using service endpoints.

## Considerations

 -  After enabling a service endpoint, the source IP addresses switch from using public IPv4 addresses to using their private IPv4 address when communicating with the service from that subnet. Any existing open TCP connections to the service are closed during this switch. Ensure that no critical tasks are running when enabling or disabling a service endpoint to a service for a subnet. Also, ensure that your applications can automatically connect to Azure services after the IP address switch.

    The IP address switch only impacts service traffic from your virtual network. There's no impact to any other traffic addressed to or from the public IPv4 addresses assigned to your virtual machines. For Azure services, if you have existing firewall rules using Azure public IP addresses, these rules stop working with the switch to virtual network private addresses.<br>

 -  With service endpoints, DNS entries for Azure services remain as-is today and continue to resolve to public IP addresses assigned to the Azure service.<br>
 -  Network security groups (NSGs) with service endpoints:<br>
     -  By default, NSGs allow outbound internet traffic and also allow traffic from your VNet to Azure services. This traffic continues to work with service endpoints as is.<br>
     -  If you want to deny all outbound internet traffic and allow only traffic to specific Azure services, you can do so using [service tags](/azure/virtual-network/network-security-groups-overview#service-tags) in your NSGs. You can specify supported Azure services as destination in your NSG rules and Azure also provides the maintenance of IP addresses underlying each tag. For more information, see [Azure Service tags for NSGs.](/azure/virtual-network/network-security-groups-overview#service-tags)

## Scenarios

 -  Peered, connected, or multiple virtual networks: To secure Azure services to multiple subnets within a virtual network or across multiple virtual networks, you can enable service endpoints on each of the subnets independently, and secure Azure service resources to all of the subnets.
 -  Filtering outbound traffic from a virtual network to Azure services: If you want to inspect or filter the traffic sent to an Azure service from a virtual network, you can deploy a network virtual appliance within the virtual network. You can then apply service endpoints to the subnet where the network virtual appliance is deployed, and secure Azure service resources only to this subnet. This scenario might be helpful if you want use network virtual appliance filtering to restrict Azure service access from your virtual network only to specific Azure resources. For more information, see [egress with network virtual appliances](/azure/architecture/reference-architectures/dmz/nva-ha).
 -  Securing Azure resources to services deployed directly into virtual networks: You can directly deploy various Azure services into specific subnets in a virtual network. You can secure Azure service resources to [managed service](/azure/virtual-network/virtual-network-for-azure-services) subnets by setting up a service endpoint on the managed service subnet.
 -  Disk traffic from an Azure virtual machine: Virtual Machine Disk traffic for managed and unmanaged disks isn't affected by service endpoints routing changes for Azure Storage. This traffic includes diskIO as well as mount and unmount. You can limit REST access to page blobs to select networks through service endpoints and [Azure Storage network rules](/azure/storage/common/storage-network-security?toc=/azure/virtual-network/toc.json).

## Logging and troubleshooting

Once you configure service endpoints to a specific service, validate that the service endpoint route is in effect by:

 -  Validating the source IP address of any service request in the service diagnostics. All new requests with service endpoints show the source IP address for the request as the virtual network private IP address, assigned to the client making the request from your virtual network. Without the endpoint, the address is an Azure public IP address.<br>
 -  Viewing the effective routes on any network interface in a subnet. The route to the service:
     -  Shows a more specific default route to address prefix ranges of each service
     -  Has a nextHopType of *VirtualNetworkServiceEndpoint*
     -  Indicates that a more direct connection to the service is in effect compared to any forced-tunneling routes

> [!NOTE]
> Service endpoint routes override any BGP routes for the address prefix match of an Azure service.

## Provisioning

Service endpoints can be configured on virtual networks independently by a user with write access to a virtual network. To secure Azure service resources to a VNet, the user must have permission to *Microsoft.Network/virtualNetworks/subnets/joinViaServiceEndpoint/action* for the added subnets. The built-in service administrator roles include this permission by default. You can modify the permission by creating custom roles.

For more information about built-in roles, see [Azure built-in roles](/azure/role-based-access-control/built-in-roles?toc=/azure/virtual-network/toc.json). For more information about assigning specific permissions to custom roles, see [Azure custom roles](/azure/role-based-access-control/custom-roles?toc=/azure/virtual-network/toc.json).

Virtual networks and Azure service resources can be in the same or different subscriptions. Certain Azure Services (not all) such as Azure Storage and Azure Key Vault also support service endpoints across different Microsoft Entra ID tenants. This means the virtual network and Azure service resource can be in different Microsoft Entra ID tenants.

## VNet service endpoint policies

VNet service endpoint policies allow you to filter virtual network traffic to Azure services. This filter allows only specific Azure service resources over service endpoints. Service endpoint policies provide granular access control for virtual network traffic to Azure services.

## Pricing and limits

There's no extra charge for using service endpoints. The current pricing model for Azure services (Azure Storage, Azure SQL Database, etc.) applies as-is today.

There's no limit on the total number of service endpoints in a virtual network.

Certain Azure services, such as Azure Storage Accounts, may enforce limits on the number of subnets used for securing the resource. Refer to the documentation for various services in the [Next steps](/azure/virtual-network/virtual-network-service-endpoints-overview#next-steps) section for details.

## VNet service endpoint policies

VNet service endpoint policies allow you to filter virtual network traffic to Azure services. This filter allows only specific Azure service resources over service endpoints. Service endpoint policies provide granular access control for virtual network traffic to Azure services. For more information, see [Virtual Network Service Endpoint Policies](/azure/virtual-network/virtual-network-service-endpoint-policies-overview).
