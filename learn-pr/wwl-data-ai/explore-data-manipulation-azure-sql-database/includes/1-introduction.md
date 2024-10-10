Efficient data management is a key aspect that can affect the performance and user experience of your application when developing applications.

Depending on the specific requirements of your application, one data manipulation method might be the obvious choice, however, in most scenarios, there will be overlapping advantages and disadvantages. 

Whether you're dealing with large datasets, complex data structures, or specific performance requirements, it's recommended to test the various methods before deciding on the best approach for your specific application needs.

In this module, you'll discover a range of methods for manipulating data, including importing, exporting, and copying data to and from Azure SQL Database.

> [!NOTE] 
> We use the terms data import, data export, data movement, and data copy as subsets of data manipulation.

## Understand data movement scenarios

Understanding the different purposes for data movement is essential for developers to effectively manage their data. The following table outlines some of the common scenarios for data movement.

| **Type** | **Description**  | **Frequency** | **Scenario** |
|-----|-----|-----|------|
| **Synchronization** | To keep data consistent across multiple systems | Continuous | Import sensor data from IoT devices to a central database and exporting configuration updates back to the devices |
| **Sharing** | Share data with other teams or systems | As needed | Exporting data to share with a partner organization |
| **Integration** | Integrate data from various sources into a single system | Continuous | Importing data from multiple sources into a central database for unified access |
| **Migration** | Migrating to a different platform or environment | One-time | Migrating data from an on-premises database to Azure SQL Database |
| **Backup** | Create a copy of the data to prevent data loss | Periodically | Exporting data to an external storage for backup purposes |
| **Archiving** | Store historical data that is no longer actively used | Periodically | Exporting old transaction records to an archive database |

> [!TIP] 
> Explore other modules part of the [Develop data-driven applications by using Azure SQL Database learning path](/training/modules/get-started-sql-database-application-development?azure-portal=true).