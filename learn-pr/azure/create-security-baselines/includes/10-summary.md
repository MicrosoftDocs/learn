We've covered many things in this module to create a baseline security checklist for commonly used Azure services. Let's quickly recap what we've gone through.

1. **Turn on Microsoft Defender for Cloud - it's free** - Upgrade your Azure subscription for Microsoft Defender for Cloud. Defender for Cloud's enhanced security features help you:

    - Find and fix security vulnerabilities.
    - Apply access and application controls to block malicious activity.
    - Detect threats using analytics and intelligence.
    - Respond quickly when under attack.

1. **Adopt Center for Internet Security (CIS) Benchmarks** - Apply them to existing tenants.

1. **Use CIS VMs for new workloads** - Acquire from Azure Marketplace.

1. **Store your keys and secrets in Azure Key Vault** (and not in your source code) - Key Vault is designed to support any type of secret: passwords, database credentials, API keys and, certificates.

1. **Install a web application firewall** - Web application firewall (WAF) is a feature of Application Gateway that provides centralized protection of your web applications from common exploits and vulnerabilities.

1. **Enforce multi-factor verification for users, especially for your administrator accounts**- Azure AD Multi-Factor Authentication (Azure AD MFA) helps administrators protect their organizations and users with more authentication methods.

1. **Encrypt your virtual hard disk files** - This encryption will help protect your boot volume and data volumes at rest in storage, along with your encryption keys and secrets.

1. **Connect Azure virtual machines (VMs) and appliances to other networked devices by placing them on Azure virtual networks** -  VMs connected to an Azure virtual network can connect to devices on the same virtual network, different virtual networks, the internet, or your own on-premises networks.

### Strong operational security practices to implement

Strong operational security practices to implement every day are:

1. **Manage your VM updates** - Azure VMs, like all on-premises VMs, are meant to be user managed. Azure doesn't push Windows updates to them. Ensure you have solid processes in place for important operations such as patch management and backup.

1. **Enable password management** and use appropriate security policies to prevent abuse.

1. **Review your workload protection dashboard regularly** to get a central view of the security state of all of your Azure resources, and take action on the recommendations.

## Further reading

To explore the topics presented in this module in more details, see the following article:

- [CIS Microsoft Azure Foundations Security Benchmark](/security/benchmark/azure/v2-cis-benchmark)
