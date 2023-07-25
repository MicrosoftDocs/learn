In this module, you learn how to:

- Design a solution for data discovery and classification using Microsoft Purview
- Specify priorities for mitigating threats to data
- Design a solution for protection of data at rest, data in motion, and data in use
- Design a security solution for data in Azure workloads
- Design a security solution for data in Azure Storage
- Design a security solution that includes Microsoft Defender for SQL and Microsoft Defender for Storage

The content in the module helps you prepare for the certification exam SC-100: Microsoft Cybersecurity Architect.

## Prerequisites

- Advanced experience and knowledge in identity and access, platform protection, security operations, securing data, and securing applications.
- Experience with hybrid and cloud implementations.

## Introduction to data security

The following section presents some Azure best practices for data security.

### Protect data

To help protect data in the cloud, you need to account for the possible states in which your data can occur, and what controls are available for that state. Best practices for Azure data security and encryption relate to the following data states:

- At rest: This includes all information storage objects, containers, and types that exist statically on physical media, whether magnetic or optical disk.
- In transit: When data is being transferred between components, locations, or programs, it's in transit. Examples are transfer over the network, across a service bus (from on-premises to cloud and vice-versa, including hybrid connections such as ExpressRoute), or during an input/output process.

### Choose a key management solution

Protecting your keys is essential to protecting your data in the cloud.

[Azure Key Vault](https://learn.microsoft.com/azure/key-vault/general/overview) helps safeguard cryptographic keys and secrets that cloud applications and services use. Key Vault streamlines the key management process and enables you to maintain control of keys that access and encrypt your data. Developers can create keys for development and testing in minutes, and then migrate them to production keys. Security administrators can grant (and revoke) permission to keys, as needed.

You can use Key Vault to create multiple secure containers, called vaults. These vaults are backed by HSMs. Vaults help reduce the chances of accidental loss of security information by centralizing the storage of application secrets. Key vaults also control and log the access to anything stored in them. Azure Key Vault can handle requesting and renewing Transport Layer Security (TLS) certificates. It provides features for a robust solution for certificate lifecycle management.

Azure Key Vault is designed to support application keys and secrets. Key Vault is not intended to be a store for user passwords.

Following are security best practices for using Key Vault.

**Best practice**: Grant access to users, groups, and applications at a specific scope. **Detail**: Use Azure RBAC predefined roles. For example, to grant access to a user to manage key vaults, you would assign the predefined role [Key Vault Contributor](https://learn.microsoft.com/azure/role-based-access-control/built-in-roles#key-vault-contributor) to this user at a specific scope. The scope in this case would be a subscription, a resource group, or just a specific key vault. If the predefined roles don't fit your needs, you can [define your own roles](https://learn.microsoft.com/azure/role-based-access-control/custom-roles).

**Best practice**: Control what users have access to. **Detail**: Access to a key vault is controlled through two separate interfaces: management plane and data plane. The management plane and data plane access controls work independently.

Use Azure RBAC to control what users have access to. For example, if you want to grant an application access to use keys in a key vault, you only need to grant data plane access permissions by using key vault access policies, and no management plane access is needed for this application. Conversely, if you want a user to be able to read vault properties and tags but not have any access to keys, secrets, or certificates, you can grant this user read access by using Azure RBAC, and no access to the data plane is required.

**Best practice**: Store certificates in your key vault. Your certificates are of high value. In the wrong hands, your application's security or the security of your data can be compromised. **Detail**: Azure Resource Manager can securely deploy certificates stored in Azure Key Vault to Azure VMs when the VMs are deployed. By setting appropriate access policies for the key vault, you also control who gets access to your certificate. Another benefit is that you manage all your certificates in one place in Azure Key Vault. See [Deploy Certificates to VMs from customer-managed Key Vault](https://learn.microsoft.com/archive/blogs/kv/updated-deploy-certificates-to-vms-from-customer-managed-key-vault) for more information.

**Best practice**: Ensure that you can recover a deletion of key vaults or key vault objects. **Detail**: Deletion of key vaults or key vault objects can be inadvertent or malicious. Enable the soft delete and purge protection features of Key Vault, particularly for keys that are used to encrypt data at rest. Deletion of these keys is equivalent to data loss, so you can recover deleted vaults and vault objects if needed. Practice Key Vault recovery operations on a regular basis.

### Manage with secure workstations

Because the vast majority of attacks target the end user, the endpoint becomes one of the primary points of attack. An attacker who compromises the endpoint can use the user's credentials to gain access to the organization's data. Most endpoint attacks take advantage of the fact that users are administrators in their local workstations.

**Best practice**: Use a secure management workstation to protect sensitive accounts, tasks, and data. **Detail**: Use a [privileged access workstation](https://4sysops.com/archives/understand-the-microsoft-privileged-access-workstation-paw-security-model/) to reduce the attack surface in workstations. These secure management workstations can help you mitigate some of these attacks and ensure that your data is safer.

**Best practice**: Ensure endpoint protection. **Detail**: Enforce security policies across all devices that are used to consume data, regardless of the data location (cloud or on-premises).

### Protect data at rest

[Data encryption at rest](https://learn.microsoft.com/azure/security/fundamentals/encryption-atrest) is a mandatory step toward data privacy, compliance, and data sovereignty.

**Best practice**: Apply disk encryption to help safeguard your data. **Detail**: Use [Azure Disk Encryption for Linux VMs](https://learn.microsoft.com/azure/virtual-machines/linux/disk-encryption-overview) or [Azure Disk Encryption for Windows VMs](https://learn.microsoft.com/azure/virtual-machines/linux/disk-encryption-overview). Disk Encryption combines the industry-standard Linux dm-crypt or Windows BitLocker feature to provide volume encryption for the OS and the data disks.

Azure Storage and Azure SQL Database encrypt data at rest by default, and many services offer encryption as an option. You can use Azure Key Vault to maintain control of keys that access and encrypt your data. See [Azure resource providers encryption model support to learn more](https://learn.microsoft.com/azure/security/fundamentals/encryption-atrest#azure-resource-providers-encryption-model-support).

**Best practices**: Use encryption to help mitigate risks related to unauthorized data access. **Detail**: Encrypt your drives before you write sensitive data to them.

Organizations that don't enforce data encryption are more exposed to data-confidentiality issues. For example, unauthorized or rogue users might steal data in compromised accounts or gain unauthorized access to data coded in Clear Format. Companies also must prove that they are diligent and using correct security controls to enhance their data security in order to comply with industry regulations.

### Protect data in transit

Protecting data in transit should be an essential part of your data protection strategy. Because data is moving back and forth from many locations, we generally recommend that you always use SSL/TLS protocols to exchange data across different locations. In some circumstances, you might want to isolate the entire communication channel between your on-premises and cloud infrastructures by using a VPN.

For data moving between your on-premises infrastructure and Azure, consider appropriate safeguards such as HTTPS or VPN. When sending encrypted traffic between an Azure virtual network and an on-premises location over the public internet, use [Azure VPN Gateway](https://learn.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpngateways).

Following are best practices specific to using Azure VPN Gateway, SSL/TLS, and HTTPS.

**Best practice**: Secure access from multiple workstations located on-premises to an Azure virtual network. **Detail**: Use [site-to-site VPN](https://learn.microsoft.com/azure/vpn-gateway/tutorial-site-to-site-portal).

**Best practice**: Secure access from an individual workstation located on-premises to an Azure virtual network. **Detail**: Use [point-to-site VPN](https://learn.microsoft.com/azure/vpn-gateway/vpn-gateway-howto-point-to-site-classic-azure-portal).

**Best practice**: Move larger data sets over a dedicated high-speed WAN link. **Detail**: Use [ExpressRoute](https://learn.microsoft.com/azure/expressroute/expressroute-introduction). If you choose to use ExpressRoute, you can also encrypt the data at the application level by using SSL/TLS or other protocols for added protection.

**Best practice**: Interact with Azure Storage through the Azure portal. **Detail**: All transactions occur via HTTPS. You can also use [Storage REST API](https://learn.microsoft.com/rest/api/storageservices/) over HTTPS to interact with [Azure Storage](https://learn.microsoft.com/azure/storage/common/storage-introduction).

Organizations that fail to protect data in transit are more susceptible to [man-in-the-middle attacks](https://learn.microsoft.com/previous-versions/office/skype-server-2010/gg195821(v=ocs.14)), [eavesdropping](https://learn.microsoft.com/previous-versions/office/skype-server-2010/gg195641(v=ocs.14)), and session hijacking. These attacks can be the first step in gaining access to confidential data.

### Secure email, documents, and sensitive data

You want to control and secure email, documents, and sensitive data that you share outside your company. [Azure Information Protection](https://learn.microsoft.com/azure/information-protection/what-is-information-protection) is a cloud-based solution that helps an organization to classify, label, and protect its documents and emails. This can be done automatically by administrators who define rules and conditions, manually by users, or a combination where users get recommendations.

Classification is identifiable at all times, regardless of where the data is stored or with whom it's shared. The labels include visual markings such as a header, footer, or watermark. Metadata is added to files and email headers in clear text. The clear text ensures that other services, such as solutions to prevent data loss, can identify the classification and take appropriate action.

The protection technology uses Azure Rights Management (Azure RMS). This technology is integrated with other Microsoft cloud services and applications, such as Microsoft 365 and Azure Active Directory. This protection technology uses encryption, identity, and authorization policies. Protection that is applied through Azure RMS stays with the documents and emails, independently of the location-inside or outside your organization, networks, file servers, and applications.

This information protection solution keeps you in control of your data, even when it's shared with other people. You can also use Azure RMS with your own line-of-business applications and information protection solutions from software vendors, whether these applications and solutions are on-premises or in the cloud.

We recommend that you:

-   [Deploy Microsoft Purview Information Protection](https://learn.microsoft.com/purview/information-protection) for your organization.
-   Apply labels that reflect your business requirements. For example: Apply a label named "highly confidential" to all documents and emails that contain top-secret data, to classify and protect this data. Then, only authorized users can access this data, with any restrictions that you specify.
-   Configure [usage logging for Azure RMS](https://learn.microsoft.com/azure/information-protection/log-analyze-usage) so that you can monitor how your organization is using the protection service.

Organizations that are weak on [data classification](https://download.microsoft.com/download/0/A/3/0A3BE969-85C5-4DD2-83B6-366AA71D1FE3/Data-Classification-for-Cloud-Readiness.pdf) and file protection might be more susceptible to data leakage or data misuse. With proper file protection, you can analyze data flows to gain insight into your business, detect risky behaviors and take corrective measures, track access to documents, and so on.