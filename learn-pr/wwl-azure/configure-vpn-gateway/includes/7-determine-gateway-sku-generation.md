When you create a virtual network gateway, you need to specify the gateway SKU to use. Select a SKU that meets your business requirements. Consider criteria such as the types of workloads you need to support, your expected throughputs, the necessary features, and your desired SLAs.

The following tables provide sample gateway SKUs that are available for implementation. Because the Basic SKU is considered a legacy SKU, samples aren't shown for this option. The tables identify the following information for each SKU type and generation:

- **Tunnels**: The maximum number of site-to-site (S2S) and Net-to-VNet tunnels that can be created for the SKU. 

- **Connections**: The maximum number of point-to-site (P2S) IKEv2 connections that can be created for the SKU.

- **Aggregate Throughput Benchmark**: The benchmark is based on measurements of multiple VPN tunnels aggregated through a single gateway. The Aggregate Throughput Benchmark for a VPN gateway is S2S + P2S combined. The Aggregate Throughput Benchmark isn't a guaranteed throughput due to internet traffic conditions and your application behavior.

For the most current SKU information, consult the [Azure VPN Gateway documentation](/azure/vpn-gateway/vpn-gateway-about-vpngateways). 

### Generation1

| SKU | Tunnels | Connections | Benchmark | 
| --- | --- | --- | --- |
| VpnGw1/Az | Max. 30| Max. 250| 650 Mbps |
| VpnGw2/Az | Max. 30 | Max. 500 | 1.0 Gbps |
| VPNGw3/Az | Max. 30 | Max. 1000 | 1.25 Gbps |

### Generation2

| SKU | Tunnels | Connections | Benchmark | 
| --- | --- | --- | --- |
| VpnGw2/Az | Max. 30 | Max. 500 | 1.25 Gbps |
| VPNGw3/Az | Max. 30 | Max. 1000 | 2.5 Gbps |
| VPNGw4/Az | Max. 100 | Max. 5000 | 5.0 Gbps |
| VPNGw5/Az | Max. 100 | Max. 10000 | 10.0 Gbps |