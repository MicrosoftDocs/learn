Azure Defender for SQL includes two Azure Defender plans that extend Azure Security Center's data security package to secure your databases and their data wherever they're located.


## What does Azure Defender for SQL protect?

Azure Defender for SQL comprises two separate Azure Defender plans:

- **Azure Defender for Azure SQL database servers** protects:

  - Azure SQL Database

  - Azure SQL Managed Instance

  - Dedicated SQL pool in Azure Synapse

- **Azure Defender for SQL servers on machines** extends the protections for your Azure-native SQL Servers to fully support hybrid environments and protect SQL servers (all supported version) hosted in Azure, other cloud environments, and even on-premises machines:

  - SQL Server on Virtual Machines

  - On-premises SQL servers:

    - Azure Arc enabled SQL Server (preview)

    - SQL Server running on Windows machines without Azure Arc

## What are the benefits of Azure Defender for SQL?

These two plans include functionality for identifying and mitigating potential database vulnerabilities and detecting anomalous activities that could indicate threats to your databases:

- Vulnerability assessment - The scanning service to discover, track, and help you remediate potential database vulnerabilities. Assessment scans provide an overview of your SQL machines' security state and details of any security findings.

- Advanced threat protection - The detection service that continuously monitors your SQL servers for threats such as SQL injection, brute-force attacks, and privilege abuse. This service provides action-oriented security alerts in Azure Security Center with details of the suspicious activity, guidance on how to mitigate the threats and options for continuing your investigations with Azure Sentinel.

- What kind of alerts does Azure Defender for SQL provide?

Threat intelligence enriched security alerts are triggered when there's:

- **Potential SQL injection attacks** - including vulnerabilities detected when applications generate a faulty SQL statement in the database

- **Anomalous database access and query patterns** - for example, an abnormally high number of failed sign-in attempts with different credentials (a brute force attempt)

- **Suspicious database activity** - for example, a legitimate user accessing a SQL Server from a breached computer that communicated with a crypto-mining C&C server

Alerts include details of the incident that triggered them, and recommendations on how to investigate and remediate threats.

