When you plan an Azure Firewall deployment to protect a workload like Azure Virtual Desktop, you need to know what rules to deploy to allow the appropriate network traffic.

In the accounting-firm scenario, you must prevent unauthorized outbound traffic from the Azure Virtual Desktop environment. You want to limit outbound traffic by using Azure Firewall.

For Azure Virtual Desktop to work, the host pool needs outbound access to the Azure Virtual Desktop service. This module allows only the endpoints that the deployment requires. In production, you can add rules for approved user destinations.

## Create firewall rules

To allow the appropriate network traffic for Azure Virtual Desktop, you'll need to create application and network firewall rules. You need to allow the host pool outbound network access to Azure Virtual Desktop and supporting services. Depending on your organization's needs, you might want to enable secure, outbound internet access for your end users.

## Configure application rules

To allow the host pool outbound network access to Azure Virtual Desktop, create an application rule collection for the service FQDN tag and the current supporting endpoints:

|Rule  |Description |
|---------|---------|
|Allow Azure Virtual Desktop | Use the FQDN tag `WindowsVirtualDesktop` to allow HTTPS traffic from the host-pool virtual network to Azure Virtual Desktop service endpoints. |
|Allow supporting HTTPS endpoints | Allow the current authentication, agent-update, monitoring, portal-support, and service FQDNs on TCP 443. |
|Allow certificate endpoints | Allow the certificate validation FQDNs on TCP 80. |

The required endpoint list changes as the service evolves. Review [Required FQDNs and endpoints for Azure Virtual Desktop](/azure/virtual-desktop/required-fqdn-endpoint) when you deploy or review firewall rules. The Service Bus endpoint `*eh.servicebus.windows.net` is optional and is needed only if you send diagnostic settings to an event hub. Don't enable Transport Layer Security (TLS) inspection on Azure Virtual Desktop traffic.

You'll walk through the specific steps to create the application rule collection in the next exercise.

## Configure network rules

To allow Azure Virtual Desktop to work, you need a network rule for Windows activation. The `WindowsVirtualDesktop` service-tag route allows direct relayed Remote Desktop Protocol (RDP) connectivity on UDP port 3478 without sending that traffic through the firewall.

Create a network rule collection and add the following rules:

|Rule  |Description  |
|---------|---------|
|Allow KMS | Allow Key Management Services (KMS) traffic on TCP port 1688 from the session-host subnet to `azkms.core.windows.net`. Azure Firewall resolves the FQDN and updates the network rule when its IP addresses change. |

The session host in this module uses Azure Firewall as its DNS proxy, and the firewall uses Azure DNS as its upstream resolver. If your production environment uses custom upstream DNS servers, configure them in the Firewall Policy. Allow TCP and UDP port 53 when traffic from Azure Firewall to those resolvers crosses another filtering device.

You'll walk through the specific steps to create a network rule collection in the next exercise.

### Allow secure outbound internet access for your users

You might need to create more Azure Firewall application and network rules when you want to allow users outbound internet access.

If you have a well-defined list of allowed destinations, such as Microsoft 365, use Azure Firewall application and network rules to route end-user traffic directly to the destinations. For information about the Office 365 IP address and URL web service, see the resources listed in this module's Summary section.

You might want to filter outbound user internet traffic by using an existing, on-premises, secure web gateway. To do this, you can configure web browsers or other applications that run on the Azure Virtual Desktop host pool with an explicit proxy configuration. For example, you can use Microsoft Edge command-line options to configure proxy settings. These proxy settings only influence internet access for your users, and allow the Azure Virtual Desktop service outbound traffic directly through Azure Firewall. For more information, see the resources listed in this module's Summary section.
