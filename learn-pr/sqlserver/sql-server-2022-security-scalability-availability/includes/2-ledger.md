---
ms.custom:
  - build-2023
---
How do you know your data has or hasn't been tampered with? Can you prove that your data hasn't been tampered with to auditors and regulators? How can you establish trust with your customers, partners, or stakeholders in a world that is largely digital and controlled by data that is shared by many? Distributed blockchain technologies have been a game changer for establishing trust, but they're complex, introduce new programming languages and environments, offer limited data management capabilities, and have poor performance compared to relational database systems. What if there was a simpler and more performant alternative to establish trust across organizational boundaries?

Ledger is a technology that offers the power of blockchain in Azure SQL and SQL Server. Ledger allows establishing trust across different business entities while maintaining the simplicity and performance of a relational database. The data is centrally managed, and you can cryptographically attest to other parties that your data can be trusted and hasn't been tampered with. This is especially useful if your records need to be audited.

:::image type="content" source="../media/ledger-table-architecture.png" alt-text="Diagram for flow of ledger in Azure SQL Database or SQL Server.":::

## How does ledger work

Any rows modified by a transaction in a ledger table are cryptographically SHA-256 hashed using a Merkle tree data structure that creates a root hash representing all rows in the transaction. The transactions that the database processes are then also SHA-256 hashed together through a Merkle tree data structure. The result is a root hash that forms a block. The block is then SHA-256 hashed through the root hash of the block, along with the root hash of the previous block as input to the hash function. That hashing forms a blockchain.

The root hashes in the database ledger, also called database digests, contain the cryptographically hashed transactions and represent the state of the database. They can be periodically generated and stored outside the database in tamper-proof storage, such as an Azure Blob Storage configured with immutability policies, Azure Confidential Ledger, or on-premises Write Once Read Many (WORM) storage devices. Database digests are later used to verify the integrity of the database by comparing the value of the hash in the digest against the calculated hashes in the database.

Ledger functionality is introduced to tables in two forms:

- Updatable ledger tables, which allow you to update and delete rows in your tables.
- Append-only ledger tables, which only allow insertions to your tables.

Both updatable ledger tables and append-only ledger tables provide tamper-evidence and digital forensics capabilities.

## Ledger tables

Let's learn about updatable ledger tables and append-only ledger tables.

### Updatable ledger tables

Updatable ledger tables are ideal for application patterns that expect to issue updates and deletions to tables in your database. Existing data patterns for your application don't need to change to enable the ledger functionality.

Updatable ledger tables are system-versioned tables on which users can perform updates and deletes, while also providing tamper-evidence capabilities. When updates or deletes occur, all earlier versions of a row are preserved in a secondary table, known as the history table. The history table mirrors the schema of the updatable ledger table. When a row is updated, the latest version of the row remains in the ledger table, while its earlier version is inserted into the history table by the system, transparently to the application.

The values in the updatable ledger table and its corresponding history table provide a chronicle of the values of your database over time. A system-generated ledger view joins the updatable ledger table and the history table so that you can easily query this chronicle of your database.

For more information, see [Updatable ledger tables](/sql/relational-databases/security/ledger/ledger-updatable-ledger-tables).

### Append-only ledger tables

Append-only ledger tables are ideal for application patterns that are insert-only. Append-only ledger tables block updates and deletions at the API level. This blocking provides more tampering protection from privileged users such as system administrators and database administrators (DBAs).

Because only insertions are allowed into the system, append-only ledger tables don't have a corresponding history table because there's no history to capture. As with updatable ledger tables, a ledger view provides insights into the transaction that are inserted rows into the append-only table, and the user that performed the insertion.

For more information, see [Append-only ledger tables](/sql/relational-databases/security/ledger/ledger-append-only-ledger-tables).

## Digest management

The hash of the latest block in the database ledger is called the database digest. It represents the state of all ledger tables in the database at the time that the block was generated.

When a block is formed, its associated database digest is published and stored outside the database in tamper-proof storage. Because database digests represent the state of the database at the time that they were generated, protecting the digests from tampering is paramount.

Ledger provides the ability to automatically generate and store the database digests in immutable storage or an Azure Confidential Ledger to prevent tampering. Alternatively, users can manually generate database digests and store them in the location of their choice. Database digests are used for verifying that the data stored in ledger tables hasn't been tampered with.

For more information, see [Digest management](/sql/relational-databases/security/ledger/ledger-digest-management).

## Database verification

The ledger feature doesn't allow modifying the content of ledger system views, append-only tables, and history tables. However, an attacker or system administrator who has control of the machine can bypass all system checks and directly tamper with the data. For example, an attacker or system administrator can edit the database files in storage. Ledger can't prevent such attacks but guarantees that any tampering will be detected when the ledger data is verified.

The ledger verification process takes as input one or more previously generated database digests, and recomputes the hashes stored in the database ledger based on the current state of the ledger tables. If the computed hashes don't match the input digests, the verification fails, indicating that the data has been tampered with. Ledger then reports all inconsistencies that it has detected.

For more information, see [Database verification](/sql/relational-databases/security/ledger/ledger-database-verification).

Now that we've learned about ledger, let's learn how to use it.
