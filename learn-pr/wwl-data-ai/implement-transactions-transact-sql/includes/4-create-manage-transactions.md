To explicitly start a transaction, use the BEGIN TRANSACTION, or the shortened version, BEGIN TRAN.

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

## XACT_ABORT

When SET XACT_ABORT is ON, if SQL Server raises an error, the entire transaction is rolled back. When SET XACT_ABORT is OFF, only the statement that raised the error is rolled back if the severity of the error is low.

For example, when SET XACT_ABORT is OFF a transaction has three statements. Two have no errors, but the third one breaks a check constraint. In this example, even though the three statements are in a transaction, two of them are committed. In the same example, if the error had been caused by an incorrect data type, this would have been severe enough to issue a rollback and none of the statements would have committed.

Because it is not always clear whether the transaction will be committed or rolled back, it is essential to add error handling to transactions.