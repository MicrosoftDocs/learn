Azure Local can use **virtual local area networks (VLANs)** to keep management, storage, and workload traffic on separate logical networks, even when they share physical adapters and switches. Plan VLAN assignments alongside IP subnets, and ensure that host and switch configurations are consistent with the selected network design.

A VLAN is a Layer 2 broadcast domain, commonly identified by an Ethernet tag. An **IP subnet** defines an address scope and local-versus-routed addressing relationship. Their identifiers are different: VLAN 711 doesn't imply that the subnet contains “711,” and matching IP prefixes don't repair inconsistent VLAN tagging.

VLAN separation isn't a substitute for workload access policy. Hosts within one VLAN can still communicate unless an applicable control restricts them; routing between VLANs also needs the intended security policy. You'll learn about workload access policies later in the module.

An **address pool** is a reserved allocation range within a subnet. A **default gateway** supplies an off-subnet next hop where routing is required. **Domain Name System (DNS)** maps names to addresses and other records. A successful DNS answer must be correct for the actual caller and intended path, not merely syntactically valid.

The table illustrates an example address space plan:

| Purpose | Proposed prefix or allocation | VLAN | Planning interpretation |
| --- | --- | --- | --- |
| Management | `192.168.10.0/24` | 110 | Custom fictional branch management network |
| Node management | `192.168.10.11` and `192.168.10.12` | 110 | Excluded from the infrastructure pool |
| Infrastructure pool | `192.168.10.100–192.168.10.111` | 110 | Twelve consecutive reserved addresses in the management subnet |
| Storage path A | `10.71.1.0/24` | 711 | Network ATC default example, subject to chosen deployment configuration |
| Storage path B | `10.71.2.0/24` | 712 | Network ATC default example, subject to chosen deployment configuration |
| Application network | `192.168.20.0/24` | 120 | Custom network containing application `.10` and database `.20` |
| Proposed pod range | `10.240.0.0/16` | Not a host VLAN assignment | Candidate only; requires workload and enterprise overlap review |
| AKS internal service range | `10.96.0.0/12` | Not a host VLAN assignment | Fixed for the documented AKS on Azure Local baseline; service-CIDR customization isn't supported. Check for conflicts with infrastructure and services the cluster must reach. |

For Kubernetes workloads, a **pod** is a scheduling unit containing one or more containers; pod addresses identify those workload endpoints. A **service address** is a virtual frontend for reaching a set of workload endpoints. Reserve pod and service ranges according to the supported workload networking model, rather than treating them as additional host-management address pools.

Azure Local requires an infrastructure IP pool containing at least six consecutive, unused addresses in the same subnet as the node management addresses. Keep node addresses outside this pool and exclude the pool from DHCP allocation and other address assignments. Azure Local uses the pool for static addresses assigned to infrastructure services such as Azure Arc resource bridge, even when the physical nodes obtain their addresses through DHCP. Configure the pool with the same DNS servers as the nodes and a gateway that supports the required outbound connectivity. For example, to meet their needs, Adatum would reserve twelve addresses, from `192.168.10.100` through `192.168.10.111`: `111 − 100 + 1 = 12`. This provides headroom above the minimum, but the pool must still be sized for the infrastructure services being deployed. Workload VM, pod, and service address requirements are planned separately.

Coordinate with your network team to record and reserve the planned management, infrastructure, storage, and application allocations in your organization's IP address management (IPAM) system or approved IP address register. Check for conflicts with connected branch and datacenter networks, VPN routes, Azure-connected networks, and existing allocations. Record the platform pod and service ranges as internal connectivity constraints, not enterprise-wide address reservations: keep this instance's infrastructure, logical networks, and the endpoints it and its AKS clusters must reach outside them. Unrelated isolated networks aren't prohibited from using the same address space. An overlap invisible within the branch can still break remote management or container connectivity.

## Storage addressing

Automatic storage addressing and competing manual assignments can't both own the same interfaces. In the default example, use the generated storage plan and validate the resulting host configuration; don't preassign arbitrary addresses to “help” reconciliation.

If requirements demand custom storage addressing, follow the documented cloud-deployment path, including the applicable Azure Resource Manager (ARM) template settings such as `enableStorageAutoIP=false`. Validate the entire selected pattern rather than combining fragments from automatic and custom examples.

Storage connectivity must follow the supported local Layer 2 pattern. A transport protocol's technical ability to cross a router doesn't grant product support for an arbitrary routed storage fabric. Likewise, don't add a storage default gateway merely because one exists on management interfaces.

## Design consistent frame handling and priority behavior

The **maximum transmission unit (MTU)** limits packet size at an interface or layer. Validate effective frame support across host adapters, applicable virtual interfaces, switch access ports, trunks, and peer interfaces.

The [cloud deployment networking guidance](/azure/azure-local/plan/cloud-deployment-network-considerations?view=azloc-2610&preserve-view=true) recommends a 9216-byte setting for RDMA storage networking. Vendors differ in whether their displayed size includes Ethernet headers or other overhead. Match effective supported frame sizes rather than copying the same number blindly. This guidance isn't an instruction to assign 9216 to every guest network or protocol.

For RoCE storage, use the required nonzero storage VLAN and supported priority configuration. Preserve the separation between VLAN membership, IP addressing, MTU, and QoS: each can independently break an otherwise plausible path.

Finally, document DNS and time-service dependencies. Clock differences can affect authentication and make incident timelines misleading. Query from the node, resource bridge, proxy, or workload that experiences the issue. For Adatum's design review, an approved address table is incomplete until it identifies resolver reachability, time sources, gateways where needed, and the team responsible for each dependency.
