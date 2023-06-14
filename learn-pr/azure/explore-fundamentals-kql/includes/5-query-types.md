You've learned how the KQL query is built in general. In this unit, you'll dive deeper into the different parts and types of queries.

## Query expressions statements

Kusto queries are made of one or more query statements. Unless explicitly stored, these statements only affect the query that is being run at any specific time. Some of the common query statements are: [Tabular expression statements](#tabular-expression-statements) and [Let statements](#let-statements).

### Tabular expression statements

Most queries use at least one **tabular expression statement**, which means both its input and output consist of tables or tabular datasets. These statements usually contain operators, each of which starts with a tabular input and returns a tabular output.

For example, the following query contains three tabular expression statements:

```kusto
StormEvents
| where EventType == "Flood" //tabular expression statement 1
| sort by DamageProperty asc //tabular expression statement 2
| take 10 //tabular expression statement 3
```

### Let statements

A let statement defines a binding between a name and an expression. Let statements can be used to break a long query into small named parts that are easier to understand.

For example, the following query uses a let statement to define scalar values

```kusto
let n = 10;  // number
let place = "VIRGINIA";  // string
let cutoff = ago(12345d); // datetime 
StormEvents 
| where StartTime > cutoff 
    and State == place 
| take n
```

## Functions

Functions are reusable queries or query parts. Kusto supports two kinds of functions, [Built-in functions](#built-in-functions) and [User-defined functions](#user-defined-functions).

### Built-in functions

Built-in are hard-coded functions defined by Kusto that can't be modified by users. KQL has a rich library of functions available for use, which can be found in the official [KQL documentation](/azure/data-explorer/kusto/query/).

For example, the following strcat() function concatenates string arguments:

```kusto
print str = strcat("hello", " ", "world")
```

### User-defined functions

User-defined functions are, as their name suggests, defined by the user. These can be divided into two types:

* **Stored functions**: are user-defined functions that are stored and managed database schema entities (such as tables).

    For example, the following KQL query stores a function that takes a parameter:
    
    ```kusto
    .create function
    with (docstring = 'Demo function with parameter', folder='Demo')
     MyFunction2(myLimit: long)  {StormEvents | take myLimit}
    ```
    
* **Query-defined functions**: are user-defined functions that are defined and used within the scope of a single query. The definition of such functions is done through a let statement.

    For example, the following query defines and then uses the function *f*:
    
    ```kusto
    let f=(a: string, b: string) {
        strcat(a, " (la la la) ", b)
    };
    print f("hello", "world")
    ```
    
