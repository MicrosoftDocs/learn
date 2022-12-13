
Your on-premises and cloud data must be protected from both inadvertent
and malicious access. *Inadvertent access* occurs when a user gains
access to data that, based on their roles and responsibilities, they
should not have. The result can be unintended data leakage, data
destruction, or violations of data security and privacy regulations.
*Malicious access* occurs when an external attacker or a malicious
insider intentionally tries to access data. Malicious insiders can use
your data for profit or to harm your organization. External attackers
can delete, alter, exfiltrate, and encrypt your most sensitive data,
leaving you open to a ransomware attack.

For both types of attacks, you must take the necessary steps to identify
your data, protect it, prevent its destruction or exfiltration, and
ensure that only users with a business purpose have access to it.
Protecting your data is part of the "assume breach" Zero Trust
principle. Even with all the user account and device protections in
place, you must assume that an attacker could find their way in and
begin traversing your environment, searching for the most valuable data
for your organization.

Before establishing the security requirements for data workloads, you
must first know your data. In other words, understand your data
landscape and identify important information across your cloud and
on-premises environment. During this process of better understanding
your data, you can execute the following steps:

| Task                                                                  | Owner                                                 |
|-----------------------------------------------------------------------|-------------------------------------------------------|
| 1. Determine data classification levels.                              | Data Security Architect                               |
| 2. Determine built-in and custom sensitive information types.         | Data Security Architect                               |
| 3. Determine the use of pre-trained and custom trainable classifiers. | Data Security Architect                               |
| 4. Discover and classify sensitive data.                              | Data Security Architect and/or Data Security Engineer |

Once you know your data, you can establish key requirements such as:

-   **Data protection across all data workloads**: protect your
    sensitive data throughout its lifecycle by applying sensitivity
    labels linked to protection actions like encryption, access
    restrictions, visual markings, and more.

-   **Prevent data loss**: apply a consistent set of data loss
    prevention policies across the cloud, on-premises environments, and
    endpoints to monitor, prevent, and remediate risky activities with
    sensitive data.

-   **Use least privilege access**: apply minimal permissions consisting
    of who is allowed to access and what they're allowed to do with
    data to meet business and productivity requirements.

#### Security posture management for data

Just like any other cloud workload, data workloads need to have an
ongoing security assessment to improve the overall security posture.
Microsoft Purview is a unified data governance service that helps you manage
and govern your on-premises, multicloud, and software-as-a-service
(SaaS) data. Create a holistic, up-to-date map of your data landscape
with automated data discovery, sensitive data classification, and
end-to-end data lineage. Enable data curators to manage and secure your
data estate. Empower data consumers to find valuable, trustworthy data.

:::image type="content" source="../media/microsoft-purview.png" alt-text="Diagram that shows high level architecture of Microsoft Purview." lightbox="../media/microsoft-purview.png":::

Microsoft Defender for Cloud integration with Microsoft Purview allows you
to obtain vital layer of metadata from Microsoft Purview and use in alerts
and recommendations: information about any potentially sensitive data
involved. This knowledge helps solve the triage challenge and ensures
security professionals can focus their attention on threats to sensitive
data. The example below shows a SQL database status in Defender for
Cloud, with the data enrichment coming from Microsoft Purview in the low
left corner:

:::image type="content" source="../media/resource-health-purview.png" alt-text="Screenshot showing security health of a database in Defender for Cloud." lightbox="../media/resource-health-purview.png":::

#### Databases

Data workloads include databases, and to provide security posture
management for databases you can use Microsoft Defender for SQL.
Microsoft Defender for Cloud is available for Azure SQL Database, Azure
SQL Managed Instance, and Azure Synapse Analytics. It includes
functionality for surfacing and mitigating potential database
vulnerabilities and detecting anomalous activities that could indicate a
threat to your database. It provides a single go-to location for
enabling and managing these capabilities. Security recommendations for
SQL database will be surfaced in Defender for Cloud as shown the screen
below:

:::image type="content" source="../media/databases.png" alt-text="Screenshot showing security recommendations for a SQL database in Defender for Cloud." lightbox="../media/databases.png":::

An advanced threat protection service continuously monitors your SQL
servers for threats such as SQL injection, brute-force attacks, and
privilege abuse. This service provides action-oriented security alerts
in Microsoft Defender for Cloud with details of the suspicious activity,
guidance on how to mitigate to the threats, and options for continuing
your investigations with Microsoft Sentinel. Learn more about advanced
threat protection.

In addition to SQL, you need to also take in considerations cloud-native
database such as Azure Cosmos DB. Microsoft Defender for Azure Cosmos DB
detects potential SQL injections, known bad actors based on Microsoft
Threat Intelligence, suspicious access patterns, and potential
exploitation of your database through compromised identities, or
malicious insiders. Defender for Azure Cosmos DB uses advanced threat
detection capabilities, and Microsoft Threat Intelligence data to
provide contextual security alerts. Those alerts also include steps to
mitigate the detected threats and prevent future attacks.

