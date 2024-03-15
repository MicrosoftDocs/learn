In this unit, you use the Model and Digitaltwin APIs to make manual updates to the sample graph that you imported in the previous unit.

## Update (replace) a model

Start this section on updating models by reviewing the [Models API documentation](/rest/api/digital-twins/dataplane/models). The API contains operations to add new models, delete models, get a model's details by its ID, list all models, and update a model.

:::image type="content" source="../media/4-models.png" alt-text="Reference doc screenshot showing the Models operations." border="true" lightbox="../media/4-models.png":::

However, models that are uploaded to an Azure Digital Twins instance are immutable, which means they can't be edited or updated in a traditional sense. Instead, one way to "update" a model in your instance is to delete the old model and reupload an updated definition.

In the city grid example for this module, say you decide you also want your graph to keep track of who owns and operates each substation. There are three substation-type models in your instance: *Delivery Substation*, *Generator Substation*, and *Base Receiver* (the base model from which the other two inherit). By adding an `Operator` property to the base model, you can make the new property available on all three substation models.

Here's the original text of the *Base Receiver* model that was uploaded to your instance with the sample scenario in the previous unit. (You can also view the [energy grid models in GitHub](https://github.com/Azure-Samples/azure-digital-twins-getting-started/tree/main/models/energy-grid-example).)

```json
{
    "@id": "dtmi:example:grid:transmission:baseReceiver;1",
    "@context": "dtmi:dtdl:context;3",
    "@type": "Interface",
    "displayName": "Base Receiver"
}
```

Here's the updated text for the model after adding a new `Operator` property. For now, just review it. Later, you'll use this code in the body of an API request to upload the new model.

```json
{
    "@id": "dtmi:example:grid:transmission:baseReceiver;1",
    "@context": "dtmi:dtdl:context;3",
    "@type": "Interface",
    "displayName": "Base Receiver",
    "contents":  [
     {
     "@type": "Property",
     "name": "Operator",
     "schema": "string"
     }
    ]
}
```

### Delete old models

Before uploading the new *Base Receiver* model, you need to delete the old one.

However, the other substation models *Delivery Substation* and *Generator Substation* depend on this model, so *Base Receiver* can't be deleted without removing those models first. So in this section, you remove all three substation models. Then, you reupload the edited *Base Receiver* model, then reupload the dependent *Delivery Substation* and *Generator Substation* models without any changes to them.

From your Postman collections, start by opening the request template at _Data plane > models > {id} > **DEL Digital Twin Models Delete**_.

Make the following changes in the template:
* In the **Params** tab, set **api-version** to *2023-10-31* and the **id** value to *dtmi:example:grid:transmission:deliverySubStation;1*. This value is the ID of the *Delivery Substation* model.
* In the **Headers** tab, uncheck the **traceparent** and **tracestate** options.

Send the request. A 204 response with no error message indicates the delete request was successful.

:::image type="content" source="../media/4-digital-twin-models-delete.png" alt-text="Postman screenshot showing the results of the Digital Twin Models Delete request." border="true" lightbox="../media/4-digital-twin-models-delete.png":::

[!INCLUDE [Reminder for how to get a new data plane bearer token](../../includes/azure-digital-twins-data-plane-token.md)]

Return to the **Params** tab and change the **id** value to *dtmi:example:grid:transmission:generatorSubStation;1*. This value is the ID of the *Generator Substation* model. Send the request.

Finally, change the **id** value again to *dtmi:example:grid:transmission:baseReceiver;1*. This value is the ID of the *Base Receiver* model. Send the request.

After these steps, all substation-type models are deleted from your instance.

### Upload new models

Now you can reupload the new *Base Receiver* model, and then reupload the two substation models that reference it.

From your Postman collections, open the request template at _Data plane > models > **POST Digital Twin Models Add**_.

Make the following changes in the template:
* In the **Params** tab, set the **api-version** value to *2023-10-31*. 
* In the **Headers** tab, uncheck the **traceparent** and **tracestate** options.
* In the **Body** tab, replace the contents with the following snippet. This code is the new *Base Receiver* model definition inside a set of square brackets.

    ```json
    [
    {
        "@id": "dtmi:example:grid:transmission:baseReceiver;1",
        "@context": "dtmi:dtdl:context;3",
        "@type": "Interface",
        "displayName": "Base Receiver",
        "contents":  [
        {
        "@type": "Property",
        "name": "Operator",
        "schema": "string"
        }
        ]
    }
    ]
    ```

Send the request.

The response from a successful request looks something like this:

:::image type="content" source="../media/4-digital-twin-models-add.png" alt-text="Postman screenshot showing the results of the Digital Twin Models Add request." border="true" lightbox="../media/4-digital-twin-models-add.png":::

It's the body of the new *Base Receiver* model. This response indicates that the new model was uploaded to the instance, and replaced the old definition that was deleted.

Next, return to the **Body** tab and replace the contents with the following code. It's the definition of the *Delivery Substation* model, copied from its [GitHub source file](https://github.com/Azure-Samples/azure-digital-twins-getting-started/blob/main/models/energy-grid-example/DeliverySubStation.json) for simplicity.

```json
[
{
    "@id": "dtmi:example:grid:transmission:deliverySubStation;1",
    "@context": "dtmi:dtdl:context;3",
    "@type": "Interface",
    "extends": ["dtmi:example:grid:transmission:baseReceiver;1"],
    "displayName": "Delivery SubStation",
    "contents": [
        {
            "@type": "Property",
            "name": "Capacity",
            "schema": "double"
        },
        {
            "@type": "Relationship",
            "name": "feeds",
            "target": "dtmi:example:grid:consumer:baseConsumer;1"
        }
    ]
}
]
```

Send the request.

Next, replace the **Body** contents with the following code. It's the definition of the *Generator Substation* model, copied from its [GitHub source file](https://github.com/Azure-Samples/azure-digital-twins-getting-started/blob/main/models/energy-grid-example/GeneratorSubStation.json) for simplicity.

```json
[
{
    "@id": "dtmi:example:grid:transmission:generatorSubStation;1",
    "@context": "dtmi:dtdl:context;3",
    "@type": "Interface",
    "extends": ["dtmi:example:grid:transmission:baseReceiver;1"],
    "displayName": "Generator SubStation",
    "contents": [
        {
            "@type": "Property",
            "name": "Capacity",
            "schema": "double"
        },
        {
            "@type": "Relationship",
            "name": "feeds",
            "target": "dtmi:example:grid:transmission:powerLine;1"
        }
    ]
}
]
```

Send the request.

Now all of the substation models are reuploaded to the instance (including the updated *Base receiver* model, and two unchanged inherited models for *Delivery Substation* and *Generator Substation*). The inherited models, and any digital twins referencing the *Base Receiver* model or any of its inherited models, now reference the updated definition and are capable of supporting an `Operator` property.

### Verify updates

You can verify the new model property by getting the *Base Receiver* model by its ID.

From your Postman collections, open the request template at _Data plane > models > {id} > **GET Digital Twin Models Get By ID**_.

Make the following changes in the template:
* In the **Params** tab, set **includeModelDefinition** to *true*, **api-version** to *2023-10-31*, and **id** to *dtmi:example:grid:transmission:baseReceiver;1*. 
* In the **Headers** tab, uncheck the **traceparent** and **tracestate** options.

Send the request.

Scrolling through the response should reveal the new `Operator` property as part of the *Base Receiver* model definition.

:::image type="content" source="../media/4-digital-twin-models-get-by-id.png" alt-text="Postman screenshot showing the results of the Digital Twin Models Get By ID request." border="true" lightbox="../media/4-digital-twin-models-get-by-id.png":::

## Update twin properties

Since your work in the previous section made a new `Operator` property available in the substation model definitions, you can add this property to any digital twins that use the substation models. In this section, you add the property to a delivery substation twin called *sub_corp*.

>[!TIP]
>To get a list of all twins that use a certain model, use the Query APIs covered in [Unit 5](../5-query-graph.yml) of this module.

Start by reviewing the [Twins API documentation](/rest/api/digital-twins/dataplane/twins). The API contains operations to add/delete, get, and update digital twins, their components, and their relationships. In this section, you focus on operations dealing with twins themselves.

:::image type="content" source="../media/4-twins.png" alt-text="Reference doc screenshot showing the Twins operations and highlighting the twin-focused ones." border="true" lightbox="../media/4-twins.png":::

From your Postman collections, open the request template at _Data plane > digitaltwins > {id} > **PATCH Digital Twins Update**_.

Make the following changes in the template:
* In the **Params** tab, set the **api-version** value to *2023-10-31* and the **id** to *sub_corp*. 
* In the **Headers** tab, uncheck the **If-Match**, **traceparent**, and **tracestate** options.
* Switch to the **Body** tab, which accepts the update instruction in JSON Patch format. Paste the following patch document into the **Body** field. This patch adds an `Operator` property to the twin and sets its value to *Contoso Electric*.

    ```json
    [
        {
        "op": "add", 
        "path": "/Operator", 
        "value": "Contoso Electric"
        }
    ]
    ```

Send the request. A 204 response with no error message indicates the delete request was successful.

:::image type="content" source="../media/4-digital-twins-update.png" alt-text="Postman screenshot showing the results of the Digital Twins Update request." border="true" lightbox="../media/4-digital-twins-update.png":::

### Verify updates

You can verify the new twin property by getting the *sub_corp* twin by its ID.

From the same Postman collection folder, open the request template for **GET Digital Twins Get By ID**.

Make the following changes in the template:
* In the **Params** tab, set the **api-version** value to *2023-10-31* and the **id** to *sub_corp*. 
* In the **Headers** tab, uncheck the **traceparent** and **tracestate** options.

Send the request. Look for the `Operator` field and its value in the response.

:::image type="content" source="../media/4-digital-twins-get-by-id.png" alt-text="Postman screenshot showing the results of the Digital Twins Get By ID request." border="true" lightbox="../media/4-digital-twins-get-by-id.png":::

This response confirms that the twin is updated with the new property. In the sample scenario, you might repeat the process with the other substation twins to include this detail throughout your environment.

## Update relationships

Start this section on updating relationships by reviewing the [Twins API documentation](/rest/api/digital-twins/dataplane/twins) again, this time looking at the operations that deal with relationships.

:::image type="content" source="../media/4-relationships.png" alt-text="Reference doc screenshot showing the Twins operations and highlighting the relationship ones." border="true" lightbox="../media/4-relationships.png":::

Let's say one of the delivery substations represented in your graph is no longer going to supply power to one of its farm consumers. Currently, the delivery substation twin *sub_farmcluster_2* has a *feeds* relationship to farm consumer *c_farm_05*. Since the substation's going to stop feeding that farm cluster, you need to update the graph to remove the relationship between these two twins.

From your Postman collections, open the request template at _Data plane > digitaltwins > {id} > relationships > {relationshipId} > **DEL Digital Twins Delete Relationship**_.

Make the following changes in the template:
* In the **Params** tab, set the **api-version** value to *2023-10-31*, the **id** value to *sub_farmcluster_2*, and the **relationshipId** value to *57becd45-1391-45e8-b127-ff3fdc5d0175*. This value was the ID value given for this relationship when the graph was imported, and together with the source twin ID it identifies this specific relationship in the graph.
* In the **Headers** tab, uncheck the **If-Match**, **traceparent**, and **tracestate** options.

Send the request. A 204 response with no error message indicates the delete request was successful.

:::image type="content" source="../media/4-digital-twins-delete-relationship.png" alt-text="Postman screenshot showing the results of the Digital Twins Delete Relationship request." border="true" lightbox="../media/4-digital-twins-delete-relationship.png":::

### Verify deletion

You can verify the relationship was deleted by listing the relationships from the  *sub_farmcluster_2* twin and confirming that the *feeds* relationship to farm consumer *c_farm_05* isn't in the list.

From your Postman collections, open the request template at _Data plane > digitaltwins > {id} > relationships > **GET Digital Twins List Relationships**_.

Make the following changes in the template:
* In the **Params** tab, set the **relationshipName** to *feeds*, the **api-version** to *2023-10-31*, and the **id** value to *sub_farmcluster_2*. This request now looks for *feeds*-type relationships coming out of *sub_farmcluster_2*.
* In the **Headers** tab, uncheck the **traceparent** and **tracestate** options.

Send the request. The response should show two relationships to *c_farm_04* and *c_farm_06*, but no relationship to *c_farm_05*. That indicates the delete operation was successful.

:::image type="content" source="../media/4-digital-twins-list-relationships.png" alt-text="Postman screenshot showing the results of the Digital Twins List Relationships." border="true" lightbox="../media/4-digital-twins-list-relationships.png":::