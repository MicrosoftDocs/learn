Use the completed data-flow diagram, answers from the security assessment, and existing security requirements to identify potential solutions to enterprise threats and security gaps.

In this example, we used many [security services](https://docs.microsoft.com/azure/security/fundamentals/overview) available in Azure.

Visit [Azure security benchmark](https://docs.microsoft.com/azure/security/benchmarks/overview) to learn about each security category and associated requirements published for public use.

## Access control

![Access Control domain](../media/policies/access-control-small.svg)

|Risk|Solution|
|----|--------|
|File access per user|Use [role-based access control](https://docs.microsoft.com/mem/configmgr/core/understand/fundamentals-of-role-based-administration), which allows an administrator to grant access based on roles instead of specific employees. It makes it easier to grant, manage, and revoke access. If an individual employee needs access to a highly classified resource, use [just-in-time access](https://docs.microsoft.com/azure/azure-resource-manager/managed-applications/request-just-in-time-access). It grants the employee access to the resource for a short period of time.|
|No MFA|Enable MFA across each SaaS offering. Integrate with [Microsoft Azure Active Directory Connect](https://docs.microsoft.com/azure/active-directory/hybrid/whatis-azure-ad-connect) (if federation is available).|
|No password or group policy|Configure [security policy settings](https://docs.microsoft.com/windows/security/threat-protection/security-policy-settings/security-policy-settings) for all endpoints with group policy or [Azure Active Directory Domain Services](https://docs.microsoft.com/azure/active-directory-domain-services/password-policy).|
|No shared account protection|Avoid using shared accounts wherever possible. If engineering teams require a service account as part of automation or engineering, use [Group Managed Service Accounts](https://docs.microsoft.com/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts).|
|No dedicated administrator account use|Use [Microsoft Identity Manager](https://docs.microsoft.com/en-us/microsoft-identity-manager/microsoft-identity-manager-2016) for on-premises or [Azure Active Directory Privilege Identity Management](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/pim-configure) for cloud privileged access management.|
|Decentralized identities|Integrate each SaaS offering with [Microsoft Azure Active Directory Connect](https://docs.microsoft.com/azure/active-directory/hybrid/whatis-azure-ad-connect) (if federation is available). Rotate passwords on all service accounts.|

## Secure development

![Secure Development domain](../media/policies/secure-development-small.svg)

|Risk|Solution|
|----|--------|
|No SDL practices found|Implement [Microsoft SDL](https://www.microsoft.com/securityengineering/sdl), [Operational Security Assurance](https://www.microsoft.com/securityengineering/osa), and [Secure DevOps](https://www.microsoft.com/securityengineering/devsecops) practices. Move all development to cloud build servers, like GitHub enterprise.|

## Business continuity

![Business Continuity domain](../media/policies/business-continuity-small.svg)

|Risk|Solution|
|----|--------|
|Unencrypted backup|Use [Azure Backup](https://azure.microsoft.com/services/backup/), which has a robust set of features, including encryption.|
|No business continuity plan|Use [Azure Paired Regions](https://docs.microsoft.com/azure/best-practices-availability-paired-regions).|
|No disaster recovery plan|Use [Azure Site Recovery](https://azure.microsoft.com/services/site-recovery/).|
|No tests or audits|Follow [Azure Backup](https://docs.microsoft.com/azure/backup/guidance-best-practices) best practices.|

## Cryptography

![Cryptography domain](../media/policies/cryptography-small.svg)

|Risk|Solution|
|----|--------|
|Use of self-signed certificates on dev environment|Use [Microsoft Azure Directory Services](https://docs.microsoft.com/en-us/windows-server/identity/identity-and-access) to manage your on-premise Public Key Infrastructure (PKI) and [Azure Key-Vault](https://azure.microsoft.com/services/key-vault/) to manage APIs, passwords, certificates, and other secrets.|
|No key rotation|Use [Azure Key-Vault](https://azure.microsoft.com/services/key-vault/) for key rotation.|

## Asset management

![Asset Management domain](../media/policies/asset-small.svg)

|Risk|Solution|
|----|--------|
|No data retention policy|Use [Azure Data Retention](https://docs.microsoft.com/azure/azure-sql-edge/data-retention-overview) practices and [Azure Time Series Insights](https://docs.microsoft.com/azure/time-series-insights/time-series-insights-concepts-retention). You may also need to create a security policy for the enterprise highlighting how long to keep each resource.|
|No data classification or labeling|Use [Azure Data Discovery & Classification](https://docs.microsoft.com/azure/azure-sql/database/data-discovery-and-classification-overview), [Azure Information Protection](https://docs.microsoft.com/azure/information-protection/what-is-information-protection) for emails and documents, [Azure Purview](https://docs.microsoft.com/azure/purview/apply-classifications), and built-in capabilities in Azure SQL Database, like [dynamic data masking](https://docs.microsoft.com/azure/azure-sql/database/dynamic-data-masking-overview). Also, check out [data encryption best practices](https://docs.microsoft.com/azure/security/fundamentals/data-encryption-best-practices)|
|No folder restrictions|Assign file level permissions using [role-based access control](https://docs.microsoft.com/mem/configmgr/core/understand/fundamentals-of-role-based-administration).|
|No asset disposal or deprecation plan|Use [Azure inventory and asset management](https://docs.microsoft.com/azure/security/benchmarks/security-control-inventory-asset-management) guidelines to come up with an asset disposal or deprecation plan.|
|No data encryption on shared drives and servers|Follow [data encryption best practices](https://docs.microsoft.com/azure/security/fundamentals/data-encryption-best-practices).|
|No Data Leakage Prevention (DLP)|Use [Microsoft data leakage prevention practices](https://docs.microsoft.com/cloud-app-security/governance-actions).|
|NAS used for both backups and file shares|First, separate the NAS by either migrating file shares completely to OneDrive, or adding a secondary NAS just for file sharing. You may also use [Azure Backup](https://azure.microsoft.com/services/backup/) for your backup needs.|
|OneDrive not fully adopted|Develop and enforce timelines to give teams time to move their files. You may also use the [migration center tool](https://docs.microsoft.com/sharepointmigration/migrating-content-to-onedrive-for-business).|
|No disk encryption on enterprise machines|Follow [data encryption best practices](https://docs.microsoft.com/azure/security/fundamentals/data-encryption-best-practices).|
|No station lock policy|Enforce [Azure group policy](https://docs.microsoft.com/azure/active-directory-domain-services/manage-group-policy).|

## Legal

![Legal domain](../media/policies/legal-small.svg)

No other action needed.

## Incident response

![Incident Response domain](../media/policies/incident-response-small.svg)

|Risk|Solution|
|----|--------|
|No incident response program for enterprise or product|Use [Azure incident response best practices](https://docs.microsoft.com/azure/security/benchmarks/security-control-incident-response) to create an incident response program for the enterprise and its product offerings.|

## Network

![Network domain](../media/policies/network-small.svg)

|Risk|Solution|
|----|--------|
|No network segmentation|Segment the network into multiple subnets. If needed, consider adding a DMZ to secure more sensitive resources. Visit [Azure segmentation](https://docs.microsoft.com/azure/architecture/framework/security/design-segmentation) for information on segmenting your infrastructure in Azure.|
|No custom firewall rules|Harden firewall rules by identifying and setting only outbound rules. Check out [Microsoft firewall design guidelines](https://docs.microsoft.com/windows/security/threat-protection/windows-firewall/basic-firewall-policy-design) and consider implementing a [firewall in Azure](https://docs.microsoft.com//azure/security/fundamentals/network-best-practices) using a hub vnet.|
|Weak VPN authentication mechanism|Connect to Azure using a [site-to-site VPN](https://docs.microsoft.com/microsoft-365/enterprise/connect-an-on-premises-network-to-a-microsoft-azure-virtual-network?view=o365-worldwide). Upgrade your VPN to a [validated device](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-about-vpn-devices). Check out the [Azure VPN gateway](https://azure.microsoft.com/services/vpn-gateway/) service.|
|Limited data encryption|Enforce [secure communication protocols](https://docs.microsoft.com/azure/storage/common/transport-layer-security-configure-minimum-version) in Azure, like TLS 1.2.|

## Operations

![Operations domain](../media/policies/operations-small.svg)

|Risk|Solution|
|----|--------|
|No automated process for security patches and updates|Use [Azure Kubernetes](https://azure.microsoft.com/en-us/overview/kubernetes-on-azure/).|
|No Antivirus (AV) enforcement|Use [Microsoft Defender Advanced Threat Protection](https://docs.microsoft.com/mem/configmgr/protect/deploy-use/defender-advanced-threat-protection).|
|No timeout session enforcement on machines|Enforce [Azure group policy](https://docs.microsoft.com/azure/active-directory-domain-services/manage-group-policy).|
|No Mobile Device Management (MDM) solution|Use [Microsoft Endpoint Configuration Manager](https://docs.microsoft.com/mem/configmgr/) for all Windows devices and [Microsoft Intune](https://docs.microsoft.com/mem/intune/) for Android and iOS.|
|Limited logging and monitoring|Use Azure Monitor [Log Analytics](https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/log-query-overview).|
|No intelligence platform or analytics service|Use [Azure Sentinel](https://azure.microsoft.com/services/azure-sentinel/), Microsoft's Security Information and Event Management (SIEM) solution.|
|Limited logging history|[Follow Azure logging guidelines](https://docs.microsoft.com/azure/security/fundamentals/log-audit).|

## Physical and environmental

![Physical and environmental domain](../media/policies/physical-small.svg)

|Risk|Solution|
|----|--------|
|IT room is unlocked|Add a lock to the IT room. Examples include lock and key, code entry, and key fobs. As you proceed with your investigation, consider adding a lock that also provides a logging mechanism to keep track of traffic.|
|No cameras or access records for the IT room|Consider adding a camera pointed directly at the IT room. It works well if combined with a lock that keeps a log of all entries.|
|Building owner has access to all rooms and floors|Depending on the contract signed by the company, consider excluding access to the IT room. If that's not possible, add locked cages to the network equipment to prevent unauthorized access.|
|No building cameras or guards|Consider adding cameras pointed at each exit. It not already implemented, add doors that automatically lock upon exit.|
|No formal visitor registration process|Create a logging system to keep track of all visitors, their sponsors, and reason for visit. Consider using visitor badges to distinguish them from employees.|

## Governance

![Governance domain](../media/policies/governance-small.svg)

|Risk|Solution|
|----|--------|
|No information security policy|Create an information security policy by using the [Azure governance](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/standard/prescriptive-guidance) guidelines.|
|No risk management program|Create risk management program by using the [Azure governance](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/standard/prescriptive-guidance) guidelines.|
|No security training|Consider using [Microsoft end-user security awareness](https://www.microsoft.com/security/blog/2020/05/13/empowering-remote-workforce-security-training/) training as the starting point for your training program.|

## Security architecture

![Security architecture domain](../media/policies/security-architecture-small.svg)

|Risk|Solution|
|----|--------|
|No secure template images|Create a set of templates to be used on each VM, server, and user machine. Use [Azure architecture guidelines](https://docs.microsoft.com/azure/security/fundamentals/iaas).|
|No security baselines|Create a set of security baselines for each OS and its security configuration. Use [Azure architecture guidelines](https://docs.microsoft.com/azure/security/fundamentals/iaas).|
|No formal audit to ensure hybrid infrastructure security|Follow the guidance provided by [Azure best practices and patterns](https://docs.microsoft.com/azure/security/fundamentals/best-practices-and-patterns).|

## Supplier

![Supplier risk domain](../media/policies/supplier-small.svg)

|Risk|Solution|
|----|--------|
|No supplier management program|Consider using a supplier management questionnaire as the basis for your supplier program.|
