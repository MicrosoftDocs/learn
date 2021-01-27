We've covered a lot of ground in this module to create a baseline security checklist for commonly used Azure services. Let's quickly recap what we've gone through.

1. **Turn on Azure Security Center - it's free** - Upgrade your Azure subscription to Azure Security Center Standard. Security Center's Standard tier helps you find and fix security vulnerabilities, apply access and application controls to block malicious activity, detect threats using analytics and intelligence, and respond quickly when under attack.

1. **Adopt CIS Benchmarks** - Apply them to existing tenants.

1. **Use CIS VMs for new workloads** - from Azure Marketplace.

1. **Store your keys and secrets in Azure Key Vault** (and not in your source code) - Key Vault is designed to support any type of secret: passwords, database credentials, API keys and, certificates.

1. **Install a web application firewall** - Web application firewall (WAF) is a feature of Application Gateway that provides centralized protection of your web applications from common exploits and vulnerabilities.

1. **Enforce multi-factor verification for users, especially your administrator accounts**- Azure AD Multi-Factor Authentication (Azure AD MFA) helps administrators protect their organizations and users with additional authentication methods.

1. **Encrypt your virtual hard disk files** - This will help protect your boot volume and data volumes at rest in storage, along with your encryption keys and secrets.

1. **Connect Azure virtual machines and appliances to other networked devices by placing them on Azure virtual networks** -  Virtual machines connected to an Azure virtual network can connect to devices on the same virtual network, different virtual networks, the Internet, or your own on-premises networks.

### Strong operational security practices to implement every day are:

1. **Manage your VM updates** - Azure VMs, like all on-premises VMs, are meant to be user managed. Azure doesn't push Windows updates to them. Ensure you have solid processes in place for important operations such as patch management and backup.

1. **Enable password management** and use appropriate security policies to prevent abuse.

1. **Review your Security Center dashboard regularly** to get a central view of the security state of all of your Azure resources and take action on the recommendations.

## Further reading

To explore the topics presented in this module in more details, refer to the following external links.

- [CIS Microsoft Azure Foundations Security Benchmark](https://azure.microsoft.com/resources/cis-microsoft-azure-foundations-security-benchmark/)
