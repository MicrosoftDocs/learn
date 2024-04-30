Your organization is using Azure Virtual Desktop to provide your workforce access to virtualized desktops and apps. Because of the sensitive data with which your organization works and your organization's network security requirements, you can't have any unauthorized network traffic in your Azure Virtual Desktop environment. You've decided to deploy Azure Firewall to limit outbound network traffic for Azure Virtual Desktop.

You completed the following steps to deploy Azure Firewall to protect an Azure Virtual Desktop host pool:

1. Set up the network:

    - Created a hub virtual network that includes a subnet for the firewall deployment.
    - Peered the hub virtual network with the virtual network used by the Azure Virtual Desktop host pool.  

1. Deployed Azure Firewall:

    - Deployed Azure Firewall to a subnet in the hub virtual network.
    - For outbound traffic, created a default route that sends traffic from all subnets to the firewall's private IP address.

1. Created Azure Firewall rules:

    - Configured the firewall with rules to filter inbound and outbound traffic for the host pool.

## Clean up

[!include[](../../../includes/azure-subscription-cleanup.md)]

## Learn more

- [Understanding Azure Virtual Desktop network connectivity](/azure/virtual-desktop/network-connectivity)
- [Required FQDNs and endpoints for Azure Virtual Desktop](/azure/virtual-desktop/required-fqdn-endpoint)
- [Proxy server guidelines for Azure Virtual Desktop](/azure/virtual-desktop/proxy-server-support)
- [Office 365 IP Address and URL web service](/microsoft-365/enterprise/microsoft-365-ip-web-service)
- [How to use Microsoft Edge command-line options to configure proxy settings](/deployedge/edge-learnmore-cmdline-options-proxy-settings)