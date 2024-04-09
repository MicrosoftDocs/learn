## Creating KQL Querysets in Microsoft Fabric


1. **Setup**: To start using KQL, you need to have an Azure account and set up Azure Data Explorer.
1. **Create KQL Queryset**: A KQL queryset is a tool that allows you to execute queries, modify, and display query results from a KQL database. It's used in Microsoft Fabric for real-time analytics.
1. **KQL Queryset limitations**: 
    1. Each tab in the KQL queryset can be associated with a different KQL database, and lets you save queries for later use or share them with others for data analysis
    1. The KQL Queryset uses the Kusto Query Language (KQL) for creating queries, and also supports many SQL functions 

    > [!NOTE]
    > The use of SQL or SQL Functions within a KQL Queryset removes the ability to build Power BI Reports with it

1. To create a KQL Queryset, you can go to any section within Microsoft Fabric and click on the **Create button** and then scroll to **Create KQL Queryset** as shown in the example, which starts from the **Data Engineering** section.

[ ![Screenshot of K Q L Queryset from within Data Engineering section.](../media/create-kql-queryset.png) ](../media/create-kql-queryset-expanded.png#lightbox)
    
1. **Basic Query**: A basic KQL query follows the pattern: `<table_name> | where <condition> | project <columns>`.
1. **Functions and Operators**: KQL supports a variety of operators for arithmetic, comparison, logical operations, and string manipulations.
1. **Advanced Querying**: Once you have a good grasp of the basics, you can move on to more advanced querying techniques such as aggregations, joins, and subqueries.
1. **Practical Exercises**: To get hands-on experience with KQL, you can try out some practical exercises provided by Microsoft Learn.

Here are some introductory queries to help you get started:

- To retrieve all records from a table: `TableName`
- To retrieve specific columns from a table: `TableName | project Column1, Column2`
- To filter records based on a condition: `TableName | where Column1 == "value"`
- To sort records in ascending order: `TableName | sort by Column1 asc`
- To sort records in descending order: `TableName | sort by Column1 desc`

You can use these queries to practice and get comfortable with the basics of KQL.

## Advantages of KQL and T-SQL

Within Microsoft Fabric KQL Database, you can use the primary language of Kusto Query Language (KQL) or Transact-Structured Query Language (T-SQL), and you can use the data to build Power BI Reports. 

[ ![Screenshot of K Q L Query with highlighted element of publishing to Power B I. ](../media/kql-queryset-pbi-build.png) ](../media/kql-queryset-pbi-build-expanded.png#lightbox)

However, there are advantages to each and in the case of a KQL database, KQL is the preferred language. More comparisons follow:

1. **Simplicity**: KQL is a simpler language than T-SQL, making it easier to learn and use.
2. **Performance**: KQL is optimized for performance and can handle large amounts of data more efficiently than T-SQL.
3. **Flexibility**: KQL is more flexible than T-SQL, allowing users to perform complex queries with ease.
4. **Integration**: KQL is integrated with other Microsoft products, such as Azure Monitor and Azure Sentinel.
                    However, T-SQL has its own advantages over KQL, including:

## Advantages of T-SQL over KQL

One major disadvantage of using T-SQL over KQL is that it's not the native language of the engine and has to go through a transformer. This langugage differrence prevents it from being published to Power BI directly from the Queryset.

  [ ![Screenshot of T - S Q L Query with highlighted element showing prevention of publishing to Power B I. ](../media/tsql-queryset-pbi-build.png) ](../media/tsql-queryset-pbi-build-expanded.png#lightbox)

As mentioned, T-SQL can be run to a limit extent against a Microsoft Fabric KQL database and provides a few advantages:

1. **Compatibility**: T-SQL is a widely used language and is compatible with many different database systems.
2. **Functionality**: T-SQL has a wider range of functions and features than KQL.
3. **Procedural programming**: T-SQL supports procedural programming, which allows developers to write complex scripts and stored procedures.

    >[!NOTE] 
    >If you’re familiar with SQL and want to learn KQL, you can translate SQL queries into KQL using the `-- explain syntax`
    
    For example: 

    ```tsql
        
       --
        Explain
        SELECT CASE
                 WHEN pickup_boroname IS NULL OR pickup_boroname = '' THEN 'Unidentified'
                 ELSE pickup_boroname
               END AS Borough,
               SUM(trip_distance) AS [Total Trip Distance]
        FROM Trips
        GROUP BY CASE
                   WHEN pickup_boroname IS NULL OR pickup_boroname = '' THEN 'Unidentified'
                   ELSE pickup_boroname
                 END;
    ```
     generates the following KQL Syntax. This function is a powerful feature within the KQL Engine
p
    ```kusto
    
    Trips
    | summarize ['Total Trip Distance']=sum(trip_distance) by groupByExpression1=iff((isnull(pickup_boroname) or (pickup_boroname == "")), "Unidentified", pickup_boroname)
    | project Borough=groupByExpression1, ['Total Trip Distance']
    
    ```
     
[ ![Screenshot of T - S Q L conversion resultset used to convert.](../media/tsql-same-results.png) ](../media/tsql-same-results-expanded.png#lightbox)
    

     Which produces the same outcome:

    
[ ![Screenshot of K Q L Query with highlighted element of publishing to Power B I.](../media/kql-same-results.png) ](../media/kql-same-results-expanded.png#lightbox)
    
     
    

Here are some extra resources:

- Use example queries in [Real-Time Analytics - Microsoft Fabric.](/fabric/real-time-analytics/query-table)
- [Query data in a KQL queryset](/fabric/real-time-analytics/kusto-query-set).
