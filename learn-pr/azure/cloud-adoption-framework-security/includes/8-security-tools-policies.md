In the Tailwind Traders narrative, the customer chose a "start small" approach to Azure landing zones. This means that their current implementation doesn't include all the suggested security controls. Ideally, the customer would have started with the Azure landing zone accelerator, which would have already installed many of the following tools.

This unit describes which controls to add to this customer's environment to move closer to the Azure landing zones conceptual architecture and prepare the organization's security requirements.

Several tools and controls are available to help you quickly achieve a security baseline:

- [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction): Provides the tools needed to harden your resources, track your security posture, protect against cyberattacks, and streamline security management.
- [Azure Active Directory (Azure AD)](/security/benchmark/azure/baselines/aad-security-baseline): The default identity and access management service. Azure AD provides an identity security score to help you assess your identity security posture relative to Microsoft's recommendations.
- [Microsoft Sentinel](/azure/sentinel/overview): A cloud-native SIEM that provides intelligent security analytics for your entire enterprise, powered by AI.
- [Azure Distributed Denial of Service (DDoS) standard protection plan](/azure/ddos-protection/ddos-protection-overview) (optional): Provides enhanced DDoS mitigation features to defend against DDoS attacks.
- [Azure Firewall](/azure/firewall/overview): A cloud-native and intelligent network firewall security service that provides threat protection for your cloud workloads running in Azure.
- [Web Application Firewall](https://azure.microsoft.com/services/web-application-firewall/): A cloud-native service that protects web apps from common web-hacking techniques such as SQL injection and security vulnerabilities such as cross-site scripting.
- [Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure): A service in Azure AD that enables you to manage, control, and monitor access to important resources in your organization.
- [Microsoft Intune](/mem/intune/fundamentals/what-is-intune): A cloud-based service that focuses on mobile device management and mobile application management.

The following sections illustrate how Tailwind Traders might achieve a security baseline in practice.

## Baseline implementation for access control

The CISO wants to achieve the following objectives from the customer narrative:

- Allow people to do their jobs securely from anywhere.
- Minimize business damage from a major security incident.

If these objectives align to your organization, or if you have other drivers to increase access controls, factor the following tasks into your security baseline:

- Implement Azure AD to enable strong credentials.
- Add Intune for device security.
- Add PIM for privileged accounts to move closer to a Zero-Trust world.
- Implement sound network segmentation by using a hub-and-spoke model with break-glass controls and firewall controls between application landing zones.
- Add Defender for Cloud and Azure Policy to monitor adherence to these requirements.

## Baseline implementation for compliance

The CISO wants to achieve the following objective from the customer narrative:

- Proactively meet regulatory and compliance requirements.

If this objective aligns to your organization, or if you have other drivers to increase access controls, factor the following task into your security baseline:

- Add PIM for privileged accounts to move closer to a Zero-Trust world.

## Baseline implementation for identifying and protecting sensitive business data

The CISO wants to achieve the following objectives from the customer narrative:

- Identify and protect sensitive business data.
- Rapidly modernize the existing security program.

If these objectives align to your organization, or if you have other drivers to increase access controls, factor the following tasks into your security baseline:

- Add Defender for Cloud to gain centralized, integrated visibility and control over a sprawling digital footprint and understand what exposures exist.
- Add Microsoft Sentinel to automate processes that are repeatable to free up time for the security team.

After the right tools are in place, make sure you have good policies in place to enforce proper use of those tools. Several policies apply to online and corporate-connected landing zones:

- [Enforce secure access, like HTTPS, to storage accounts](/azure/storage/common/storage-require-secure-transfer): Configure your storage account to accept requests from secure connections only by setting the **Secure transfer required** property for the storage account. When you require secure transfer, any requests that originate from an insecure connection are rejected.
- [Enforce auditing for Azure SQL Database](/azure/azure-sql/database/auditing-overview): Track database events and write them to an audit log in your Azure storage account, Log Analytics workspace, or event hubs.
- [Enforce encryption for Azure SQL Database](/azure/azure-sql/database/transparent-data-encryption-tde-overview?tabs=azure-portal): Transparent data encryption helps protect SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics against the threat of malicious offline activity by encrypting data at rest.
- [Prevent IP forwarding](/azure/virtual-network/virtual-network-network-interface): IP forwarding enables a network interface attached to a VM to receive network traffic not destined for any of the IP addresses assigned to any of the network interface's IP configurations. You can also send network traffic with a different source IP address than the one assigned to one of a network interface's IP configurations. The setting must be enabled for every network interface that's attached to the VM that receives traffic that the VM needs to forward.
- [Ensure subnets are associated with network security groups (NSGs)](/azure/virtual-network/network-security-groups-overview): Use an Azure NSG to filter network traffic to and from Azure resources in an Azure virtual network. An NSG contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources. For each rule, you can specify source and destination, port, and protocol.
