## Querying the change tables for changes

When a table is enabled for change data capture, an associated capture instance is created to support the dissemination of the change data in the source table. The capture instance consists of a change table and up to two query functions. The requirements for the capture instance name are that it be a valid object name, and that it be unique across the database capture instances. By default, the name is <schema name_table name> of the source table. Its associated change table is named by appending _CT to the capture instance name.

Functions are provided to enumerate the changes that appear in the change tables over a specified range, returning the information in the form of a filtered result set. The filtered result set is typically used by an application process to update a representation of the source in some external environment. The function that is used to query for all changes is fn_cdc_get_all_changes_<capture_instance>.
If the capture instance is configured to support net changes, the net_changes query function is also created - fn_cdc_get_net_changes_<capture_instance>.

## Access required for enabling / disabling CDC

The db_owner role is required to enable change data capture for Azure SQL Database. Sysadmin permissions are required to enable change data capture for SQL Server or Azure SQL Managed Instance.

## User interface options

You can use CDC by running T-SQL commands.

## Key use cases

- Tracking data changes for audit purposes.

- Propagating changes to downstream subscribers or executing ETL operations to move all the data changes from the OLTP system to the data lake or warehouse.

- Performing analytics on change data.

- Programming reactive / event based solutions.