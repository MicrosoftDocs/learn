When you create a virtual network gateway, you need to specify the gateway SKU that you want to use. Select the SKU that satisfies your requirements based on the types of workloads, throughputs, features, and SLAs.

Here are some samples of the available Gateway SKUs. Be sure to always [consult the documentation](/azure/vpn-gateway/vpn-gateway-about-vpngateways) for the latest information. 

:::row:::
  :::column:::
    **Gen**
  :::column-end:::
  :::column:::
    **SKU**
  :::column-end:::
  :::column:::
    **S2S/VNet-to-VNet Tunnels**
  :::column-end:::
  :::column:::
    **P2S IKEv2 Connections**
  :::column-end:::
  :::column:::
    **Aggregate Throughput Benchmark**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    VpnGw1/Az
  :::column-end:::
  :::column:::
    Max. 30
  :::column-end:::
  :::column:::
    Max. 250
  :::column-end:::
  :::column:::
    650 Mbps
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    VpnGw2/Az
  :::column-end:::
  :::column:::
    Max. 30
  :::column-end:::
  :::column:::
    Max. 500
  :::column-end:::
  :::column:::
    1.0 Gbps
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    VpnGw2/Az
  :::column-end:::
  :::column:::
    Max. 30
  :::column-end:::
  :::column:::
    Max. 500
  :::column-end:::
  :::column:::
    1.25 Gbps
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    VPNGw3/Az
  :::column-end:::
  :::column:::
    Max. 30
  :::column-end:::
  :::column:::
    Max. 1000
  :::column-end:::
  :::column:::
    1.25 Gbps
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    VPNGw3/Az
  :::column-end:::
  :::column:::
    Max. 30
  :::column-end:::
  :::column:::
    Max. 1000
  :::column-end:::
  :::column:::
    2.5 Gbps
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    VPNGw4/Az
  :::column-end:::
  :::column:::
    Max. 100
  :::column-end:::
  :::column:::
    Max. 5000
  :::column-end:::
  :::column:::
    5.0 Gbps
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    VPNGw5/Az
  :::column-end:::
  :::column:::
    Max. 100
  :::column-end:::
  :::column:::
    Max. 10000
  :::column-end:::
  :::column:::
    10.0 Gbps
  :::column-end:::
:::row-end:::


Aggregate Throughput Benchmark is based on measurements of multiple tunnels aggregated through a single gateway. The Aggregate Throughput Benchmark for a VPN Gateway is S2S + P2S combined. The Aggregate Throughput Benchmark is not a guaranteed throughput due to Internet traffic conditions and your application behaviors.

> [!NOTE]
> The Basic SKU (not shown) is considered a legacy SKU.
