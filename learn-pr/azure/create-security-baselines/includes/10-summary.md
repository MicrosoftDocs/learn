We've covered many things in this module to create a baseline security checklist for commonly used Azure services. Let's quickly recap what we've gone through:

- **Turn on Microsoft Defender for Cloud - it's free**. Upgrade your Azure subscription to turn on Microsoft Defender for Cloud. Defender for Cloud's enhanced security features help you:

  - Find and fix security vulnerabilities.
  - Apply access and application controls to block malicious activity.
  - Detect threats by using analytics and intelligence.
  - Respond quickly when under attack.

- **Adopt Center for Internet Security (CIS) Benchmarks**. Apply the benchmarks to existing tenants.

- **Use CIS VMs for new workloads**. Get CIS hardened VM images in Azure Marketplace.

- **Store your keys and secrets in Azure Key Vault** (not in your source code). Key Vault is designed to support any type of secret, including passwords, database credentials, API keys, and certificates.

- **Install a web application firewall**. A web application firewall (WAF) is a feature of Azure Application Gateway that provides centralized protection of your web applications from common exploits and vulnerabilities. Third parties also offered Azure-supported WAFs.

- **Enforce multifactor verification for users, especially for your administrator accounts**. Multifactor authentication for Microsoft Entra users helps administrators protect their organizations and users by requiring more than one authentication method.

- **Encrypt your virtual hard disk files**. Encryption helps protect your boot volume and data volumes at rest in storage, along with your encryption keys and secrets.

- **Connect Azure VMs and appliances to other networked devices by placing them in Azure virtual networks**. VMs that are connected to an Azure virtual network can connect to devices that are on the same virtual network, on different virtual networks, on the internet, or on your own on-premises networks.

### Strong operational security practices to implement

Implement these strong operational security practices every day:

- **Manage your VM updates**. Azure VMs, like all on-premises VMs, are meant to be user-managed. Azure doesn't push Windows updates to these VMs. Ensure that you have solid processes in place for important operations like patch management and backup.

- **Enable password management**. Use appropriate security policies to prevent abuse.

- **Review your workload protection dashboard regularly**. Get a central view of the security state of all of your Azure resources, and take action on the recommendations regularly.

## Further reading

To explore the topics presented in this module in more detail, see [CIS Microsoft Azure Foundations Security Benchmark](/security/benchmark/azure/v2-cis-benchmark).
