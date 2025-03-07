The network bandwidth allocated to each virtual machine is metered on egress (outbound) traffic from the virtual machine. All network traffic leaving the virtual machine is counted toward the allocated limit, regardless of destination.

For example, if a virtual machine has a 1,000-Mbps limit, that limit applies whether the outbound traffic is destined for another virtual machine in the same virtual network, or outside of Azure. Ingress isn't metered or limited directly. However, there are other factors, such as CPU and storage limits, which can affect a virtual machine’s ability to process incoming data.

Expected outbound throughput and the maximum number of network interfaces depend on the virtual machine size. The throughput limit applies to the virtual machine. Throughput is unaffected by the following factors:

- **Number of network interfaces**: The bandwidth limit is cumulative of all outbound traffic from the virtual machine.
- **Accelerated networking**: Though the feature can help in achieving the published limit, it doesn't change the limit.
- **Traffic destination**: All destinations count toward the outbound limit.
- **Protocol**: All outbound traffic over all protocols counts towards the limit.
