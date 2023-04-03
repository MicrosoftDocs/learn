You've learned a bit about how query languages function, and where you might use them. In this unit, you'll explore the way a KQL query is built.

## KQL query structure

Different query languages often have different structures. You may be familiar with SQL, which begins with a "SELECT" statement to specify the output fields, followed by stating the target data source, then a condition to be evaluated, and sometimes even a statement to order the results.

In contrast, KQL is organized around the way data is processed. To get to the same results as the SQL query described above, the parallel KQL query begins with the data source. The data funnel is then reduced by passing through conditions, ordered, and reduced further with a filter.

These two query structures are represented in the following schematic image:

:::image type="content" source="../media/kql-sql-structures.png" alt-text="Schematic diagram showing the order of query elements in SQL vs KQL languages.":::

## Data processing

 Imagine the data going through a data processing funnel. Each KQL query begins with reference to a tabular input, which is the beginning of the funnel of data. This data is "piped" into the next line, and filtered or manipulated using an operator. The "surviving" data coming out of the operator is piped into the subsequent line, and so on until arriving at the final query output. This query output is returned in a tabular format, which can also be rendered into visualizations.

:::image type="content" source="../media/kql-funnel.png" alt-text="Schematic image of data being processed by a funnel.":::

## Types of KQL queries



## Functions

(built-in, query-defined, stored)

## Management commands




Read only query language 

Optimized for time series (is this true of KQL or just ADX?) 

Structured, unstructured, semi-structured data 

Used to explore, analyze, and transform data 

Built-in advanced data analysis capabilities 

Compare with SQL/splunk 

"Kusto Query Language is an expressive, intuitive, and highly productive query language. It offers a smooth transition from simple one-liners to complex data processing scripts, and supports querying structured, semi-structured, and unstructured (text search) data. There is a wide variety of query language operators and functions (aggregation, filtering, time series functions, geospatial functions, joins, unions, and more) in the language. KQL supports cross-cluster and cross-database queries, and is feature rich from a parsing (json, XML etc.) perspective. In addition, the language natively supports advanced analytics." 

