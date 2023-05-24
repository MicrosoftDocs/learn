---
ms.custom:
  - build-2023
---
In this module, we explore some of the new capabilities in security, scalability, and availability of SQL Server 2022.

:::image type="content" source="../media/secure-scalable-available.png" alt-text="Diagram of the SQL Server 2022 features for security, scalability, and availability.":::

## Security enhancements in SQL Server 2022

SQL Server provides security capabilities to protect your data through authentication, encryption, and authorization. SQL Server 2022 enhances security through several new capabilities. Here are some of the highlighted features:

:::image type="content" source="../media/security-enhancements.png" alt-text="Diagram of the SQL Server 2022 security enhancements.":::

In the following units, we'll go over:

- How you can attest that your data hasn't been tampered with and use the auditing capabilities of ledger.
- The Always Encrypted additions to SQL Server 2022 to support confidential queries.
- The added built-in server roles to provide more granular permissions for specific tasks.
- How you can apply UNMASK permissions at the database, schema, table, or column level to control and limit unauthorized access to data stored in the database.

## Scalability

SQL Server has a proven track record to provide scalability without requiring application changes. SQL Server 2022 continues this tradition, and includes:

- Improvements to the performance of buffer pool scan operations on large-memory machines.
- System page latch concurrency enhancements that apply to all user databases, and especially benefits `tempdb` heavy workloads

This is not an exhaustive list of the scalability enhancements in SQL Server 2022, but we go over some of the key improvements in this area to help you scale your workloads.

## Availability

Ensuring SQL Server is highly available and your data is protected from disasters is important for any business critical application. SQL Server 2022 provides new capabilities for both availability and disaster recovery. Here are some of the highlighted features:

- Contained availability groups and the ability to synchronize server-level objects between replicas.
- SQL Server 2022 provides built-in support for snapshot backups using the `ALTER DATABASE` T-SQL statement option `SUSPEND_FOR_SNAPSHOT_BACKUP`.
- Backup compression and integrated offloading with Intel&reg; QuickAssist Technology (QAT).

## Learning objectives

At the end of this module, you will be able to:

- Describe what ledger for SQL Server is, and use ledger tables to enhance your auditing capabilities.
- Be familiar with the security feature enhancements, like the added granular fixed server roles, Always Encrypted enhancements, strict connection encryption, and granular UNMASK permissions for dynamic data masking.
- Understand the enhancements to memory management, `tempdb`, and how SQL Server 2022 can help you scale large-memory environments with no code or application changes.
- Describe the new capabilities around SQL Server 2022 availability, including contained availability groups, cross-platform snapshot backups, and Intel&reg; QuickAssist Technology backup compression.

## Prerequisites

- SQL Server 2022 installed.
- Basic working knowledge of SQL Server security, performance, and availability features.
- Fundamental knowledge of the Transact-SQL (T-SQL) language.
