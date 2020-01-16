Modifying items in CosmosDB involves working with the same `CosmosClient` object that you used earlier in this module and getting a reference to the "products" container.

```typescript
const client = new CosmosClient(process.env.CONNECTION_STRING);

const database = client.database("tailwind");
const container = database.container("products");
```

Once you have a reference to the container, you use either the `items` or `item` properties to modify the data. Which one you use depends on what you want to do.

## Creating Items

Creating an item involves using the `items.create` method. Whichever item you pass to this method will be created in the collection.

```typescript
const client = new CosmosClient(process.env.CONNECTION_STRING);

const database = client.database("tailwind");
const container = database.container("products");

const productToCreate = req.body;

const result = await container.items.create(productToCreate);
```

## Updating an item

To update or delete an item, you first have to get a reference to that item. This is done by calling `collection.item` and passing in the id of the item you want to update or delete.

```typescript
const client = new CosmosClient(process.env.CONNECTION_STRING);

const database = client.database("tailwind");
const container = database.container("products");

const itemToModify = container.item(id, undefined);
```

> [!NOTE]
> Note that the `item` method takes 2 parameters: the id of the object that you want to retreive and the value of the partition key. If you are not using a partition key (as in this module), you can pass `undefined` as the second parameter value.

CosmosDB offers to mechanisms to update an item - `replace` and `upsert`. The difference between the two is that `replace` simply replaces an existing object with a new one. The `upsert` method replaces an object if it exists and creates it if it does not. The term "upsert" is a combination of the ideas "update" and "insert".

In this module, we'll be using the `replace` method.

```typescript
const client = new CosmosClient(process.env.CONNECTION_STRING);

const database = client.database("tailwind");
const container = database.container("products");

const product = req.body;

const productToUpdate = container.item(product.id, undefined);

const result = await productToUpdate.replace(product);
```

## Deleting an item

To delete an item, retreive a reference to the item just as if you were doing an update. Instead of calling `replace`, call `delete`.

```typescript
const client = new CosmosClient(process.env.CONNECTION_STRING);

const database = client.database("tailwind");
const container = database.container("products");

const id = req.params.id;

const productToDelete = container.item(id, undefined);

const result = await productToUpdate.delete();
```

In the next exercise, you'll create the "CreateProduct", "UpdateProduct" and "DeleteProduct" endpoints, finishing out the rest of the products API.
