Microsoft Defender for Cloud database security, allows you to protect your entire database estate, by detecting common attacks, supporting enablement, and threat response for the most popular database types in Azure.

The types of protected databases are:

- Azure SQL Databases
- SQL servers on machines
- Open-source relational databases (OSS RDB)
- Azure Cosmos DB
Database provides protection to engines, and data types, with different attack surface, and security risks. Security detections are made for the specific attack surface of each DB type.

Defender for Cloud’s database protection detects unusual and potentially harmful attempts to access, or exploit your databases. Advanced threat detection capabilities and Microsoft Threat Intelligence data are used to provide contextual security alerts. Those alerts include steps to mitigate the detected threats, and prevent future attacks.

You can enable database protection on your subscription, or exclude specific database resource types.


Microsoft Defender for SQL includes two plans that extend Defender for Cloud's data security package to secure your databases and their data wherever they're located.

## What does Microsoft Defender SQL protect?

Microsoft Defender for SQL comprises two separate Microsoft Defender plans:

- **Defender for Azure SQL database servers** protects:

  - Azure SQL Database

  - Azure SQL Managed Instance

  - Dedicated SQL pool in Azure Synapse

- **Microsoft Defender for SQL servers on machines** extends the protections for your Azure-native SQL Servers to fully support hybrid environments and protect SQL servers (all supported version) hosted in Azure, other cloud environments, and even on-premises machines:

  - SQL Server on Virtual Machines

  - On-premises SQL servers:

    - Azure Arc enabled SQL Server (preview)

    - SQL Server running on Windows machines without Azure Arc

## What are the benefits of Microsoft Defender for SQL?

These two plans include functionality for identifying and mitigating potential database vulnerabilities and detecting anomalous activities that could indicate threats to your databases:

- Vulnerability assessment - The scanning service to discover, track, and help you remediate potential database vulnerabilities. Assessment scans provide an overview of your SQL machines' security state and details of any security findings.

- Advanced threat protection - The detection service that continuously monitors your SQL servers for threats such as SQL injection, brute-force attacks, and privilege abuse. This service provides action-oriented security alerts in Defender for Cloud with details of the suspicious activity, guidance on how to mitigate the threats and options for continuing your investigations with Microsoft Sentinel.

### What kind of alerts does Defender for SQL provide?

Threat intelligence enriched security alerts are triggered when there's:

- **Potential SQL injection attacks** - including vulnerabilities detected when applications generate a faulty SQL statement in the database

- **Anomalous database access and query patterns** - for example, an abnormally high number of failed sign-in attempts with different credentials (a brute force attempt)

- **Suspicious database activity** - for example, a legitimate user accessing a SQL Server from a breached computer that communicated with a crypto-mining C&C server

Alerts include details of the incident that triggered them, and recommendations on how to investigate and remediate threats.



## What are the benefits of Microsoft Defender for open-source relational databases
This Defender for Cloud plan brings threat protections for the following open-source relational databases:

- Azure Database for PostgreSQL
- Azure Database for MySQL
- Azure Database for MariaDB

When you enable this plan, Microsoft Defender for Cloud will provide alerts when it detects anomalous database access and query patterns and suspicious database activities.

:::image type="content" source="../media/defender-alerts.png" alt-text="Screenshot of the alert screen with open-source database alerts.":::

### Microsoft Defender alerts for open-source relational databases

Threat intelligence enriched security alerts are triggered when there are:

- **Anomalous database access and query patterns** For example, an abnormally high number of failed sign-in attempts with different credentials (a brute force attempt)
- **Suspicious database activities** For example, a legitimate user accessing an SQL Server from a breached computer that communicated with a crypto-mining C&C server
- **Brute-force attacks** With the ability to separate simple brute force from brute force on a valid user or a successful brute force.



## What are the benefits of Microsoft Defender for Azure Cosmos DB

Microsoft Defender for Azure Cosmos DB detects potential SQL injections, known bad actors based on Microsoft Threat Intelligence, suspicious access patterns, and potential exploitation of your database through compromised identities, or malicious insiders.

You can enable protection for all your databases (recommended), or enable Microsoft Defender for Azure Cosmos DB at either the subscription level, or the resource level.

Defender for Azure Cosmos DB continually analyzes the telemetry stream generated by the Azure Cosmos DB service. When potentially malicious activities are detected, security alerts are generated. These alerts are displayed in Defender for Cloud together with the details of the suspicious activity along with the relevant investigation steps, remediation actions, and security recommendations.

Defender for Azure Cosmos DB doesn't access the Azure Cosmos DB account data, and doesn't have any effect on its performance.

### Microsoft Defender alerts for Microsoft Defender for Azure Cosmos DB

Threat intelligence enriched security alerts are triggered when there are:

- **Potential SQL injection attacks:** Due to the structure and capabilities of Azure Cosmos DB queries, many known SQL injection attacks can’t work in Azure Cosmos DB. However, there are some variations of SQL injections that can succeed and may result in exfiltrating data from your Azure Cosmos DB accounts. Defender for Azure Cosmos DB detects both successful and failed attempts, and helps you harden your environment to prevent these threats.

- **Anomalous database access patterns:** For example, access from a TOR exit node, known suspicious IP addresses, unusual applications, and unusual locations.

- **Suspicious database activity:** For example, suspicious key-listing patterns that resemble known malicious lateral movement techniques and suspicious data extraction patterns.