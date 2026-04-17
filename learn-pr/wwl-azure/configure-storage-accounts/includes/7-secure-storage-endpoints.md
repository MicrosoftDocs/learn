In the Azure portal, each Azure service requires certain steps to configure the service endpoints and restrict network access.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=a877ed25-bfb0-4552-a35a-563cb7a67061]

To access these settings for your storage account, you use the **Firewalls and virtual networks** settings. You add the virtual networks that should have access to the service for the account. - This setting restricts access to your storage account from specific subnets on virtual networks or public IPs.

:::image type="content" source="../media/secure-storage-access-d32868ef.png" alt-text="Screenshot of the Storage Account Firewalls and virtual networks settings in the Azure portal.":::

The service endpoints for a storage account provide the base URL for any blob, queue, table, or file object in Azure Storage. Use this base URL to construct the address for any given resource.

:::image type="content" source="../media/service-endpoints-portal-lrg.png" alt-text="Screenshot of the service endpoint URLs in the Azure portal.":::


### Things to know about configuring service endpoints

Here are some points to consider about configuring service access settings:

- You can configure the service to allow access to one or more public IP ranges.

- Subnets and virtual networks must exist in the same Azure region or region pair as your storage account.

> [!Important]
> Be sure to test the service endpoint and verify the endpoint limits access as expected.

### Things to know about configuring private endpoints

In addition to service endpoints, Azure Storage supports private endpoints for enhanced security and network isolation. Private endpoints are the recommended approach for production workloads requiring secure access.

A private endpoint uses a private IP address from your virtual network to bring the Azure Storage service into your VNet. All traffic between your VNet and the storage service goes over the Microsoft backbone network, eliminating exposure to the public internet.

**Key differences from service endpoints**

- Private endpoints assign a private IP from your VNet to the storage account, keeping all traffic within the Microsoft backbone. Use private endpoints for production workloads requiring complete network isolation and compliance requirements
  
- Service endpoints keep the storage account on its public endpoint but restrict access to specific VNets and subnets. Use service endpoints for development scenarios or when you need simpler configuration with some public internet access



> [!TIP]
> Learn more with the [*Secure and isolate access to Azure resources by using network security groups and service endpoints*](/training/modules/secure-and-isolate-with-nsg-and-service-endpoints/) training module. This module has a sandbox where you can restrict access to Azure Storage by using service endpoints.
