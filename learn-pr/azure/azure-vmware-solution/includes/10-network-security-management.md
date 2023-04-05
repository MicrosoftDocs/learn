In this unit, you'll learn to configure fine-grained rules, which enable Azure VMware Solution private cloud to connect with the internet.

## Block by default

Azure Firewall is configured in "block by default" design. It means any network traffic that is configured to pass through it will be blocked. So far, you've injected the default route through Azure Firewall for Azure VMware Solution private cloud. But Azure Firewall's "block by default" configuration won't allow any traffic. This is a good principle on which you can configure fine-grained rules, which enable tighter network controls.

## Outbound network rules

While "block by default" is a good principle, you need legitimate traffic to be excluded from this principle.  You can use one of the two features provided by Azure Firewall to exclude legitimate traffic from "block by default" configuration. The first feature is called "classic rules" or just "rules." As the name suggests, each Azure Firewall instance is configured with a rule, which consists of a protocol, source IP address space, source ports, destination IP address space and destination ports. This is an excellent choice for smaller deployments. But for enterprise-grade deployments, this approach has limited scalability as the rules are defined per Azure Firewall instance. When there are multiple Azure Firewall instances, the process of defining rules becomes repetitive and difficult to manage. This is where the second feature, which uses "Azure Firewall policy", becomes handy. Using Azure Firewall policy, rules are defined only once and then applied to multiple 
Azure Firewall instances.

## Firewall rules for Azure VMware Solution

In this unit, you'll use the "rule" feature instead of the "Azure Firewall policy" feature. However, using the "Azure Firewall policy" feature is recommended for enterprise-grade deployments as it offers better scalability and manageability. Defining firewall rules for Azure VMware Solution involves the workload segment IP address space, protocol, and ports. For destination type, select "IP Address". For destination address space, choose "\*" and for destination ports, choose "\*" or specific ports such as 80, 443. etc.

:::image type="content" source="../media/10-network-rules.png" alt-text="Screenshot of Azure Firewall network rule. The menu entry titled 'IP Addresses' highlight source and destination addresses." lightbox="./media/10-network-rules.png":::

