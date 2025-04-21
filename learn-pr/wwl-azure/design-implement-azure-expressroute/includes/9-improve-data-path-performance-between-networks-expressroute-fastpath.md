
## What is ExpressRoute FastPath?

ExpressRoute virtual network gateway facilitates the exchange of network routes and directs network traffic. [ExpressRoute FastPath](/azure/expressroute/about-fastpath) enhances data path performance between your on-premises network and your virtual networks. When enabled, ExpressRoute FastPath routes network traffic directly to virtual machines, bypassing the ExpressRoute virtual network gateway. 

FastPath is available on all ExpressRoute circuits. ExpressRoute FastPath is useful for enterprises that need consistent and high-performance connectivity to Azure for mission-critical applications. 

:::image type="content" source="../media/fastpath-vnet-peering.png" alt-text="Diagram of the FastPath layout.":::

### Advantages of ExpressRoute FastPath

- **Improved Performance**. FastPath reduces latency and increases throughput by allowing data to bypass the Azure WAN, providing a more direct path to your virtual network.

- **Lower Latency**. FastPath reduces the number of hops and routing directly to the virtual network. Optimized routing can significantly reduce latency, which is crucial for applications requiring real-time processing.

- **Higher Throughput**. FastPath supports higher data transfer rates, making it suitable for bandwidth-intensive applications and workloads.

- **Optimized Routing**. FastPath provides optimized routing for data packets, which can enhance the overall efficiency of network operations.

- **Reliability**. With a more direct connection, there's less chance of network congestion or packet loss, improving the reliability of data transfers.

- **Security**. FastPath ensures that data travels through fewer intermediary points, potentially reducing exposure to security risks.