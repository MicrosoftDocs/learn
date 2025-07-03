While there are methods available for migrating an entire schema and its data, there are also cases where only a subset of the database is needed. Fortunately, many of the methods we’ve seen support partial data migration, and we’ll learn about a few others.

In our bicycle manufacturer scenario, suppose the company has an on-premises SQL Server database that contains several years’ worth of sales, customer, and product data. The company wants to migrate to an Azure SQL Database to take advantage of the scalability and flexibility of the cloud. However, they only need to migrate the customer and product tables, as they want to keep their sales data on-premises for security reasons.

## Bulk copy

The [bcp utility](/sql/relational-databases/import-export/import-and-export-bulk-data-by-using-the-bcp-utility-sql-server) allows bulk exporting of data from a SQL Server table into a data file and vice versa. The utility is versatile, enabling data transfer between SQL Server and other programs or databases. 

Understanding the schema and data types of the table is essential for using the bcp command effectively, unless a pre-existing format file is available.

## Azure Data Factory	

You can use [Azure Data Factory](/azure/data-factory/quickstart-get-started) for data migration rather than entire database migration. Azure Data Factory can migrate and transform data from source SQL Server databases, and it's commonly used for business intelligence workloads (BI). 
