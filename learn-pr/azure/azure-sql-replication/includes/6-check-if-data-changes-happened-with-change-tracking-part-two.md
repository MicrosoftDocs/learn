## Obtain changes and information about the changes made to a database

Applications can use the following functions to obtain the changes that are made in a database and information about the changes:

### CHANGETABLE(CHANGES ...) function

This rowset function is used to query for change information. The function queries the data stored in the internal change tracking tables. The function returns a results set that contains the primary keys of rows that have changed together with other change information such as the operation, columns updated and version for the row.

Below is an example of how to use this function to obtain changes for a SalesLT.Product table:

*declare @last_synchronization_version bigint;*
*SELECT*  
    *CT.ProductID, CT.SYS_CHANGE_OPERATION,*  
    *CT.SYS_CHANGE_COLUMNS, CT.SYS_CHANGE_CONTEXT*  
*FROM*  
    *CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT*

### CHANGE_TRACKING_CURRENT_VERSION() function

This function is used to obtain the current version that will be used the next time when querying changes. This version represents the version of the last committed transaction.

### CHANGE_TRACKING_MIN_VALID_VERSION() function

This function is used to obtain the minimum valid version that a client can have and still obtain valid results from CHANGETABLE(). The client should check the last synchronization version against the value that is returned by this function. If the last synchronization version is less than the version returned by this function, the client will be unable to obtain valid results from CHANGETABLE() and will have to reinitialize.

## User interface options

You can enable Change Tracking on your databases and tables by running T-SQL. You can also enable Change Tracking on SQL Server Management Studio, by using the Database Properties (ChangeTracking page) dialog box. However, if a database contains memory optimized tables, you can’t enable Change Tracking with SQL Server Management Studio and you need to use T-SQL.
