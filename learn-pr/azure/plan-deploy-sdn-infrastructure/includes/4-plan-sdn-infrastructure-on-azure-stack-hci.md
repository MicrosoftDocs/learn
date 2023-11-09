Your initial research of the SDN capabilities of Azure Stack HCI raised your level of confidence in being able to use them to improve the resiliency, agility, security, and manageability of your network infrastructure. However, you realize that a successful SDN deployment requires proper planning, especially if you want to integrate it with your existing environment.

## Plan for SDN deployment

Before you can deploy SDN on an Azure Stack HCI cluster, you must ensure that your infrastructure meets all the relevant prerequisites, including:

- Azure Stack HCI cluster nodes and infrastructure VMs
- Network Controller
- Logical networks
- Routing infrastructure
- Physical networks

> [!NOTE]
> This unit provides a high-level overview of SDN requirements on Azure Stack HCI. For detailed, comprehensive information regarding this topic, refer to the Microsoft documentation referenced in the Summary unit of this module.

### Azure Stack HCI cluster nodes and infrastructure VMs

Each Azure Stack HCI cluster node must be connected to the Management logical network through at least one physical adapter that’s part of an external Hyper-V virtual switch. All VMs that host SDN infrastructure services, such as Network Controller, RAS Gateways, and Software Load Balancers, must be running the Azure Stack HCI operating system.

Microsoft provides minimum compute, storage, and software requirements for physical hosts and SDN infrastructure VMs. However, keep in mind that sizing and resource requirements for your infrastructure ultimately depend on the demands of tenant workload VMs. Fortunately, SDN facilitates scaling, which allows you to deploy more instances of network function virtualization-based services on an as-needed basis. Depending on the hardware capabilities of your Azure Stack HCI cluster, you also have the option of adding physical cluster nodes.

> [!NOTE]
> SDN isn’t supported on stretched (multisite) clusters.

### Network Controller

To prepare for the deployment of Network Controller in an Active Directory Domain Services (AD DS) environment, you need to set up Kerberos-based authentication and authorization. This authorization allows Network Controller to manage all relevant aspects of the SDN infrastructure. The required permissions are assigned automatically during Network Controller deployment.

> [!NOTE]
> In highly available deployments, Network Controller forms a cluster consisting of three or more VMs, each running on a separate Azure Stack HCI cluster node. All Network Controller instances are joined to the same AD DS domain.

### Logical networks

To support the network function virtualization-based services, you need to provision the required logical networks, including:

- Management and HNV Provider logical networks
- Software Load Balancer and Gateways logical networks

#### Management and HNV Provider logical networks

All Azure Stack HCI cluster nodes must have access to the Management logical network and the HNV Provider logical network. For IP address planning purposes, each Azure Stack HCI cluster node must have at least one IP address assigned from the Management logical network. For the Management network, you can assign IP addresses statically or through Dynamic Host Configuration Protocol (DHCP). The SDN stack automatically assigns IP addresses for the HNV Provider logical network for the individual Azure Stack HCI cluster nodes. The addresses are provided from an IP address pool, specified through and managed by Network Controller.

The Network Controller REST DNS name must be configured to allow dynamic DNS updates. All Network Controller VMs must be allowed to create and update the DNS record.

> [!NOTE]
> There are other logical network configuration considerations that depend on the use of such features as VLANs and Switch Embedded Teaming (SET). You can learn more about these considerations in the Microsoft documentation referenced in the Summary unit of this module.

#### Software Load Balancer and Gateways logical networks

You need to provision further logical networks to accommodate deployments of the Software Load Balancer Multiplexer and RAS Gateway VMs. For each of them, you need to identify their respective IP prefixes, VLAN IDs, and gateway IP addresses.

- Public virtual IP logical network. This network is intended for assignments of virtual IPs that represent front-end IP addresses. These IP addresses are used by external clients to access resources within virtual networks. Such as, for example, public load balancers or the front-end virtual IP of the Site-to-Site VPN gateway. Effectively, its IP address space must be routable outside of the SDN environment. You don’t need to preconfigure this network in your physical switches or routers, or assign it a VLAN.
- Private virtual IP logical network. This network is intended for the assignment of virtual IPs accessed by Azure Stack HCI tenant workloads, so it doesn't need to be routable outside of the SDN environment. You don’t need to preconfigure this network in your physical switches or routers, or assign it a VLAN.
- GRE virtual IP logical network. The GRE virtual IP network is used exclusively to define virtual IPs that are assigned to Gateway VMs for Site-to-Site GRE connections. You don’t need to preconfigure this network in your physical switches or routers, or assign it a VLAN.

### Routing configuration

To allow for connectivity between public virtual IP logical networks and external clients, it’s necessary to advertise routing information from the Software Load Balancer Multiplexer or RAS Gateway to an external BGP peer. Effectively, you need to configure a BGP peer on the router used by the SDN infrastructure to receive routes for the virtual IP logical networks advertised by the Software Load Balancer Multiplexers and RAS Gateways.

Machines that are configured to connect to multiple networks, such as the Azure Stack HCI cluster nodes and gateway VMs must only have one default gateway configured. This gateway should reside on the management network for Azure Stack HCI cluster nodes, Network Controller VMs, and Software Load Balancer Multiplexer VMs. For the gateway VMs, this gateway should reside on the HNV Provider network.

### Physical networks

There are other prerequisites that apply to switches and routers. These prerequisites account for the need to support designated Maximum Transmission Unit (MTU) settings, link control capabilities, high availability and redundancy, and routing and VLAN tagging protocols.

> [!NOTE]
> Sample configuration files for most common switch models and vendors are available from the Microsoft SDN GitHub repository.
