An application has different resources like products or orders. Divide your application into different sections for the different resources. This makes it easy to maintain and extend the app.

A way to easily extend a web application is to make sure that different resources are accessible through dedicated URLs. Two different URLs trigger two different parts of code in your web application.  

It's important to understand what a URL is, as well as, other concepts used to build an API:

- **URL**: A URL is an address that a user would enter into a into a client, like a browser, to locate your specific server and a specific resource.
- **Routes**: A route is a subsection of a URL that usually points to a specific resource. Other concepts for routes help the user be more intentional:
  - **Route parameters**: A route parameter identifies a specific resource item from a collection, for instance, **/products/123**.
  - **Query parameters**: Query parameters are located at the very end of the URL and filter down the size of the response. For instance **/products?sort=desc**
  - **HTTP verbs**: HTTP verbs express the *what*. By using the verb **GET** the user says they want to read data from the resource. The verb **POST** means that they want to write data toward the resource.

## URL

Learn the different parts of a URL and what each part does. Knowing how the URL works helps you organize your app around it. Here's a typical URL:

```bash
http://localhost:8000/products/1?page=1&pageSize=20
```

The URL conforms to a syntax that looks like this:

```bash
scheme:[//authority]path[?query][#fragment]
```

Let's explain the parts:

- **Scheme**: This part indicates the protocol used. In this case, the scheme is **http**. Other examples of schemes are **https**, **ftp**, **irc**, and **file**.
- **Authority**: The authority consists of two parts:
  - **User info**: It consists of an optional **username@password** part and also a **host** part. In the example, **localhost** is the host part. The **localhost** points to your own machine as the web server. On the web, the **host** part is usually a domain name like **google** or **microsoft**.
  - **Host**:  The host is a friendly name that you specify instead of an IP address. The IP address is the actual web address. It's a series of numbers, such as **127.0.0.1**. An IP address makes it easy for routers to *route* requests from one part of the web to another. However, they're not human friendly. Hosts and domain names exist so that we can remember them.
- **Path**: The path portion of the URL consists of 0 to many segments. Each segment is separated by a **/**. In the example, the only segment is **/products**. A segment filters down the exact resources you're interested in.
- **Query**: The query portion is an optional part of the URL that is defined after the **?** character. It consists of a number of query parameter-value pairs delimited by either **&** or **;**. It filters down data further by asking for a number of records from a specific page. The query in the example is **?page=1&pageSize=20**. Imagine you have two million records on this resource. It would take a long time to return all those records. If you specify that you want 20 records, the data returns quickly and is small in size.
- **Fragment**: This is part of the URL that helps you be even more specific. For example, a fragment can sort the data you ask for in a specific sort order.

## Routes

You learned in the previous unit how Express lets you associate an HTTP verb with a specific route like **/products**. Express also handles the following:

- **Routing parameters**: A routing parameter in a URL expresses that you want to access a specific resource. Looking at the route **/orders/1/items/2**, the routing parameters are **1** and **2**. The **1** signals we want a specific order with the unique key **1**. The **2** asks for a specific order item with the unique key **2**. These routing parameters return a specific resource rather than all resources of a specific type.
- **Query parameters**: The query part of the URL is a set of key-value pairs that exist after the **?** character. The route example, **/products?page=1&pageSize=20**, shows the query parameters **page** and **pageSize**. These two parameters work in tandem to help you filter down the size of a returned response. Imagine if the route **/products** returned 2 million records from a database. That answer would be huge and it would also take a long time for the user to see the rendered response. That's a poor user experience and a strain on the app. A better approach is to use query parameters to limit the size of the response.
- **General pattern management**: So far you've seen simple routes like **/products** and **/orders/1/items/2**. There are other patterns like  **`**`**, which could mean *catch-all*. You would normally define such a route to make sure that unexpected requests, like typos, are handled in a graceful way. This helps the user have a good experience.
- **Read and write**: HTTP has different verbs like, **GET** and **POST** for example. These verbs represent different intentions. For example, that you want to read or write data. Express has specific methods that let's you associate a piece of code to a specific URL fragment and HTTP verb. You've seen so far how Express responds with data when a request asks for it. Express also handles when the client is trying to write data. It's relatively straight forward to instruct Express to handle incoming data.

### Routing parameters

Express can define routes and associate different *handlers* to them. Handlers are code that is invoked when a certain path is matched. Express has a pattern handling mechanism to manage different looking routes. The following shows different routes expressed as route patterns.

| Route                        | Express route pattern         |
|------------------------------|-------------------------------|
| /products                    | products/                     |
| /products/1 and products/114 | products/:id                  |
| /orders/1/items/2            | orders/:orderId/items/:itemId |
| xyz                          | **                            |

Based on the above you then write code like the below to match for example `/products/114`:

```javascript
app.get('/products/:id', (req, res) => {
  // handle this request `req.params.id`
})
```

Route parameters would be written to a `params` property on the request object `res`. A request of `/products/114` would have `req.params.id` contain `114`.

### Query parameters

Express has an easy way of handling query parameters. Given a route like this `/products?page=1&pageSize=20`, the query parameters would be written to a `query` object on the request object `res`. Consider the below code:

```javascript
app.get('/products', (req, res) => {
  // handle this request `req.query.page` and `req.query.pageSize`
})
```

Imagine you would create a request with the route `/products?page=1&pageSize=20`, then `req.query` would have following value:

```javascript
{
  page: 1,
  pageSize: 20
}
```

### Read and write

So far you've seen example of requests being made towards a web application when the client wants to read data. It roughly looks like this using the `get()` method:

```javascript
app.get('/<path>', (req, res) => {
  // handling the request
})
```

To handle a client sending data to the web application, you need to configure Express. You configure Express differently depending on the format of the incoming data. If you, for example,  expect the incoming data to come from an HTML form, you would configure it one way. If the data is of type JSON, you would configure it in another way. Regardless of the data format, there are some common steps namely:

1. Import the library `body-parser` (it's installed with Express)

   ```javascript
   let bodyParser = require('body-parser');
   ```

1. Configure Express to parse the incoming data:

   ```javascript
   app.use(bodyParser.json({ extended: false }));
   ```

   Above the `bodyParser()` function is passed to the Express instance by calling `app.use()`. Note also how the `bodyParser` calls `.json()`, this call determines how the incoming data will be parsed. In this case, it's being parsed as JSON but can be parsed to some other format. What the `body parser` function will do is to listen to all the incoming data is it's being streamed a few bytes at a time. Once data is done being transmitted, it's placed on the `body` property of the request object.
1. Handle the request, to handle an incoming request there are two different methods on the Express instance you could be using namely `post()` or `put()`. Both of these methods are capable of handling a request but `post()` is used to express that you want to create a resource. `put()` on the other hand is used to convey that a resource should be updated using the incoming data. Here's an example:

   ```javascript
   app.post('/<path>', (req, res) => {
     console.log('req.body', req.body) // contains incoming data
   })
   ```
