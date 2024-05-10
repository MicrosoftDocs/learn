PostgreSQL has two levels of transaction isolation that prevent three types of concurrency conflicts, dirty reads, non-repeatable reads, and phantom reads.

## Types of concurrency conflict

### Dirty reads

A dirty read occurs when one transaction reads the updated version of data that another transaction is editing. However, this update is never committed.

For example, a transaction occurs on a savings account that would take the balance of the account to less than zero. Before the transaction is committed, the account balance is checked and the transaction is rolled back since savings accounts aren't allowed to have a balance less than zero. At the same time, a report is being run to show the current balance of all savings accounts. If dirty reads are allowed, the negative balance would be returned, even though it never commits.

### Non-repeatable reads

A non-repeatable read occurs if a transaction: reads data, another transaction updates the data, and the initial transaction reads the data again and sees the new updates.

For example, Connection A starts a transaction and reads the cost per unit and number of units for an order, which are a cost of 10 and number of units of 3. Connection B then starts another transaction and updates the same order to set the cost per unit to 12. In the same transaction as the original query, Connection A calculates the total cost for the order. If non-repeatable reads are allowed Connection A returns cost per unit of 10, number of units of 3, and total cost of 36, which obviously doesn't make sense.

### Phantom reads

A phantom read occurs if a transaction: reads data, another transaction adds a new row (or rows) to the data, and the initial transaction reads the data again and sees the new updates.

For example, Connection A starts a transaction and counts the total number of invoices for the day in Paris. The count totaled 1,100 invoices for all the 10 stores in Paris. Connection B then starts another transaction and adds a new retail store in Paris with 200 invoices for the new store's opening day. In the Connection A transaction, the system now counts the number of stores to calculate the number of invoices per store. Connection A would now divide the 1,100 transactions by 11 stores instead of the original 10 that existed when it ran the invoice count query. This calculation now returns an incorrect average of 100 even though the new store had 200 invoices that Connection A transaction didn't account for in its average calculation.

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

Read committed is the default isolation level in Azure Database for PostgreSQL. Read committed is most appropriate for most scenarios because it prevents dirty reads while providing good performance. It's possible to have non-repeatable reads and phantom reads, but these conditions can only occur if there are multiple SELECT statements concurrently querying the same data.

Repeatable read differs from read committed because multiple SELECT statements within a transaction would see the same results even if another transaction updated the rows between the execution of the transaction's two SELECT statements. If another transaction inserts new rows, these rows wouldn't appear in the results of the second SELECT statement.

The serializable isolation level provides the highest level of transaction isolation and performs as if different transactions were running in serial, that is, one after the other. Serializable isolation level's disadvantage is that if a transaction is performing an update, other transactions could block it. The serializable transaction has to wait until the blocking transaction completes, which affects performance.

Serializable transactions also can't make changes to any rows that other transactions modify during the serializable transaction. If this form of conflict occurs, then an error message is returned and therefore it's important to have retry logic built into applications when serializable transactions are used.

To update transaction isolation levels, use the **TRANSACTION ISOLATION LEVEL** command within a transaction.

For example:

```sql
BEGIN TRANSACTION
TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM humanresources.department
COMMIT;
```
