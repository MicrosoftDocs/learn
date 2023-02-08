Recall that the center of Azure Digital Twins is the twin graph, constructed from digital twins and relationships.

This graph can be queried to get information about the digital twins and relationships it contains. These queries are written in a custom SQL-like query language, referred to as the Azure Digital Twins query language. This language is similar to the IoT Hub query language with many comparable features.

## Azure Digital Twins query language and considerations

You can use the Azure Digital Twins query language to retrieve digital twins according to the following:

 -  properties of the twin (including tag properties)
 -  models
 -  relationships
 -  properties of the relationships

To submit a query to the Azure Digital Twins service from a client app, you will use the Azure Digital Twins Query API. One way to use the API is through one of the SDKs for Azure Digital Twins.

### Considerations for querying

When writing queries for Azure Digital Twins, keep the following considerations in mind:

 -  Remember case sensitivity: All Azure Digital Twins query operations are case-sensitive, so take care to use the exact names defined in the models. If property names are misspelled or incorrectly cased, the result set is empty with no errors returned.
 -  Escape single quotes: If your query text includes a single quote character in the data, the quote will need to be escaped with the \\ character. Here is an example that deals with a property value of D'Souza:
    
    ```
    SELECT * FROM DIGITALTWINS WHERE Name = 'D\'Souza'
    
    ```

### Expressions and conditions

Before writing any queries, it is important to understand the operators and functions that are available to write Azure Digital Twins queries.

The following operators are supported:

:::row:::
  :::column:::
    **Family**
  :::column-end:::
  :::column:::
    **Operators**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Logical
  :::column-end:::
  :::column:::
    AND, OR, NOT
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Comparison
  :::column-end:::
  :::column:::
    `=, !=, <, >, <=, >=`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Contains
  :::column-end:::
  :::column:::
    IN, NIN
  :::column-end:::
:::row-end:::


The following type checking and casting functions are supported:

:::row:::
  :::column:::
    **Function**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IS\_DEFINED
  :::column-end:::
  :::column:::
    Returns a Boolean indicating if the property has been assigned a value. This is supported only when the value is a primitive type. Primitive types include string, Boolean, numeric, or null. DateTime, object types, and arrays are not supported.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IS\_OF\_MODEL
  :::column-end:::
  :::column:::
    Returns a Boolean value indicating if the specified twin matches the specified model type
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IS\_BOOL
  :::column-end:::
  :::column:::
    Returns a Boolean value indicating if the type of the specified expression is a Boolean.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IS\_NUMBER
  :::column-end:::
  :::column:::
    Returns a Boolean value indicating if the type of the specified expression is a number.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IS\_STRING
  :::column-end:::
  :::column:::
    Returns a Boolean value indicating if the type of the specified expression is a string.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IS\_NULL
  :::column-end:::
  :::column:::
    Returns a Boolean value indicating if the type of the specified expression is null.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IS\_PRIMITIVE
  :::column-end:::
  :::column:::
    Returns a Boolean value indicating if the type of the specified expression is a primitive (string, Boolean, numeric, or null).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IS\_OBJECT
  :::column-end:::
  :::column:::
    Returns a Boolean value indicating if the type of the specified expression is a JSON object.
  :::column-end:::
:::row-end:::


The following string functions are supported:

:::row:::
  :::column:::
    **Function**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    STARTSWITH(x,y)
  :::column-end:::
  :::column:::
    Returns a Boolean indicating whether the first string expression starts with the second.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ENDSWITH(x,y)
  :::column-end:::
  :::column:::
    Returns a Boolean indicating whether the first string expression ends with the second.
  :::column-end:::
:::row-end:::


## Azure Digital Twins graph query examples

The following examples help to illustrate the query language structure and common query operations for digital twins.

### Show all digital twins

Here is the basic query that will return a list of all digital twins in the instance:

```SQL
SELECT * FROM DIGITALTWINS

```

### Query by property

Get digital twins by properties (including ID and metadata):

```SQL
SELECT  *
FROM DIGITALTWINS T 
WHERE T.firmwareVersion = '1.1'
AND T.$dtId IN ['123', '456']
AND T.Temperature = 70

```

As shown in the query above, the ID of a digital twin is queried using the metadata field `$dtId`.

> [!TIP]
> If you are using Cloud Shell to run a query with metadata fields that begin with `$`, you should escape the `$` with a backtick to let Cloud Shell know it's not a variable and should be consumed as a literal in the query text.

You can also get twins based on whether a certain property is defined. Here is a query that gets twins that have a defined Location property:

```
SELECT * FROM DIGITALTWINS WHERE IS_DEFINED(Location)

```

This same approach can help you to get twins by their tag properties. Here is a query that gets all twins tagged with red:

```
SELECT * FROM DIGITALTWINS WHERE IS_DEFINED(tags.red)

```

### Query by model

The IS\_OF\_MODEL operator can be used to filter based on the twin's model.

It considers inheritance and model versioning, and evaluates to true for a given twin if the twin meets either of these conditions:

 -  The twin directly implements the model provided to IS\_OF\_MODEL(), and the version number of the model on the twin is greater than or equal to the version number of the provided model
 -  The twin implements a model that extends the model provided to IS\_OF\_MODEL(), and the twin's extended model version number is greater than or equal to the version number of the provided model

For example, if you query for twins of the model `dtmi:example:widget;4`, the query will return all twins based on version 4 or greater of the widget model, and also twins based on version 4 or greater of any models that inherit from widget.

IS\_OF\_MODEL can take several different parameters, resulting in a number of different overload options.

The simplest use of IS\_OF\_MODEL takes only a twinTypeName parameter: IS\_OF\_MODEL(twinTypeName). Here is a query example that passes a value in this parameter:

```
SELECT * FROM DIGITALTWINS WHERE IS_OF_MODEL('dtmi:example:thing;1')

```

### Query by relationship

When querying based on digital twins' relationships, the Azure Digital Twins query language has a special syntax.

Relationships are pulled into the query scope in the FROM clause. An important distinction from "classical" SQL-type languages is that each expression in this FROM clause is not a table; rather, the FROM clause expresses a cross-entity relationship traversal, and is written with an Azure Digital Twins version of JOIN.

Recall that with the Azure Digital Twins model capabilities, relationships do not exist independently of twins, which means the Azure Digital Twins query language's JOIN is a little different from the general SQL JOIN, as relationships here can't be queried independently and must be tied to a twin. To incorporate this difference, the keyword RELATED is used in the JOIN clause to reference a twin's set of relationships.

> [!TIP]
> Conceptually, this feature mimics the document-centric functionality of CosmosDB, where JOIN can be performed on child objects within a document. CosmosDB uses the IN keyword to indicate the JOIN is intended to iterate over array elements within the current context document.

To get a dataset that includes relationships, use a single FROM statement followed by N JOIN statements, where the JOIN statements express relationships on the result of a previous FROM or JOIN statement.

```
SELECT T, CT
FROM DIGITALTWINS T
JOIN CT RELATED T.contains
WHERE T.$dtId = 'ABC'

```

Count items You can count the number of items in a result set using the Select COUNT clause:

```
SELECT COUNT()
FROM DIGITALTWINS

```

Add a WHERE clause to count the number of items that meet the specified criteria.

```
SELECT COUNT()
FROM DIGITALTWINS
WHERE IS_OF_MODEL('dtmi:sample:Room;1')

SELECT COUNT()
FROM DIGITALTWINS c
WHERE IS_OF_MODEL('dtmi:sample:Room;1') AND c.Capacity > 20

```

## Query limitations

This section describes limitations of the query language.

 -  Timing: There may be a delay of up to 10 seconds before changes in your instance are reflected in queries. For example, if you complete an operation like creating or deleting twins with the DigitalTwins API, the result may not be immediately reflected in Query API requests. Waiting for a short period should be sufficient to resolve.
 -  No subqueries are supported within the FROM statement.
 -  OUTER JOIN semantics are not supported, meaning if the relationship has a rank of zero, then the entire "row" is eliminated from the output result set.
 -  Graph traversal depth is restricted to five JOIN levels per query.
 -  Relationships in Azure Digital Twins can't be queried as independent entities; you also need to provide information about the source twin that the relationship comes from. There are some restrictions on the JOIN operation, which is used to query relationships, to make sure that the query declares the twin(s) where the query begins.

For more Azure Digital Twins query details and examples, see the following articles:

 -  Query API: [Query - Query Twins](/rest/api/digital-twins/dataplane/query/querytwins)
 -  Query the twin graph: [Query the Azure Digital Twins twin graph](/azure/digital-twins/how-to-query-graph)