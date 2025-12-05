A [public IP address](/azure/virtual-network/ip-services/public-ip-addresses) resource can be associated with virtual machine network interfaces, internet-facing load balancers, VPN gateways, and application gateways. You can associate your resource with both dynamic and static public IP addresses.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=8124baac-6dbd-4bc3-97b1-3693b3b465c0]

> [!IMPORTANT]
> On September 30, 2025, Basic SKU public IPs were retired. For more information, see the [official announcement](https://azure.microsoft.com/updates?id=upgrade-to-standard-sku-public-ip-addresses-in-azure-by-30-september-2025-basic-sku-will-be-retired).

### Things to consider when associating public IP addresses

The next table summarizes how you can associate public IP addresses for different types of resources.

| Top-level resource | IP address configuration |
| --- | --- | 
| Virtual machine | Network interface configuration | 
| Virtual Network Gateway (VPN), Virtual Network Gateway (ER), NAT Gateway | Gateway IP configuration | 
| Public Load Balancer, Application Gateway, Azure Firewall, Route Server, API Management | Front-end configuration | 
| Bastion host | Public IP configuration | 

#### Public IP address SKU features

The next table summarizes the standard SKU features. 

| Public IP address | Standard SKU |
| --- | --- | 
| Allocation method | Static | 
| Security | Secure by default model  | 
| Available zones | Supported. Standard IPs can be nonzonal, zonal, or zone-redundant.| 



