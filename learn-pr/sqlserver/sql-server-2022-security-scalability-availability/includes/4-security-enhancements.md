---
ms.custom:
  - build-2023
---
In this unit, we'll explore some of the security enhancements to SQL Server 2022 that helps protect and manage your data.

- Always Encrypted enhancements
- New granular fixed server roles
- Strict connected encryption (TDS 8.0 and TLS 1.3)
- Granular UNMASK permissions for dynamic data masking

## Enhancements to Always Encrypted with secure enclaves

Always Encrypted with secure enclaves allows some computations on plaintext data inside a secure enclave on the server side. A secure enclave is a protected region of memory within the Database Engine process. The secure enclave appears as an opaque box to the rest of the Database Engine and other processes on the hosting machine. There's no way to view any data or code inside the enclave from the outside, even with a debugger. These properties make the secure enclave a trusted execution environment that can safely access cryptographic keys and sensitive data in plaintext, without compromising data confidentiality.

:::image type="content" source="../media/always-encrypted-data-flow.png" alt-text="Diagram for the flow of Always Encrypted in Azure SQL Database or SQL Server.":::

SQL Server 2022 adds additional support for confidential queries with JOIN, GROUP BY and ORDER BY operations on encrypted columns.

Confidential queries are [DML queries](/sql/t-sql/queries/queries) that involve operations on enclave-enabled columns performed inside the secure enclave.

The operations supported inside the secure enclaves are:

| Operation| Azure SQL Database | SQL Server 2022 (16.x) | SQL Server 2019 (15.x) |
|:---|:---|:---| :---|
| [Comparison Operators](/sql/mdx/comparison-operators) | Supported | Supported | Supported |
| [BETWEEN (Transact-SQL)](/sql/t-sql/language-elements/between-transact-sql) | Supported | Supported | Supported |
| [IN (Transact-SQL)](/sql/t-sql/language-elements/in-transact-sql) | Supported | Supported | Supported |
| [LIKE (Transact-SQL)](/sql/t-sql/language-elements/like-transact-sql) | Supported | Supported | Supported |
| [DISTINCT](/sql/t-sql/queries/select-transact-sql#c-using-distinct-with-select) | Supported | Supported | Supported |
| [Joins](/sql/relational-databases/performance/joins) | Supported | Supported | Only nested loop joins supported |
| [SELECT - ORDER BY Clause (Transact-SQL)](/sql/t-sql/queries/select-order-by-clause-transact-sql) | Supported | Supported | Not supported |
| [SELECT - GROUP BY- Transact-SQL](/sql/t-sql/queries/select-group-by-transact-sql) | Supported | Supported | Not supported |

## Granular fixed server roles

SQL Server provides fixed server roles to ease the burden of providing permissions for certain server based activities. For example, a SQL principal can be assigned to the **sysadmin** fixed server role, which gives the principal the broadest set of permissions possible across the SQL Server instance.

In SQL Server 2022, new fixed server roles have been added that provide more granular permissions for specific tasks. For example, the new fixed server role **##MS_ServerPerformanceStateReader##** allows any member to view key performance metrics through Dynamic Management Views (DMV), but not the same full rights as members of the **sysadmin** role. New fixed server roles provide the concept of principle of least privilege.

For more information and all the server roles introduced in SQL Server 2022, see [Fixed server-level roles introduced in SQL Server 2022](/sql/relational-databases/security/authentication-access/server-level-roles#fixed-server-level-roles-introduced-in-sql-server-2022).

## Strict connection encryption

SQL Server 2022 provides a more secure method to encrypt connections and communication through a new version of the Tabular Data Stream (TDS) protocol: 8.0. When applications use the new connection string option `Encrypt=strict`, TDS 8.0 is used to communicate with SQL Server 2022.

TDS 8.0 provides the following benefits:

- TDS login communication is fully protected under the Transport Layer System (TLS) protocol.
- The latest TLS 1.3 version is now supported.
- Applications must specify a certificate for encryption purposes instead of relying on the `TrustServerCertificate` option. This requirement can help prevent man-in-the-middle attacks.

For more information, see [TDS 8.0 and TLS 1.3 support](/sql/relational-databases/security/networking/tds-8-and-tls-1-3) and [Connect to SQL Server with strict encryption](/sql/relational-databases/security/networking/connect-with-strict-encryption).

## Granular UNMASK permissions for dynamic data masking

Dynamic data masking helps prevent unauthorized access to sensitive data by enabling customers to specify how much sensitive data to reveal with minimal effect on the application layer. By masking the result set of a query, you can hide the sensitive data in the result set of a query over designated database fields, while the data in the database isn't changed.

Previously, dynamic data masking only masked data at the column-level. Starting with SQL Server 2022, you can prevent unauthorized access to sensitive data and gain control by masking it to an unauthorized user at different levels of the database. You can grant or revoke UNMASK permission at the database-level, schema-level, table-level or at the column-level to a user or database role. This enhancement provides a more granular way to control and limit unauthorized access to data stored in the database and improve data security management.

For a complete list of the security enhancements, and to learn more, see [What's new in SQL Server 2022 (16.x) Security](/sql/sql-server/what-s-new-in-sql-server-2022#security).
