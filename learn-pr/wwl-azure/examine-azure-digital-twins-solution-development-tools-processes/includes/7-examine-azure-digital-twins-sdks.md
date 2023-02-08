Microsoft has developed Azure Digital Twins SDKs to cover the APIs as follows:

 -  Control plane APIs: Resource Management SDKs that can be used to implement the Azure Digital Twins service.
 -  Data plane APIs: Client SDKs that can be used to implement digital twins, models, queries, and event routes.

The supported programming languages are:

 -  Control plane APIs:
     -  .NET (C\#)
     -  Java
     -  JavaScript
     -  Python
     -  Go
 -  Data plane APIs
     -  .NET (C\#)
     -  Java
     -  JavaScript
     -  Python

The GitHub projects and Namespace documentation for the SDKs are organized by programming language. For example, the information the .NET (C\#) SDKs can be found in the following locations:

 -  Namespace docs: [Digital Twins](/dotnet/api/overview/azure/digitaltwins)
 -  GitHub: [https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/digitaltwins](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/digitaltwins)

The GitHub project for .NET includes the sample projects that demonstrate the following:

 -  Instantiate the client.
 -  Create, get, and remove models.
 -  Create, query, and delete a digital twin.
 -  Get and update components for a digital twin.
 -  Create, get, and delete relationships between digital twins.
 -  Create, get, and delete event routes for digital twin.
 -  Publish telemetry messages to a digital twin and digital twin component.

## Serialization helpers

Serialization helpers are helper functions available within the SDK for quickly creating or deserializing twin data for access to basic information. Since the core SDK methods return twin data as JSON by default, it can be helpful to use these helper classes to further break down the twin data.

The available helper classes are:

 -  BasicDigitalTwin: Generically represents the core data of a digital twin.
 -  BasicDigitalTwinComponent: Generically represents a component in the Contents properties of a BasicDigitalTwin.
 -  BasicRelationship: Generically represents the core data of a relationship.
 -  DigitalTwinsJsonPropertyName: Contains the string constants for use in JSON serialization and deserialization for custom digital twin types.

## Code examples for the .NET (C\#) SDK (data plane)

When developing code that uses the SDK, you will need to include the latest version of the following NuGet packages within your project:

 -  Azure.DigitalTwins.Core. This package is the package for the Azure Digital Twins SDK for .NET.
 -  Azure.Identity. This library provides tools to help with authentication against Azure.

The following code samples illustrate use of the .NET SDK.

### Authenticate against the service:

```csharp
// Authenticate against the service and create a client
string adtInstanceUrl = "https://<your-Azure-Digital-Twins-instance-hostName>";
var credential = new DefaultAzureCredential();
DigitalTwinsClient client = new DigitalTwinsClient(new Uri(adtInstanceUrl), credential);

```

### Upload a model:

```csharp
// 'client' is an instance of DigitalTwinsClient
// Read model file into string (not part of SDK)
string dtdl = new File.ReadAllText("MyModelFile.json");
await client.CreateModelsAsync(new[] { dtdl });

```

### List models:

```csharp
// 'client' is a valid DigitalTwinsClient object

// Get a single model, metadata and data
Response<DigitalTwinsModelData> md1 = await client.GetModelAsync(id);
DigitalTwinsModelData model1 = md1.Value;

// Get a list of the metadata of all available models; print their display names and IDs
AsyncPageable<DigitalTwinsModelData> md2 = client.GetModelsAsync();
await foreach (DigitalTwinsModelData md in md2)
{
    Console.WriteLine($"Type name: {md.DisplayName}: {md.Id}");
}

// Get models and metadata for a model ID, including all dependencies (models that it inherits from, components it references)
AssyncPageable<DigitalTwinsModelData> md3 = client.GetModelsAsync(new GetModelsOptions { IncludeModelDefinition = true });

```

### Create twins:

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

### Query twins and loop through results:

```csharp
AsyncPageable<string> result = client.QueryAsync("Select * From DigitalTwins");
try
{
    await foreach(BasicDigitalTwin twin in result)
    {
        // You can include your own logic to print the result
        // The logic below prints the twin's ID and contents
        Console.WriteLine($"Twin ID: {twin.Id} \nTwin data");
        foreach (KeyValuePair<string, object> kvp in twin.Contents)
        {
            Console.WriteLine($"{kvp.Key}  {kvp.Value}");
        }
    }
}
catch (RequestFailedException ex)
{
    Console.WriteLine($"Error {ex.Status}, {ex.ErrorCode}, {ex.Message}");
    throw;
}

```

### Deserialize a digital twin

You can always deserialize twin data using the JSON library of your choice, like System.Text.Json or Newtonsoft.Json. For basic access to a twin, the helper classes can make this more convenient.

The BasicDigitalTwin helper class also gives you access to properties defined on the twin, through a Dictionary&lt;string, object&gt;. To list properties of the twin, you can use:

```csharp
BasicDigitalTwin twin;
Response<BasicDigitalTwin> twinResponse = await client.GetDigitalTwinAsync<BasicDigitalTwin>(twinId);
twin = twinResponse.Value;
Console.WriteLine($"Model id: {twin.Metadata.ModelId}");
foreach (string prop in twin.Contents.Keys)
{
    if (twin.Contents.TryGetValue(prop, out object value))
        Console.WriteLine($"Property '{prop}': {value}");
}

```

> [!NOTE]
> BasicDigitalTwin uses `System.Text.Json` attributes. In order to use BasicDigitalTwin with your DigitalTwinsClient, you must either initialize the client with the default constructor, or, if you want to customize the serializer option, use the JsonObjectSerializer.