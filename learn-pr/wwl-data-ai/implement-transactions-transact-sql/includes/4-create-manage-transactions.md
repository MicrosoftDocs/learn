To implicitly start a transaction, use the BEGIN TRANSACTION, or the shortened version, BEGIN TRAN.

Once a transaction has been started, it must be ended with either:

* COMMIT TRANSACTION, or 
* ROLLBACK TRANSACTION. 

This ensures that all the statements within the transaction are committed together or rolled back together if there's an error.  

Transactions last until a COMMIT TRANSACTION or ROLLBACK TRANSACTION command is issued, or the connection is dropped. If the connection is dropped part way through a transaction, the whole transaction is rolled back.

Transactions may be nested, in which case the inner transactions will be rolled back if the outer transaction rolls back.

## No error is detected

When the statements in your transaction have completed without error, use COMMIT TRANSACTION, sometimes shortened to COMMIT TRAN. This commits the changes to the database. This will also release resources such as locks held during the transaction.

## If an error is detected

If an error occurred within the transaction, use the ROLLBACK command.

ROLLBACK undoes any modifications made to data during the transaction, leaving it in the state it was before the transaction started. ROLLBACK also releases resources, such as locks, held for the transaction.
