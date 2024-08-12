In this unit, you use the Model and Digitaltwin APIs to make manual updates to the sample graph that you imported in the previous unit.

## Update (replace) a model

First, make some updates to the models in your graph.

### View Models API documentation

Start by reviewing the [Models API documentation](/rest/api/digital-twins/dataplane/models). The API contains operations to add new models, delete models, get a model's details by its ID, list all models, and update a model.

:::image type="content" source="../media/4-models.png" alt-text="Reference doc screenshot showing the Models operations." border="true" lightbox="../media/4-models.png":::

### Understand model update process

Models that are uploaded to an Azure Digital Twins instance are immutable, which means they can't be edited or updated in a traditional sense. Instead, one way to "update" a model in your instance is to delete the old model and reupload an updated definition.

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

Follow these steps to delete the models using the [DigitalTwinModels Delete](/rest/api/digital-twins/dataplane/models/digital-twin-models-delete) API.

1. Return to the *data.http* file in your Visual Studio project for this module. 

1. Signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

1. Paste the following DELETE request on the next line. This is the [DigitalTwinModels Delete](/rest/api/digital-twins/dataplane/models/digital-twin-models-delete) request copied from the reference documentation, with parameters filled in for the host name, data plane version, and the DTMI ID of the *Delivery Substation* model. It also has the authorization header specifying use of your bearer token.

    ```http
    DELETE https://{{hostName}}/models/dtmi:example:grid:transmission:deliverySubStation;1?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    ```
    :::image type="content" source="../media/4-models-delete-request.png" alt-text="Visual Studio screenshot showing the Models Delete request." border="true" lightbox="../media/4-models-delete-request.png":::

1. Select **Send request** above the request to send it.

    A 204 response with no error message indicates the delete request was successful.
    
    :::image type="content" source="../media/4-models-delete-response.png" alt-text="Visual Studio screenshot showing the results of the Digital Twin Models Delete request." border="true" lightbox="../media/4-models-delete-response.png":::
    
    [!INCLUDE [Reminder for how to get a new data plane bearer token](../../includes/azure-digital-twins-data-plane-token.md)]

1. Signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line. Paste the following DELETE request on the next line, to delete the *Generator Substation* model.

    ```http
    DELETE https://{{hostName}}/models/dtmi:example:grid:transmission:generatorSubStation;1?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    ```

1. Select **Send request** above the request to send it, and verify the response is a 204.

1. Signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line. Paste the following DELETE request on the next line, to delete the *Base Receiver* model.

    ```http
    DELETE https://{{hostName}}/models/dtmi:example:grid:transmission:baseReceiver;1?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    ```

1. Select **Send request** above the request to send it, and verify the response is a 204.

After these steps, all substation-type models are deleted from your instance.

### Upload new models

Now you can reupload the new *Base Receiver* model, and then reupload the two substation models that reference it. 

Follow these steps to add the models using the [DigitalTwinModels Add](/rest/api/digital-twins/dataplane/models/digital-twin-models-add) API.

1. In *data.http*, signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

1. Paste the following POST request on the next line. This is the [DigitalTwinModels Add](/rest/api/digital-twins/dataplane/models/digital-twin-models-add) request copied from the reference documentation, with parameters filled in for the host name and data plane version. It also has the authorization header specifying use of your bearer token, and a header specifying the `Content-Type` of the body. The body of the request contains the code for the new *Base Receiver* model definition.

    ```http
    POST https://{{hostName}}/models?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    Content-Type: application/json
    
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

1. Select **Send request** above the request to send it.

    The response from a successful request looks something like this:
    
    :::image type="content" source="../media/4-models-add-response.png" alt-text="Visual Studio screenshot showing the results of the Digital Twin Models Add request." border="true" lightbox="../media/4-models-add-response.png":::
    
    It's the body of the new *Base Receiver* model. This response indicates that the new model was uploaded to the instance, and replaced the old definition that was deleted.

1. Signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line. Paste the following POST request on the next line, to add back the *Delivery Substation* model. The model code is unchanged from its original form, copied here from the [DeliverySubStation.json source file](https://github.com/Azure-Samples/azure-digital-twins-getting-started/blob/main/models/energy-grid-example/DeliverySubStation.json) in GitHub.

    ```http
    POST https://{{hostName}}/models?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    Content-Type: application/json
    
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

1. Select **Send request** above the request to send it, and verify the response is a 201.

1. Signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line. Paste the following POST request on the next line, to add back the *Generator Substation* model. The model code is unchanged from its original form, copied here from the [GeneratorSubStation.json source file](https://github.com/Azure-Samples/azure-digital-twins-getting-started/blob/main/models/energy-grid-example/GeneratorSubStation.json) in GitHub.

    ```http
    POST https://{{hostName}}/models?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    Content-Type: application/json
    
    POST https://{{hostName}}/models?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    Content-Type: application/json
    
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

1. Select **Send request** above the request to send it, and verify the response is a 201.

Now all of the substation models are reuploaded to the instance (including the updated *Base receiver* model, and two unchanged inherited models for *Delivery Substation* and *Generator Substation*). The inherited models, and any digital twins referencing the *Base Receiver* model or any of its inherited models, now reference the updated definition and are capable of supporting an `Operator` property.

### Verify updates

You can verify the new model property by getting the *Base Receiver* model by its ID, using the [DigitalTwinModels GetById](/rest/api/digital-twins/dataplane/models/digital-twin-models-get-by-id) API.

1. In *data.http*, signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

1. Paste the following GET request on the next line. This is the [DigitalTwinModels GetById](/rest/api/digital-twins/dataplane/models/digital-twin-models-get-by-id) request copied from the reference documentation, with parameters filled in for the host name, data plane version, the DTMI ID of the *Base Receiver* model, and the specification that the full model definition should be included in the response. It also has the authorization header specifying use of your bearer token.

    ```http
    GET https://{{hostName}}/models/dtmi:example:grid:transmission:baseReceiver;1?includeModelDefinition=true&api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    ```

1. Select **Send request** above the request to send it.

    Scrolling through the response should reveal the new `Operator` property as part of the *Base Receiver* model definition.
    
    :::image type="content" source="../media/4-models-get-response.png" alt-text="Visual Studio screenshot showing the results of the Digital Twin Models Get By ID request." border="true" lightbox="../media/4-models-get-response.png":::

## Update twin properties

Since your work in the previous section made a new `Operator` property available in the substation model definitions, you can add this property to any digital twins that use the substation models. In this section, you add the property to a delivery substation twin called *sub_corp*.

>[!TIP]
>To get a list of all twins that use a certain model, use the Query APIs covered in [Unit 5](../5-query-graph.yml) of this module.

### View Twins API documentation (twins)

Start by reviewing the [Twins API documentation](/rest/api/digital-twins/dataplane/twins). The API contains operations to add/delete, get, and update digital twins, their components, and their relationships. In this section, you focus on operations dealing with twins themselves.

:::image type="content" source="../media/4-twins.png" alt-text="Reference doc screenshot showing the Twins operations and highlighting the twin-focused ones." border="true" lightbox="../media/4-twins.png":::

### Make the request

Follow these steps to update the *sub_corp* twin using the [DigitalTwins Update](/rest/api/digital-twins/dataplane/twins/digital-twins-update) API.

1. In *data.http*, signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

1. Paste the following PATCH request on the next line. This is the [DigitalTwins Update](/rest/api/digital-twins/dataplane/twins/digital-twins-update) request copied from the reference documentation, with parameters filled in for the host name, data plane version, and ID of the *sub_corp* twin. It also has the authorization header specifying use of your bearer token, and a header specifying the `Content-Type` of the body. The body of the request contains JSON Patch code that adds an `Operator` property to the twin, and sets its value to *Contoso Electric*.

    ```http
    PATCH https://{{hostName}}/digitaltwins/sub_corp?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    Content-Type: application/json
    
    [
        {
        "op": "add", 
        "path": "/Operator", 
        "value": "Contoso Electric"
        }
    ]
    ```

1. Select **Send request** above the request to send it. A 204 response with no error message indicates the update request was successful.

    :::image type="content" source="../media/4-twins-update-response.png" alt-text="Visual Studio screenshot showing the results of the Digital Twins Update request." border="true" lightbox="../media/4-twins-update-response.png":::

### Verify updates

You can verify the new twin property by getting the *sub_corp* twin by its ID.

Follow these steps to get the twin using the [DigitalTwins GetById](/rest/api/digital-twins/dataplane/twins/digital-twins-get-by-id) API.

1. In *data.http*, signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

1. Paste the following GET request on the next line. This is the [DigitalTwins GetById](/rest/api/digital-twins/dataplane/twins/digital-twins-get-by-id) request copied from the reference documentation, with parameters filled in for the host name, data plane version, and ID of the *sub_corp* twin. It also has the authorization header specifying use of your bearer token.

    ```http
    GET https://{{hostName}}/digitaltwins/sub_corp?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    ```

1. Select **Send request** above the request to send it.

    Look for the `Operator` field and its value in the response.
    
    :::image type="content" source="../media/4-twins-get-response.png" alt-text="Visual Studio screenshot showing the results of the Digital Twins Get By ID request." border="true" lightbox="../media/4-twins-get-response.png":::

This response confirms that the twin is updated with the new property. In the sample scenario, you might repeat the process with the other substation twins to include this detail throughout your environment.

## Update relationships

Let's say one of the delivery substations represented in your graph is no longer going to supply power to one of its farm consumers. Currently, the delivery substation twin *sub_farmcluster_2* has a *feeds* relationship to farm consumer *c_farm_05*. Since the substation's going to stop feeding that farm cluster, you need to update the graph to remove the relationship between these two twins.

### View Twins API documentation (relationships)

Start by reviewing the [Twins API documentation](/rest/api/digital-twins/dataplane/twins) again, this time looking at the operations that deal with relationships.

:::image type="content" source="../media/4-relationships.png" alt-text="Reference doc screenshot showing the Twins operations and highlighting the relationship ones." border="true" lightbox="../media/4-relationships.png":::

### Make the request

Follow these steps to delete the *feeds* relationship from *sub_farmcluster_2* to farm consumer *c_farm_05*, using the [DigitalTwins DeleteRelationship](rest/api/digital-twins/dataplane/twins/digital-twins-delete-relationship) API.

1. In *data.http*, signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

1. Paste the following DELETE request on the next line. This is the [DigitalTwins DeleteRelationship](rest/api/digital-twins/dataplane/twins/digital-twins-delete-relationship) request copied from the reference documentation, with parameters filled in for the host name, data plane version, ID of the *sub_farmcluster_2* twin, and relationship ID (the value plugged in below was the ID value given for this relationship when the graph was imported, and together with the source twin ID it identifies this specific relationship in the graph). It also has the authorization header specifying use of your bearer token.

    ```http
    DELETE https://{{hostName}}/digitaltwins/sub_farmcluster_2/relationships/57becd45-1391-45e8-b127-ff3fdc5d0175?api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    ```
1. Select **Send request** above the request to send it. A 204 response with no error message indicates the delete request was successful.

    :::image type="content" source="../media/4-twins-delete-relationship-response.png" alt-text="Visual Studio screenshot showing the results of the Digital Twins Delete Relationship request." border="true" lightbox="../media/4-twins-delete-relationship-response.png":::

### Verify deletion

You can verify the relationship was deleted by listing the relationships from the *sub_farmcluster_2* twin and confirming that the *feeds* relationship to farm consumer *c_farm_05* isn't in the list.

Follow these steps to list the relationships using the [DigitalTwins ListRelationships](rest/api/digital-twins/dataplane/twins/digital-twins-list-relationships) API.

1. In *data.http*, signify the start of a new request by adding a new blank line, followed by a line with `###`, followed by another blank line.

1. Paste the following GET request on the next line. This is the [DigitalTwins ListRelationships](rest/api/digital-twins/dataplane/twins/digital-twins-list-relationships) request copied from the reference documentation, with parameters filled in for the host name, data plane version, ID of the *sub_farmcluster_2* twin, and the relationship name *feeds*. It also has the authorization header specifying use of your bearer token.

    ```http
    GET https://{{hostName}}/digitaltwins/sub_farmcluster_2/relationships?relationshipName=feeds&api-version={{DPversion}}
    Authorization: Bearer {{DPtoken}}
    ```
1. Select **Send request** above the request to send it. The response should show two relationships to *c_farm_04* and *c_farm_06*, but no relationship to *c_farm_05*. That indicates the delete operation was successful.

    :::image type="content" source="../media/4-twins-list-relationships-response.png" alt-text="Visual Studio screenshot showing the results of the Digital Twins List Relationships." border="true" lightbox="../media/4-twins-list-relationships-response.png":::