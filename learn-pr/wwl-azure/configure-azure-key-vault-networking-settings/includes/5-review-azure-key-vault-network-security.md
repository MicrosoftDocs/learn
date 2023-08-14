
## Key Vault Firewall Disabled (Default)

By default, when you create a new key vault, the Azure Key Vault firewall is disabled. All applications and Azure services can access the key vault and send requests to the key vault. This configuration doesn't mean that any user is able to perform operations on your key vault. The key vault still restricts access to secrets, keys, and certificates stored in key vault by requiring Azure Active Directory authentication and access policy permissions.

## Key Vault Firewall Enabled (Trusted Services Only)

When you enable the Key Vault Firewall, you are given an option to 'Allow Trusted Microsoft Services to bypass this firewall. The trusted services list doesn't cover every single Azure service. For example, Azure DevOps isn't on the trusted services list. This doesn't imply that services that do not appear on the trusted services list aren't trusted or are insecure. The trusted services list encompasses services where Microsoft controls all of the code that runs on the service. Since users can write custom code in Azure services such as Azure DevOps, Microsoft doesn't provide the option to create a blanket approval for the service. Furthermore, just because a service appears on the trusted service list, doesn't mean it is allowed for all scenarios.

## Key Vault Firewall Enabled (Internet Protocol Version 4 Addresses and Ranges - Static IPs)

If you would like to authorize a particular service to access key vault through the Key Vault Firewall, you can add its IP Address to the key vault firewall allowlist. This configuration is best for services that use static IP addresses or well-known ranges. There's a limit of 1000 Classless Inter-Domain Routing (CIDR) ranges for this case.

To allow an IP Address or range of an Azure resource, such as a Web App or Logic App, perform the following steps.

1.  Sign in to the Azure portal.
2.  Select the resource (specific instance of the service).
3.  Select on the 'Properties' blade under 'Settings'.
4.  Look for the "IP Address" field.
5.  Copy this value or range and enter it into the key vault firewall allowlist.

## Key Vault Firewall Enabled (Virtual Networks - Dynamic IPs)<br>

If you're trying to allow an Azure resource such as a virtual machine through key vault, you may not be able to use Static IP addresses, and you may not want to allow all IP addresses for Azure Virtual Machines to access your key vault.

In this case, you should create the resource within a virtual network, and then allow traffic from the specific virtual network and subnet to access your key vault.

1.  Sign in to the Azure portal
2.  Select the key vault you wish to configure
3.  Select the 'Networking' blade
4.  Select '+ Add existing virtual network'
5.  Select the virtual network and subnet you would like to allow through the key vault firewall.

## Key Vault Firewall Enabled (Private Link)

> [!IMPORTANT]
> After firewall rules are in effect, users can only perform Key Vault data plane operations when their requests originate from allowed virtual networks or internet protocol version 4 address ranges. This also applies to accessing Key Vault from the Azure portal. Although users can browse to a key vault from the Azure portal, they might not be able to list keys, secrets, or certificates if their client machine is not in the allowed list. This also affects the Key Vault Picker used by other Azure services. Users might be able to see a list of key vaults, but not list keys, if firewall rules prevent their client machine.

> [!NOTE]
> Be aware of the following configuration limitations:

 -  A maximum of 200 virtual network rules and 1000 internet protocol version 4 rules are allowed.
 -  IP network rules are only allowed for public IP addresses. IP address ranges reserved for private networks (as defined in RFC 1918) aren't allowed in IP rules. Private networks include addresses that start with 10.172.16-31, and 192.168.
 -  Only internet protocol version 4 addresses are supported at this time.

## Public Access Disabled (Private Endpoint Only)

To enhance network security, you can configure your vault to disable public access. This denies all public configurations and allows only connections through private endpoints.
