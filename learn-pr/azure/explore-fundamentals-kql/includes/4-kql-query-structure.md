You've learned a bit about how query languages function, and where you might use them. In this unit, you'll explore the way a KQL query is built.

## KQL query structure

A Kusto query is a read-only request to process data and return results. The request is stated in plain text, using a data-flow model that is easy to read, author, and automate.

Different query languages often have different structures. You may be familiar with SQL, which begins with a "SELECT" statement to specify the output fields, followed by stating the target data source, then a condition to be evaluated, and sometimes even a statement to order the results.

In contrast, KQL is organized around the way data is processed. To get to the same results as the SQL query described above, the parallel KQL query begins with the data source. The data funnel is then reduced by passing through conditions, ordered, and reduced further with a filter.

These two query structures are represented in the following schematic image:

:::image type="content" source="../media/kql-sql-structures.png" alt-text="Schematic diagram showing the order of query elements in SQL vs KQL languages.":::

## Data processing

 Imagine that the data travels the above steps through a data processing funnel. The tabular input, in this example the "StormEvents" table, is the beginning of the funnel of data. This data is "piped" into the next line, and filtered or manipulated using an operator. The "surviving" data coming out of the operator is piped into the subsequent line, and so on until arriving at the final query output. This query output is returned in a tabular format.

:::image type="content" source="../media/kql-funnel.png" alt-text="Schematic image of data being processed by a funnel.":::

Filtering steps that remove the largest amounts of data should be used at the beginning of the query, so that the following operators have a smaller amount of data to process. This arrangement will give the fastest, or most "performant" queries.