When an end user connects to an Azure Virtual Desktop environment, their session is run by a host pool.

 -  A host pool is a collection of Azure virtual machines that register to Azure Virtual Desktop as session hosts.
 -  These virtual machines run in your virtual network and are subject to the virtual network security controls.
 -  They need outbound Internet access to the Azure Virtual Desktop service to operate properly and might also need outbound Internet access for end users.
 -  Azure Firewall can help you lock down your environment and filter outbound traffic.

:::image type="content" source="../media/network-security-auzre-firewall-71cb8db3.png" alt-text="Diagram showing the Azure Virtual Desktop architecture.":::


### Host pool outbound access to Azure Virtual Desktop

The Azure virtual machines you create for Azure Virtual Desktop must have access to several Fully Qualified Domain Names (FQDNs) to function properly. Azure Firewall provides an Azure Virtual Desktop FQDN Tag to simplify this configuration. Use the following steps to allow outbound Azure Virtual Desktop platform traffic:

 -  Deploy Azure Firewall and configure your Azure Virtual Desktop host pool subnet User Defined Route (UDR) to route all traffic via the Azure Firewall. Your default route now points to the firewall.
 -  Create an application rule collection and add a rule to enable the *WindowsVirtualDesktop* FQDN tag. The source IP address range is the host pool virtual network, the protocol is **https**, and the destination is **WindowsVirtualDesktop**.
 -  The set of required storage and service bus accounts for your Azure Virtual Desktop host pool is deployment-specific. It isn't captured in the `WindowsVirtualDesktop` FQDN tag. You can address this in one of the following ways:
     -  Allow https access from your host pool subnet to `*xt.blob.core.windows.net`, `*eh.servicebus.windows.net` and `*xt.table.core.windows.net`. These wildcard FQDNs enable the required access, but are less restrictive.
     -  Use the following log analytics query to list the exact required FQDNs, and then allow them explicitly in your firewall application rules:

```
AzureDiagnostics
| where Category == "AzureFirewallApplicationRule"
| search "Deny"
| search "gsm*eh.servicebus.windows.net" or "gsm*xt.blob.core.windows.net" or "gsm*xt.table.core.windows.net"
| parse msg_s with Protocol " request from " SourceIP ":" SourcePort:int " to " FQDN ":" *
| project TimeGenerated,Protocol,FQDN

```

 -  Create a network rule collection add the following rules:
     -  **Allow DNS.** Traffic from your AD DS private IP address to `*` for TCP and UDP ports 53.
     -  **Allow KMS.** Traffic from your Azure Virtual Desktop virtual machines to Windows Activation Service TCP port 1688.

Some deployments may not need DNS rules, for example Microsoft Entra Domain controllers forward DNS queries to Azure DNS at 168.63.129.16.

## Host pool outbound access to the Internet

Depending on your organization needs, you may want to enable secure outbound Internet access for your end users. In cases where the list of allowed destinations is well-defined (for example, Microsoft 365 access) you can use Azure Firewall application and network rules to configure the required access. This routes end-user traffic directly to the Internet for best performance.

You can filter outbound user Internet traffic using an existing on-premises secure web gateway. You can configure web browsers and applications running on the Azure Virtual Desktop host pool with an explicit proxy configuration. These proxy settings only influence your end-user Internet access, allowing the Azure Virtual Desktop platform outbound traffic directly via Azure Firewall.
