You've learned about the structure of a KQL query. In this unit, you'll dive deeper into the different parts and types of KQL queries.

This unit provides an overview of query statements and functions. In KQL, all queries consist of one or more query statements. These statements only affect the specific query in which they're used, unless explicitly stored for future use. The most common types of query statements are [tabular expression statements](#tabular-expression-statements) and [let statements](#let-statements). In addition to its extensive library of [built-in functions](#built-in-functions), KQL allows for [user-defined functions](#user-defined-functions) that can be either stored or defined for use in a single query.

## Tabular expression statements

Most queries use at least one *tabular expression statement*, which means both its input and output consist of tables or tabular datasets. These statements usually contain operators, each of which starts with a tabular input and returns a tabular output.

There is a wide range of operators provided by KQL, ranging from simple operators (such as `count`, `sort`, and `where`) to more complex (such as `parse`, `join`, and `render`) ones. 

For example, the following query contains four tabular expression statements:

```kusto
StormEvents // tabular expression statement 1
| where EventType == "Flood" // tabular expression statement 2
| sort by DamageProperty asc // tabular expression statement 3
| take 10 // tabular expression statement 4
```

## Let statements

A *let statement* defines a binding between a name and an expression. Let statements can be used to break a long query into small named parts that are easier to understand.

For example, the following query uses a let statement to define scalar values:

```kusto
let n = 10;  // number
let place = "VIRGINIA";  // string
let cutoff = ago(12345d); // datetime 
StormEvents 
| where StartTime > cutoff and State == place 
| take n
```

## Built-in functions

Built-in functions are hard-coded functions defined by KQL that can't be modified. KQL has a rich library of functions available for use, which can be found in the official [KQL documentation](/azure/data-explorer/kusto/query/). The functions range from simple sorting and matching to complex statistical and geospatial functions.

For example, the following `strcat()` function concatenates string arguments:

```kusto
print str = strcat("hello", " ", "world")
```

## User-defined functions

User-defined functions are, as their name suggests, defined by the user. User-defined functions can be divided into two types:

* **Stored functions**: User-defined functions that are stored and managed database schema entities, similar to tables. Different products use different ways to store functions.

    For example, the following query in Azure Data Explorer stores a function that takes a parameter:

    ```kusto
    .create function
    with (docstring = 'Demo function with parameter', folder='Demo')
     MyFunction2(myLimit: long)  {StormEvents | take myLimit}
    ```

    In other environment, such as Azure Monitor and Microsoft Sentinel, queries can be saved through the UI.

* **Query-defined functions**: User-defined functions that are defined and used within the scope of a single query. The definition of such functions is done through a let statement.

    For example, the following query defines and then uses the function *f*:

    ```kusto
    let f=(a: string, b: string) {
        strcat(a, " (la la la) ", b)
    };
    print f("hello", "world")
    ```
