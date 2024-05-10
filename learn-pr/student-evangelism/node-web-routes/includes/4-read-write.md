So far, you've developed routes to read data for the Tailwind Traders products API. However, you need to add products too. 

In this unit, we discuss the different methods we can use to add or update products and show examples of how that code is implemented. In the next unit, you'll actually edit your application code to add new products and update existing ones.

## Understand how to write data to the API

To write data, use an HTTP method to indicate if the data is new or an update to existing data. 

Common HTTP methods are:

| Method | Description |
| --- | --- |
| `POST` | Create a new resource. |
| `PUT` | Update an existing resource. |
| `PATCH` | Update part of an existing resource. |

`PUT` and `PATCH` are similar. The difference is that `PUT` replaces the entire resource. `PATCH` replaces only the properties that are specified in the request body.

## Understand how to configure your app to receive data

To receive data in your web application, configure Express based on the format of the incoming data such as HTML or JSON format. These are common steps, regardless of the data format.

> [!NOTE]
> Data is sent through the body of the request.

1. **Import a body parser**. To convert the incoming data into a format that's readable, import the `body-parser` library that's installed with Express:

   ```javascript
   let bodyParser = require('body-parser');
   ```

1. **Configure data type**. Configure Express to parse the incoming body data into the intended format. The following code converts the data to JSON:

   ```javascript
   app.use(bodyParser.json({ extended: false }));
   ```

The data sent from the client is available from `req.body`. You can read the data and insert it into the database.

## Understand how to insert a new product

After configuring an app to receive data, you're ready to create code to insert data. Here's an example of some code that inserts new products to the Tailwind Trader's application data store:

```javascript
// Insert a new product
app.post('/products', (req, res) => {
  const newProduct = req.body;
  newProduct.id = products.length + 1;
  products.push(newProduct);
  res.status(201).json(newProduct);
});
```

Call this API with a POST request to `/products` with a JSON body to insert a new product. For example:

```json
{
  "name": "The Hobbit",
  "author": "J.R.R. Tolkien"
}
```

## Understand how to update entire product

In addition to adding new products, Tailwind Traders needs the ability to replace existing product data. Here's a sample of that code, which handles `PUT` requests:

```javascript
app.put('/products/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const updatedProduct = req.body;
  const index = products.findIndex(product => product.id === id);
  if (index !== -1) {
    products[index] = updatedProduct;
    res.json(updatedProduct);
  } else {
    res.status(404).send('Product not found');
  }
});
```

Call this API with a PUT request to `/products/:id` with a JSON body to update a product. For example:

```json
{
  "id": 1,
  "name": "The Hobbit",
  "author": "J.R.R. Tolkien"
}
```

## Understand how to update part of a product

You also need the capability to replace a portion of a product's data rather than all of it. Here's an example of that code, which handles `PATCH` requests:

```javascript
app.patch('/products/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const updates = req.body;
  const index = products.findIndex(product => product.id === id);
  if (index !== -1) {
    // overwrite existing properties with updates
    products[index] = {...products[index], ...updates};
    res.json(products[index]);
  } else {
    res.status(404).send('Product not found');
  }
});
```

Call this API with a PATCH request to `/producs/:id` with a JSON body to update a product. For example:

```json
{
  "author": "J.R.R. Tolkien"
}
```
