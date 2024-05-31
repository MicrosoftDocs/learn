You can use Azure Firewall to protect the network traffic for Azure services like Azure Virtual Desktop. Azure Firewall is a managed network security service that's cloud-based and that protects your Azure Virtual Network resources. It's a fully stateful and centralized network firewall as a service. It provides network-level and application-level protection across different subscriptions and virtual networks.

## Example scenario

Suppose you work at a large accounting firm, where you've deployed a host pool on Azure Virtual Desktop. Your organization is using Azure Virtual Desktop to provide your workforce access to virtualized desktops and apps, including some legacy apps. Because of the sensitive data with which your organization works and your organization's network-security requirements, network security is very important to you. You can't have any unauthorized network traffic in your Azure Virtual Desktop environment. You want to start by limiting outbound network traffic for Azure Virtual Desktop by using Azure Firewall.

## What will we be doing?

In this module, you'll:

- Deploy an Azure Firewall instance.
- Configure the subnet for your Azure Virtual Desktop host pool to route all network traffic through Azure Firewall.
- Configure the subnet and use an application rule to allow outbound network access from the host pool to Azure Virtual Desktop.

## What is the main goal?

By the end of this module, you'll be able to deploy and configure Azure Firewall to protect outbound network traffic for Azure Virtual Desktop.
