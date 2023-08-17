Use the completed data-flow diagram, answers from the security assessment, and existing security requirements to identify potential solutions to enterprise threats and security gaps.

In this example, we used many [security services](/azure/security/fundamentals/overview) available in Azure.

Visit [Microsoft cloud security benchmark](/azure/security/benchmarks/overview) to learn about each security category and associated requirements published for public use.

## Access control

![Access Control domain.](../media/policies/access-control-small.png)

|Issue|Solution|
|-----|--------|
|File access per user|Use [role-based access control](/mem/configmgr/core/understand/fundamentals-of-role-based-administration), which allows an administrator to grant access based on roles instead of specific employees. It makes it easier to grant, manage, and revoke access. If an individual employee needs access to a highly classified resource, use [just-in-time access](/azure/azure-resource-manager/managed-applications/request-just-in-time-access). It grants the employee access to the resource for a short period of time.|
|No MFA|Enable MFA across each SaaS offering. Integrate with [Microsoft Azure Active Directory connect](/azure/active-directory/hybrid/whatis-azure-ad-connect) for hybrid identities where applicable.|
|No password or group policy|Configure [security policy settings](/windows/security/threat-protection/security-policy-settings/security-policy-settings) for all endpoints with group policy or [Azure Active Directory domain services](/azure/active-directory-domain-services/password-policy).|
|No shared account protection|Avoid using shared accounts wherever possible. If engineering teams require a service account as part of automation or engineering, use [group managed service accounts](/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts).|
|No dedicated administrator account use|Use [Microsoft Identity Manager](/microsoft-identity-manager/microsoft-identity-manager-2016) for on-premises or [Azure Active Directory Privilege Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) for cloud privileged access management.|
|Decentralized identities|Integrate each SaaS offering with [Azure Active Directory connect](/azure/active-directory/hybrid/whatis-azure-ad-connect) for hybrid identities where applicable. Rotate passwords on all service accounts.|

## Secure development

![Secure Development domain.](../media/policies/secure-development-small.png)

|Issue|Solution|
|-----|--------|
|No SDL practices found|Implement [Microsoft SDL](https://www.microsoft.com/securityengineering/sdl), [operational security assurance](https://www.microsoft.com/securityengineering/osa), and [secure devops](https://www.microsoft.com/securityengineering/devsecops) practices. Move all development to cloud build servers, like GitHub enterprise, which can be used on-premises and on the cloud. It also has [valuable security features](https://github.com/features/security).|

## Business continuity

![Business Continuity domain.](../media/policies/business-continuity-small.png)

|Issue|Solution|
|-----|--------|
|Unencrypted backup|Use [Azure backup](https://azure.microsoft.com/services/backup/), which has a robust set of features, including encryption. [Azure SQL transparent data encryption](/azure/azure-sql/database/transparent-data-encryption-byok-overview) can be used too.|
|No business continuity plan|Use [Azure paired regions](/azure/best-practices-availability-paired-regions) and [Azure Virtual Desktop](/azure/virtual-desktop/disaster-recovery) on workstations.|
|No disaster recovery plan|Use [Azure Site Recovery](https://azure.microsoft.com/services/site-recovery/).|
|No tests or audits|Follow [Azure backup](/azure/backup/guidance-best-practices) guidance.|

## Cryptography

![Cryptography domain.](../media/policies/cryptography-small.png)

|Issue|Solution|
|-----|--------|
|Use of self-signed certificates on dev environment|Use [Azure Directory Services](/windows-server/identity/identity-and-access) to manage your on-premises Public Key Infrastructure (PKI) and [Azure Key-Vault](https://azure.microsoft.com/services/key-vault/) to manage APIs, passwords, certificates, and other secrets.|
|No key rotation|Use [Azure Key-Vault](https://azure.microsoft.com/services/key-vault/) for key rotation.|

## Asset management

![Asset Management domain.](../media/policies/asset-small.png)

|Issue|Solution|
|-----|--------|
|No data retention policy|Use [Azure data retention](/azure/azure-sql-edge/data-retention-overview) practices and [Azure time series insights](/azure/time-series-insights/time-series-insights-concepts-retention). You may also need to create a security policy for the enterprise highlighting how long to keep each resource. Use [long-term retention](/azure/azure-sql/database/long-term-retention-overview) with Azure SQL.|
|No data classification or labeling|Use [Azure data discovery & classification](/azure/azure-sql/database/data-discovery-and-classification-overview), [Azure information protection](/azure/information-protection/what-is-information-protection) for emails and documents. Also, [Microsoft Purview](/azure/purview/apply-classifications), and built-in capabilities in Azure SQL Database, like [dynamic data masking](/azure/azure-sql/database/dynamic-data-masking-overview). Also, check out [data security and encryption guidance](/azure/security/fundamentals/data-encryption-best-practices)|
|No folder restrictions|Assign file level permissions using [role-based access control](/mem/configmgr/core/understand/fundamentals-of-role-based-administration).|
|No asset disposal or deprecation plan|Use [Azure inventory and asset management](/azure/security/benchmarks/security-control-inventory-asset-management) guidelines to come up with an asset disposal or deprecation plan.|
|No data encryption on shared drives and servers|Follow [data encryption guidance](/azure/security/fundamentals/data-encryption-best-practices).|
|No Data Loss Prevention (DLP)|Use [data loss prevention compliance guidelines](/microsoft-365/compliance/dlp-learn-about-dlp).|
|NAS used for both backups and file shares|First, separate the NAS by either migrating file shares completely to OneDrive, or adding a secondary NAS just for file sharing. You may also use [Azure backup](https://azure.microsoft.com/services/backup/) for your backup needs.|
|OneDrive not fully adopted|Develop and enforce timelines to give teams time to move their files. You may also use the [migration center tool](/sharepointmigration/migrating-content-to-onedrive-for-business). Share the [adoption guidelines](https://adoption.microsoft.com/onedrive/) with teams.|
|No disk encryption on enterprise machines|Follow [data encryption guidance](/azure/security/fundamentals/data-encryption-best-practices).|
|No station lock policy|Enforce [Azure group policy](/azure/active-directory-domain-services/manage-group-policy).|

## Legal

![Legal domain.](../media/policies/legal-small.png)

No other action needed.

## Incident response

![Incident Response domain.](../media/policies/incident-response-small.png)

|Issue|Solution|
|-----|--------|
|No incident response program for enterprise or product|Use [Azure incident response guidance](/azure/security/benchmarks/security-control-incident-response) to create an incident response program for the enterprise and its product offerings.|

## Network

![Network domain.](../media/policies/network-small.png)

|Issue|Solution|
|-----|--------|
|No network segmentation|Segment the network into multiple subnets. If needed, consider adding a perimeter network to secure more sensitive resources. Visit [segmentation strategies](/azure/architecture/framework/security/design-segmentation) for information on segmenting your infrastructure in Azure.|
|No custom firewall rules|Harden firewall rules by identifying and setting only outbound rules. Check out [firewall design guidelines](/windows/security/threat-protection/windows-firewall/basic-firewall-policy-design) and consider implementing a [firewall in Azure](/azure/security/fundamentals/network-best-practices) using a hub vnet.|
|Weak VPN authentication mechanism|Connect to Azure using a [site-to-site VPN](/microsoft-365/enterprise/connect-an-on-premises-network-to-a-microsoft-azure-virtual-network). Upgrade your VPN to a [validated device](/azure/vpn-gateway/vpn-gateway-about-vpn-devices). Check out the [Azure VPN gateway](https://azure.microsoft.com/services/vpn-gateway/) service. Most importantly, enforce a zero-trust mindset across the company and secure workstation connections with VPN.|
|Limited data encryption|Enforce [secure communication protocols](/azure/storage/common/transport-layer-security-configure-minimum-version) in Azure, like TLS 1.2.|

## Operations

![Operations domain.](../media/policies/operations-small.png)

|Issue|Solution|
|-----|--------|
|No automated process for security patches and updates|Use [Automatic VM guest patching for Azure VMs](/azure/virtual-machines/automatic-vm-guest-patching) or [Microsoft Intune](/mem/intune/fundamentals/what-is-intune). Integrate with [Microsoft Defender for Cloud](https://azure.microsoft.com/services/security-center) for the ultimate protection.|
|No Antivirus (AV) enforcement|Use [Microsoft Defender for Endpoint](/mem/configmgr/protect/deploy-use/defender-advanced-threat-protection) for advanced threat protection.|
|No timeout session enforcement on machines|Enforce [Azure group policy](/azure/active-directory-domain-services/manage-group-policy).|
|No Mobile Device Management (MDM) solution|Implement [Microsoft Configuration manager](https://www.microsoft.com/microsoft-365/microsoft-endpoint-manager), which includes solutions like [Microsoft Intune](/mem/intune/). It manages and monitors mobile devices, desktop computers, virtual machines, embedded devices, and servers.|
|Limited logging and monitoring|Use Azure Monitor [Log analytics](/azure/azure-monitor/log-query/log-query-overview) and follow [Azure logging guidelines](/azure/security/fundamentals/log-audit).|
|No intelligence platform or analytics service|Use [Microsoft Sentinel](https://azure.microsoft.com/services/azure-sentinel/), Microsoft's Security Information and Event Management (SIEM) solution.|
|Limited logging history|Follow [Azure logging guidelines](/azure/security/fundamentals/log-audit).|

## Physical and environmental

![Physical and environmental domain.](../media/policies/physical-small.png)

|Issue|Solution|
|-----|--------|
|IT room is unlocked|Add a lock to the IT room. Examples include lock and key, code entry, and key fobs. As you continue with your investigation, consider adding a lock that also provides a logging mechanism to keep track of traffic.|
|No cameras or access records for the IT room|Consider adding a camera pointed directly at the IT room. It works well if combined with a lock that keeps a log of all entries.|
|Building owner has access to all rooms and floors|Depending on the contract signed by the company, consider excluding access to the IT room. If that's not possible, add locked cages to the network equipment to prevent unauthorized access.|
|No building cameras or guards|Consider adding cameras pointed at each exit. If not already implemented, add doors that automatically lock upon exit.|
|No formal visitor registration process|Create a logging system to keep track of all visitors, their sponsors, and reason for visit. Consider using visitor badges to distinguish them from employees.|

## Governance

![Governance domain.](../media/policies/governance-small.png)

|Issue|Solution|
|-----|--------|
|No information security policy|Create an information security policy by using the [Azure governance](/azure/cloud-adoption-framework/govern/guides/standard/prescriptive-guidance) guidelines.|
|No risk management program|Create risk management program by using the [Azure governance](/azure/cloud-adoption-framework/govern/guides/standard/prescriptive-guidance) guidelines.|
|No security training|Consider using [Microsoft end-user security awareness](https://www.microsoft.com/security/blog/2020/05/13/empowering-remote-workforce-security-training/) training as the starting point for your training program. The IT security team should also consider [certifications available from Microsoft Learn](/certifications/browse/), like the [Security administrator associate](/certifications/m365-security-administrator/).|

## Security architecture

![Security architecture domain.](../media/policies/security-architecture-small.png)

|Issue|Solution|
|-----|--------|
|No secure template images|Create a set of templates to be used on each VM, server, and user machine. Use [Azure architecture guidelines](/azure/security/fundamentals/iaas) or [Azure VM builder](/azure/virtual-machines/image-builder-overview).|
|No security baselines|Create a set of security baselines for each OS and its security configuration. Use [Azure architecture guidelines](/azure/security/fundamentals/iaas), [Azure security baselines](/azure/security-center/security-baseline), and [Azure blueprints](/azure/governance/blueprints/overview).|
|No formal audit to ensure hybrid infrastructure security|Follow the guidance provided by [Azure best practices and patterns](/azure/security/fundamentals/best-practices-and-patterns).|
|No human operated ransomware protection plan|Review the [human operated ransomware guide](/security/compass/human-operated-ransomware), which contains information on securing your privileged access to sensitive resources. Check out [how to deploy a secure, Azure-managed workstation](/security/compass/overview).|

## Supplier

![Supplier risk domain.](../media/policies/supplier-small.png)

|Issue|Solution|
|-----|--------|
|No supplier management program|Consider using a supplier management questionnaire as the basis for your supplier program.|
