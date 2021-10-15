It's helpful to compare the behavior of T-SQL batches, enclosed within a TRY/CATCH block, to the behavior of transactions.

Consider the following code that is inserting two customer orders, requiring a row in the **SalesLT.SalesOrderHeader** table, and one or more rows in the **SalesLT.SalesOrderDetail** table. All the INSERT statements are enclosed within the TRY block. 

* If the first insert fails, execution passes to the CATCH block and no further code is executed. 
* If the second insert fails, execution passes to the CATCH block and no further code is executed. However, the first insert was successful, and isn't rolled back leaving the database in an inconsistent state. A row was inserted for the order, but no row for the order detail.

```sql
BEGIN TRY
	INSERT INTO dbo.Orders(custid, empid, orderdate) 
		VALUES (68, 9, '2021-07-12');
	INSERT INTO dbo.Orders(custid, empid, orderdate) 
		VALUES (88, 3, '2021-07-15');
	INSERT INTO dbo.OrderDetails(orderid,productid,unitprice,qty) 
		VALUES (1, 2, 15.20, 20);
	INSERT INTO dbo.OrderDetails(orderid,productid,unitprice,qty) 
		VALUES (999, 77, 26.20, 15);
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrNum, ERROR_MESSAGE() AS ErrMsg;
END CATCH;
```

Compare this to implementing the code within a transaction. The TRY/CATCH block is still used for error handling, however the INSERT statements for the Orders and OrderDetails tables are enclosed within BEGIN TRANSACTION/COMMIT TRANSACTION keywords. This ensures that all statements are treated as a single transaction, which either succeeds or fails. Either one row is written to both the Orders and OrderDetails table, or neither row is inserted. In this way, the database can never be in an inconsistent state.

```sql
BEGIN TRY
 BEGIN TRANSACTION;
	INSERT INTO dbo.Orders(custid, empid, orderdate) 
		VALUES (68,9,'2006-07-15');
	INSERT INTO dbo.OrderDetails(orderid,productid,unitprice,qty) 
		VALUES (99, 2,15.20,20);
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
 SELECT ERROR_NUMBER() AS ErrNum, ERROR_MESSAGE() AS ErrMsg;
 ROLLBACK TRANSACTION;
END CATCH;
```

