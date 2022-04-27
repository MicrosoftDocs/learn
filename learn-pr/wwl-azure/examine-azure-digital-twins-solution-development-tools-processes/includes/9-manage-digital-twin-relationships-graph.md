The twin graph is made of individual digital twins connected via relationships.

Managing your twin graph may include creating, modifying, and deleting the relationships that connect the digital twins in an Azure Digital Twins instance. To complete these operations, you can use the Digital Twins APIs, the .NET (C\#) SDK, and the Azure Digital Twins CLI. Microsoft also provides sample and custom apps that can be used to complete these tasks.

We focus on a programmatic approach using the Azure Digital Twins SDKs.

## Create relationships

Relationships describe how different digital twins are connected to each other, which forms the basis of the twin graph. Relationships are created using the `CreateOrReplaceRelationshipAsync()` call.

To create a relationship, you need to specify:

 -  The source twin ID (srcId in the code sample below): The ID of the twin where the relationship originates.
 -  The target twin ID (targetId in the code sample below): The ID of the twin where the relationship arrives.
 -  A relationship name (relName in the code sample below): The generic type of relationship, something like contains.
 -  A relationship ID (relId in the code sample below): The specific name for this relationship, something like Relationship1.

The relationship ID must be unique within the given source twin. It doesn't need to be globally unique. For example, for the twin foo, each specific relationship ID must be unique. However, another twin bar can have an outgoing relationship that matches the same ID of a foo relationship.

The following code sample illustrates how to create a relationship in your Azure Digital Twins instance.

```csharp
private async static Task CustomMethod_CreateRelationshipAsync(DigitalTwinsClient client, string srcId, string targetId, string relName, IDictionary<string,object> inputProperties)
{
    var relationship = new BasicRelationship
    {
        TargetId = targetId,
        Name = relName,
        Properties = inputProperties
    };

    try
    {
        string relId = $"{srcId}-{relName}->{targetId}";


        await client.CreateOrReplaceRelationshipAsync<BasicRelationship>(srcId, relId, relationship);


        Console.WriteLine($"Created {relName} relationship successfully. Relationship ID is {relId}.");
    }
    catch (RequestFailedException rex)
    {
        Console.WriteLine($"Create relationship error: {rex.Status}:{rex.Message}");
    }

}

```

This custom function can now be called to create a contains relationship like this:

```csharp
await CustomMethod_CreateRelationshipAsync(client, srcId, targetId, "contains", properties);

```

There is no restriction on the number of relationships that you can have between two twins—you can have as many relationships between twins as you like. You can also express several different types of relationships between two twins at once. For example, Twin A can have both a stored relationship and manufactured relationship with Twin B.

You can even create multiple instances of the same type of relationship between the same two twins, if desired. In this example, Twin A could have two different stored relationships with Twin B, as long as the relationships have different relationship IDs.

## List relationships

Relationships can be classified as either:

 -  Outgoing relationships: Relationships belonging to this twin that point outward to connect it to other twins. The `GetRelationshipsAsync()` method is used to get outgoing relationships of a twin.
 -  Incoming relationships: Relationships belonging to other twins that point towards this twin to create an "incoming" link. The `GetIncomingRelationshipsAsync()` method is used to get incoming relationships of a twin.

To access the list of outgoing relationships for a given twin in the graph, you can use the `GetRelationships()` method like this:

```csharp
AsyncPageable<BasicRelationship> rels = client.GetRelationshipsAsync<BasicRelationship>(dtId);

```

This method returns an `Azure.Pageable<T>` or `Azure.AsyncPageable<T>`, depending on whether you use the synchronous or asynchronous version of the call.

Here is an example that retrieves a list of relationships.

```csharp
private static async Task<List<BasicRelationship>> CustomMethod_FindOutgoingRelationshipsAsync(DigitalTwinsClient client, string dtId)
{
    // Find the relationships for the twin
   
    try
    {
        // GetRelationshipsAsync will throw if an error occurs


        AsyncPageable<BasicRelationship> rels = client.GetRelationshipsAsync<BasicRelationship>(dtId);


        var results = new List<BasicRelationship>();
        await foreach (BasicRelationship rel in rels)
        {
            results.Add(rel);
            Console.WriteLine($"Found relationship: {rel.Id}");

            //Print its properties
            Console.WriteLine($"Relationship properties:");
            foreach(KeyValuePair<string, object> property in rel.Properties)
            {
                Console.WriteLine("{0} = {1}", property.Key, property.Value);
            }
        }

        return results;
    }
    catch (RequestFailedException ex)
    {
        Console.WriteLine($"*** Error {ex.Status}/{ex.ErrorCode} retrieving relationships for {dtId} due to {ex.Message}");
        return null;
    }
}

```

You can now call this custom method to see the outgoing relationships of the twins like this:

```csharp
await CustomMethod_FindOutgoingRelationshipsAsync(client, twin_Id);

```

Azure Digital Twins also has an API to find all incoming relationships to a given twin. This is often useful for reverse navigation, or when deleting a twin.

```csharp
private static async Task<List<IncomingRelationship>> CustomMethod_FindIncomingRelationshipsAsync(DigitalTwinsClient client, string dtId)
{
    // Find the relationships for the twin
   
    try
    {

        // GetRelationshipsAsync will throw an error if a problem occurs
        AsyncPageable<IncomingRelationship> incomingRels = client.GetIncomingRelationshipsAsync(dtId);


        var results = new List<IncomingRelationship>();
        await foreach (IncomingRelationship incomingRel in incomingRels)
        {
            results.Add(incomingRel);
            Console.WriteLine($"Found incoming relationship: {incomingRel.RelationshipId}");

            //Print its properties
            Response<BasicRelationship> relResponse = await client.GetRelationshipAsync<BasicRelationship>(incomingRel.SourceId, incomingRel.RelationshipId);
            BasicRelationship rel = relResponse.Value;
            Console.WriteLine($"Relationship properties:");
            foreach(KeyValuePair<string, object> property in rel.Properties)
            {
                Console.WriteLine("{0} = {1}", property.Key, property.Value);
            }
        }
        return results;
    }
    catch (RequestFailedException ex)
    {
        Console.WriteLine($"*** Error {ex.Status}/{ex.ErrorCode} retrieving incoming relationships for {dtId} due to {ex.Message}");
        return null;
    }
}

```

You can now call this custom method to see the incoming relationships of the twins like this:

```csharp
await CustomMethod_FindIncomingRelationshipsAsync(client, twin_Id);

```

## Update relationships

Relationships are updated using the UpdateRelationship method.

> [!NOTE]
> This method is for updating the properties of a relationship. If you need to change the source twin or target twin of the relationship, you'll need to delete the relationship and re-create one using the new twins.

The required parameters for the client call are the ID of the source twin (the twin where the relationship originates), the ID of the relationship to update, and a JSON Patch document containing the properties and new values you'd like to update.

Here is sample code showing how to use this method.

```csharp
private async static Task CustomMethod_UpdateRelationshipAsync(DigitalTwinsClient client, string srcId, string relId, Azure.JsonPatchDocument updateDocument)
{

    try
    {

        await client.UpdateRelationshipAsync(srcId, relId, updateDocument);

        Console.WriteLine($"Successfully updated {relId}");
    }
    catch (RequestFailedException rex)
    {
        Console.WriteLine($"Update relationship error: {rex.Status}:{rex.Message}");
    }

}

```

## Delete relationships

To delete a relationship, you can use DeleteRelationshipAsync() method.

The first parameter specifies the source twin (the twin where the relationship originates). The other parameter is the relationship ID. You need both the twin ID and the relationship ID, because relationship IDs are only unique within the scope of a twin.

Here is sample code showing how to use this method.

```csharp
private static async Task CustomMethod_DeleteRelationshipAsync(DigitalTwinsClient client, string srcId, string relId)
{
    try
    {
        Response response = await client.DeleteRelationshipAsync(srcId, relId);
        await CustomMethod_FetchAndPrintTwinAsync(srcId, client);
        Console.WriteLine("Deleted relationship successfully");
    }
    catch (RequestFailedException e)
    {
        Console.WriteLine($"Error {e.ErrorCode}");
    }
}

```
