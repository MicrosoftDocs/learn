
With [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach), you can link ExpressRoute circuits to create a private network between your on-premises networks. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=750c807c-1fec-4665-abf0-25608c92ead8]

### Global Reach example architecture

Imagine you have a branch office in San Francisco and another branch office in London. Both branch offices have high-speed connectivity to Azure resources in US West and UK South. However, the branch offices can't connect and send data directly with one another. With Global Reach the San Francisco office can directly exchange data with your London office through the existing ExpressRoute circuits and Microsoft's global network.

:::image type="content" source="../media/global-reach-5558594f.png" alt-text="Diagram of the GlobalReach layout.":::


### Global Reach advantages

- **Improved Connectivity**. Azure Global Reach enables direct connectivity between different on-premises sites using Microsoft's global network.

- **Security**. Data is transmitted securely across Microsoft's private network, reducing exposure to potential threats compared to public internet connections.

- **Reduced Latency**. The use of Microsoft's high-speed global network can significantly reduce latency, providing faster and more efficient data transfer between connected sites.

- **Scalability**. Azure Global Reach can easily scale to accommodate growing network demands, allowing businesses to expand their connectivity as needed without significant infrastructure changes.

- **Simplified Network Management**. Centralized management through Azure can simplify the configuration and monitoring of network connections, making it easier for IT teams to manage complex network topologies.