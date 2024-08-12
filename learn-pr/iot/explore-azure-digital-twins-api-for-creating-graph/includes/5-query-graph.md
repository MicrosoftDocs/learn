In this unit, you'll use the Query API to gather more information about the state of the sample graph that you've worked on in previous units.

## View Query API documentation

Start by reviewing the [Query API documentation](/rest/api/digital-twins/dataplane/query). The API contains one operation for running a query. The text of the query determines what digital twins are in the result.

:::image type="content" source="../media/5-query.png" alt-text="Reference doc screenshot showing the Query operation." border="true" lightbox="../media/5-query.png":::

Queries are written in the SQL-like **Azure Digital Twins query language**, and can find twins by their models, properties, and relationships. You can also combine these parameters to further narrow down query results.

## Query by model

First, try a query that finds twins based on their model. Say that you want to see all the power lines from your energy grid represented in your Azure Digital Twins instance.

From your Postman collections, start by opening the request template at _Data plane > query > **POST Query Query Twins**_.

Make the following changes in the template:
* In the **Params** tab, set the **api-version** value to *2023-10-31*. 
* In the **Headers** tab, uncheck the **max-items-per-page**, **traceparent**, and **tracestate** options.
* In the **Body** tab, replace the contents with the following information. This query returns all twins that have a model of *dtmi:example:grid:transmission:powerLine;1*.

  ```json
  {
    "query": "SELECT * FROM DIGITALTWINS WHERE IS_OF_MODEL('dtmi:example:grid:transmission:powerLine;1')"
  }
  ```

Send the request.

[!INCLUDE [Reminder for how to get a new data plane bearer token](../../includes/azure-digital-twins-data-plane-token.md)]

The response from a successful request looks something like this:

:::image type="content" source="../media/5-query-query-twins-model.png" alt-text="Postman screenshot showing the results of the Query Query Twins request with the model query." border="true" lightbox="../media/5-query-query-twins-model.png":::

This 200 response contains a list of digital twins in JSON format that meet the query criteria. In this case, it's a list of all the power lines in the instance (there are five).

## Query by property

Next, run some queries that find twins based on their property values.

### Query for undefined properties

The *Power Line* model contains a property definition for *Capacity*. Although you imported several power line twins in [Unit 3](../3-upload-models-twins-graph-bulk.yml), they don't all have a value set for this property. The query in this section builds on the model query from the previous section and adds a provision to select only the power lines that don't have a value set for their capacity property.

In the same request template of  **POST Query Query Twins**, edit the **Body** tab. Replace the contents with the following information. This query looks for power line twins that don't have a defined *Capacity* property.

```json
{
  "query": "SELECT * FROM DIGITALTWINS WHERE IS_OF_MODEL('dtmi:example:grid:transmission:powerLine;1') AND NOT IS_DEFINED(Capacity)"
}
```

Send the request.

The 200 response from a successful request looks very similar to the response from the previous section. However, if you scroll through the results, you'll notice that there are only four twins in the result. The power line *pl_distribute* is missing from the list, since it was given a *Capacity* value of 0 when it was originally defined.

You can use queries like this to make sure your digital twin representation is fully populated.

>[!TIP]
>You learned how to update a twin property in [Unit 4](../4-update-graph-elements.yml). For a challenge exercise, try using the *$dtId* values in the query result along with that process to update the *Capacity* property on each twin that's missing it.

### Query by value

You can also query twins based on the value of a property that's been defined.

Say you want to verify the capacity values on your power line twins, and make sure none of them are set to 0. You can use the query request in this section to see any power lines that have a capacity value of 0.

In the same request template of  **POST Query Query Twins**, edit the **Body** tab. Replace the contents with the following information. This query looks for power line twins that have a *Capacity* value of 0.

```json
{
  "query": "SELECT * FROM DIGITALTWINS WHERE IS_OF_MODEL('dtmi:example:grid:transmission:powerLine;1') AND Capacity = 0"
}
```

The 200 response from a successful request only contains one twin, *pl_distribute*.

:::image type="content" source="../media/5-query-query-twins-property.png" alt-text="Postman screenshot showing the results of the Query Query Twins request with the property query." border="true" lightbox="../media/5-query-query-twins-property.png":::

You can use queries like this to verify your twin graph. You can also use them to check for irregularities in live properties that are set by devices in a fully connected solution.

## Query by relationships

Finally, run a query that finds twins based on relationships.

Having noticed that the *pl_distribute* power line has a capacity of 0, you might want to check on all the twins that are fed by this power line to see if their capacity values also need to be updated. You can use the query in this section to find all the twins that are fed by *pl_distribute*.

In the same request template of  **POST Query Query Twins**, edit the **Body** tab. Replace the contents with the following information. This query looks for any twins that are connected to *pl_distribute* by a *feeds* relationship pointing out from the power line.

```json
{
  "query": "SELECT CT FROM DIGITALTWINS T JOIN CT RELATED T.feeds WHERE T.$dtId = 'pl_distribute'"
}
```

Send the request.

The 200 response from a successful request contains six *Delivery Substation* twins. You can see in the twin details that they all also have a *Capacity* value of 0.

:::image type="content" source="../media/5-query-query-twins-relationship.png" alt-text="Postman screenshot showing the results of the Query Query Twins request with the relationship query." border="true" lightbox="../media/5-query-query-twins-relationship.png":::

You can use queries like this to verify relationships in your graph and understand how different twins impact each other.
