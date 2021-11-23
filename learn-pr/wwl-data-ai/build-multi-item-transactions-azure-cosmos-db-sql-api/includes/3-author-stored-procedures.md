Transactions are defined as JavaScript functions. The function is then executed when the stored procedure is invoked.

```javascript
function name() {
}
```

Within the function, the ``getContext()`` method retrieves a context object, which can be used to perform multiple actions, including:

- Access the HTTP response object

- Access the corresponding Azure Cosmos DB SQL API container

Using the context object, you can invoke the ``getResponse()`` method to access the HTTP response object to perform actions such as returning a **HTTP OK** (200) and setting the response's body to a static string.

```javascript
function greet() {
    var context = getContext();
    var response = context.getResponse();
    response.setBody("Hello, Learn!");
}
```

Again, use the context object, you can invoke the ``getCollection()`` method to access the container using the JavaScript query API.

```javascript
function createProduct(item) {
    var context = getContext();
    var container = context.getCollection(); 
}
```

At this point, you can perform typical operations such as creating a new document.

```javascript
function createProduct(item) {
    var context = getContext();
    var container = context.getCollection(); 
    container.createDocument(
        container.getSelfLink(),
        item
    );
}
```

This stored procedure is almost complete. While this code will run fine, it does stand the risk of swallowing errors and potentially not returning if the stored procedure has exceeded the timeout. We should update the code by implementing two more changes:

- Store the boolean return value of container.createDocument, and then use that to determine if we should return from the function due to an impending server timeout.

- Add a third parameter to container.createDocument to handle potential errors and set the response of this stored procedure to the newly created item returned from the operation.

```javascript
function createProduct(item) {
    var context = getContext();
    var container = context.getCollection(); 
    var accepted = container.createDocument(
        container.getSelfLink(),
        item,
        (error, newItem) => {
            if (error) throw error;
            context.getResponse().setBody(newItem)
        }
    );
    if (!accepted) return;
}
```

> [!TIP]
> Alternatively, you can use the ``__`` (double underline) shortcut as an equivalent to ``getContext().getCollection()``.
