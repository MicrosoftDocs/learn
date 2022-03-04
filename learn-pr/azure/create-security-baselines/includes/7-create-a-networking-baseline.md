Azure networking services maximize flexibility, availability, resiliency, security, and integrity by design. Network connectivity is possible between resources located in Azure, between on-premises and Azure-hosted resources, and to and from the internet and Azure.

## Azure networking security recommendations

Use the following security recommendations to set Azure networking policies in your Azure subscriptions. Included with each recommendation are the basic steps to follow in the Azure portal. You should perform these steps with your own subscription using your own resources to validate the security for each. Keep in mind that **Level 2** options might restrict some features or activity, so carefully consider which security options you decide to enforce.

### Restrict RDP and SSH access from the Internet - Level 1

It's possible to reach Azure virtual machines (VMs) by using **Remote Desktop Protocol (RDP)** and the **Secure Shell (SSH)** protocol. These protocols enable the management VMs from remote locations and are standard in datacenter computing.

The potential security problem with using these protocols over the internet is that attackers can use brute force techniques to gain access to Azure VMs. After the attackers gain access, they can use your VM as a launching pad for compromising other machines on your virtual network or even attack networked devices outside Azure.

We recommended that you disable direct RDP and SSH access to your Azure VMs from the internet.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Virtual machines*. The **Virtual machines** pane displays.

1. For each VM selection, in the middle menu pane, under **Settings**, select **Networking**. The **Networking** pane displays for the VM.

1. Verify that the **Inbound port rules** tab doesn't have a rule for RDP, for example: `port=3389, protocol = TCP, Source = Any or Internet`

1. Verify that the **Inbound port rules** tab doesn't have a rule for SSH, for example: `port=22, protocol = TCP, Source = Any or Internet`

    :::image type="content" source="../media/7-rdp.png" alt-text="Screenshot the VM networking pane." lightbox="../media/7-rdp.png#lightbox":::

 After direct RDP and SSH access from the internet is disabled, you have other options that you can use to access these VMs for remote management:

- Point-to-site VPN
- Site-to-site VPN
- Azure ExpressRoute
- Azure Bastion Host

### Restrict SQL Server access from the Internet - Level 1

Firewall systems help prevent unauthorized access to computer resources. If a firewall is turned on but not correctly configured, attempts to connect to SQL Server might be blocked.

To access an instance of the SQL Server through a firewall, you must configure the firewall on the computer that is running SQL Server. Allowing ingress for the IP range `0.0.0.0/0` (Start IP of `0.0.0.0` and End IP of `0.0.0.0`) allows open access to any/all traffic, potentially making the SQL database vulnerable to attacks. Ensure that no SQL databases allow ingress from the internet.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *SQL servers*. The **SQL servers** pane displays.

1. For each SQL server selection, in the middle menu pane, under **Security**, select **Firewalls and virtual networks**. The **Firewalls and virtual networks** pane displays for the SQL server.

1. Ensure that the firewall rules exist, and no rule has a **Start IP** of `0.0.0.0` and **End IP** of `0.0.0.0` or other combinations that allow access to wider public IP ranges.

1. On the top menu bar, select **Save**.

    :::image type="content" source="../media/7-firewall.png" alt-text="Screenshot of Firewalls and virtual networks pane." lightbox="../media/7-firewall.png#lightbox":::

### Configure the NSG flow log retention period for more than 90 days - Level 2

When you create or update a virtual network in your subscription, Network Watcher will be enabled automatically in your virtual network's region. There's no impact to your resources or associated charge for automatically enabling Network Watcher.

Network security group (NSG) flow logs are a feature of Network Watcher that allows you to view information about ingress and egress IP traffic through an NSG. Flow logs are written in JSON format, and show:

- Outbound and inbound flows on a per rule basis
- Network interface (NIC) the flow applies to
- 5-tuple information about the flow: source/destination IP, source/destination port, and protocol
- If the traffic was allowed or denied
- In Version 2, throughput information like bytes and packets

Logs can be used to check for anomalies and give insight into suspected breaches.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Network Watcher*. The **Network Watcher** pane displays.

1. In the left menu pane, under **Logs**, select **NSG flow logs**. The **NSG flow logs** pane displays.

1. Ensure **Retention (days)** setting is greater than 90 days.

1. On the top menu bar, select **Save**.

    :::image type="content" source="../media/7-nsg-flow.png" alt-text="Screenshot of the nsg flow log pane." lightbox="../media/7-nsg-flow.png":::

### Enable Network Watcher - Level 1

Network security group (NSG) flow logs are a feature of Network Watcher that allows you to view information about ingress and egress IP traffic through an NSG.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Network Watcher*. The **Network Watcher** pane displays.

1. Select the *Network watcher* from the appropriate subscription and location you choose. The **Network Watcher** pane displays for your subscription/location.

> [!TIP]
> Remember to select **Save** if you make changes to any of the settings.
