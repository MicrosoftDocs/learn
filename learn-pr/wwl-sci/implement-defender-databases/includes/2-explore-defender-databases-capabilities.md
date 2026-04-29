Platform security controls and auditing logs are foundational, but they don't alert you when an attack is in progress or when an AI service begins querying sensitive data in unusual patterns. Microsoft Defender for Databases fills this gap by providing active threat detection, real-time alerts, and automated vulnerability scanning across your database workloads. At Contoso Financial Services, the security team needs to determine which plans to enable and how to configure detection policies.

:::image type="content" source="../media/defender-databases-capabilities.png" alt-text="Diagram showing the Defender for Databases plans with their coverage, shared threat detection capabilities, and MITRE ATT&CK mapping." lightbox="../media/defender-databases-capabilities.png":::

| Plan | Coverage |
|------|----------|
| Defender for Azure SQL Databases | Azure SQL Database, Azure SQL Managed Instance, Azure Synapse Analytics dedicated SQL pools, SQL Server on Azure VMs, SQL Server on Arc-enabled machines |
| Defender for open-source relational databases | Azure Database for PostgreSQL Flexible Server, Azure Database for MySQL Flexible Server, Amazon RDS instances—Aurora PostgreSQL, Aurora MySQL, PostgreSQL, MySQL, MariaDB (Preview) |

## Compare Defender for Databases plans

Defender for Databases is a bundle within Microsoft Defender for Cloud that contains four independently priced subplans: Defender for Azure SQL Databases, Defender for SQL Servers on Machines, Defender for Open-Source Relational Databases, and Defender for Azure Cosmos DB. This module focuses on the two plans most relevant to Azure SQL environments. Each plan targets a different database platform family and operates independently. Enable one or both based on your environment.

The first plan, Defender for Azure SQL Databases, covers all Microsoft SQL-based services. This includes Azure SQL Database (single databases and elastic pools), Azure SQL Managed Instance (including read/write replicas), Azure Synapse Analytics dedicated SQL pools, and SQL Server running on infrastructure. With this plan, you protect SQL Server 2012–2022 running on Azure virtual machines and SQL Server on on-premises or multicloud machines connected through Azure Arc. This broad coverage means you can apply consistent threat detection policies across both platform-as-a-service databases and infrastructure-hosted SQL instances.

The second plan, Defender for open-source relational databases, covers PostgreSQL and MySQL workloads. This plan protects Azure Database for PostgreSQL Flexible Server and Azure Database for MySQL Flexible Server across all pricing tiers. In preview, it also extends to Amazon RDS instances running Aurora PostgreSQL, Aurora MySQL, PostgreSQL, MySQL, and MariaDB. Unlike the Azure SQL plan, this plan doesn't support database servers running on virtual machines or Arc-enabled machines. The plan is designed exclusively for managed database services.

| Feature | Azure SQL plan | Open-source plan |
|---------|---------------|------------------|
| PaaS database coverage | Yes | Yes |
| IaaS database coverage | Yes (SQL Server on VMs and Arc) | No |
| Multicloud support | Yes (Arc-enabled SQL) | Yes (Amazon RDS in preview) |
| Threat detection | Yes | Yes |
| Vulnerability assessment | Yes | No (not included) |

The key difference for Contoso is coverage scope: if you run SQL Server on virtual machines or on-premises servers with Arc, you need the Azure SQL plan. If you only use managed PostgreSQL or MySQL services, the open-source plan provides the appropriate protection.

## Detect active threats in real time

Defender for Databases analyzes database information to identify attacks that bypass network and access controls. The detection engine continuously monitors query patterns, access behavior, and authentication attempts to surface threats as they occur.

For Azure SQL workloads, Defender detects SQL injection attacks by identifying when applications construct SQL statements that include malicious user input. The detection logic identifies both successful injection attempts and vulnerability indicators. Even if the attacker hasn't yet escalated privileges, you receive an alert that the database is vulnerable. At Contoso, the banking API that constructs dynamic queries from customer input would trigger an alert when an attacker attempts to inject commands, giving the security team immediate visibility into the attack.

Defender also detects anomalous database access and query patterns. The service establishes a baseline of normal behavior for each database, then alerts when access occurs from unusual geographic locations, at unexpected times, or with query volumes that deviate significantly from historical patterns. When Contoso's AI-powered fraud detection service begins querying customer transaction tables at 3 AM with 10 times the normal query volume, Defender flags this as suspicious activity even though the service uses legitimate credentials.

Brute force attacks surface as abnormally high numbers of failed sign-in attempts within a short time window. Defender correlates these attempts and generates a single alert rather than flooding your queue with individual failed authentication events. Suspicious database activity includes access patterns associated with known threat indicators, such as queries originating from a host that's communicating with cryptocurrency mining command-and-control servers.

Each alert includes a mapping to MITRE ATT&CK tactics, helping your security operations team understand which stage of the attack chain the threat represents: initial access, persistence, or exfiltration. This context accelerates response decisions and helps you prioritize remediation based on attack progression.

## Identify vulnerabilities before attackers exploit them

Vulnerability assessment is included in Defender for Azure SQL Databases as an integrated feature, not a separate product. The assessment engine automatically scans your databases for security misconfigurations and known vulnerabilities, then generates findings categorized by severity level: High, Medium, and lower-severity best practice recommendations.

With Express configuration (the recommended mode), Microsoft manages scan result storage and no storage account configuration is required. Findings appear directly in Defender for Cloud's recommendations view without requiring you to configure storage accounts or scan agents. You can mark accepted findings—such as configurations that are intentional for your environment—so only new deviations surface as open issues. This baseline approach reduces alert fatigue and focuses your attention on configuration drift.

At Contoso, vulnerability assessment might surface findings like publicly accessible database endpoints, weak password policies, or missing encryption at rest. Each finding includes remediation guidance that the security team can apply immediately or route to database administrators through Azure DevOps or ServiceNow integrations.

Defender for Databases uses an agentless architecture across both plans. No agent deployment is required on database servers. Defender analyzes information at the Azure platform layer. This approach works uniformly across platform-as-a-service databases like Azure SQL Database and infrastructure-hosted SQL Server instances connected through Arc. You gain active threat detection without managing agent updates or troubleshooting connectivity issues.
