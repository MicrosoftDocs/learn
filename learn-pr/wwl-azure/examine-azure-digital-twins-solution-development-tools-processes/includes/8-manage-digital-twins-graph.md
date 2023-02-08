Managing your twin graph may include creating, modifying, and deleting digital twins in an Azure Digital Twins instance. You can also manage the underlying models. To complete these operations, you can use the Digital Twins APIs and SDKs, the Azure Digital Twins CLI command set, or a GUI tool such as the Azure Digital Twins explorer.

## Using the .NET (C\#) SDK

The Azure Digital Twins .NET (C\#) SDK is part of the Azure SDK for .NET. It is open source, and is based on the Azure Digital Twins data plane APIs.

The following sections describe how to perform some common management tasks using the .NET (C\#) SDK.

### Create a digital twin

To create a twin, you use the `CreateOrReplaceDigitalTwinAsync()` method on the service client like this:

```csharp
await client.CreateOrReplaceDigitalTwinAsync<BasicDigitalTwin>(twinId, initData);

```

To create a digital twin, you need to provide:

 -  The desired ID for the digital twin.
 -  The model you want to use.

Optionally, you can provide initial values for all properties of the digital twin. Properties are treated as optional and can be set later, but they will not show up as part of a twin until they have been set.

> [!NOTE]
> While twin properties do not have to be initialized, any components on the twin do need to be set when the twin is created. They can be empty objects, but the components themselves must exist.

The model and any initial property values are provided through the initData parameter, which is a JSON string containing the relevant data.

### Initialize twin properties

You can initialize the properties of a twin at the time that the twin is created.

The helper class of `BasicDigitalTwin` allows you to store property fields in a "twin" object directly. You can build the list of properties using a `Dictionary<string, object>`, which can then be added to the twin object as its CustomProperties directly.

```csharp
string twinId = "myTwinID";
var initData = new BasicDigitalTwin
{
    Id = twinId,
    Metadata = { ModelId = "dtmi:example:Room;1" },
    // Initialize properties
    Contents =
    {
        { "Temperature", 25.0 },
        { "Humidity", 50.0 },
    },
};

await client.CreateOrReplaceDigitalTwinAsync<BasicDigitalTwin>(twinId, initData);

```

> [!NOTE]
> As shown in the preceding code, BasicDigitalTwin objects come with their own \`Id\` field. You can leave this field empty, but if you do provide an ID value, it needs to match the value of the ID parameter passed to the \`CreateOrReplaceDigitalTwinAsync()\` call, which also includes an ID parameter.

### Get data for a digital twin

You can access the details of any digital twin by calling the `GetDigitalTwin()` method like this:

```csharp
Response<BasicDigitalTwin> twinResponse = await client.GetDigitalTwinAsync<BasicDigitalTwin>(twinId);
twin = twinResponse.Value;

```

This call returns twin data as a strongly-typed object type such as BasicDigitalTwin.

### Update a digital twin

To update properties of a digital twin, you write the information you want to replace in JSON Patch format. In this way, you can replace multiple properties at once. You then pass the JSON Patch document into an `UpdateDigitalTwin()` method:

> [!NOTE]
> If you are not familiar with JSON Patch, you can read more here: [JsonPatch in ASP.NET Core web API](/aspnet/core/web-api/jsonpatch)

```csharp
await client.UpdateDigitalTwinAsync(twinId, updateTwinData);

```

A patch call can update as many properties on a single twin as you would like (even all of them). If you need to update properties across multiple twins, you will need a separate update call for each twin.

> [!TIP]
> After creating or updating a twin, there may be a latency of up to 10 seconds before the changes will be reflected in queries. The GetDigitalTwin API (described earlier in this article) does not experience this delay, so use the API call instead of querying to see your newly updated twins if you need an instant response.

Here is an example of JSON Patch code. This document replaces the mass and radius property values of the digital twin it is applied to.

```JSON
[
    {
      "op": "replace",
      "path": "/mass",
      "value": 0.0799
    },
    {
      "op": "replace",
      "path": "/radius",
      "value": 0.800
    }
  ]

```

You can create patches using the Azure .NET SDK's `JsonPatchDocument`. Here is an example.

```csharp
var updateTwinData = new JsonPatchDocument();
updateTwinData.AppendAdd("/Temperature", 25.0);
updateTwinData.AppendAdd("/myComponent/Property", "Hello");
// Un-set a property
updateTwinData.AppendRemove("/Humidity");

await client.UpdateDigitalTwinAsync("myTwin", updateTwinData);

```

### Update a digital twin's model

The `UpdateDigitalTwin()` function can also be used to migrate a digital twin to a different model.

For example, consider the following JSON Patch document that replaces the digital twin's metadata `$model` field:

```json
[
  {
    "op": "replace",
    "path": "/$metadata/$model",
    "value": "dtmi:example:foo;1"
  }
]

```

This operation will only succeed if the digital twin being modified by the patch conforms with the new model. Consider the following example:

 -  Imagine a digital twin with a model of foo\_old. foo\_old defines a required property mass.
 -  The new model foo\_new defines a property mass, and adds a new required property temperature.
 -  After the patch, the digital twin must have both a mass and temperature property.

The patch for this situation needs to update both the model and the twin's temperature property, like this:

```json
[
  {
    "op": "replace",
    "path": "/$metadata/$model",
    "value": "dtmi:example:foo_new;1"
  },
  {
    "op": "add",
    "path": "/temperature",
    "value": 60
  }
]

```

### Delete a digital twin

You can delete twins using the `DeleteDigitalTwin()` method. However, you can only delete a twin when it has no more relationships. So, delete the twin's incoming and outgoing relationships first.

Here is an example of the code to delete twins and their relationships. The DeleteDigitalTwin SDK call is highlighted to clarify where it falls in the wider example context.

```csharp
private static async Task CustomMethod_DeleteTwinAsync(DigitalTwinsClient client, string twinId)
{
    await CustomMethod_FindAndDeleteOutgoingRelationshipsAsync(client, twinId);
    await CustomMethod_FindAndDeleteIncomingRelationshipsAsync(client, twinId);
    try
    {
        await client.DeleteDigitalTwinAsync(twinId);
        Console.WriteLine("Twin deleted successfully");
    }
    catch (RequestFailedException ex)
    {
        Console.WriteLine($"*** Error:{ex.Message}");
    }
}

private static async Task CustomMethod_FindAndDeleteOutgoingRelationshipsAsync(DigitalTwinsClient client, string dtId)
{
    // Find the relationships for the twin

    try
    {
        // GetRelationshipsAsync will throw an error if a problem occurs
        AsyncPageable<BasicRelationship> rels = client.GetRelationshipsAsync<BasicRelationship>(dtId);

        await foreach (BasicRelationship rel in rels)
        {
            await client.DeleteRelationshipAsync(dtId, rel.Id).ConfigureAwait(false);
            Console.WriteLine($"Deleted relationship {rel.Id} from {dtId}");
        }
    }
    catch (RequestFailedException ex)
    {
        Console.WriteLine($"*** Error {ex.Status}/{ex.ErrorCode} retrieving or deleting relationships for {dtId} due to {ex.Message}");
    }
}

private static async Task CustomMethod_FindAndDeleteIncomingRelationshipsAsync(DigitalTwinsClient client, string dtId)
{
    // Find the relationships for the twin

    try
    {
        // GetRelationshipsAsync will throw an error if a problem occurs
        AsyncPageable<IncomingRelationship> incomingRels = client.GetIncomingRelationshipsAsync(dtId);

        await foreach (IncomingRelationship incomingRel in incomingRels)
        {
            await client.DeleteRelationshipAsync(incomingRel.SourceId, incomingRel.RelationshipId).ConfigureAwait(false);
            Console.WriteLine($"Deleted incoming relationship {incomingRel.RelationshipId} from {dtId}");
        }
    }
    catch (RequestFailedException ex)
    {
        Console.WriteLine($"*** Error {ex.Status}/{ex.ErrorCode} retrieving or deleting incoming relationships for {dtId} due to {ex.Message}");
    }
}

```

## Using the Azure Digital Twins Explorer

The Azure Digital Twins Explorer is a developer tool for visualizing and interacting with the data in your Azure Digital Twins instance, including your models and twin graph.

The main way to access Azure Digital Twins Explorer is through the Azure portal. With your Azure Digital Twins instance open in the portal, you can open a connected Azure Digital Twins Explorer window by selecting the Open Azure Digital Twins Explorer (preview) button.

The following sections describe some common tasks that can be completed using the Azure Digital Twins Explorer.

### Query your digital twin graph

You can use the Query Explorer panel at the top of the explorer to perform queries on your graph. Enter the query you want to run and select the Run Query button. This action will load the query results in the Twin Graph panel.

### Create twins

You can create a new digital twin from its model definition in the Models panel on the left side of the explorer window.

To create a twin from a model, find that model in the list and choose the Create a Twin icon next to the model name. You will be asked to enter a name for the new twin, which must be unique. Then save the twin, which will add it to your graph.

### Create relationships

To create a relationship between two twins, start by selecting the source twin for the relationship in the Twin Graph area in the middle of the explorer window. Next, hold down a CTRL/CMD or SHIFT key while you select a second twin to be the target of the relationship.

Once the two twins are simultaneously selected, right-click either one of the twins. This will bring up a menu with an option to Add relationships between them. Clicking Add Relationship This will bring up the Create Relationship dialog, which shows the source twin and target twin of the relationship, followed by a Relationship dropdown menu that contains the types of relationship that the source twin can have (defined in its DTDL model). Select an option for the relationship type, and Save the new relationship.

### Edit twins and relationships

To view the property values of a twin or a relationship, select the element in the Twin Graph and use the Toggle property inspector button to expand the Properties panel.

You can use this panel to directly edit writable properties. Update their values inline, and click the Patch twin (save) button at the top of the panel to save your changes. When the update is saved, the screen displays a modal window showing the JSON Patch operation that was applied by the update API.

### Delete twins and relationships

To delete a twin or a relationship, right-click it in the Twin Graph window. This action will open a menu with an option to delete the element.

You can delete multiple twins or multiple relationships at once, by using the CTRL/CMD or SHIFT keys to multi-select several elements of the same type in the graph. From here, follow the same right-click process to delete the elements.

You can also choose to delete all of the twins in your instance at the same time, using the Delete All Twins button in the top toolbar.

### Explore models and the Model Graph

Models can be viewed both in the Models panel on the left side of the Azure Digital Twins Explorer screen, and in the Model Graph panel in the middle of the screen.

### Import graph

You can use the import feature of the explorer to add twins, relationships, and models to your instance. This approach can be useful for creating larger numbers of twins, relationships, and/or models as a single operation.

#### Create an import file

The first step in importing a graph is creating a file representing the twins and relationships you want to add.

The import file can be in either of these two formats:

 -  The custom Excel-based format described in the remainder of this section. This format allows you to upload twins and relationships.
 -  The JSON-based format generated on graph export. This format can contain twins, relationships, and/or models.

#### Import the file to Azure Digital Twins Explorer

Once you have a file on your local machine that is ready to be imported, select the Import Graph icon in the Twin Graph panel.

In the file selector box that appears, navigate to the graph file (.xlsx or .json) that you want to upload and choose Open to upload it.

The Azure Digital Twins Explorer will open an Import panel showing a preview of the graph to be imported. To confirm, select the Save icon in the upper-right corner of the panel.

If the import is successful, a modal window will display the number of models, twins, and relationships that were uploaded.

### Export graph and models

You can use the export feature to export partial or complete graphs, including models, twins, and relationships. Export serializes the twins and relationships from the most recent query results, and all models in the instance, to a JSON-based format that you can download to your local machine.

To begin, use the Query Explorer panel to run a query that selects the twins and relationships that you want to download. The query results will be used to populate the Twin Graph panel.

Once the Twin Graph panel is showing the portion of the graph you want to download, select the Export Graph icon.

This action enables a Download link in the Twin Graph box. Select it to download a JSON-based representation of the query result, and all the models in your instance, to your machine.