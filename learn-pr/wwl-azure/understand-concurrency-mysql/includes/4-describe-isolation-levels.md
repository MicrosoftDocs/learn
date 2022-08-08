## Transactions

To understand isolation levels, you first need to understand transactions. MySQL supports two types of transactions:

- **Autocommit**. Each SQL statement is a transaction and changes are committed straight away. The server parameter is **autocommit** and it is set to ON by default.
- **Explicit**. Explicit requires that transactions to start with the key words START TRANSACTION or BEGIN, and end with the key works COMMIT or ROLLBACK. Explicit transactions allow a group of statements to either be committed together or rolled back together. They cannot be partially committed or partially rolled back.

## Conflicts

When many clients are connected to the same database, the possibility of them trying to modify and read the same data increases. If more than one user is trying to modify data at the same time, problems include:

- **Dirty reads** - when one user reads data that is in the process of being updated by another user. The first user reads the data, while the second user commits their change to disk, updating the data. The first user now has out of data information.
- **Lost updates** - one user updates some data, only to have that change overridden by another user. The first user's data is "lost".
- **Non-repeatable reads** - when two users query the database with the same query but receive different information because another user has updated the data. The SELECT statement made by the original users is not repeatable because it returns different data when it is run.
- **Phantom reads** - occur when rows are added or deleted while a transaction is in progress. When the same query is executed again it will return a different number of rows.

## Isolation levels

These problems are managed by setting an isolation level either at the storage engine level or for the session. The four isolation levels are:

- **READ UNCOMMITTED** - no locks are placed on the data, which means "dirty reads" are possible. One user can read data that is being modified by someone else, but the modified data has not yet been committed to disk.
- **READ COMMITTED** - prevents dirty reads by making uncommitted modifications not visible to other users. Only committed data is available for each SELECT statement. Read committed can still result in non-repeatable reads when multiple queries are being executed within the same transaction. This means that two users can select the same data but get different results. READ COMMITTED is the default isolation for other common relational databases, such as SQL Server and Postgres. It is not the default for MySQL.
- **REPEATABLE READ** - This is the InnoDb storage engine default transaction isolation level. It guarantees consistent reads within the same transaction by taking a snapshot of the data and using that when the same SELECT is executed. This solves the problem of non-repeatable reads but can impact performance.
- **SERIALIZABLE** - this is the most restricted isolation level. This places a lock on every row and does not allow one transaction to interfere with another. A row selected by one transaction cannot be changed by any other user until the transaction has finished. SERIALIZABLE guarantees that data reads are always consistent.

You can view or amend the default isolation level in server parameters. **Transaction_isolation** is the parameter that defines the default isolation level.
