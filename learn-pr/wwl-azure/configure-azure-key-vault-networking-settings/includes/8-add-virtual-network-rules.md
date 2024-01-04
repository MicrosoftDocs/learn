The virtual network service endpoints for Azure Key Vault allow you to restrict access to a specified virtual network. The endpoints also allow you to restrict access to a list of internet protocol version 4 address ranges. Any user connecting to your key vault from outside those sources is denied access.

There is one important exception to this restriction. If a user has opted-in to allow trusted Microsoft services, connections from those services are let through the firewall. For example, these services include Office 365 Exchange Online, Office 365 SharePoint Online, Azure compute, Azure Resource Manager, and Azure Backup. Such users still need to present a valid Azure Active Directory token, and must have permissions (configured as access policies) to perform the requested operation.

## Usage scenarios

You can configure Key Vault firewalls and virtual networks to deny access to traffic from all networks (including internet traffic) by default. You can grant access to traffic from specific Azure virtual networks and public internet IP address ranges, allowing you to build a secure network boundary for your applications.

> [!NOTE]
> Key Vault firewalls and virtual network rules only apply to the data plane of Key Vault. Key Vault control plane operations (such as create, delete, and modify operations, setting access policies, setting firewalls, and virtual network rules and deployment of secrets or keys through Azure resource manger templates are not affected by firewalls and virtual network rules.

Here are some examples of how you might use service endpoints:

 -  You are using Key Vault to store encryption keys, application secrets, and certificates, and you want to block access to your key vault from the public internet.
 -  You want to lock down access to your key vault so that only your application, or a short list of designated hosts, can connect to your key vault.
 -  You have an application running in your Azure virtual network, and this virtual network is locked down for all inbound and outbound traffic. Your application still needs to connect to Key Vault to fetch secrets or certificates, or use cryptographic keys.

## Grant access to trusted Azure services

You can grant access to trusted Azure services to the key vault, while maintaining network rules for other apps. These trusted services will then use strong authentication to securely connect to your key vault.

You can grant access to trusted Azure services by configuring networking settings.

When you grant access to trusted Azure services, you grant the following types of access:

 -  Trusted access for select operations to resources that are registered in your subscription.
 -  Trusted access to resources based on a managed identity.
 -  Trusted access across tenants using a Federated Identity Credential
