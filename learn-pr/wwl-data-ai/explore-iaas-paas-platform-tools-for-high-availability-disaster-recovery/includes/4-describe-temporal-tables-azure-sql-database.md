Azure SQL Database and Azure SQL Managed Instance allow you to track and analyze the changes to your data using a feature called Temporal Tables. This feature requires that the tables themselves be converted to be temporal, which means the table will have special properties and will also have a corresponding history table. 

The temporal table feature allows you to use the history table to recover data that may have been deleted or updated. Recovering data from the history table is a manual process involving Transact-SQL, but could be helpful in certain scenarios such as if a user accidentally deletes important data that the business needs.

The following query searches for row versions for an employee with the filter condition `WHERE EmployeeID = 1000` that were active at least for a portion of period between January 1, 2021 and January 1, 2022.

```sql
SELECT * FROM Employee
FOR SYSTEM_TIME
        BETWEEN '2021-01-01 00:00:00.0000000' AND '2022-01-01 00:00:00.0000000'
WHERE EmployeeID = 1000 ORDER BY ValidFrom;
```

## Use case scenarios

The temporal table feature has various uses, including but not limited to:

- **Auditing** - Provides data audit capabilities to existing applications.

- **Historical trends (time travel)** - In time-travel scenarios, users can see how data sets changed over time.

- **Anomaly detection** - For data that don't match an expected pattern. You might investigate sales spikes that don't line up with the average, for example.

- **Data protection due to data loss** - Useful to revert undesired data change without requiring backups.

- **Slowly changing dimensions** - Dimensions in data warehousing are typically static data. However, certain scenarios require you to track data changes in dimension tables as well.

## Storage consideration

Keeping historical data for a long time or performing heavy data changes may cause the history table to increase the database size more than normal tables. A large history table can increase storage cost and also affect your query performance.

It's important to establish a data retention policy within the history table, and to maintain a suitable retention policy threshold by regularly monitoring the size of the history table.

In a temporal history table, there are four ways to manage, store, and delete historical data:

- **Stretch Database** - You can configure SQL Server to silently move historical data from your temporal history tables to Azure

- **Table Partitioning** - The oldest part of the historical data can be moved out of the history table by using a sliding window approach

- **Custom Cleanup Script**- If none of the other options work, you can use a custom cleanup script to remove the data from the history table

- **Retention Policy** - A retention policy can be easily configured at the temporal table level, increasing flexibility

To explore a list of limitations for temporal table, see [Temporal Table Considerations and Limitations](/sql/relational-databases/tables/temporal-table-considerations-and-limitations)