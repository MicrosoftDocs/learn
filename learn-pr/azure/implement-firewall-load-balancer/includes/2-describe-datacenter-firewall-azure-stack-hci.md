To evaluate whether Azure Stack HCI SDN might help you enhance the security of your environment, you decide to explore its Datacenter Firewall functionality. On the surface, this option seems like a suitable solution that could potentially minimize the sprawl of hardware devices and help with your company’s consolidation initiatives. However, you want to ensure that its capabilities extend beyond virtual networking by providing integration with your existing virtual local area network (VLAN) environment.

## What is Datacenter Firewall?

Similar to traditional on-premises datacenters that rely on physical firewall appliances to restrict network connectivity, customers need to be able to control connectivity in their SDN environments. Microsoft provides this functionality in the form of distributed Datacenter Firewall, which, alongside Software Load Balancing and Remote Access Server (RAS) Gateway, serves as a core component of SDN. Datacenter Firewall, in coordination with Network Controller, which provides a management and monitoring interface, makes it possible to centrally implement and manage firewalls that help protect virtualized workloads from unauthorized network access.

### What are the benefits of using Datacenter Firewall?

Traditional firewall deployments targeted edge connectivity, filtering traffic between on-premises datacenters and the internet (commonly referred to as *North-South* communication). However, such an approach offers limited protection in today's world where the significance of the network perimeter as the protection boundary has been considerably diminished.

To provide meaningful protection as an element of the zero-trust strategy, firewalls must also help protect resources within a datacenter from internal threats, filtering traffic between on-premises resources (referred to as *East-West* communication). However, using physical firewalls to accomplish this objective is challenging, because it requires added investment in hardware and increases operational overhead. Another negative implication is increased latency affecting internal workloads, because all protected traffic must be routed via a separate physical device.

With Azure Stack HCI, you can define software-based granular filtering of virtualized workloads that are applicable to external and internal traffic. Datacenter Firewall provides this filtering through access control lists (ACLs) in logical and virtual networks.

For Azure Stack HCI administrators, Datacenter Firewall provides the following benefits:

- A highly scalable software-based firewall solution that can be centrally managed
- The ability to move virtual machines (VMs) across Azure Stack HCI cluster nodes without affecting the firewall configuration
- Protection of tenant VMs regardless of their guest operating system

For Azure Stack HCI tenants, Datacenter Firewall provides network level protection in the following scenarios:

- Internet-facing workloads within virtual and logical networks of Azure Stack HCI
- Communication within and between the virtual and logical network subnets of Azure Stack HCI
- Communication between datacenter networks and tenant workloads hosted by Azure Stack HCI

### What functionality does Datacenter Firewall provide?

Datacenter Firewall is a network-layer, stateful, multitenant firewall that supports filtering by any combination of five parameters: source and destination port numbers, source and destination IP addresses, and a protocol. Datacenter Firewall is implemented as a distributed firewall, with firewall policies that you can apply at the VM-network interface, logical network subnet, or virtual network subnet level to restrict traffic between virtualized workloads and both external and internal networks.

To implement Datacenter Firewall-based traffic filtering, you define firewall policies by using any management tool that supports communication with the northbound Representational State Transfer (REST) API of Network Controller. These tools include PowerShell, Windows Admin Center, and Microsoft System Center Virtual Machine Manager (VMM). Network Controller applies these policies to the virtual switch ports of Azure Stack HCI cluster nodes that function as Hyper-V hosts. This process facilitates portability, because the rules are automatically updated if you move VMs across cluster nodes, thereby helping ensure that firewall-based protection remains consistent. Network Controller will also automatically remediate any deviations from the policies you defined due to local configuration changes.

> [!NOTE]
> These policies support Azure Stack HCI workloads that are connected to VLAN-based networks.

:::image type="content" source="../media/2-azure-stack-hci-firewall-architecture.png" alt-text="Diagram depicting Network Controller with a Distributed Firewall. The Distributed Firewall is using policies to administer firewalls protecting VMs." border="false":::
