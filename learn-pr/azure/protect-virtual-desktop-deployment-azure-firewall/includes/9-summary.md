Your organization uses Azure Virtual Desktop to provide virtualized desktops and apps. To meet its network security requirements, you deployed Azure Firewall to restrict outbound session-host traffic.

You completed the following steps to deploy Azure Firewall to protect an Azure Virtual Desktop host pool:

1. Set up the network:

    - Created a hub virtual network that includes a subnet for the firewall deployment.
    - Peered the hub virtual network with the virtual network used by the Azure Virtual Desktop host pool.

1. Deployed Azure Firewall:

    - Deployed Azure Firewall with a Firewall Policy to a subnet in the hub virtual network.
    - Enabled DNS proxy and configured the session-host virtual network to use the firewall for DNS resolution.
    - Created a default route that sends traffic without a more specific route to the firewall's private IP address.
    - Created a `WindowsVirtualDesktop` service-tag route that sends gateway, broker, and relayed RDP traffic directly to the service.

1. Created Azure Firewall rules:

    - Configured application rules for Azure Virtual Desktop service, supporting, and certificate-validation endpoints.
    - Configured an FQDN network rule for Windows activation.
    - Validated required endpoint access with the Azure Virtual Desktop Agent URL Tool.

For a production deployment, review the required Azure Virtual Desktop endpoint list regularly, monitor Azure Firewall logs and metrics, and update the Firewall Policy when service requirements change. Add access for user applications only after your organization approves the destinations.

## Clean up

[!include[](../../../includes/azure-subscription-cleanup.md)]

## Learn more

- [Understanding Azure Virtual Desktop network connectivity](/azure/virtual-desktop/network-connectivity)
- [Use Azure Firewall to protect Azure Virtual Desktop deployments](/azure/firewall/protect-azure-virtual-desktop)
- [Required FQDNs and endpoints for Azure Virtual Desktop](/azure/virtual-desktop/required-fqdn-endpoint)
- [Check access to required FQDNs and endpoints for Azure Virtual Desktop](/azure/virtual-desktop/check-access-validate-required-fqdn-endpoint)
- [Proxy server guidelines for Azure Virtual Desktop](/azure/virtual-desktop/proxy-server-support)
- [Office 365 IP Address and URL web service](/microsoft-365/enterprise/microsoft-365-ip-web-service)
- [How to use Microsoft Edge command-line options to configure proxy settings](/deployedge/edge-learnmore-cmdline-options-proxy-settings)