You've learned a bit about how query languages function, and where you might use them. In this unit, you'll explore the way a KQL query is built.

## KQL query structure

A Kusto query is a read-only request to process data and return results. The request is stated in plain text, using a data-flow model that is easy to read, author, and automate.

Different query languages often have different structures. You may be familiar with SQL, which begins with a "SELECT" statement to specify the output fields, followed by stating the target data source, then a condition to be evaluated, and sometimes even a statement to order the results.

In contrast, KQL is organized around the way data is processed. To get to the same results as the SQL query described above, the parallel KQL query begins with the data source. The data funnel is then reduced by passing through conditions, ordered, and reduced further with a filter.

These two query structures are represented in the following schematic image:

:::image type="content" source="../media/kql-sql-structures.png" alt-text="Schematic diagram showing the order of query elements in SQL vs KQL languages.":::

## Data processing

Kusto queries are made of one or more query statements. Unless explicitly stored, these statements only affect the query that is being run at any specific time. 

The most common type of query statement is a **tabular expression statement**, which means both its input and output consist of tables or tabular datasets. Tabular statements contain zero or more operators, each of which starts with a tabular input and returns a tabular output.

 Imagine that the data travels through a data processing funnel. The tabular input is the beginning of the funnel of data. This data is "piped" into the next line, and filtered or manipulated using an operator. The "surviving" data coming out of the operator is piped into the subsequent line, and so on until arriving at the final query output. This query output is returned in a tabular format.

:::image type="content" source="../media/kql-funnel.png" alt-text="Schematic image of data being processed by a funnel.":::

Other statement types are:

* **Let statements**, used to set a variable name equal to an expression or a function, or to create views.
* **Set statements**, used to set a query option for the duration of the query. Query options control how a query executes and returns results.

## Functions

Functions are reusable queries or query parts. Kusto supports two kinds of functions:

* **Built-in functions** are hard-coded functions defined by Kusto that can't be modified by users.

* **User-defined functions**, which are divided into two types:

    * **Stored functions**: are user-defined functions that are stored and managed database schema entities (such as tables).
    * **Query-defined functions**: are user-defined functions that are defined and used within the scope of a single query. The definition of such functions is done through a let statement.

## Management commands

Kusto Query Language also supports a set of commands that are used retrieve information that is not necessarily data in the database tables, or to modify the service state. These commands are prefaced by the dot (`.`) character, and are outside of the scope of this training.
