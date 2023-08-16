One recommended architecture for and Azure Kubernetes Service cluster is the hub-spoke network topology. The hub and spoke(s) are deployed in separate virtual networks connected through peering. Some advantages of this topology are:

 -  Segregated management. Enables a way to apply governance and adhere to the principle of least privilege. It also supports the concept of an [Azure landing zone](/azure/cloud-adoption-framework/ready/landing-zone/) with separation of duties.
 -  Minimizes direct exposure of Azure resources to the public internet.
 -  Organizations often operate with regional hub-spoke topologies. Hub-spoke network topologies can be expanded in the future and provide workload isolation.
 -  All web applications should require a web application firewall (WAF) service to help govern HTTP traffic flow.
 -  A natural choice for workloads that span multiple subscriptions.
 -  It makes the architecture extensible. To accommodate new features or workloads, new spokes can be added instead of redesigning the network topology.
 -  Certain resources, such as a firewall and DNS can be shared across networks.:::image type="content" source="../media/network-cluster-hub-spoke-40877d23.png" alt-text="Diagram showing how a hub and spoke interacts with on premises and internet.":::
    

### Hub

The hub virtual network is the central point of connectivity and observability. The hub contains an Azure Firewall with global firewall policies defined by your central IT teams to enforce organization wide firewall policy, Azure Bastion, and Azure Monitor for network observability.

Within the network, three subnets are deployed.

#### Subnet to host Azure Firewall

Azure Firewall is firewall as a service. The firewall instance secures outbound network traffic. Without this layer of security, this traffic might communicate with a malicious third-party service that could exfiltrate sensitive company data. [Azure Firewall Manager](/azure/firewall-manager/overview) enables you to centrally deploy and configure multiple Azure Firewall instances and manage Azure Firewall policies for this *hub virtual network* architecture type.

#### Subnet to host a gateway

This subnet is a placeholder for a VPN or ExpressRoute gateway. The gateway provides connectivity between the routers in your on-premises network and the virtual network.

#### Subnet to host Azure Bastion

This subnet is a placeholder for Azure Bastion. You can use Bastion to securely access Azure resources without exposing the resources to the internet. This subnet is used for management and operations only.

### Spoke

The spoke virtual network contains the AKS cluster and other related resources. The spoke has four subnets:

#### Subnet to host Azure Application Gateway

Azure [Application Gateway](/azure/application-gateway/overview) is a web traffic load balancer operating at Layer 7. The reference implementation uses the Application Gateway v2 SKU that enables Web Application Firewall (WAF). WAF secures incoming traffic from common web traffic attacks, including bots. The instance has a public frontend IP configuration that receives user requests. By design, Application Gateway requires a dedicated subnet.

#### Subnet to host the ingress resources

#### To route and distribute traffic, an ingress controller fulfills the Kubernetes ingress resources. The Azure internal load balancers exist in this subnet. 

#### Subnet to host the cluster nodes

AKS maintains two separate groups of nodes (or node pools). The *system node pool* hosts pods that run core cluster services. The *user node pool* runs your workload and the ingress controller to enable inbound communication to the workload.

#### Subnet to host Private Link endpoints

Azure Private Link connections are created for the Azure Container Registry and Azure Key Vault, so these services can be accessed using private endpoint within the spoke virtual network. Private endpoints don't require a dedicated subnet and can also be placed in the hub virtual network. In the baseline implementation, they're deployed to a dedicated subnet within the spoke virtual network. This approach reduces traffic passing the peered network connection and keeps the resources that belong to the cluster in the same virtual network.
