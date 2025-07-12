


## Choose a peering scheme

You can use two different peering schemes with ExpressRoute: **Private Peering** and **Microsoft Peering**. 

:::image type="content" source="../media/expressroute-peerings-31290ff8.png" alt-text="Diagram of ExpressRoute peering use cases.":::


- [**Private peering**](/azure/expressroute/expressroute-circuit-peerings#privatepeering). Private Peering is ideal for scenarios where you need secure, high-performance connectivity to Azure resources. Private peering allows you to connect on premises hosts with Azure IaaS and PaaS services configured to work with Azure virtual networks. All resources must be located in Azure virtual networks and allocated IP addresses in a private address space that doesn't overlap with your on-premises address space. You can’t connect to an Azure resource’s public IP address, such as an IaaS VM’s public IP address through private peering. 

- **[Microsoft peering](/azure/expressroute/expressroute-faqs#microsoft-peering)**. Microsoft Peering is suitable for accessing Microsoft SaaS and PaaS services. Microsoft peering allows you to connect over ExpressRoute with Azure PaaS services, Microsoft 365 services, and Dynamics 365. 

### Choose between Private peering and Microsoft peering 

This comparison table compares Private peering with Microsoft peering. 

| Feature                     | ExpressRoute Private Peering                  | ExpressRoute Microsoft Peering                |
|-----------------------------|-----------------------------------------------|-----------------------------------------------|
| **Purpose**                 | Connects directly to Azure virtual networks   | Connects to Microsoft services like Office 365, Dynamics 365, and Azure PaaS services |
| **Traffic Type**            | Private IP traffic                            | Public IP traffic                             |
| **Access**                  | Direct access to Azure VMs and services within virtual networks | Access to Microsoft SaaS services and Azure PaaS services |
| **Security**                | Traffic stays on private network, not exposed to the internet | Traffic is routed over public IPs but through a private connection |
| **Use Cases**               | Enterprise applications, databases, and other workloads requiring secure, high-performance connectivity | Access to Microsoft services like Office 365, Dynamics 365, and Azure PaaS services |
| **Network Isolation**       | Provides network isolation from the public internet | Doesn't provide network isolation from the public internet, but ensures traffic doesn't traverse the public internet |
| **Bandwidth Options**       | Offers scalable bandwidth options             | Offers scalable bandwidth options             |


## Choose a peering location

ExpressRoute locations, also known as peering locations or meet-me locations, are colocation facilities where Microsoft Enterprise Microsoft Edge (MSEE) devices are situated. These locations serve as the entry points to Microsoft's network and are globally distributed, offering the ability to connect to Microsoft's network worldwide. To choose an Azure ExpressRoute [peering location](/azure/expressroute/expressroute-locations?tabs=america%2Ca-c%2Cus-government-cloud%2Ca-C), consider: 

- **Proximity to your data centers**. Choose a peering location that is geographically close to your on-premises data centers or office locations. Proximity to the data center minimizes latency and can improve the performance of your applications.

- **Azure region connectivity**: Ensure that the peering location provides connectivity to the Azure regions you need to access. Different peering locations can offer connectivity to different sets of Azure regions, especially if you're using the Local or Standard SKU.

- **Network Service Provider availability**: Check which network service providers (NSPs) are available at the peering location. You need to work with an NSP to establish the physical connection to Azure ExpressRoute. Choose a provider that offers competitive pricing and reliable service.

- **Bandwidth requirements**: Consider your bandwidth needs and ensure that the peering location can support the required capacity. Different locations may have different bandwidth options available.

- **Cost Considerations**: Costs can vary based on the peering location, the NSP chosen, and the bandwidth required. To find the most cost-effective solution for your needs, compare costs across different locations and providers.

- **Compliance and regulatory requirements**: If your organization has specific compliance or regulatory requirements, ensure that the peering location meets these standards. Compliance requirements might include data residency or industry-specific regulations.

- **Future growth and scalability**: Consider your future growth plans and ensure that the peering location can accommodate increased bandwidth and other connections as your needs evolve.