In database operations, there is sometimes a need to perform a SQL MERGE operation. This DML option allows you to synchronize two tables by inserting, updating, or deleting rows in one table based on differences found in the other table. The table that is being modified is referred to as the *target* table. The table that is used to determine which rows to change are called the *source* table.

MERGE modifies data, based on one or more conditions:

 *  When the source data has a matching row in the target table, it can update data in the target table.
 *  When the source data has no match in the target, it can insert data into the target table.
 *  When the target data has no match in the source, it can delete the target data.

The general syntax of a MERGE statement is shown below. We're matching the target and the source on a specified column, and if there's a match between target and source, we specify an action to take on the target table. If there's not a match, we specify an action. The action can be an INSERT, UPDATE, or DELETE operation. This code indicates that an UPDATE is performed when there's a match between the source and the target. An INSERT is performed when there's data in the source with no matching data in the target. Finally, a DELETE is performed when there is data in the target with no match in the source. There are many other possible forms of a MERGE statement.

```sql
MERGE INTO schema_name.table_name AS TargetTbl
USING (SELECT <select_list>) AS SourceTbl
ON (TargetTbl.col1 = SourceTbl.col1)
WHEN MATCHED THEN 
   UPDATE SET TargetTbl.col2 = SourceTbl.col2
WHEN NOT MATCHED [BY TARGET] THEN
   INSERT (<column_list>)
   VALUES (<value_list>)
WHEN NOT MATCHED BY SOURCE THEN
   DELETE;
```

You can use only the elements of the MERGE statement that you need. For example, suppose the database includes a table of staged invoice updates, that includes a mix of revisions to existing invoices and new invoices. You can use the WHEN MATCHED and WHEN NOT MATCHED clauses to update or insert invoice data as required.

```sql
MERGE INTO Sales.Invoice as i
USING Sales.InvoiceStaging as s
ON i.SalesOrderID = s.SalesOrderID
WHEN MATCHED THEN
    UPDATE SET i.CustomerID = s.CustomerID,
                i.OrderDate = GETDATE(),
                i.PurchaseOrderNumber = s.PurchaseOrderNumber,
                i.TotalDue = s.TotalDue
WHEN NOT MATCHED THEN
    INSERT (SalesOrderID, CustomerID, OrderDate, PurchaseOrderNumber, TotalDue)
    VALUES (s.SalesOrderID, s.CustomerID, s.OrderDate, s.PurchaseOrderNumber, s.TotalDue);
```
