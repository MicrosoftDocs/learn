Structured exception handling uses the TRY/CATCH construct to test for errors, and handle errors. When using exception handling with transactions, it is important to place the COMMIT or ROLLBACK keywords in the correct place in relation to the TRY/CATCH blocks.

## Commit transactions

When using transactions with structured exception handling, place the COMMIT the transaction inside the TRY block as in the following code example:

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
When used with structured exception handling, place the ROLLBACK the transaction inside the CATCH block as in the following code example:

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
To avoid rolling back an active transaction, use the XACT_STATE function. XACT_STATE returns the following values:

Return value | Meaning
---------|----------
 1  | The current request has an active, committable user transaction.
 0  | No active transaction. 
 -1 | The current request has an active user transaction, but an error has occurred that has caused the transaction to be classified as an uncommittable transaction.


XACT_State can be used before the ROLLBACK command, to check whether the transaction is active.

The following code shows the XACT_STATE function being used within the CATCH block so that the transaction is only rolled back if there is an active user transaction.

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
	IF (XACT_STATE()) <> 0
    	BEGIN
        ROLLBACK TRANSACTION;
    	END;
	ELSE .... -- provide for other outcomes of XACT_STATE()
END CATCH;
```
