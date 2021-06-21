When you plan an Azure Firewall deployment to protect a workload like Azure Virtual Desktop, you need to know what rules to deploy to allow the appropriate network traffic.

Recall from the accounting firm example, that you can't have any unauthorized network traffic in your Azure Virtual Desktop environment. You want to limit outbound network traffic for Azure Virtual Desktop by using Azure Firewall.

For Azure Virtual Desktop to work, the session host virtual machines (VMs) need outbound internet access to the Azure Virtual Desktop service. The VMs might also need outbound internet access for your users.

<!-- Diagram to show the pieces?? highlight from one of previous diagrams-->

## Route all traffic through the firewall

After you've deployed Azure Firewall, you need to route all traffic through it. In the next exercise unit, you'll complete the following three steps.

1. Create a route table in the same resource group as your session host VMs and firewall.
1. Associate the route table to the subnet that your session host VMs uses.
1. On the route table, add the route to the firewall.

After you complete those steps, all traffic will route to Azure Firewall. By default, the firewall denies access to everything. So you need to configure conditions under which traffic is allowed through the firewall.

## Create firewall rules

To allow the appropriate network traffic for Azure Virtual Desktop, you'll need to create application and network firewall rules. You need to allow the host pool outbound network access to Azure Virtual Desktop and supporting services. Depending on your organization needs, you might want to enable secure outbound Internet access for your end users.

### Configure application rules

To allow the host pool outbound network access to Azure Virtual Desktop, create an application rule collection with the following two rules.

- Allow Azure Virtual Desktop: Use FQDN tag "WindowsVirtualDesktop" to allow traffic from the host pool virtual network.
- Allow storage and service bus accounts: Use target FQDNs to allow access from the host pool virtual network to the set of storage and service bus accounts used by the host pool. Use either wildcard FQDNs to enable the required access or, to be more restrictive, add the exact FQDNs.


    |Options |FQDNs to use|
    |---------|---------|
    |Wildcard FQDN    | *xt.blob.core.windows.net, *eh.servicebus.windows.net        |
    |Exact FQDNs    |   Use the following log analytics query to list the exact required FQDNs used by the host pool.|

     ```kusto
       AzureDiagnostics
       | where Category == "AzureFirewallApplicationRule"
       | search "Deny"
       | search "gsm*eh.servicebus.windows.net" or "gsm*xt.blob.core.windows.net"
       | parse msg_s with Protocol " request from " SourceIP ":" SourcePort:int " to " FQDN ":" *
       | project TimeGenerated,Protocol,FQDN
    ```


When you add both rules, your rule collection will look similar to the following screenshot.

:::image type="content" source="../media/6-firewall-rules-classic-application-rule-collection-form.png" alt-text="Screenshot that shows an example application rule collection form filled out.":::

You'll walk through the specific steps to create the application rule collection in the next exercise unit.

### Configure network rules

To allow Azure Virtual Desktop to work, you need to add Azure Firewall rules for DNS and the Windows Activation service.
Create a network rule collection and add the following rules:

- Allow DNS: Allow traffic from your Active Directory Domain Server (AD DS) private IP address to * for TCP and UDP ports 53.
- Allow KMS: Allow traffic from your Azure Virtual Desktop VMs to the Windows Activation Service TCP port 1688.

### Allow secure outbound Internet access for your end users

You might need to create more Azure Firewall application and network rules when you want to allow users outbound internet access.

If you have a well defined list of allowed destinations like Microsoft 365, use Azure Firewall application and network rules to route end-user traffic directly to the destinations.

To filter outbound user Internet traffic by using an existing on-premises secure web gateway, configure web browsers or other applications that run on the Azure Virtual Desktop host pool with an explicit proxy configuration.
