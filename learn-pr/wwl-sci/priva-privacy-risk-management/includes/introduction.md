Microsoft Priva Privacy Risk Management scans your Microsoft 365 environment for overexposed personal data and for transfers that cross boundaries you set. You flag the risk, notify content owners, and act before it becomes a compliance incident.

Consider a healthcare organization that stores patient records, employee data, and appointment histories across SharePoint, OneDrive, and Exchange. A recent audit found sensitive data like Social Security numbers and medical histories sitting in internal file shares that anyone in the company can open. The team lacks a consistent way to catch when that data gets shared externally. The privacy team uses Microsoft Priva Privacy Risk Management to **flag overexposed content and alert admins when personal data crosses organizational or regional boundaries**, then routes the matches to content owners for remediation.

## Learning objectives

In this module you learn to:

- Explain how Privacy Risk Management detects personal data risks and represents them as matches, alerts, and issues.
- Create a data overexposure or data transfer policy from a built-in template.
- Customize a Privacy Risk Management policy with your own data sources, classification groups, users, conditions, and alert thresholds.
- Move policies through their lifecycle by testing, activating, editing, and turning them off based on match volume and quality.
- Investigate alerts, create issues, and remediate matched content with actions like Notify owner, Make private, or Apply a sensitivity or retention label.
- Use Privacy Risk Management reports for spotting trends in personal data, overexposure, and data transfers across your environment.

## Learning prerequisites

- Working knowledge of Microsoft 365 services like Exchange, SharePoint, OneDrive, and Teams.
- Familiarity with data privacy regulations such as HIPAA, and with sensitive information types and classification.
- Can navigate the Microsoft Purview portal and the Microsoft Priva portal.

## Technical prerequisites

Which parts of this module you can act on depends on your tenant's licensing, configuration, and role assignments:

| Capability | Which parts of this module apply |
| --- | --- |
| [Priva Privacy Risk Management](/privacy/priva/priva-setup?azure-portal=true) add-on license, layered on a qualifying Microsoft 365 or Office 365 subscription | All units that create, manage, investigate, or report on policies |
| Microsoft 365 [audit log](/purview/audit-solutions-overview?azure-portal=true) turned on for the tenant | Any policy detection, since Privacy Risk Management reads audit activity to generate matches |
| **Privacy Management Administrators** role group in the Microsoft Purview portal | Creating and managing policies from templates or custom setup |
| **Privacy Management Analysts** or **Privacy Management Investigators** role group | Units that investigate alerts and issues. Investigators can view matched content |
| **Privacy Management Viewer** role group | Reviewing Overview and Reports insights without policy or content access |
| Microsoft Azure and Amazon Web Services S3 connectors (preview), configured in Priva | The multicloud coverage shown on the Reports page |

For current licensing and role details, see [Get started with Priva](/privacy/priva/priva-setup?azure-portal=true).

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
