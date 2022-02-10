With the evaluation of Datacenter Firewall successfully completed, the remaining challenge concerns the load-balancing functionality. In this case, you also have high hopes, because based on your cursory review, Azure Stack HCI supports different types of software-based load balancers. However, you’re curious to find out about their architecture and the benefits they offer as compared to their hardware-based counterparts.

## What is Azure Stack HCI Software Load Balancer?

The Azure Stack HCI Software Load Balancer is a Layer 4 (L4) load balancer that distributes incoming traffic among virtual network resources combined into a backend pool according to the rules you define.

### What are the benefits of Software Load Balancer?

Software-based load balancers combine flexibility, resiliency, scalability, and performance advantages. At the same time, they eliminate common challenges associated with traditional hardware-based load balancers, including expensive support contracts and the need for disruptive firmware upgrades. They also significantly reduce the complexity involved in setting up highly available deployments.

With Azure Stack HCI Software Load Balancer, the VMs hosting the load-balancing components reside on the same infrastructure as the load-balanced workloads. This means that they benefit from the characteristics of the underlying platform, including rapid provisioning, with high throughput and low latency of intra-cluster network operations.

## What functionality does Software Load Balancer provide?

Software Load Balancer offers the following functionality:

- Load balancing of TCP and UDP network traffic targeting Azure Stack HCI resources that originate from internal and external networks (**North-South** and **East-West**). This includes Hyper-V Network Virtualization-based virtual networks and VLAN-based logical networks.
- Support for Network Address Translation (NAT) for inbound and outbound traffic.
- Performance enhancements such as Direct Server Return, host-based health probes, and automatic support for the Active/Active mode.
- Integration with Switch Embedded Teaming (SET) or Single Root Input/Output Virtualization (SR-IOV).

## What is the architecture of Software Load Balancer?

From the architectural standpoint, Software Load Balancer consists of the following infrastructure components:

- Network Controller, which hosts the Software Load Balancing (SLB) Manager and performs the following tasks:

  - Processes load balancer commands originating from management applications such as PowerShell, Windows Admin Center, or VMM and targeting its northbound API.
  - Provisions load balancer policies for distribution to Azure Stack HCI cluster nodes and Software Load Balancer Multiplexer VMs based on the SLB commands.
  - Monitors and evaluates the health status of the SLB infrastructure.

- Software Load Balancer Multiplexer, which processes inbound network traffic, maps virtual IPs (VIPs) to dynamic IPs assigned to the backend pool VMs, and forwards the traffic to the correct dynamic IP. Multiplexers use Border Gateway Protocol (BGP) to publish VIP routes to edge routers. BGP Keep Alive probes notify multiplexers when one or more of them fail, which allows the remaining active multiplexers to redistribute the load in response to that failure, effectively providing load balancing of load balancers.
- Azure Stack HCI cluster nodes running the Hyper-V server role. These are Azure Stack HCI-based servers that host multiplexer VMs.
- SLB Host Agent. Deployment of SLB results in provisioning the SLB Host Agent on each Azure Stack HCI cluster node that is part of the SLB environment. The SLB Host Agent listens for SLB policy updates from the Network Controller and applies SLB rules to local Hyper-V virtual switches.
- SDN-enabled Hyper-V virtual switch, which:

  - Processes the data path for SLB.
  - Accepts inbound network traffic from the multiplexer.
  - Bypasses the multiplexer for outbound network traffic, sending it to a BGP-enabled router by using Direct Server Return.

- BGP-enabled router, which:

  - Routes inbound traffic to the multiplexer by using equal cost multipath routing.
  - Uses the route provided by the Hyper-V role hosted on the Azure Stack HCI cluster nodes for outbound network traffic.
  - Listens for route updates for VIPs from SLB multiplexer.
  - Removes SLB multiplexers from the SLB rotation if Keep Alive probes fail.

- Management applications. Tools such as PowerShell, Windows Admin Center, and VMM that are capable of communicating with the northbound API of Network Controller and the corresponding SLB infrastructure.

:::image type="content" source="../media/4-azure-stack-hci-slb-architecture.png" alt-text="Diagram depicting the architectural components of an Azure Stack HCI SLB." border="false":::
