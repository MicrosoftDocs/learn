A **transaction** is one or more T-SQL statements that are treated as a unit. If any one of the statements fail, then all the statements fail. If a transaction is successful, you know that all the data modification statements in the transaction were successful and committed to the database.

Transactions ensure all statements within a transaction either succeed or all fail, no partial completion is permitted. Transactions encapsulate operations that must logically occur together, such as multiple entries into related tables that are part of a single operation.

Consider a business that stores purchases in a **Sales.Order** table, and payments in a **Sales.Payment** table. When someone buys something both tables must be updated. If this is implemented without transactions, and an error occurs when the payment is being written to the database, the **Sales.Order** insert will still be committed, leaving the payment table without an entry.

When this is implemented with transactions, either both entries are made or neither entry is made. If there's an error writing the payment to the table, the order insert will also be rolled back. This means the database is always in a consistent state.

:::image type="content" source="../media/transactions.png" alt-text="Diagram showing the difference between using transactions and not using transactions.":::

It should be noted that this refers to severe errors, such as hardware or network errors. Errors in SQL statements would only cause the transaction to roll back in certain circumstances and it is important to review the subsequent units in this module to fully understand the implications of using transactions.

There are different types of transactions:

## Explicit transactions

The keywords BEGIN TRANSACTION and either COMMIT or ROLLBACK start and end each batch of statements. This allows you to specify which statements must be either committed or rolled back together.

## Implicit transactions

A transaction is started when the previous transaction has completed. Each transaction is explicitly completed with a COMMIT or ROLLBACK statement.
