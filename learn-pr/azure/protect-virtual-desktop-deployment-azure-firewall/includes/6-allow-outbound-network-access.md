When you plan an Azure Firewall deployment to protect a workload like Azure Virtual Desktop, you need to know what rules to deploy to allow the appropriate network traffic.

Recall from the accounting firm example, that you can't have any unauthorized network traffic in your Azure Virtual Desktop environment. You want to limit outbound network traffic for Azure Virtual Desktop by using Azure Firewall.

For Azure Virtual Desktop to work, the session host VMs need outbound internet access to the Azure Virtual Desktop service. The VMs might also need outbound internet access for your users.

<!-- Diagram to show the pieces?? highlight from one of previous diagrams-->

## Route all traffic through the firewall

After you've deployed Azure Firewall, you need to route all traffic through it. In the next exercise unit, you'll complete the following three steps.

1. Create a route table in the same resource group as your session host VMs and firewall.
1. Associate the route table to the subnet that your session host VMs uses.
1. On the route table, add the route to the firewall.

After you complete those steps, all traffic will route to Azure Firewall. By default, the firewall denies access to everything. So you need to configure conditions under which traffic is allowed through the firewall.

## Create firewall rules

To allow the appropriate network traffic for Azure Virtual Desktop, you'll need to create application and network firewall rules.

### Configure application rules

Allow outbound network access from the host pool to the Internet:

- When the list of allowed destinations is well-defined (e.g. Microsoft 365 access). 
- Use Azure Firewall application and network rules to configure the required access.
- To filter outbound user Internet traffic using an existing on-premises secure web gateway, configure web browsers or other applications running on the Azure Virtual Desktop host pool with an explicit proxy configuration.

### Configure network rules