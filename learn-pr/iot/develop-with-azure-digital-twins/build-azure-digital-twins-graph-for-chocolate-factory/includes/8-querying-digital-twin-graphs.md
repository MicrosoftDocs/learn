
Now let's go over the digital twin graph query language.

You can query the digital twin graph that you just built, to get information about the digital twins and relationships it contains. You write these queries in a custom, SQL-like query language, referred to as the Azure Digital Twins query language. This language is also similar to [the query language for Azure IoT Hub](https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-query-language).

Queries *can* be made through the Digital Twins API. In this module, you'll be using the Azure Digital Twins explorer sample to handle the API calls for you.

> [!NOTE]
> All Azure Digital Twins query operations are case-sensitive.

Get digital twins by their model, properties, or relationships. The next sections examine each of these options.

## Model

You can use the `IS_OF_MODEL` operator to filter based on the twin's model. It supports inheritance, and has several overload options.

### Examples with models

Example | Description
------- | -----------
`SELECT * FROM DIGITALTWINS WHERE IS_OF_MODEL('dtmi:sample:thing;1')` | The simplest use of `IS_OF_MODEL`, taking only a `twinTypeName` parameter.
`SELECT * FROM DIGITALTWINS DT WHERE IS_OF_MODEL(DT, 'dtmi:sample:thing;1')` | To specify a twin collection and to search when there's more than one, add the `twinCollection` parameter. This might occur when a `JOIN` is used.
`SELECT * FROM DIGITALTWINS WHERE IS_OF_MODEL('dtmi:sample:thing;1', exact)` | To do an exact match, add the `exact` parameter.

> [!NOTE]
> You can pass all three arguments: `IS_OF_MODEL(twinCollection, twinTypeName, exact)`.

## Properties

You can query for digital twins by properties, including by ID, tags, and metadata. The ID of a digital twin is queried by using the metadata field `$dtId`.

### Examples with properties

In these examples, assume there's a range of models, some containing a `Temperature` property, and some containing a `firmwareVersion` property.

Example | Description
------- | -----------
`SELECT * FROM DIGITALTWINS T WHERE T.Temperature >= 70` | Returns all the model twins with a `Temperature` property where the current value is greater than 70 degrees.
`SELECT * FROM DIGITALTWINS T WHERE T.firmwareVersion = '1.1' AND T.$dtId in ['123', '456'] AND T.Temperature = 70` | Returns all the model twins with a firmware version of "1.1", an ID of either "123" or "456", and with a temperature of 70 degrees.
`SELECT * FROM DIGITALTWINS WHERE IS_DEFINED(Location)` | Returns all the model twins that have a `Location` property defined.
`SELECT * from DIGITALTWINS where is_defined(tags.red)` | Returns all the model twins tagged with `red`.
`SELECT * FROM DIGITALTWINS T WHERE IS_NUMBER(T.Temperature)` | Returns all the model twins where the `Temperature` property is a number.

> [!NOTE]
> In the second example, see how the `in ['123', '456']` construct is used to return true if a property occurs within the specified list. The following is also an example of a legitimate list showing how to validate against a longer list: `WHERE Floor.$dtId IN ['floor_1','floor_2', ..'floor_n']`

## Relationships

When you query based on digital twins' relationships, the Azure Digital Twins query language has a special syntax.

Relationships are pulled into the query scope in the `FROM` clause. An important distinction from traditional SQL-type languages is that each expression in this `FROM` clause isn't a table. Rather, the `FROM` clause expresses a cross-entity relationship traversal, and you write it with an Azure Digital Twins version of `JOIN`.

Relationships don't exist independently of twins. This means that in Azure Digital Twins, the query language's `JOIN` is a little different from the general SQL `JOIN`. Relationships here can't be queried independently, and must be tied to a twin. To incorporate this difference, you use the keyword `RELATED` in the `JOIN` clause to reference a twin's set of relationships.

To get a dataset that includes relationships, use a single `FROM` statement followed by several `JOIN` statements. The `JOIN` statements express relationships on the result of a previous `FROM` or `JOIN` statement.

### Examples

Example | Description
------- | -----------
`SELECT T, CT FROM DIGITALTWINS T JOIN CT RELATED T.contains WHERE T.$dtId = 'ABC'` | Selects all the digital twins with an ID property of 'ABC', and all digital twins related to these digital twins via a `contains` relationship.

> [!NOTE]
> The developer doesn't need to correlate this `JOIN` with a key value in the `WHERE` clause, nor specify a key value inline with the `JOIN` definition. This correlation is computed automatically, as the relationship properties themselves identify the target entity.

### Query the properties of a relationship

Relationships can have properties. You can query twins based on the properties of their relationships. The Azure Digital Twins query language allows filtering and projection of relationships by assigning an alias to the relationship within the `JOIN` clause.

Consider a `servicedBy` relationship that has a `reportedCondition` property. In the next example, this relationship is given an alias of `R` in order to reference its property.

Example | Description
------- | -----------
`SELECT T, SBT, R FROM DIGITALTWINS T JOIN SBT RELATED T.servicedBy R WHERE T.$dtId = 'ABC' AND R.reportedCondition = 'clean'` | Note how `reportedCondition` is a property of the `servicedBy` relationship itself, and not of some digital twin that has a `servicedBy` relationship.

## Summary of the query language

For more information on constructing a query, see [About the query language for Azure Digital Twins](https://docs.microsoft.com/azure/digital-twins/concepts-query-language#reference-expressions-and-conditions).

Next, you'll try using the language on your factory graph.
