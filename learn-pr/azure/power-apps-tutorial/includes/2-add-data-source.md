Information is a vital part of any application as the entire logic resides on the type of information stored. Likewise, in Power Apps, the data is stored in a data source that can be accessed using connections. The connection utilizes a particular connector to converse with the data source. Many significant services and on-premises data sources, such as SharePoint, SQL Server, Office 365, Salesforce, and Twitter, have connectors in Power Apps.

The most common data sources are tables through which you can store and retrieve information. Connections help you read and write data in Microsoft Excel workbooks, SharePoint lists, SQL tables, and many other formats, which can be stored in cloud services such as OneDrive for Business, DropBox, and SQL Server.

A connector might give tables of information or actions. A few connectors give just tables, some give just actions, and some give both. Likewise, your connector might be either a standard or custom connector.

## Local data sources

To create an app that reads and writes from a data source, you must use either one of these controls. They are:

* **Gallery** - Gallery control is used to filter, sort, search, scroll through records in a data source, and select a specific record. You can also display only a few fields from each record to show several records at a time, even on a small screen.

* **Display form** - Display form helps you show any or all fields in a single record.

* **Edit form** - Edit form allows you to update one or more fields in a single record (or create a record starting with default values) and save those changes back to the underlying data source.

These controls are used when Power Apps creates an app from data. Behind the scenes, the application stores and manipulates data from the data source using an internal table.

## Popular connectors

* **SharePoint** - Connect to a SharePoint site to instantly produce an app from a custom list, or create a connection before adding data to an existing app or creating a new one.
* **Office 365 outlook** - User can view, send, delete, and reply to email messages and perform other actions when you connect to Office 365 Outlook.
* **SQL server** - Connect to SQL Server, whether in Azure or on-premises, to manage your data using operations including creating, reading, updating, and deleting.
* **Oracle** - After you make a connection and develop an app in Power Apps, you may list tables and create, read, update, and delete table rows in an Oracle database. Filtering, sorting, and other functions can be fully delegated using the Oracle Database connection, but triggers and stored procedures are not supported.
* **Office 365 users** - Using your Office 365 account, you can access user profiles inside your organization. For example, you can receive your profile, a user's profile, a user's manager, or direct reports, among other things.
