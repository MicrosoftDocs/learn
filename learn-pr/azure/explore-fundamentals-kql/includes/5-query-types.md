You've learned how the KQL query is built in general. In this unit, you'll dive deeper into the different parts and types of queries.

## Query expressions statements

Kusto queries are made of one or more query statements. Unless explicitly stored, these statements only affect the query that is being run at any specific time. 

Most queries use a **tabular expression statement**, which means both its input and output consist of tables or tabular datasets. Tabular can contain operators, each of which starts with a tabular input and returns a tabular output.

For example, the following query contains three tabular expression statements:

```kusto
StormEvents
| where EventType == "Flood" //tabular expression statement 1
| sort by DamageProperty asc //tabular expression statement 2
| take 10 //tabular expression statement 3
```

Other statement types are:

* **Let statements**, used to set a variable name equal to an expression or a function, or to create views.
* **Set statements**, used to set a query option for the duration of the query. Query options control how a query executes and returns results.

## Functions

Functions are reusable queries or query parts. Kusto supports two kinds of functions:

* **Built-in functions** are hard-coded functions defined by Kusto that can't be modified by users.

* **User-defined functions**, which are divided into two types:

    * **Stored functions**: are user-defined functions that are stored and managed database schema entities (such as tables).
    * **Query-defined functions**: are user-defined functions that are defined and used within the scope of a single query. The definition of such functions is done through a let statement.

