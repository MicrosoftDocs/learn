## Enhancements to Always Encrypted with secure enclaves
Always Encrypted with secure enclaves allows some computations on plaintext data inside a secure enclave on the server side. A secure enclave is a protected region of memory within the Database Engine process. The secure enclave appears as an opaque box to the rest of the Database Engine and other processes on the hosting machine. There's no way to view any data or code inside the enclave from the outside, even with a debugger. These properties make the secure enclave a trusted execution environment that can safely access cryptographic keys and sensitive data in plaintext, without compromising data confidentiality.

![Diagram for flow of ledger in Azure SQL Database or SQL Server.](../media/ae-data-flow.png)

When parsing a Transact-SQL statement submitted by an application, the Database Engine determines if the statement contains any operations on encrypted data that require the use of the secure enclave. For such statements:

- The client driver sends the column encryption keys required for the operations to the secure enclave (over a secure channel), and submits the statement for execution.

- When processing the statement, the Database Engine delegates cryptographic operations or computations on encrypted columns to the secure enclave. If needed, the enclave decrypts the data and performs computations on plaintext.

During statement processing, both the data and the column encryption keys aren't exposed in plaintext in the Database Engine outside of the secure enclave.

SQL Server 2022 adds additional support for confidential queries with JOIN, GROUP BY and ORDER BY operations on encrypted columns.

Confidential queries are [DML queries](../../../t-sql/queries/queries.md) that involve operations on enclave-enabled columns performed inside the secure enclave.

The operations supported inside the secure enclaves are:

| Operation| Azure SQL Database | SQL Server 2022 (16.x) | SQL Server 2019 (15.x) | 
|:---|:---|:---| :---|
| [Comparison Operators](../../../mdx/comparison-operators.md) | Supported | Supported | Supported |
| [BETWEEN (Transact-SQL)](../../../t-sql/language-elements/between-transact-sql.md) | Supported | Supported | Supported |
| [IN (Transact-SQL)](../../../t-sql/language-elements/in-transact-sql.md) | Supported | Supported | Supported |
| [LIKE (Transact-SQL)](../../../t-sql/language-elements/like-transact-sql.md) | Supported | Supported | Supported |
| [DISTINCT](../../../t-sql/queries/select-transact-sql.md#c-using-distinct-with-select) | Supported | Supported | Supported |
| [Joins](../../performance/joins.md) | Supported | Supported | Only nested loop joins supported | 
| [SELECT - ORDER BY Clause (Transact-SQL)](../../../t-sql/queries/select-order-by-clause-transact-sql.md) | Supported | Supported | Not supported | 
| [SELECT - GROUP BY- Transact-SQL](../../../t-sql/queries/select-group-by-transact-sql.md) | Supported | Supported | Not supported |