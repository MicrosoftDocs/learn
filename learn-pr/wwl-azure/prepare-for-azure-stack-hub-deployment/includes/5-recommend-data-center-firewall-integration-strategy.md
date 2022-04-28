Use a firewall device to help secure Azure Stack Hub. Firewalls can help defend against things like distributed denial-of-service (DDOS) attacks, intrusion detection, and content inspection. However, they can also become a throughput bottleneck for Azure storage services like blobs, tables, and queues.

If a disconnected deployment mode is used, you must publish the AD FS endpoint.

The Azure Resource Manager (administrator), administrator portal, and Key Vault (administrator) endpoints don't necessarily require external publishing. For example, as a service provider, you could limit the attack surface by only administering Azure Stack Hub from inside your network, and not from the internet.

For enterprise organizations, the external network can be the existing corporate network. In this scenario, you must publish endpoints to operate Azure Stack Hub from the corporate network.

### Network Address Translation

Network Address Translation (NAT) is the recommended method to allow the deployment virtual machine (DVM) to access external resources and the internet during deployment as well as the Emergency Recovery Console (ERCS) virtual machines or privileged endpoint (PEP) during registration and troubleshooting.

NAT can also be an alternative to Public IP addresses on the external network or public VIPs. However, it's not recommended to do so because it limits the tenant user experience and increases complexity. One option would be a one to one NAT that still requires one public IP per user IP on the pool. Another option is a many to one NAT that requires a NAT rule per user VIP for all ports a user might use.

Some of the downsides of using NAT for Public VIP are:

 -  NAT adds overhead when managing firewall rules because users control their own endpoints and their own publishing rules in the software-defined networking (SDN) stack. Users must contact the Azure Stack Hub operator to get their VIPs published, and to update the port list.
 -  While NAT usage limits the user experience, it gives full control to the operator over publishing requests.
 -  For hybrid cloud scenarios with Azure, consider that Azure doesn't support setting up a VPN tunnel to an endpoint using NAT.

### SSL interception

It's currently recommended to disable any SSL interception (for example decryption offloading) on all Azure Stack Hub traffic. If it's supported in future updates, guidance will be provided about how to enable SSL interception for Azure Stack Hub.

## Edge firewall scenario

In an edge deployment, Azure Stack Hub is deployed directly behind the edge router or the firewall. In these scenarios, it's supported for the firewall to be above the border (Scenario 1) where it supports both active-active and active-passive firewall configurations or acting as the border device (Scenario 2) where it only supports active-active firewall configuration relying on equal-cost multi-path (ECMP) with either BGP or static routing for failover.

Public routable IP addresses are specified for the public VIP pool from the external network at deployment time. In an edge scenario, it's not recommended to use public routable IPs on any other network for security purposes. This scenario enables a user to experience the full self-controlled cloud experience as in a public cloud like Azure.

:::image type="content" source="../media/recommend-firewall-1-a028dc08.png" alt-text="Image showing normalized relational tables.":::


## Enterprise intranet or perimeter network firewall scenario

In an enterprise intranet or perimeter deployment, Azure Stack Hub is deployed on a multi-zoned firewall or in between the edge firewall and the internal, corporate network firewall. Its traffic is then distributed between the secure, perimeter network (or DMZ), and unsecure zones as described below:

 -  **Secure zone**: This is the internal network that uses internal or corporate routable IP addresses. The secure network can be divided, have internet outbound access through NAT on the Firewall, and is accessible from anywhere inside your datacenter via the internal network. All Azure Stack Hub networks should reside in the secure zone except for the external network's public VIP pool.
 -  **Perimeter zone**. The perimeter network is where external or internet-facing apps like Web servers are typically deployed. It's monitored by a firewall to avoid attacks like DDoS and intrusion (hacking) while still allowing specified inbound traffic from the internet. Only the external network public VIP pool of Azure Stack Hub should reside in the DMZ zone.
 -  **Unsecure zone**. This is the external network, the internet. It **is not** recommended to deploy Azure Stack Hub in the unsecure zone.
    
    :::image type="content" source="../media/recommend-firewall-2-f62ad6a0.png" alt-text="Image showing datacenter and firewall protection.":::
    
