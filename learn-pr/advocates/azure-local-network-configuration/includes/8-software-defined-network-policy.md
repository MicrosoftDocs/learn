**Software-defined networking (SDN)** uses a control plane to program network behavior. **Network Controller** distributes policy; host components enforce it in the data plane. A **network security group (NSG)** contains traffic rules associated with supported network resources.

Network ATC configures host networking but doesn't own application NSG policy. Arc-enabled SDN uses Network Controller as a **Failover Cluster service** managed through the Azure Local lifecycle. On-premises-managed SDN uses its documented local deployment, including dedicated controller VMs. These are different management models, not interchangeable consoles.

| Boundary | Arc-enabled SDN | On-premises-managed SDN |
| --- | --- | --- |
| Workload management | Azure Local VMs deployed through Azure interfaces | Eligible unmanaged VMs deployed through local tools |
| Controller | Failover Cluster service | Dedicated controller VMs in the local deployment |
| Supported resource scope | Logical networks, VM NICs, NSGs | Local SDN resources, including virtual networks, software load balancers, and gateways |
| Configuration owner | Azure portal, Azure CLI, ARM templates | Supported local management procedures |
| Mixing rule | Don't overlay local management on the Arc-managed controller | Don't enable the Arc model over an existing local-controller deployment |

Installing the Azure Connected Machine agent inside a locally created VM registers its guest operating system as an Arc-enabled server; it doesn't change how the VM or its network interfaces were provisioned and are managed. Arc-enabled SDN applies NSGs to supported logical networks and network interfaces for Azure Local VMs provisioned through Azure interfaces, such as the Azure portal, Azure CLI, or Azure Resource Manager templates. A VM created through Hyper-V Manager, Windows Admin Center, or another local provisioning tool doesn't enter that scope merely because an Arc agent is installed inside it.

For eligible locally provisioned VMs, use the on-premises-managed SDN model and its supported local tools to manage NSGs. Don't apply locally managed NSGs to Azure-provisioned VMs or use both management models on the same controller. Before investigating a denied connection, establish how the VM was provisioned, which controller owns its network configuration, and where the applicable NSG is attached. Seeing an Arc-enabled server resource in Azure isn't sufficient evidence that Azure manages the VM's network security policy.

## Logical networks and overlays

An Azure Local **logical network** projects a physical network's subnet, VLAN, IP pools, gateway, and DNS settings into the management model. It isn't automatically an Azure virtual network or a VXLAN overlay.

An **overlay** encapsulates tenant traffic over an underlying network, called the **underlay**. Hyper-V Network Virtualization in an appropriate on-premises SDN architecture can use mechanisms such as VXLAN. That concept doesn't grant Arc-enabled SDN virtual-network support.

An on-premises SDN gateway providing VPN, Layer 3, or GRE connectivity is unrelated to Azure Arc gateway's outbound management role.

AKS can coexist with Arc-enabled SDN, but attaching these NSGs to the AKS workload logical network or AKS workload VM NICs is unsupported. Don't infer attachment support from coexistence.
