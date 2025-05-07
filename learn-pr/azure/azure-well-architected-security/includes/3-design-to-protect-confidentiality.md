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

- Contoso Rise Up backs up each PostgreSQL database by using the built-in point-in-time restores. To be safe, they also make a daily backup that's consistent and store it separately in a storage account.

- The disaster recovery storage account is restricted with just-in-time access and only a few Microsoft Entra ID accounts can access it.
- During a recovery drill, an employee tried to access a backup and accidentally copied the backup to network share in the Contoso organization.
- A few months later, this backup was discovered and reported to Contoso's privacy team. They did a full investigation into how it was accessed and what happened to it up to the time when the incident was discovered. Luckily, no sensitive information was exposed, and the file was deleted after they finished their investigation and audit.

*Applying the approach and outcomes*

- The team now has a clear rule that all backups must be encrypted at rest, and the encryption keys must be secured in Azure Key Vault.

- Even if a backup ends up somewhere it shouldn't, the data inside it is useless without the decryption key. So a privacy breach is much less likely.
- The disaster recovery plan now includes standard guidance about how to properly handle backups, including how and when to safely decrypt a backup.
