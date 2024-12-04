| :::image type="icon" source="../media/goal.svg"::: Prevent exposure to privacy, regulatory, application, and proprietary information through access restrictions and obfuscation techniques. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Workload data can be classified by user, usage, configuration, compliance, intellectual property, and more. Workload data must not be shared or accessed beyond the established trust boundaries. Efforts to protect confidentiality should focus on access controls, opacity, and keeping an audit trail of activities that pertain to data and the system.

**Example scenario**

Contoso Rise Up provides a multitenant, Software-as-a-Service offering that specializes in supporting nonprofits in their fundraising and donation activities. They've been in the market for a few years now with a healthy client base. The solution is built on Azure Red Hat OpenShift (ARO) and Azure Database for PostgreSQL. It offers both isolated tenants and colocated tenants as a more affordable  offering. 

## Strictly limit access

**Implement strong access controls that grant access only on a need-to-know basis.**

The workload will be protected from unauthorized access and prohibited activities. Even when access is from trusted identities, the access permissions and exposure time will be minimized because the communication path is open for a limited period.

*Contoso's challenge*

- Contoso Rise Up has always prided itself on amazing customer support. Everyone on the support team has ready-access to customer data to help troubleshoot and advise in real-time.
- The support team is regularly trained on ethical access.
- Unfortunately, one disgruntled support employee copied and publicly shared the donor list for an organization, breaching the customer’s confidentiality. While the employee was fired, the reputation harm to Contoso Rise Up was already done.

*Applying the approach and outcomes*

- Contoso Rise Up implemented strict segmentation of users into Microsoft Entra ID groups and defined RBAC for those groups to the various resource groups and resources.
- All access to data is time limited and goes through an approval and auditing process.
- These standards have been applied across the workload and customer support teams. Contoso Rise Up now is confident that there's no standing access to customer data.

## Identify confidential data through classification

**Classify data based on its type, sensitivity, and potential risk. Assign a confidentiality level for each. Include system components that are in scope for the identified level.**

This evaluation helps you right-size security measures. You'll also be able to identify data and components that have a high potential impact and/or exposure to risk. This exercise adds clarity to your information protection strategy and helps ensure agreement.

*Contoso's challenge*

- The donor management system stores many different types of data, ranging from information that is confidential to Contoso Rise Up (such as it’s customer list), to information that’s confidential to its customers (such as the donor list), and information that’s confidential to its customers’ donors (such as their mailing address).
- The system also holds nonsensitive data, like stock images and document templates.
- The workload team has never taken the time to classify data, and has simply applied security broadly across the dataset.

*Applying the approach and outcomes*

- Following the taxonomy lead of the Contoso organization, the workload team spends time to flag data stores, columns, storage accounts, and other storage resources with metadata that indicate what type and sensitivity of data exists there.
- This activity gives the team the opportunity to validate that sensitive data is treated with the level of confidentiality required throughout the entire system, including logging statements and backups.
- The team finds that they have some relatively sensitive data in a lower security database and have some nonsensitive data in a higher security database. They'll be adjusting storage locations to make sure security controls are aligned with the data they're protecting.
- They also plan on implementing data masking on key fields to better protect the confidentiality of data, even when authorized staff access the system.

## Apply encryption at every step of the data lifecycle

**Safeguard your data at rest, in transit, and during processing by using encryption. Base your strategy on the assigned confidentiality level.**

By following this approach, even if an attacker gets access, they won't be able to read properly encrypted sensitive data.

Sensitive data includes configuration information that's used to gain further access inside the system. Data encryption can help you contain risks.

*Contoso's challenge*

- Contoso Rise Up takes per-tenant backups of the PostgreSQL databases using the built-in point-in-time restores. Additionally, for added assurances they make one transactionally consistent backup per day to an isolated storage account for full disaster recovery (DR) preparedness.
- The storage account used for DR is restricted with just-in-time access and few Microsoft Entra ID accounts are allowed to access it.
- During a recovery drill, an employee went through the process to access a backup, and accidentally copied a backup to network share in the Contoso organization.
- This backup was discovered and reported to Contoso’s privacy team a few months later, launching an investigation into how it was accessed between the point of the incident and the time of discovery.  Luckily there was no confidentiality breach detected, and the file was deleted after the forensics and audit review was complete.

*Applying the approach and outcomes*

- The team has formalized a new process dictating that all backups must be encrypted at rest and the encryption keys must be secured in Key Vault.
- Now incidents like this will have a lower chance of privacy breach, as the data contained in the backup file would be useless without the ability to decrypt.
- Additionally, the DR plan now includes standard guidance dictating proper handling of the backups, including how and when to safely decrypt a backup.
