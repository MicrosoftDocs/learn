

Choosing between ExpressRoute Direct and the Service Provider model depends on the requirements of the organization. These requirements include performance requirements, budget constraints, and desired level of control over the network infrastructure. Large enterprises with high data transfer needs might opt for ExpressRoute Direct. Smaller businesses or those seeking managed services might prefer the Service Provider model.

In this video, we discuss provisioning a ExpressRoute Direct circuit. An ExpressRoute circuit is a dedicated, private connection that allows you to extend your on-premises networks into the Microsoft cloud.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=f84282e5-0826-478b-aaee-2a900b74ccb0]


### Comparison of ExpressRoute Direct and the Service Provider models

This table highlights the key differences between ExpressRoute Direct and the Service Provider model. 

| Feature/Aspect | ExpressRoute using a Service Provider |   ExpressRoute Direct   |
| --- | --- | --- |
| Usage cases | Small to medium sized business looking for a simple setup with managed services | Large enterprises with mission-critical applications requiring high-performance connectivity |
| Connectivity | Connection via a service provider's infrastructure | Direct connection to Microsoft's network through dual 10-Gbps or 100-Gbps ports |
| Circuit SKUs |                             Ranges from 50 Mbps to 10 Gbps                             | 10-Gbps: 1, 2, 5, 10 Gbps; 100-Gbps: 5, 10, 40, 100 Gbps |
| Optimization | Optimized for single tenant with multiple business units | Optimized for a single tenant |

Azure ExpressRoute offers different [SKUs](/azure/expressroute/expressroute-faqs#expressroute-premium) to cater to various connectivity needs and performance requirements. Each SKU has different pricing and features, such as varying limits on the number of virtual networks you can connect to and the bandwidth options available. When choosing a SKU, consider your organization's geographic footprint, latency requirements, and budget constraints.

:::image type="content" source="../media/sku-scope.png" alt-text="Diagram of the ExpressRoute SKU coverage.":::


- **Local SKU (if available)**. The Local SKU provides connectivity to a single Azure region. It's suitable for scenarios where you need low-latency access to resources in a particular Azure region.

- **Standard SKU**: The Standard SKU allows connectivity to multiple Azure regions within the same geopolitical area. The Standard SKU is useful for businesses that operate within a specific region but need access to resources across multiple locations. 

- **Premium SKU**: The Premium SKU extends connectivity to all Azure regions globally. This SKU is ideal for multinational organizations that require seamless connectivity to Azure resources across different continents.


> [!TIP]
> You also need to select a billing model. ExpressRoute offers unlimited data, metered data, and a premium add-on.