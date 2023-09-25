Now that you have a basic understanding of the core SDN concepts, you want to explore the architecture and characteristics of Network Controller. You’re aware of the significance of Network Controller as the foundational component of the Azure Stack HCI SDN control plane. Now, you’re interested in the technologies that form the basis of its resiliency. You also want more information about its management capabilities.

## What is Network Controller?

Network Controller is the core component of the SDN implementation in Azure Stack HCI. It’s included as an optional part of the Azure Stack HCI cluster creation process. You can also install it later. It serves as the primary interface for communication between management applications, such as Windows Admin Center and VMM, and the managed network devices and services. Network Controller is also responsible for policy-based configuration and monitoring, which help ensure that the SDN environment deploys required resources and adjusts their characteristics to adhere to the rules that you define.

### What is Network Controller architecture?

Network Controller is implemented as a Service Fabric application. Service Fabric is a hosting platform optimized for scalable, highly available distributed systems, which make it suitable for essential core infrastructure services. To make use of its built-in state management and automatic failover, it’s important to deploy multiple Network Controller VMs into the Azure Stack HCI cluster that provides the SDN functionality, with a minimum of three VMs. Each of the Network Controller VMs runs the Azure Stack HCI operating system.

### What are Network Controller APIs?

Network Controller is accessible through two APIs:

- The Northbound API is intended for REST-based communication with management applications to provide centralized administration of the SDN infrastructure and virtualized workloads.
- The Southbound API is intended for interaction with and monitoring of managed SDN infrastructure components, including network function virtualization-based services.

  > [!NOTE]
  > *North-South* is commonly used to designate traffic between a datacenter and an external network (such as the internet). In the context of Network Controller, it’s meant to represent the relationship between the managing and managed components.

Network Controller offers the following management features:

- Virtual network management. Deployment and configuration of Hyper-V  virtual switches, virtual networks, VMs connected to these virtual networks, and virtual network policies.
- Software Load Balancer management. Implementation of load balancing and NAT within and across virtual networks as well as within and across traditional VLAN networks.
- Firewall management. Configuration and management of access control list (ACL) rules within and across virtual networks as well as within and across traditional VLAN networks.
- RAS Gateway management. Deployment, configuration, and management of virtual gateway devices that provide the following functionality:

  - Site-to-Site VPN connectivity between remote tenant networks and your datacenter by using encrypted IPsec tunnels.
  - Site-to-Site VPN connectivity between remote tenant networks and your datacenter by using GRE tunnels.
  - Layer 3 forwarding connectivity to the physical network infrastructure in the local datacenter.
  - Border Gateway Protocol (BGP) route exchange between your tenants' VM networks and their remote sites.

- Virtual appliance management. Bring third-party virtual appliances such as firewalls, intrusion detection devices, and load balancers and attach them to SDN virtual networks for advanced services.

:::image type="content" source="../media/3-network-controller-policies.png" alt-text="Network Controller architecture diagram, illustrating its Northbound REST API accessible from PowerShell, VMM, and Windows Admin Center. The diagram also shows the Northbound API used to interact with Hyper-V switch-based virtualized resources." border="false":::
