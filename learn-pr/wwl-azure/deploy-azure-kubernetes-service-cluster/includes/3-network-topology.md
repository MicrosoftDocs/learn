One recommended architecture for an Azure Kubernetes Service (AKS) cluster is the hub-spoke network topology. The hub and spoke(s) are deployed in separate virtual networks connected through peering. Some advantages of this topology are:

- Segregated management. Enables a way to apply governance and adhere to the principle of least privilege. It also supports the concept of an [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) with separation of duties.
- Minimizes direct exposure of Azure resources to the public internet.
- Organizations often operate with regional hub-spoke topologies. Hub-spoke network topologies can be expanded in the future and provide workload isolation.
- Internet-facing or high-risk web applications should use a web application firewall (WAF) service to help govern HTTP traffic flow.
- A natural choice for workloads that span multiple subscriptions.
- It makes the architecture extensible. To accommodate new features or workloads, new spokes can be added instead of redesigning the network topology.
- Certain resources, such as a firewall and DNS can be shared across networks.

## Hub

The hub centralizes connectivity and observability. It contains an Azure Firewall with global firewall policies defined by your central IT teams to enforce organization-wide firewall policy, and Azure Bastion. The hub also serves as the focal point for network observability, with diagnostics and metrics flowing to Azure Monitor and topology and connectivity data collected by Network Watcher.

Within the network, three subnets are deployed.

### Subnet to host Azure Firewall

Azure Firewall is firewall as a service. The firewall instance secures outbound network traffic. Without this layer of security, this traffic might communicate with a malicious third-party service that could exfiltrate sensitive company data. [Azure Firewall Manager](/azure/firewall-manager/overview) enables you to centrally deploy and configure multiple Azure Firewall instances and manage Azure Firewall policies for this *hub virtual network* architecture type. Azure Firewall requires this subnet to be named exactly AzureFirewallSubnet with a minimum size of /26. The Azure Firewall Basic SKU **always** requires an `AzureFirewallManagementSubnet` (minimum size /26) for the **Firewall Management network interface**. For the Standard and Premium SKUs, you must also create this subnet when you enable forced tunneling or other features that require the management network interface. The Management network interface (the feature that previously required this subnet was called Forced Tunneling) has been decoupled from forced tunneling and is now required by additional Azure Firewall features. For more information, see [Azure Firewall Management network interface](/azure/firewall/management-nic).

### Subnet to host a gateway

This subnet is a placeholder for a VPN or ExpressRoute gateway. The gateway provides connectivity between the routers in your on-premises network and the virtual network. Azure requires this subnet to be named exactly GatewaySubnet. For VPN gateways, the minimum supported size is /29 for the Basic SKU, and /27 for all other SKUs (with /27 or larger recommended). Note that since October 1, 2023, new policy-based VPN gateways can only be configured by using PowerShell or the Azure CLI. Separately, the Basic VPN gateway SKU is no longer available in the Azure portal and must be configured by using PowerShell or the Azure CLI; the Basic gateway SKU is not retiring. For ExpressRoute gateways, /27 or larger is recommended; if you plan to connect 16 ExpressRoute circuits to the gateway, you must use /26 or larger.

### Subnet to host Azure Bastion

This subnet is a placeholder for Azure Bastion. You can use Bastion to securely access Azure resources without exposing the resources to the internet. This subnet is used for management and operations only. For Azure Bastion deployments other than the Developer offering, Azure Bastion requires a dedicated subnet named exactly `AzureBastionSubnet` with a minimum size of `/26`.

## Spoke

The spoke virtual network contains the AKS cluster and other related resources. The spoke has five subnets:

- `snet-clusternodes` for AKS node IPs.
- `snet-clusteringressservices` for internal load balancers that support ingress services.
- `snet-applicationgateway` for Azure Application Gateway.
- `snet-privatelinkendpoints` for Private Link endpoints to Azure Container Registry, Azure Key Vault, and similar services.
- `snet-apiserver`, a minimum `/28` subnet delegated to `Microsoft.ContainerService/managedClusters` for [AKS API Server VNet Integration](/azure/aks/api-server-vnet-integration).

### Subnet to host Azure Application Gateway

Azure [Application Gateway](/azure/application-gateway/overview) is a web traffic load balancer operating at Layer 7. The reference implementation uses the `WAF_v2` SKU with a [Web Application Firewall (WAF) policy](/azure/web-application-firewall/ag/policy-overview) associated at the gateway, listener, or path level. The WAF policy helps protect incoming traffic from common web attacks and can also mitigate bot traffic when bot-related managed rule sets are enabled. The instance has a public frontend IP configuration that receives user requests. By design, Application Gateway requires a dedicated subnet.

> [!NOTE]
> The legacy inline WAF *configuration* on the Application Gateway `WAF_v2` SKU is deprecated. New WAF *configuration* deployments were discontinued on March 15, 2025, and existing inline WAF configurations are fully retired on March 15, 2027. The `WAF_v2` SKU itself is **not** deprecated. New and existing deployments should use `WAF_v2` together with a separate **WAF Policy** resource (associated at the gateway, listener, or path level) instead of the inline WAF configuration. The `Standard_v2` SKU has no WAF support at all (neither inline WAF configuration nor WAF Policy resources). For migration guidance, see [Upgrade Web Application Firewall policies](/azure/web-application-firewall/ag/upgrade-ag-waf-policy).

### Subnet to host the ingress resources

To route and distribute traffic, an ingress controller fulfills the Kubernetes ingress resources. The Azure internal load balancers exist in `snet-clusteringressservices`.

### Subnet to host the cluster nodes

In this baseline architecture, deploy a dedicated **system node pool** for critical system pods and one or more **user node pools** for workloads and ingress components. System pools should be dedicated. For production, run at least 2 (preferably 3) nodes and apply the taint `CriticalAddonsOnly=true:NoSchedule` to prevent application pods from scheduling there. For more information, see [Use system node pools in AKS](/azure/aks/use-system-pools).

### Subnet to host Private Link endpoints

Azure Private Link connections are created for the Azure Container Registry and Azure Key Vault, so these services can be accessed using private endpoints within the spoke virtual network. Private endpoints don't require a dedicated subnet and can also be placed in the hub virtual network. In the baseline implementation, they're deployed to a dedicated subnet within the spoke virtual network. This approach reduces traffic passing the peered network connection and keeps the resources that belong to the cluster in the same virtual network.

### Subnet for AKS API Server VNet Integration

AKS uses `snet-apiserver` for API Server VNet Integration. The subnet must be at least `/28` and delegated to `Microsoft.ContainerService/managedClusters`. A `/28` is a tight minimum (16 IPs, of which AKS reserves at least 9), so consider `/27` or larger for production clusters to allow for API server scaling.
