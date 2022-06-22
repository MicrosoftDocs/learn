PostgreSQL has two levels of transaction isolation that prevent three types of concurrency conflicts, dirty reads, non-repeatable reads, and phantom reads.

## Types of concurrency conflict

### Dirty reads

A dirty read occurs when one transaction reads the updated version of data that another transaction is editing. However, this update is never actually committed.

For example, a transaction occurs on a savings account that would take the balance of the account below zero. Before the transaction is committed, the account balance is checked and the transaction is rolled back because savings accounts aren't allowed to have a balance below zero. At the same time, a report is being run to show the current balance of all savings accounts. If dirty reads are allowed, the negative balance would be returned, even though it's never actually committed.

### Non-repeatable reads

A non-repeatable read occurs if a transaction reads data, the data is updated by another transaction, and the initial transaction reads the data again and sees the new updates.

For example, Connection A starts a transaction and reads the cost per unit and number of units for an order, which are a cost of $10 and number of units of 3. Connection B then starts another transaction and updates the same order to set the cost per unit to $12. In the same transaction as the original query, Connection A calculates the total cost for the order. If non-repeatable reads are allowed Connection A will return cost per unit of $10, number of units of 3, and total cost of $36, which obviously doesn't make sense.

### Phantom reads

A phantom read occurs if a transaction reads data, a new row (or rows) is added to the data by another transaction, and the initial transaction reads the data again and sees the new updates.

For example, Connection A starts a transaction and counts the total number of transactions per day in Paris, which is 1,100. Connection B then starts another transaction and adds a new retail store in Paris with transactions on its opening day of 200. In the same transaction as the original query, Connection A counts the number of stores in Paris and calculates the average number of transactions per store by dividing the number of transactions per day which it already queried by the count of stores. If phantom reads are allowed, it would divide the original total transactions per day of 1,100 by the new number of stores, which is 11, and return an average of 100 even if the new store had transactions.

## Isolation levels

Azure Database for PostgreSQL has three transaction isolation levels, read committed, repeatable read, and serializable. The read uncommitted isn't available in Azure Database for PostgreSQL.

How isolation levels affect concurrency conflicts:


|Isolation level  |Dirty read  |Non-repeatable read  |Phantom read  |
|---------|---------|---------|---------|
|Read uncommitted*     |Possible         |Possible         |Possible         |
|Read committed     |Not possible         |Possible         |Possible         |
|Repeatable read     |Not possible         |Not possible         |Possible         |
|Serializable     |Not possible         |Not possible         |Not possible         |

\* Not available in PostgreSQL

Read committed is the default isolation level in Azure Database for PostgreSQL. Read committed is most appropriate for most scenarios because it prevents dirty reads while providing good performance. It's possible to have non-repeatable reads and phantom reads, but these can only occur if there are multiple SELECT statements.

Repeatable read differs from read committed because multiple SELECT statements within a transaction would see the same results even if another transaction had updated the rows between the two SELECT statements. iIf new rows had been inserted by another transaction, these wouldn't appear in the results of the second SELECT statement.

The serializable isolation level provides the highest level of transaction isolation and performs as if different transactions were running in serial, that is, one after the other. The disadvantage of the serializable isolation level is that if a transaction is performing an update it's more likely to be blocked by other transactions and have to wait until they complete, which will affect performance.

Serializable transactions also can't make changes to any rows which are modified by other transactions during the serializable transaction. If this form of conflict occurs, then an error message is returned and therefore it's important to have retry logic built into applications when serializable transactions are used.

To update transaction isolation levels use the **TRANSACTION ISOLATION LEVEL** command within a transaction.

For example:

```sql
BEGIN TRANSACTION
TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM humanresources.department
COMMIT;
```
