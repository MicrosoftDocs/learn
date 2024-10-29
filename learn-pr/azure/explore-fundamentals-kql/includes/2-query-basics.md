
Organizations often collect a wide range of data about IT resources and users. Querying data is a powerful tool for working with and acting on data you collect.

Here, you learn about what a query is and what you can do using KQL.

## What is a query?

A query is a request for information from a data source, such as a database or table. A simple query might return:

- Information about a user from a table of registered users.
- All information in a specific table.
- All information logged by a specific computer at a given time.

A query language also lets you define how to present the data returned by the query. For example, you can specify the sort order of the results, the range of rows to return, whether duplicate rows should be returned, and whether to display data in a chart or graph.

## What is a query language?

There are various ways you can return data from a database, including:

- Selecting search parameters from a menu.
- Choosing the fields and values that define the query through a user interface.
- Using a query language to request information from a database in an API call or through a user interface. Using a query language is the most complex way to query data, but it's also the most flexible.

A query language consists of a set of keywords, operators, and syntax rules for writing statements that return data from a database.

There are many query languages, and each has its own syntax, capabilities, and strengths. Common query languages include:

- **Structured Query Language (SQL)** - A standard language for storing, manipulating and retrieving data in databases.
- **XQuery** - A query language for XML data.

## Why use KQL? 

KQL was developed as part of Azure Data Explorer, a big data analytics platform for near-real-time analysis of large volumes of data streamed in from multiple sources. By ensuring service and resource reliability, performance, and security, the Azure Data Explorer and KQL form the perfect foundation for services that require near-real-time monitoring and analytics.

In a later unit in this module, we take a quick look at Azure services that apply KQL's ability to quickly analyze large volumes of varied data.

Compared to SQL, KQL is more concise and better optimized for ad-hoc queries and data exploration.
 
## What can you do with KQL?

All Microsoft services that use Azure Data Explorer clusters provide a set of ready-to-use data analysis tools that don't require KQL knowledge, but a bit of KQL knowledge allows you to do much more. For example, you can: 

- Investigate or analyze - use KQL to troubleshoot issues or gain specific insights. 
- Define your own alerts - trigger an alert based on logic you define using KQL.
- Create custom visualizations - create dashboards and workbooks that visualize the results of KQL queries. 
- Transform data - transform data before you store or present it. For example, you can use KQL to convert data from one format to another. Some services let you use KQL to filter out data from a data source to save costs on ingesting and storing data you don't need.