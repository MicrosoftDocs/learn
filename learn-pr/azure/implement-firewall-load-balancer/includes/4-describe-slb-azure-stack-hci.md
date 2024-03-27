Azure Stack HCI supports different types of software-based load balancers. This unit describes the functionality and architecture of software-based load balancers, and their benefits compared to their hardware-based counterparts.

## Benefits of Software Load Balancer

Software-based load balancers provide the following benefits:

- Improve flexibility, resiliency, scalability, and performance.
- Eliminate common challenges of traditional hardware-based load balancers, like expensive support contracts and disruptive firmware upgrades.
- Significantly reduce the complexity of setting up highly available deployments.

With Azure Stack HCI Software Load Balancer, the virtual machines (VMs) that host the load-balancing components reside on the same infrastructure as the load-balanced workloads. This configuration means that the load balancers benefit from the characteristics of the underlying platform, including rapid provisioning, with high throughput and low latency intra-cluster network operations.

## Software Load Balancer functionality

The Azure Stack HCI Software Load Balancer is an Open Systems Interconnection (OSI) model Layer 4 load balancer. Software Load Balancer distributes incoming traffic among virtual network resources in a backend pool according to rules you define. Software Load Balancer offers the following functionality:

- Load balancing of TCP and UDP network traffic that targets Azure Stack HCI from external and internal networks, or *North-South* and *East-West* traffic. These networks include Hyper-V Network Virtualization-based virtual networks and VLAN-based logical networks.
- Support for Network Address Translation (NAT) for inbound and outbound traffic.
- Performance enhancements such as Direct Server Return, host-based health probes, and automatic support for Active-Active mode.
- Integration with Switch Embedded Teaming (SET) or Single Root Input-Output Virtualization (SR-IOV).

## Software Load Balancer architecture

The following diagram shows the architectural components of Azure Stack HCI Software Load Balancer:

:::image type="content" source="../media/4-azure-stack-hci-slb-architecture.png" alt-text="Diagram depicting the architectural components of an Azure Stack HCI SLB." border="false" lightbox="../media/4-azure-stack-hci-slb-architecture.png":::

Software Load Balancer (SLB) architecture consists of the following infrastructure components:

- **Network Controller**, which hosts the Software Load Balancing Manager and does the following tasks:

  - Processes load balancer commands originating from management applications such as PowerShell, Windows Admin Center, or Virtual Machine Manager (VMM) that target its northbound API.
  - Provisions load balancer policies for distribution to Azure Stack HCI cluster nodes and Software Load Balancer Multiplexer VMs based on the SLB commands.
  - Monitors and evaluates the health status of the SLB infrastructure.

- **Software Load Balancer Multiplexers**, which:

  - Process inbound network traffic.
  - Map virtual IPs (VIPs) to dynamic IPs assigned to the backend pool VMs.
  - Forward the traffic to the correct dynamic IPs.

  Multiplexers use Border Gateway Protocol (BGP) to advertise VIP routes to edge routers. BGP Keep Alive probes notify multiplexers when one or more multiplexers fail. The remaining active multiplexers can redistribute the load in response to the failure, effectively providing load balancing of load balancers.

- **Azure Stack HCI cluster nodes running the Hyper-V server role** that host the multiplexer VMs.

- **SLB Host Agents** on each Azure Stack HCI cluster node that's part of the SLB environment. The SLB Host Agent listens for SLB policy updates from the Network Controller and applies SLB rules to local Hyper-V virtual switches.

- **SDN-enabled Hyper-V virtual switch**, which:

  - Processes the data path for SLB.
  - Accepts inbound network traffic from the multiplexer.
  - Bypasses the multiplexer for outbound network traffic, sending it to a BGP-enabled router by using Direct Server Return.

- **BGP-enabled router**, which:

  - Routes inbound traffic to the multiplexer by using equal cost multipath routing.
  - Uses the route provided by the Hyper-V role hosted on the Azure Stack HCI cluster nodes for outbound network traffic.
  - Listens for route updates for VIPs from the SLB multiplexer.
  - Removes SLB multiplexers from the SLB rotation if Keep Alive probes fail.

- **Management tools** such as PowerShell, Windows Admin Center, and VMM that can communicate with the Network Controller northbound API and the corresponding SLB infrastructure.

