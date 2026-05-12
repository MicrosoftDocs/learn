Contoso Manufacturing's factory systems need secure remote access without the attack surface created by public RDP and SSH ports. Azure Bastion provides browser-based and native client connectivity through encrypted TLS 443 connections, eliminating the need for public IP addresses on virtual machines and open management ports in network security groups.

## Understand Azure Bastion connectivity model

Azure Bastion acts as a secure gateway between users and target virtual machines. When you connect through Bastion, the service establishes an RDP or SSH session from the Bastion host directly to the target VM over the Azure backbone network. The user's client connects to the Bastion host using HTTPS over port 443, which passes through most corporate firewalls without special exceptions.

This architecture removes several attack vectors. Virtual machines no longer need public IP addresses for remote access. Network security groups no longer require inbound rules for RDP port 3389 or SSH port 22 from internet sources. All remote connectivity flows through the hardened Bastion service, which provides a single, auditable access point.

## Select the appropriate Bastion SKU

Azure Bastion offers four SKUs with distinct capabilities and cost structures. The right choice depends on your access patterns, user count, required features, and budget constraints.

| SKU | Host Units | Concurrent Sessions | Browser Access | Native Client | Shareable Links | Session Recording | Typical Use Case |
|-----|------------|---------------------|----------------|---------------|-----------------|-------------------|------------------|
| Developer | Free tier | One user | Yes | No | No | No | Individual development, testing |
| Basic | 2 (fixed) | 40 RDP / 80 SSH | Yes | No | No | No | Small teams, browser-only access |
| Standard | 2–50 (configurable) | 20 RDP + 40 SSH per instance | Yes | Yes | Yes | No | Enterprise deployments, native tooling |
| Premium | 2–50 (configurable) | 20 RDP + 40 SSH per instance | Yes | Yes | Yes | Yes | Regulated environments, compliance |

The **Developer SKU** provides no-cost access for individual users during development and testing. This tier supports a single concurrent user and lacks scaling capabilities, making it unsuitable for production team environments.

The **Basic SKU** offers browser-based access through its fixed allocation of 2 host units, supporting up to 40 concurrent RDP sessions or 80 concurrent SSH sessions. Users connect through the Azure portal using the browser-based RDP or SSH client. This tier works well for small teams that don't require native RDP client features or significant scaling.

The **Standard SKU** adds native client support, IP-based connections, and configurable scaling from 2 to 50 host units. Native client support allows users to connect using their existing RDP clients (such as Microsoft Remote Desktop or Windows App) and SSH tools through an Azure CLI tunnel command. IP-based connections enable administrators to connect to virtual machines by specifying an IP address rather than selecting from the portal's VM list, which proves essential for hub-spoke architectures where Bastion in the hub virtual network provides access to spoke VNets through peering. Shareable links provide time-limited URL-based access for users without Azure portal credentials, useful for contractor or vendor scenarios.

The **Premium SKU** adds session recording capabilities that capture complete RDP and SSH session activity to an Azure Storage account for compliance and security auditing. Private-only mode removes the public IP address requirement from the Bastion host itself for air-gapped or highly restricted network environments.

For Contoso Manufacturing, the **Standard SKU** provides the right balance. Factory engineers already use native RDP clients with custom configurations, and the native client tunnel feature preserves this workflow. The IP-based connection capability allows Bastion to be deployed in the hub virtual network while serving factory VMs in spoke VNets.

## Design the network architecture

Azure Bastion deploys into a dedicated subnet within an Azure virtual network. This subnet must be named exactly **AzureBastionSubnet** and sized with a minimum /26 prefix (64 IP addresses). The /26 minimum ensures sufficient address space for the Bastion service infrastructure and future scaling requirements.

Organizations with hub-spoke network topologies face a deployment choice: deploy Bastion in the hub virtual network to serve all spoke VNets, or deploy separate Bastion instances in each spoke virtual network. A hub deployment reduces costs (one Bastion host instead of many) and simplifies management, but requires Standard or Premium SKU with IP-based connection capability. The Bastion host in the hub connects to VMs in spoke VNets through VNet peering relationships. With IP-based connections enabled, administrators specify the target VM's IP address directly rather than selecting from the portal's resource list.

Per-VNet deployment provides isolation and removes dependencies on virtual network peering, but multiplies costs and administrative overhead. This approach makes sense for VNets with strict isolation requirements or when different teams manage separate VNets independently.

Contoso Manufacturing operates a hub-spoke topology with factory systems distributed across spoke VNets. Deploying Bastion with Standard SKU in the hub virtual network provides access to all factory VMs while maintaining a single managed endpoint and minimizing costs.

## Configure public IP and NSG requirements

Azure Bastion requires a Standard SKU static public IP address for inbound connectivity from user clients. This public IP attaches to the Bastion host itself, not to the target virtual machines. The target VMs can operate without any public IP addresses, which eliminates their exposure to internet-based attacks.

The AzureBastionSubnet requires a network security group with specific inbound and outbound rules. Inbound rules must allow HTTPS (port 443) from the internet to permit user connections, and allow port 443 from the GatewayManager service tag to enable Azure control plane operations. Outbound rules must allow traffic to target VMs on ports 3389 (RDP) and 22 (SSH), and allow port 443 to the AzureCloud service tag for Azure service dependencies.

These NSG requirements differ from typical subnet NSGs because they accommodate both user-facing traffic (inbound 443 from Internet) and backend service communication (GatewayManager, AzureCloud). Restrictive NSGs that block these required flows prevent Bastion from functioning.

## Plan for scaling and performance

Each instance supports 20 concurrent RDP sessions or 40 concurrent SSH sessions. The Standard and Premium SKUs allow scaling from 2 to 50 instances, providing capacity for up to 1,000 concurrent RDP sessions or 2,000 concurrent SSH sessions at maximum scale. Host unit scaling happens manually through the Azure portal or programmatically through Azure CLI or Azure PowerShell.

Performance planning considers both the number of concurrent users and the bandwidth requirements of active sessions. RDP sessions with high-resolution displays or multimedia content consume more bandwidth than basic SSH terminal sessions. Organizations with peak usage periods should configure host units to handle maximum concurrent load rather than average load.

Contoso Manufacturing identified 40 engineers who require factory VM access, with typical peak concurrency of 15 simultaneous sessions. The default 2 host units provide sufficient capacity, but the team configured four host units to accommodate growth and unexpected surge scenarios.

Now that you understand how to select the appropriate SKU and design the network architecture, you're ready to deploy and configure Azure Bastion in your environment.
