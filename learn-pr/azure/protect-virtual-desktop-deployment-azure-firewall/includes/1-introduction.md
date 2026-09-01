You can use Azure Firewall to protect network traffic for Azure services such as Azure Virtual Desktop. Azure Firewall is a managed, stateful network security service that provides network-level and application-level protection across subscriptions and virtual networks.

## Example scenario

Suppose you work at a large accounting firm that uses Azure Virtual Desktop to provide virtualized desktops and apps. Your organization handles sensitive data and must restrict unauthorized outbound traffic. You want to use Azure Firewall to allow only the network destinations that your session hosts and users need.

In this module, the firm allows only required Azure Virtual Desktop, supporting, certificate-validation, and Windows activation endpoints. General user internet access isn't part of the policy that you implement.

## What you'll do

In this module, you'll:

- Deploy Azure Firewall with a Firewall Policy.
- Configure Azure Firewall as a DNS proxy for fully qualified domain name (FQDN) network rules.
- Configure a default route through Azure Firewall and a direct service-tag route for Azure Virtual Desktop gateway and broker traffic.
- Configure application and network rules for required Azure Virtual Desktop endpoints.

## Main goal

By the end of this module, you'll be able to deploy and configure Azure Firewall to protect outbound network traffic for Azure Virtual Desktop.
