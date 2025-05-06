| :::image type="icon" source="../media/goal.svg"::: Keep privacy, regulatory, application, and proprietary information safe by limiting who can access it and hiding details when needed. |
| :----------------------------------------------------------------------------------------------------------------------------- |

You can classify workload data by user, usage, configuration, compliance, intellectual property, and other criteria. But no matter how it's classified, it should only be shared within trusted boundaries. To protect confidentiality, focus on access controls, opacity, and keeping an audit trail of activities related to data and the system.

**Example scenario**

Contoso Rise Up provides a multitenant, software as a service offering that helps nonprofits manage fundraising and donations. They've been in the market for a few years and have a solid client base. The solution is built on Azure Red Hat OpenShift and Azure Database for PostgreSQL. It offers both isolated and shared tenants options to meet different budget needs. 

## Strictly limit access

**Only give access to people who really need it, and only for as long as they need it.**

Even trusted users shouldn't have open-ended access. Keep permissions tight and time-limited, so the system stays protected from misuse or mistakes.

*Contoso's challenge*

- Contoso Rise Up is known for great customer support. To help troubleshoot quickly, the support team has full access to customer data.

- The support team is regularly trained on ethical access.
- Unfortunately, one upset employee broke that trust. They copied and publicly shared a donor list. The person was fired, but the damage to Contoso Rise Up's reputation was already done.

*Applying the approach and outcomes*

- Contoso Rise Up strictly grouped users in Microsoft Entra ID and set up role-based access (RBAC) to control who can access what.

- All data access now requires approval, is time-limited, and gets logged.
- These rules apply across the workload and customer support teams, so there's no more standing access to customer data.

## Identify confidential data through classification

**Figure out what kind of data you have, how sensitive it is, and what could go wrong if it got out. Label the data accordingly so that you can apply the right level of protection where needed.**

This evaluation helps you rightsize security measures. You can also identify high-risk data and components that might impact your workload or be exposed. This exercise helps get everyone on the same page about how to handle different types of data.

*Contoso's challenge*

- The donor management system stores many different types of data:
  - Internal information like Contoso Rise Up's customer list
  - Customer-owned data like donor lists
  - Donor-specific data like mailing addresses
  - Nonsensitive data like stock images and document templates

- The workload team hasn't classified the data. They've applied security broadly across the dataset.

*Applying the approach and outcomes*

- The workload team follows Contoso's data classification guidelines and flags data stores, columns, storage accounts, and other storage resources with metadata to indicate the type and sensitivity of the data.

- This activity helps make sure that each level of sensitive data is properly handled throughout the entire system, including logging statements and backups.
- The team finds relatively sensitive data in a lower security database and nonsensitive data in a higher security database. So they're reorganizing to match security levels with the data type.
- They also plan to use data masking on key fields to better protect data confidentiality, so even authorized users only see what they need.

## Apply encryption at every step of the data life cycle

**Use encryption to protect your data, whether it's in storage, moving across the network, or being processed. Base your encryption strategy on how sensitive the data is.**

By following this approach, even if someone manages to get access, they can't read anything without the right keys.

Sensitive data includes configuration information that's used to gain further access inside the system. Data encryption can help you contain risks.

*Contoso's challenge*

- Contoso Rise Up takes per-tenant backups of the PostgreSQL databases using the built-in point-in-time restores. Additionally, for added assurances they make one transactionally consistent backup per day to an isolated storage account for full disaster recovery preparedness.

- The storage account used for DR is restricted with just-in-time access and few Microsoft Entra ID accounts are allowed to access it.
- During a recovery drill, an employee went through the process to access a backup, and accidentally copied a backup to network share in the Contoso organization.
- This backup was discovered and reported to Contoso's privacy team a few months later, launching an investigation into how it was accessed between the point of the incident and the time of discovery. Luckily there was no confidentiality breach detected, and the file was deleted after the forensics and audit review was complete.

*Applying the approach and outcomes*

- The team has formalized a new process dictating that all backups must be encrypted at rest and the encryption keys must be secured in Key Vault.

- Now incidents like this will have a lower chance of privacy breach, as the data contained in the backup file would be useless without the ability to decrypt.
- Additionally, the DR plan now includes standard guidance dictating proper handling of the backups, including how and when to safely decrypt a backup.
