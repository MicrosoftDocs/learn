In this unit, you conclude your proof of concept by testing the most common scenarios you expect to encounter in your production environment. These scenarios include internal load balancing and network address translation (NAT)-based access to virtualized workloads.

## Implement Software Load Balancer

To implement Software Load Balancer, you first deploy the Network Controller and provision one or more Software Load Balancer multiplexer virtual machines (VMs). The Network Controller serves as the SLB management interface. You also configure Hyper-V hosts with the SDN-enabled Hyper-V virtual switch, and verify that the SLB Host Agent is running. The routers that serve the hosts must support equal cost multipath routing and Border Gateway Protocol (BGP), and must be configured to accept BGP peering requests from the Software Load Balancer Multiplexers.

You can configure SLB to provide the following functionality:

- Load-balance incoming external traffic to VMs on a virtual network, also called the public virtual IP (VIP) load balancing.
- Load-balance incoming traffic from VMs in the same virtual network or a peered private network, also called the internal or private VIP load balancing.
- Forward outgoing network traffic from VMs on a virtual network to external destinations by using NAT, also called the outbound NAT.
- Forward incoming external traffic to a specific VM, also called the inbound NAT.

To implement these scenarios, you create the following different types of load balancers:

- **Internal SLB** is an internal load balancer with target VMs that reside within an SDN virtual network subnet.
- **Public IP SLB** is an external load balancer with target VMs that reside within an SDN virtual network subnet, a logical network subnet, or a VLAN. To create this type of load balancer, you first need to provision a public IP address.
- **IP address SLB** is also an external load balancer with target VMs that reside within an SDN virtual network subnet, a logical network subnet, or a VLAN. Creating this type of load balancer automatically provisions a corresponding public IP address, which is automatically deprovisioned when the load balancer is deleted.

### Implement internal load balancing

To implement internal load balancing of network traffic across a pool of VMs on a virtual network, use the following procedure:

1. Create a load balancer to serve as the load-balancing VIP and assign it a private front-end IP address. The VIP must be an available IP from a logical network IP pool allocated for private load balancing.

   :::image type="content" source="../media/5-azure-stack-hci-slb-private-vip-new.png" alt-text="Screenshot of the Windows Admin Center New Load Balancer pane with the Private VIP option selected." lightbox="../media/5-azure-stack-hci-slb-private-vip-new.png":::

1. Create a backend pool that contains the dynamic IPs assigned to the network interfaces of the VMs that host a load-balanced workload.

1. Configure a health probe that the load balancer uses to determine the health state of the VMs in the backend pool.

   The health probe uses either TCP or HTTP protocol to validate the operational status of the load-balanced workload. HTTP-based probes offer more flexibility, because they allow you to create custom webpages that implement arbitrary tests to do the validation. TCP-based probes simply rely on an acknowledgment to confirm that each target VM is reachable. If the backend IP isn't healthy, the load balancer excludes it from distribution of incoming requests.

   > [!NOTE]
   > Ensure that you don't block traffic to or from the first IP in the subnet for any access control lists (ACLs) that you apply to the backend dynamic IPs, because that's the origination point for the probes.

1. Create a load-balancing rule that relays traffic arriving at the front-end VIP to one of the backend pool dynamic IPs. For example, the rule might be configured to distribute TCP traffic on port 80 to the same port on the backend pool VMs.

   :::image type="content" source="../media/5-azure-stack-hci-slb-private-vip-rule-create-1.png" alt-text="Screenshot of the Windows Admin Center New Load Balancing Rule pane." lightbox="../media/5-azure-stack-hci-slb-private-vip-rule-create-1.png":::

### Implement inbound NAT

To implement inbound NAT from an external network to one or more designated VMs in a virtual network, use the following procedure:

1. Create a load balancer to serve as the load-balancing VIP and assign it a public front-end IP address. The VIP must be an available IP from a logical network IP pool allocated for public load balancing.

   :::image type="content" source="../media/5-azure-stack-hci-slb-public-vip-new.png" alt-text="Screenshot of the Windows Admin Center New Load Balancer pane with the Public VIP option selected." lightbox="../media/5-azure-stack-hci-slb-public-vip-new.png":::

1. Create a backend pool that contains the dynamic IPs assigned to the network interfaces of the VMs you intend to connect to via NAT.

1. Create an inbound NAT rule for traffic arriving at a specific port on the front-end VIP. Relay the traffic to a designated port of the dynamic IP assigned to the network interface of the target VM.

   :::image type="content" source="../media/5-azure-stack-hci-slb-private-vip-public-nat-completed.png" alt-text="Screenshot of the Windows Admin Center Load balancers pane with the two load balancers created." lightbox="../media/5-azure-stack-hci-slb-private-vip-public-nat-completed.png":::
