The **Scripts** property in the **Microsoft.Azure.Cosmos.Container** class contains a **CreateTriggerAsync** method that is used to create a new pre/post trigger from code.

> [!NOTE]
> The next set of examples assume that you already have a container variable defined.

### Create a pre-trigger

Start by creating a string variable with the definition of your pre-trigger function in JavaScript.

```csharp
string preTrigger = @"function addLabel() {
    var context = getContext();
    var request = context.getRequest();
    
    var pendingItem = request.getBody();

    if (!('label' in pendingItem))
        pendingItem['label'] = 'new';

    request.setBody(pendingItem);
}";
```

> [!TIP]
> Alternatively, you can use file APIs such as **System.IO.File** to read a function from a *.js file.

Now, create an object of type **Microsoft.Azure.Cosmos.Scripts.TriggerProperties** with the **Id** and **Body** properties set to the unique identifier and content of the trigger, respectively. Set the **TriggerOperation** property to **TriggerOperation.Create** for this example, and then set the **TriggerType** property to **TriggerType.Pre**.

```csharp
TriggerProperties properties = new()
{
    Id = "addLabel",
    Body = preTrigger,
    TriggerOperation = TriggerOperation.Create,
    TriggerType = TriggerType.Pre
};
```

Invoke the **CreateTriggerAsync** method of the container variable to create a new pre-trigger passing in the properties composed earlier.

```csharp
await container.Scripts.CreateTriggerAsync(properties);
```

### Create a post-trigger

Creating a post-trigger is almost identical to creating a pre-trigger. Start by creating a string variable with the JavaScript definition of your post-trigger function.

```csharp
string postTrigger = @"function createView() {
    var context = getContext();
    var container = context.getCollection();
    var response = context.getResponse();
    
    var createdItem = response.getBody();
    
    var viewItem = {
        sourceId: createdItem.id,
        categoryId: createdItem.categoryId,
        displayName: `${createdItem.name} [${createdItem.categoryName}]`
    };
 
    var accepted = container.createDocument(
        container.getSelfLink(),
        viewItem,
        (error, newItem) => {
            if (error) throw error;
        }
    );
    if (!accepted) return;
}";
```

Now, create an object of type **Microsoft.Azure.Cosmos.Scripts.TriggerProperties** configured almost identically to the same configuration used with the pre-trigger with one key difference. Set the **TriggerType** property to **TriggerType.Post**. Then, invoke the **CreateTriggerAsync** method of the container variable to create a new post-trigger passing in the properties composed earlier.

```csharp
TriggerProperties properties = new()
{
    Id = "createView",
    Body = postTrigger,
    TriggerOperation = TriggerOperation.Create,
    TriggerType = TriggerType.Post
};

await container.Scripts.CreateTriggerAsync(properties);
```

> [!TIP]
> In these examples, we have exclusively created triggers on the **create** operation. You can also create triggers for other operations in your container.

### Use a trigger in an operation

Now that the triggers have been defined and created within the container, you can use them in an operation on the same container.

Let’s use an example where you create a new item in C# using an anonymous type.

```csharp
var newItem = new
{
    id = "caab0e5e-c037-48a4-a760-140497d19452",
    name = "Handlebar",
    categoryId = "e89a34d2-47ee-4da8-bcf6-10f552604b79",
    categoryName = "Accessories",
    price = 50
};
```

Prior to invoking the operation, create an object of type Microsoft.Azure.Cosmos.ItemRequestOptions. Within that options object, configure the PreTriggers and PostTriggers property lists to include the triggers you would like enabled for this operation.

```csharp
ItemRequestOptions options = new()
{
    PreTriggers = new List<string> { "addLabel" },
    PostTriggers = new List<string> { "createView" }
};
```

> [!NOTE]
> Remember, triggers are not automatically executed; they must be specified for each database operation where you want them to execute.

Now, invoke the **CreateItemAsync** method of the container object passing in the item to be created and the options object.

```csharp
await container.CreateItemAsync(newItem, requestOptions: options);
```

Finally, if you query your container, you will see that two things have happened:

1. The pre-trigger added a **label** property to your first item with a value of **new**.

1. The post-trigger created a second item with a materialized view of your data.

```json
[
  {
    "id": "caab0e5e-c037-48a4-a760-140497d19452",
    "name": "Handlebar",
    "categoryId": "e89a34d2-47ee-4da8-bcf6-10f552604b79",
    "categoryName": "Accessories",
    "price": 50,
    "label": "new"
  },
  {
    "id": "77875d1e-dac4-3b66-9f9c-ab6747d65952",
    "sourceId": "caab0e5e-c037-48a4-a760-140497d19452",
    "categoryId": "e89a34d2-47ee-4da8-bcf6-10f552604b79",
    "displayName": "Handlebar [Accessories]"
  }
]
```
