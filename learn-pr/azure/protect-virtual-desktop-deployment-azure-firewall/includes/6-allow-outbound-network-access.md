When you plan an Azure Firewall deployment to protect a workload like Azure Virtual Desktop, you need to know what rules to deploy to allow the appropriate network traffic.

From the accounting firm example, recall that you can't have any unauthorized network traffic in your Azure Virtual Desktop environment. You want to limit outbound network traffic for Azure Virtual Desktop by using Azure Firewall.

For Azure Virtual Desktop to work, the host pool needs outbound internet access to the Azure Virtual Desktop service. The host pool might also need outbound internet access for your users.

## Create firewall rules

To allow the appropriate network traffic for Azure Virtual Desktop, you'll need to create application and network firewall rules. You need to allow the host pool outbound network access to Azure Virtual Desktop and supporting services. Depending on your organization's needs, you might want to enable secure, outbound internet access for your end users.

## Configure application rules

To allow the host pool outbound network access to Azure Virtual Desktop, create an application rule collection with the following two rules:

|Rule  |Description |
|---------|---------|
|Allow Azure Virtual Desktop    |  Use FQDN tag *WindowsVirtualDesktop* to allow traffic from the host pool virtual network. |
|Allow storage and service bus accounts    |  Use target FQDNs to allow access from the host pool virtual network to the set of storage and service bus accounts used by the host pool. Use either wildcard FQDNs to enable the required access, or, to be more restrictive, add the exact FQDNs.       |

The following table shows the target options you can use to create a rule that allows storage and service bus accounts:

|Options |FQDNs to use|
|---------|---------|
|Wildcard FQDN    | `*xt.blob.core.windows.net`, `*eh.servicebus.windows.net`        |
|Exact FQDNs    |   Use the following Log Analytics query in Azure Monitor Logs to list the exact required FQDNs used by the host pool.|

  ```kusto
    AzureDiagnostics
    | where Category == "AzureFirewallApplicationRule"
    | search "Deny"
    | search "gsm*eh.servicebus.windows.net" or "gsm*xt.blob.core.windows.net"
    | parse msg_s with Protocol " request from " SourceIP ":" SourcePort:int " to " FQDN ":" *
    | project TimeGenerated,Protocol,FQDN
  ```


When you add both rules, your rule collection will look similar to the following screenshot:

:::image type="content" source="../media/6-firewall-rules-classic-application-rule-collection-form.png" alt-text="Screenshot that shows an example application rule collection form filled out." lightbox="../media/6-firewall-rules-classic-application-rule-collection-form.png":::

You'll walk through the specific steps to create the application rule collection in the next exercise.

## Configure network rules

To allow Azure Virtual Desktop to work, you need to add Azure Firewall rules for DNS and the Windows activation service.

Create a network rule collection and add the following rules:

|Rule  |Description  |
|---------|---------|
|Allow DNS    |Allow traffic from your Active Directory Domain Server private IP address to * for TCP and UDP ports 53. Some deployments might not need DNS rules. For example, Microsoft Entra Domain Services forwards DNS queries to Azure DNS at 168.63.129.16. |
|Allow KMS    |  Allow traffic from your Azure Virtual Desktop VMs to the Windows activation service TCP port 1688.|

When you add both network rules, your rule collection will look similar to the following screenshot:

:::image type="content" source="../media/6-network-collection-example.png" alt-text="Screenshot that shows a network collection with rules added to allow DNS and KMS traffic." lightbox="../media/6-network-collection-example.png":::

You'll walk through the specific steps to create a network rule collection in the next exercise.

### Allow secure outbound internet access for your users

You might need to create more Azure Firewall application and network rules when you want to allow users outbound internet access.

If you have a well-defined list of allowed destinations—like Microsoft 365—use Azure Firewall application and network rules to route end-user traffic directly to the destinations. For information about the Office 365 IP address and URL web service, see the resources listed in this module's Summary section.

You might want to filter outbound user internet traffic by using an existing, on-premises, secure web gateway. To do this, you can configure web browsers or other applications that run on the Azure Virtual Desktop host pool with an explicit proxy configuration. For example, you can use Microsoft Edge command-line options to configure proxy settings. These proxy settings only influence internet access for your users, and allow the Azure Virtual Desktop service outbound traffic directly through Azure Firewall. For more information, see the resources listed in this module's Summary section.
