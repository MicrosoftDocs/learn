Triggers are the core way that Azure Cosmos DB for NoSQL can inject business logic both before and after operations. Triggers are resources stored within a container, and their code is written in JavaScript, much like stored procedures and user-defined functions.

Triggers are defined as JavaScript functions. The function is then executed when the trigger is invoked.

```javascript
function name() {
}
```

Within the function, the ``getContext()`` method retrieves a context object, which can be used to perform multiple actions, including:

- Access the HTTP request object (the source of a pre-trigger)

- Access the HTTP response object (the source of a post-trigger)

- Access the corresponding Azure Cosmos DB for NoSQL container

Using the context object, you can invoke the ``getRequest()`` or ``getResponse()`` methods to access the HTTP request and response objects. You can also invoke the `getCollection()` method to access the container using the JavaScript query API.

### Pre-trigger

Pre-triggers are run before an operation and cannot have any input parameters. They can perform actions such as validate the properties of an item, or inject missing properties.

Let's walk through a simple example where a JSON item is ready to be created in a container.

```json
{
  "id": "caab0e5e-c037-48a4-a760-140497d19452",
  "name": "Handlebar",
  "categoryId": "e89a34d2-47ee-4da8-bcf6-10f552604b79",
  "categoryName": "Accessories",
  "price": 50
}
```

In this example, a pre-trigger will be created that runs before an HTTP POST operation. This trigger will check for the existence of a **label** property. If it does not exist, it will add the label property with a value of **new**. The JavaScript code for this function uses the ``getContext()`` and ``getRequest()`` methods to get the current HTTP request, and then the request body.

```javascript
function addLabel() {
    var context = getContext();
    var request = context.getRequest();
    
    var pendingItem = request.getBody();
}
```

Finally, the function will check for the existence of the **label** property, add it if it does not exist, and then return the modified item as the updated request body.

```javascript
if (!('label' in pendingItem))
    pendingItem['label'] = 'new';

request.setBody(pendingItem);
```

The final pre-trigger function contains the following code:

```javascript
function addLabel() {
    var context = getContext();
    var request = context.getRequest();
    
    var pendingItem = request.getBody();

    if (!('label' in pendingItem))
        pendingItem['label'] = 'new';

    request.setBody(pendingItem);
}
```

If you invoke the create operation using this pre-trigger, you should expect your resulting JSON to include the **label** property thanks to the logic in the trigger.

```json
{
  "id": "caab0e5e-c037-48a4-a760-140497d19452",
  "name": "Handlebar",
  "categoryId": "e89a34d2-47ee-4da8-bcf6-10f552604b79",
  "categoryName": "Accessories",
  "price": 50,
  "label": "new"
}
```

### Post-trigger

Post-triggers run after an operation has completed and can have input parameters even though they are not required. They perform actions on the HTTP response message right before it is sent to the client. They can perform actions such as updating or creating secondary items based on changes to your original item.

Let's walk through a slightly different example with the same JSON file. Now, a post-trigger will be used to create a second item with a different materialized view of our data. Our goal is to create a second item with three JSON properties; **sourceId**, **categoryId**, and **displayName**.

```json
{
  "sourceId": "caab0e5e-c037-48a4-a760-140497d19452",
  "categoryId": "e89a34d2-47ee-4da8-bcf6-10f552604b79",
  "displayName": "Handlebar [Accessories]",
}
```

> [!NOTE]
> We are including the **categoryId** property because all items created within a post-trigger must have the same logical partition key as the original item that was the source of the trigger.

We can start our function by getting both the container and HTTP response using the **getCollection()** and **getResponse()** methods. We will also get the newly created item using the **getBody()** method of the HTTP response object.

```javascript
function createView() {
    var context = getContext();
    var container = context.getCollection();
    var response = context.getResponse();
    
    var createdItem = response.getBody();
}
```

Using the various properties of our newly created item, we can construct a new JavaScript object.

```javascript
var viewItem = {
    sourceId: createdItem.id,
    categoryId: createdItem.categoryId,
    displayName: `${createdItem.name} [${createdItem.categoryName}]`
};
```

And then we can use the **createDocument** method to create a new item from our view, and then throw or return if there are any errors or timeouts.

```javascript
var accepted = container.createDocument(
    container.getSelfLink(),
    viewItem,
    (error, newItem) => {
        if (error) throw error;
    }
);
if (!accepted) return;
```

The final post-trigger function contains the following code:

```javascript
function createView() {
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
}
```
