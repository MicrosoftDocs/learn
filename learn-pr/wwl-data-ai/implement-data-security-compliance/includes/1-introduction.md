Data security isn't just about preventing external attackers. You must protect sensitive information from unauthorized internal access, maintain compliance with regulations, and create accountability through detailed audit trails. Microsoft's SQL platforms provide built-in security features that address these requirements without requiring extensive application changes.

Modern development practices require you to build security into your database designs from the start. When you create tables that store personal information, you need to consider who should see that data and how to protect it. When you write stored procedures, you must think about what permissions they require and whether they could expose sensitive information. Security decisions made during development are far easier to implement than adding them later.

Modern database security requires a defense-in-depth approach. A single security measure isn't enough. You need encryption to protect data even if storage is compromised, masking to limit exposure of sensitive values, row-level filtering to enforce data boundaries, and auditing to track who accessed what and when. Each layer addresses different threat vectors and compliance requirements.

## What you'll learn

In this module, you'll learn how to:

- Design and implement data encryption using Always Encrypted and column-level encryption
- Configure Dynamic Data Masking to protect sensitive data from unauthorized viewers
- Implement Row-Level Security to filter data access based on user context
- Design object-level permissions using roles and schemas
- Implement secure, passwordless database access using Microsoft Entra ID and Managed Identity
- Configure auditing to track database activity and maintain compliance
- Secure model endpoints for AI-enabled database solutions
- Protect GraphQL, REST, and MCP endpoints from unauthorized access

## Prerequisites

- Experience writing T-SQL queries and developing databases in SQL Server, Azure SQL, or SQL databases in Microsoft Fabric
- Familiarity with database security concepts such as authentication and authorization
- Understanding of Microsoft Entra ID (formerly Azure Active Directory) basics
- Access to a SQL Server, Azure SQL Database, or SQL database in Microsoft Fabric for testing
