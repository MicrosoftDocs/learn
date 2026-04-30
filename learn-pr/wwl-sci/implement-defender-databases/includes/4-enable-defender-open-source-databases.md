Defender for Cloud extends threat detection beyond Azure SQL Database to include open-source relational database services. Contoso Financial Services runs Azure Database for PostgreSQL as a secondary customer portal database, which currently sits outside the SQL threat detection coverage you configured in the previous unit.

:::image type="content" source="../media/open-source-database-coverage.png" alt-text="Diagram of Azure and Amazon RDS database types covered by Defender for open-source relational databases." lightbox="../media/open-source-database-coverage.png":::

| Coverage | Included | Not included |
|----------|----------|--------------|
| Azure services | PostgreSQL Flexible Server, MySQL Flexible Server | PostgreSQL Single Server (deprecated), Azure Database for MariaDB, SQL Server on machines |
| AWS RDS (Preview) | Aurora PostgreSQL, Aurora MySQL, PostgreSQL, MySQL, MariaDB | Arc-connected on-premises servers |

## Review Defender for open-source relational databases coverage

Defender for open-source relational databases is a separate plan from Defender for Azure SQL Databases. You enable it independently, and it covers a different set of database services.

The plan protects Azure Database for PostgreSQL Flexible Server and Azure Database for MySQL Flexible Server across all pricing tiers. Azure Database for MariaDB isn't covered by this plan. In preview, the plan also protects Amazon RDS instances running Aurora PostgreSQL, Aurora MySQL, PostgreSQL, MySQL, and MariaDB. This RDS coverage has geographic limitations that you should verify before relying on it for production workloads.

The plan doesn't extend to SQL Server running on virtual machines or Arc-connected servers. If you need threat detection for SQL Server instances outside Azure SQL Database, you use the Defender for Azure SQL Databases plan with Arc enablement, which you learned about in the previous unit.

## Enable protection for open-source databases

You enable Defender for open-source relational databases at the subscription level using the same Databases plan settings where you configured Azure SQL Database protection.

In Microsoft Defender for Cloud, navigate to **Environment settings** and select your subscription. Under the **Databases** plan, you see a separate toggle for **Defender for open-source relational databases**. Enabling this toggle automatically protects all supported open-source database resources in the subscription, including both existing databases and any you create later.

Enablement is independent from the Azure SQL Database toggle. Turning on protection for Azure SQL databases doesn't activate open-source database protection, and vice versa. You need to enable both toggles to get comprehensive database threat detection across your subscription.

The plan detects the same threat categories you saw for Azure SQL databases: anomalous access patterns, brute force attacks, suspicious database activity, and potentially harmful access attempts. Alerts from open-source database threats appear in the same Defender for Cloud security alerts view you use for Azure SQL alerts, so your security team manages all database threats from a single console.

## Recognize key differences from Defender for Azure SQL Databases

While both plans share similar threat detection capabilities, they differ in scope and pricing structure.

| Aspect | Defender for Azure SQL Databases | Defender for open-source relational databases |
|--------|----------------------------------|-----------------------------------------------|
| Azure Arc support | Yes (SQL Server 2012–2022) | No |
| Amazon RDS support | No | Yes (Preview) |
| Pricing model | Per SQL server | Per database server |
| Deprecated services | Covers Single Databases (legacy tier) | Excludes PostgreSQL Single Server |

The most significant difference is Arc support. Defender for Azure SQL Databases extends to on-premises and multicloud SQL Server instances through Azure Arc, while the open-source plan doesn't support Arc connectivity. If you're running PostgreSQL or MySQL on on-premises servers or in other clouds, you can't use Defender for Cloud to protect them. Only Azure-native and AWS RDS instances receive coverage.

The pricing model also differs. Defender for Azure SQL Databases charges per SQL server (covering all databases on that server), while the open-source plan charges per database server. This difference affects cost planning when you run multiple database engines across your environment.

For Contoso's scenario, enabling Defender for open-source relational databases brings their PostgreSQL customer portal database under the same threat detection umbrella as their Azure SQL databases. The security team now monitors threats across both database types from a unified alert view, simplifying their incident response workflow. In the next unit, you configure vulnerability assessment to identify security misconfigurations in your Azure SQL databases.

