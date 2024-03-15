An application has a variety of data it manages, like products or orders. As a developer for Tailwind Traders, organize your APIs into sections for the type of data. Using sections helps you maintain and extend the app.

An easy way to extend a web app is to make sure that data is accessible through dedicated URLs. Two different URLs trigger two different parts of code in your web app.  

```
https://tailwindtraders.com/products
https://tailwindtraders.com/orders
```

This unit describes what a URL is in order to create an API.

## URL path 

A URL is an address that a user enters into a client, like a browser, to locate a specific server and a specific functionality. Knowing how the URL works helps you organize your app around it. 

Here's a typical URL: `http://localhost:8000/products/1?page=1&pageSize=20`

The URL conforms to a syntax that looks like this:

`scheme:[//authority]path[?query][#fragment]`

Let's explain the parts for the example URL: `https://tailwindtraders.com/products/1?page=1&pageSize=20#sort=asc`.

| URL Component | Example | Description |
| --- | --- | --- |
| Scheme | `https` |The protocol used, such as `http`, `https`, `ftp`, `irc`, or `file`. |
| Authority | `tailwindtraders.com` |Consists of optional user info and a host, which is usually a domain name. |
| Path | `/products/1` |Zero to many segments separated by a slash (`/`), specifying the resources you're interested in. |
| Query | `page=1&pageSize=20` |Optional part defined after the `?` character, consisting of parameter/value pairs to filter data further. |
| Fragment | `sort=asc` |Helps you be even more specific, such as sorting the data in a particular order. |

Each route can have actions such as create, read, update, and delete (known as CRUD). The action is indicated by the route method, and combined with additional information sent in the HTTP headers and body. 

## HTTP handlers

Express is a web framework that helps you create HTTP APIs. Use it to create routes that handle HTTP requests.

Here's an example of code that handles HTTP requests for the URL `/products/114`:

```javascript
app.get('/products/:id', (req, res) => {
  // handle this request `req.params.id`
})
```

The format of the handler is `app.<method>(<route>, <callback>)`. The request for the route `/products/114` with the GET method runs the code in the function which has access to the incoming request (`req`) and returns the response (`res`). 

This code can be rewritten to make it easier to read:

```javascript
const routeHandler = (incomingRequest, outgoingResponse) => {
  // handle this request
}

app.get('/products/:id', routeHandler)
```

In your work at Tailwind Traders, you may have to work in Express apps with either style of code.

## Incoming data

Data can be sent into the API in several ways: 

| Data | Location | Explanation | 
| --- | --- | --- |
| Route parameter |  `/products/:id`, where `:id` is the parameter | Route parameters are part of the URL. They're used to identify a specific resource. The data length is confined to the allowed length of the URL so it is typically short such as an ID or a name. A route can have multiple parameters.|
| Query parameter | `/products?page=1&pageSize=20`, where `?page=1&pageSize=20` is the parameter | Query parameters are part of the URL. They're used to filter data. The data length is confined to the allowed length of the URL so it is typically short such as an ID or a name. A route can have multiple query parameters.|
| Request body | `POST /products` | The request body is part of the HTTP request. It's used to send data to the API. The data length isn't confined to the allowed length of the URL so it can be long. The HTTP header indicates to the API the type of data such as text, JSON, or binary.|

Incoming data usually matches the following methods based on the purpose of the action: 

| Action | Method | Data |
| --- | --- | --- |
| Create | POST | Request body |
| Read | GET | Route and query parameters |
| Update | PUT | Request body |
| Delete | DELETE | Route and query parameters |

> [!TIP]
> The first letter of each method spells CRUD. That terms is used in the industry to describe the four basic types of operations that can be performed on data.

## Route parameter example with req.params

Assume the request URL is `/products/20`. The Express route to handle this request is:

```javascript
app.get('/products/:id', (req, res) => {
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

Assume the request URL is `/products` and the request body is `{ "name": "Product 1" }`. The Express route to handle this request is:

```javascript
app.post('/products', (req, res) => {
    const name = req.body.name

    // add new product to database
})
```
