Contoso Financial Services secured their Azure SQL environment with Microsoft Entra authentication, private endpoints, and customer-managed encryption keys. But during a recent compliance audit, their financial regulator identified a critical gap: the organization can't prove who accessed the banking database, when they connected, or what queries they executed. There's no audit trail for any database activity.

The problem affects both the Azure SQL Database server that processes daily transactions and the SQL Managed Instance that runs credit risk assessments. An AI fraud detection service makes hundreds of queries per minute using a managed identity. However, none of those operations are recorded anywhere the compliance team can review. Without auditing enabled, Contoso can't meet regulatory requirements for financial data access tracking.

In this module, you learn how Azure SQL auditing captures database activity with configurable action groups and scope settings. You explore how to send audit logs to blob storage with immutable retention, Log Analytics workspaces, or Event Hubs. You discover the configuration differences between Azure SQL Database and SQL Managed Instance, including T-SQL commands and diagnostic settings. Finally, you design a compliant audit strategy that combines multiple destinations and enforces coverage using Azure Policy.

By the end of this module, you can:

- Describe Azure SQL auditing capabilities and select appropriate audit action groups
- Configure audit log destinations for Azure SQL Database
- Configure auditing for SQL Managed Instance
- Design a compliant audit strategy using multiple log destinations
