An application has a variety of data it manages, like products or orders. As a developer for Tailwind Traders, organize your APIs into sections for the type of data. Using sections helps you maintain and extend the app.

An easy way to extend a web app is to make sure that data is accessible through dedicated URLs. Two different URLs trigger two different parts of code in your web app.  

```
https://tailwindtraders.com/products
https://tailwindtraders.com/orders
```

This unit describes what a URL is in order to create an API.

## URL path 

A URL is an address that a user enters into a client, like a browser, to locate a specific server and a specific functionality. Knowing how the URL works helps you organize your app around it. 

Here's a typical URL:

```bash
http://localhost:8000/product/1?page=1&pageSize=20
```

The URL conforms to a syntax that looks like this:

```bash
scheme:[//authority]path[?query][#fragment]
```

Let's explain the parts.

| URL Component | Description |
| --- | --- |
| Scheme | The protocol used, such as `http`, `https`, `ftp`, `irc`, or `file`. |
| Authority | Consists of optional user info and a host, which is usually a domain name. |
| Path | Zero to many segments separated by a slash (`/`), specifying the resources you're interested in. |
| Query | Optional part defined after the `?` character, consisting of parameter/value pairs to filter data further. |
| Fragment | Helps you be even more specific, such as sorting the data in a particular order. |

An example is: `https://tailwindtraders.com/product/1?page=1&pageSize=20#sort=asc`. This URL has the following components:

| URL Component | Value |
| --- | --- |
| Scheme | `https` |
| Authority | `tailwindtraders.com` |
| Path | `/product/1` |
| Query | `page=1&pageSize=20` |
| Fragment | `sort=asc` |

The different between `/products` and `/product/1` is that the first URL points to a collection of products, and the second URL points to a specific product. 

Each route can have actions such as create, read, update, and delete (known as CRUD). The action is indicated by the route method, and combined with additional information send in the HTTP headers and body. 

The following table shows the connection between the crud action and the HTTP method.

| CRUD Action | HTTP Method |
| --- | --- |
| Create | POST |
| Read | GET |
| Update | PUT |
| Delete | DELETE |

Other HTTP methods exist, but these are the most common.

## HTTP handlers

Express is a web framework that helps you create HTTP APIs. It's a library that you can use to create routes that handle HTTP requests.

Write code to match the table for `/products/114`, like this:

```javascript
app.get('/products/:id', (req, res) => {
  // handle this request `req.params.id`
})
```

The format of the handler is `app.<method>(<route>, <callback>)`. When a GET request is made to `/products/114`, run the code in the callback function*. The callback function has two parameters, `req` and `res`. The `req` parameter is the request object, and the `res` parameter is the response object. 

A simplified version of this code can show the different parts of the method, route, and route handler:

```javascript
const routeHandler = (incomingRequest, outgoingResponse) => {
  // handle this request
}

app.get('/products/:id', routeHandler)
```

## Incoming data

Data can be sent into the API in several ways: 

| Data | Location | Explanation | 
| --- | --- | --- |
| Route parameter |  `/products/:id`, where `:id` is the parameter | Route parameters are part of the URL. They're used to identify a specific resource. The data length is confined to the allowed length of the URL so it is typically short such as an ID or a name. A route can have multiple parameters.|
| Query parameter | `/products?page=1&pageSize=20`, where `?page=1&pageSize=20` | Query parameters are part of the URL. They're used to filter data. The data length is confined to the allowed length of the URL so it is typically short such as an ID or a name. A route can have multiple query parameters.|
| Request body | `POST /product` | The request body is part of the HTTP request. It's used to send data to the API. The data length isn't confined to the allowed length of the URL so it can be long. The HTTP header indicates to the API the type of data such as text, JSON, or binary.|

Incoming data usually matches the following methods based on the purpose of the action: 

| Action | Method | Data |
| --- | --- | --- |
| Create | POST | Request body |
| Read | GET | Route and query parameters |
| Update | PUT | Request body |
| Delete | DELETE | Route and query parameters |

## Route parameter example with req.params

Assume the request URL is `/product/20`. The Express route to handle this request is:

```javascript
app.get('/product/:id', (req, res) => {
    const id = req.params.id

    // get product that matches id from database
})
```

## Query string example with req.query

Assume the request URL is `/products?page=1&pageSize=20`. The Express route to handle this request is:

```javascript
app.get('/products', (req, res) => {
    const page = req.query.page
    const pageSize = req.query.pageSize

    // get next page of products from database
})
```

## Request body example with req.body

Assume the request URL is `/product` and the request body is `{ "name": "Product 1" }`. The Express route to handle this request is:

```javascript
app.post('/product', (req, res) => {
    const name = req.body.name

    // add new product to database
})
```
