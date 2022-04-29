Looking back at the Tailwind Traders narrative, the customer chose a "start small" approach to ALZ. This means that their current implementation doesn't include all the suggested security controls. Ideally, the customer would have started with the Azure Landing Zone Accelerator, which would have already installed many of the following tools. This unit will outline which controls to add to this customer's environment to move closer to the ALZ conceptual architecture and prepare for the customer's security requirements.

There are several tools and controls available to help you quickly achieve a security baseline. These tools include:

- [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction): provides the tools needed to harden your resources, track your security posture, protect against cyber-attacks, and streamline security management.
- [Azure Active Directory](/security/benchmark/azure/baselines/aad-security-baseline): The default identity and access management service. Azure AD provides an identity secure score to help you assess identity security posture relative to Microsoft’s best practice recommendations.
- [Microsoft Sentinel](/azure/sentinel/overview): a cloud-native SIEM that provides intelligent security analytics for your entire enterprise, powered by AI.
- [Azure DDoS standard protection plan](/azure/ddos-protection/ddos-protection-overview) (optional): provides enhanced DDoS mitigation features to defend against DDoS attacks
- [Azure Firewall](/azure/firewall/overview): a cloud-native and intelligent network firewall security service that provides the best of breed threat protection for your cloud workloads running in Azure.
- [Web Application Firewall (WAF)](https://azure.microsoft.com/services/web-application-firewall/): a cloud-native service that protects web apps from common web-hacking techniques such as SQL injection and security vulnerabilities such as cross-site scripting.
- [Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure): a service in Azure Active Directory (Azure AD) that enables you to manage, control, and monitor access to important resources in your organization.
- [Microsoft Intune](/mem/intune/fundamentals/what-is-intune): a cloud-based service that focuses on mobile device management (MDM) and mobile application management (MAM).

The following illustrates how Tailwind Traders might accomplish this in practice:

## Baseline implementation for access control

The CISO would like to achieve the following from the customer narrative:

- Allow people to do their jobs securely from anywhere
- Minimize business damage from a major security incident

If these objectives align to your organization, or if you have other drivers to increase access controls, the following should be factored into your security baseline:

- Implement Azure Active Directory to enable strong credentials
- Add Intune for device security
- Add PIM for privileged accounts to move closer to a zero-trust world
- Implement sound network segmentation using a hub/spoke model with break glass controls and firewall controls between application landing zones
- Add Defender and Azure Policy to monitor adherence to these requirements

## Baseline implementation for compliance

The CISO would like to achieve the following from the customer narrative:

- Proactively meet regulatory and compliance requirements

If these objectives align to your organization, or if you have other drivers to increase access controls, the following should be factored into your security baseline:

- Add PIM for privileged accounts to move closer to a zero-trust world

## Baseline implementation for identifying and protecting sensitive business data

The CISO would like to achieve the following from the customer narrative:

- Identify and protect sensitive business data
- Rapidly modernize the existing security program

If these objectives align to your organization, or if you have other drivers to increase access controls, the following should be factored into your security baseline:

- Add Defender to gain centralized, integrated visibility and control over a sprawling digital footprint and understand what exposures exist
- Add Sentinel to automate processes that are repeatable to free up time for the security team

Once the right tools are in place, you should make sure you have good policies in place to enforce proper use of those tools. There are several applicable policies for online and corporate-connected landing zones, including:
  
- [Enforce secure access, like HTTPS, to storage accounts](/azure/storage/common/storage-require-secure-transfer): You can configure your storage account to accept requests from secure connections only by setting the Secure transfer required property for the storage account. When you require secure transfer, any requests originating from an insecure connection are rejected.
- [Enforce auditing for Azure SQL Database](/azure/azure-sql/database/auditing-overview): Track database events and write them to an audit log in your Azure storage account, Log Analytics workspace, or Event Hubs.
- [Enforce encryption for Azure SQL Database](/azure/azure-sql/database/transparent-data-encryption-tde-overview?tabs=azure-portal): Transparent data encryption (TDE) helps protect Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics against the threat of malicious offline activity by encrypting data at rest.
- [Prevent IP forwarding](/azure/virtual-network/virtual-network-network-interface): IP forwarding enables the virtual machine a network interface is attached to: Receive network traffic not destined for one of the IP addresses assigned to any of the IP configurations assigned to the network interface or send network traffic with a different source IP address than the one assigned to one of a network interface's IP configurations. The setting must be enabled for every network interface that is attached to the virtual machine that receives traffic that the virtual machine needs to forward.
- [Ensure subnets are associated with NSG](/azure/virtual-network/network-security-groups-overview): You can use an Azure network security group to filter network traffic to and from Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources. For each rule, you can specify source and destination, port, and protocol.
