A Spark connector for KQL is included for use in notebook development to give the user greater flexibility in handling unstructured and streaming datasources.

## Overview
The Spark Connector for Microsoft Fabric is an open-source project that enables seamless data integration between Apache Spark and various data sources. It supports both data source and data sink operations, allowing you to move data to and from Spark clusters efficiently.

## Key Features
- **Compatibility**: The connector is compatible with Apache Spark 3.0 and supports all Apache Spark bindings, including Scala, Python, and R.
- **Data Integration**: It allows you to use SQL Server or Azure SQL as input data sources or output data sinks for Spark jobs.
- **Performance**: The connector provides high-performance data transfer, outperforming traditional JDBC connectors by 10 to 20 times.
- **Security**: Supports basic authentication, Active Directory (AD) Key Tab, and Microsoft Entra ID.

## Use Cases
- **Data Analytics**: Perform big data analytics using transactional data from SQL Server or Azure SQL.
- **Machine Learning**: Score machine learning models from SQL Server Machine Learning Services or perform machine learning in Spark and score results in SQL.
- **Real-Time Intelligence**: Integrate with Microsoft Fabric's Real-Time Intelligence for processing and analyzing streaming data.

## Getting Started
One of the newer features within Microsoft Fabric notebooks is that it provides [code snippets](https://learn.microsoft.com/fabric/data-engineering/author-execute-notebook#code-snippets). By creating a new notebook in Microsoft Fabric or within a cell of an existing notebook, you can either drag-and-drop objects from the Lakehouse explorer or open up the Intellisense style of code snippets by typing ```snippet``` on within the cell. By doing this or using a keyword, such as Lakehouse. When you know you need to do something with a Lakehouse, you can start by typing it, and a list of snippet options appear assisting you with writing code with good hygiene and at a quicker pace.
