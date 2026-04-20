
Azure provides a range of interconnected infrastructure security services that protect your resources at multiple layers—from network-level DDoS mitigation to application-layer firewall protection, secure remote access, and cryptographic key management.

In this module, you explored the following services:

- **Azure DDoS Protection** protects applications and servers from distributed denial of service attacks at layers 3 and 4. It offers two tiers—DDoS Network Protection and DDoS IP Protection—that provide dedicated monitoring, telemetry, alerting, and, for Network Protection, rapid response support.
- **Azure Firewall** is a managed, cloud-based, stateful network security service. It's available in Basic, Standard, and Premium SKUs to match different organizational needs, and supports centralized management through Azure Firewall Manager.
- **Web Application Firewall (WAF)** provides centralized protection for web applications against common exploits like SQL injection and cross-site scripting. WAF can be deployed with Azure Application Gateway, Azure Front Door, or Azure CDN.
- **Azure Virtual Networks** are the fundamental building block for private networking in Azure. Subnets, VNet peering, and traffic filtering through NSGs and Azure Firewall enable network segmentation that supports defense-in-depth and the Zero Trust principle of assume breach.
- **Network Security Groups (NSGs)** filter inbound and outbound network traffic using configurable rules based on IP address, port, and protocol. Application security groups (ASGs) let you group VMs and manage security policies based on your application’s structure.
- **Azure Bastion** is a fully managed PaaS service that provides secure RDP and SSH connectivity to virtual machines directly from the Azure portal, over TLS, without requiring public IP addresses or open management ports. It’s available in Developer, Basic, Standard, and Premium SKUs.
- **Azure Key Vault** centralizes the storage and management of secrets, keys, and certificates. It enforces the Zero Trust principle of least privilege access through Microsoft Entra ID authentication and Azure RBAC, and integrates with a wide range of Azure services.

Together, these services support a defense-in-depth strategy that layers multiple security controls to reduce the risk and impact of security breaches.

Now that you've completed this module, you should be able to:

- Describe Azure DDoS Protection and the tiers available.
- Describe Azure Firewall and its key capabilities.
- Describe Web Application Firewall (WAF) and the types of attacks it protects against.
- Describe network segmentation with Azure Virtual Networks.
- Describe Azure Network Security Groups and how they filter network traffic.
- Describe Azure Bastion and how it provides secure remote access to virtual machines.
- Describe Azure Key Vault and how it helps manage secrets, keys, and certificates.

## Learn more

To learn more about any of the topics covered in this module, go to:

### Azure DDoS Protection

- [What is Azure DDoS Protection?](/azure/ddos-protection/ddos-protection-overview)
- [Azure DDoS Protection tier comparison](/azure/ddos-protection/ddos-protection-sku-comparison)

### Azure Firewall

- [What is Azure Firewall?](/azure/firewall/overview)
- [Azure Firewall features by SKU](/azure/firewall/features-by-sku)
- [What is Azure Firewall Manager?](/azure/firewall-manager/overview)
- [Azure Firewall integration in Microsoft Security Copilot](/azure/firewall/firewall-copilot)

### Web Application Firewall

- [What is Azure Web Application Firewall?](/azure/web-application-firewall/overview)
- [Azure Web Application Firewall integration in Microsoft Security Copilot](/azure/web-application-firewall/waf-copilot)

### Azure Virtual Networks and network segmentation

- [What is Azure Virtual Network?](/azure/virtual-network/virtual-networks-overview)

### Network Security Groups

- [Network security groups](/azure/virtual-network/network-security-groups-overview)

### Azure Bastion

- [What is Azure Bastion?](/azure/bastion/bastion-overview)
- [Azure Bastion SKU comparison](/azure/bastion/bastion-sku-comparison)

### Azure Key Vault

- [About Azure Key Vault](/azure/key-vault/general/overview)
