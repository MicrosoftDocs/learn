Structured exception handling uses the TRY/CATCH construct to test for errors, and handle errors. When using exception handling with transactions, it is important to place the `COMMIT` or `ROLLBACK` keywords in the correct place in relation to the TRY/CATCH blocks.

## Commit transactions

When using transactions with structured exception handling, place the `COMMIT TRANSACTION` inside the TRY block as in the following code example:

```sql
BEGIN TRY
 BEGIN TRANSACTION
 	INSERT INTO dbo.Orders(custid, empid, orderdate)
	VALUES (68,9,'2006-07-12');
	INSERT INTO dbo.OrderDetails(orderid,productid,unitprice,qty)
	VALUES (1, 2,15.20,20);
 COMMIT TRANSACTION
END TRY 
```

## Rollback transaction
When used with structured exception handling, place the `ROLLBACK TRANSACTION` inside the CATCH block as in the following code example:

```sql
BEGIN TRY
 BEGIN TRANSACTION;
 	INSERT INTO dbo.Orders(custid, empid, orderdate)
	VALUES (68,9,'2006-07-12');
	INSERT INTO dbo.OrderDetails(orderid,productid,unitprice,qty)
	VALUES (1, 2,15.20,20);
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrNum, ERROR_MESSAGE() AS ErrMsg;
	ROLLBACK TRANSACTION;
END CATCH;
```

## XACT_STATE
To avoid rolling back an active transaction, use the `XACT_STATE` function. `XACT_STATE` returns the following values:

Return value | Meaning
---------|----------
 1  | The current session has an active user transaction. The session can perform any actions, including writing data and committing the transaction.
 0  | No active transaction.
 -1 | The current session has an active user transaction, but an error has occurred that classified the transaction as uncommittable. The session can't commit or roll back to a savepoint; it can only perform reads and must issue a full `ROLLBACK TRANSACTION`.


`XACT_STATE` can be used before the `ROLLBACK` command, to check whether the transaction is active.

The following code shows the `XACT_STATE` function used inside a CATCH block. It distinguishes state `-1` (uncommittable—must fully roll back) from state `1` (committable—can be committed):

```sql
BEGIN TRY
 BEGIN TRANSACTION;
 	INSERT INTO dbo.SimpleOrders(custid, empid, orderdate) 
	VALUES (68,9,'2006-07-12');
	INSERT INTO dbo.SimpleOrderDetails(orderid,productid,unitprice,qty) 
	VALUES (1, 2,15.20,20);
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrNum, ERROR_MESSAGE() AS ErrMsg;

	-- Test for uncommittable transaction (for example, caused by SET XACT_ABORT ON).
	IF XACT_STATE() = -1
	BEGIN
		ROLLBACK TRANSACTION;
	END;

	-- Test for active, committable transaction.
	IF XACT_STATE() = 1
	BEGIN
		COMMIT TRANSACTION;
	END;
	-- If XACT_STATE() = 0, there is no active transaction; no action needed.
END CATCH;
```
