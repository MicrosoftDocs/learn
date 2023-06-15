<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-learning-unit-introduction-format)
-->
In this unit, you'll learn about what a query is and the use cases for querying data in Azure using Kusto Query Language. 

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
TODO: add your scenario sub-task

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
Here, you'll learn about what a query is and what you can do using Kusto Query Language in Azure. 

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->
TODO: add a visual element

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## What is a query? 

A query is a request for information from a data source, such as a database or table. A simple query might retrieve:

- Information about a user from a table of registered users.
- All information in a specific table.
- All information logged by a specific computer at a given time.

A query language also lets you define how to present the data that's returned. For example, you can specify the sort order of the results, the range of rows to return, whether duplicate rows should be returned, and whether to display data in a chart or graph.
## What is a query language?

There are various ways you can retrieve data from a database, including:

- Selecting search parameters from a menu.
- Choosing the fields and values that define the query through a user interface.
- Using a query language to request information from a database in an API call or through a user interface. Using a query language is the most complex way to query data, but it's also the most flexible. 

A query language consists of a set of keywords, operators, and syntax rules for writing statements that retrieve data from a database. 

There are many query languages, each with its own syntax, capabilities, and strengths. Common query languages include Structured Query Language (SQL), a standard language for storing, manipulating and retrieving data in databases, and XQuery, a query language for XML data.

## Why use Kusto Query Language? 

Kusto Query Language (KQL) was developed as part of Azure Data Explorer, a big data analytics platform for near-real-time analysis of large volumes of data streamed in from multiple sources. These capabilities make the platform and KQL the perfect foundations for Azure services that require near-real-time monitoring and analytics to ensure service and resource reliability, performance, and security.

In a later unit in this module, we'll have a quick look at these Azure services, which leverage KQL's abilities to analyze large volume of varied data quickly.

Other Azure services with different needs use different query languages. For example, storage services often use Structured Query Language (SQL).  

Compared to SQL, KQL is a simpler and more concise language that's optimized for running ad-hoc queries and data exploration. 
## What can you do with KQL? 

1. investigate or analyze - you might want to retrieve data using a query when working with Azure Monitor or Azure Data Explorer. For example, you can write log queries in Azure Monitor to understand query structure, sort query results, filter query results, specify a time range, select which fields to include in the results, define and use custom fields, and aggregate and group results.
1. create alerts - you can use kql to create alerts in Azure Monitor. For example, you can create alerts based on the results of a log query, and you can create alerts based on metrics.
1. create workbooks - you can use kql to create workbooks in Azure Monitor. For example, you can create workbooks based on the results of a log query, and you can create workbooks based on metrics.
1. create custom detections - you can use kql to create custom detections in Azure Sentinel. For example, you can create custom detections based on the results of a log query, and you can create custom detections based on metrics.
1. create custom visualizations - you can use kql to create custom visualizations in Azure Sentinel. For example, you can create custom visualizations based on the results of a log query, and you can create custom visualizations based on metrics. 
1. transform data - you can use kql to transform data in Azure Data Explorer. 


In Azure, you might want to retrieve data using a query when working with Azure Monitor or Azure Data Explorer. For example, you can write log queries in Azure Monitor to understand query structure, sort query results, filter query results, specify a time range, select which fields to include in the results, define and use custom fields, and aggregate and group results4. In the stand-alone Azure Data Explorer web UI, the query editor provides suggestions and warnings as you write your queries5.
