As part of architecting your application, you divide up your application into different sections to make it easy to maintain and extend. This division is made based on an application having different resources like products or orders for example. 

A way to easily extend a web application is to ensure that different resources are accessible through dedicated URLs. Two different looking URLs would trigger two different parts of code in your web application.  

It's important to understand what a URL is but also what other important concept comes into play when building an API such as:

- **URL**: a URL is an address that a user would type into a client like a browser to locate your specific server and a specific resource.
- **Routes**: a route is a subsection of a URL and points to a specific resource usually. There are more concepts tied to a route that helps the user be more intentional like:
  - **route parameters**: a route parameter is a part of the route and is used to identify a specific resource item from a collection, for instance, `/products/123`
  - **query parameters**: these parameters are located at the very end of the URL and help with filtering down the size of the response, for instance `/products?sort=desc`
  - **HTTP Verbs**: HTTP Verbs express the *what*. By using the verb `GET` the user states, they want to read data from the resource whereas `POST` means that they mean to write data towards the resource.

## URL

Let's have a closer look at the URL to see what it consists of and how you can organize your app around it.

A URL has many parts to it. Let's break down what those parts and what it's used for. Here's a typical URL:

```bash
http://localhost:8000/products/1?page=1&pageSize=20
```

The above URL conforms to a syntax, looking like this:

```bash
scheme:[//authority]path[?query][#fragment]
```

Let's explain the parts:

- `scheme`: this part indicates the protocol used, in this case, the scheme is `http`. Another example of a scheme is `https`, `ftp`, `irc`, and `file` among others.
- `authority`: the authority consists of two parts:
  - **User info**: It consists of an optional `username@password` part and also a `host` part. In the example above you have `localhost` be the host part. `localhost` points to your own machine as the web server. On the Web, the host part is usually domain names like `google`, `microsoft`, or similar.
  - **Host**:  The `host` is a friendly name and something you specify instead of an IP address. An IP address is the actual Web addresses and looks like a series of numbers like so `127.0.0.1`. This makes it easy for so-called routers to *route* requests from one part of The Web to the other. However, it's not human friendly, which is why `host` or `domain names` exist to create a name that why humans can remember like `microsoft.com`.
- `path`: the path portion of the URL consists of 0 to many segments. Each segment is separated by a `/`. In our URL example, our only segment is `/products`. A segment has the role of filtering down exactly what resources you are interested in.
- `query`: the query portion is an optional piece of the URL that is defined after the `?` character. It consists of a number of query parameter-value pairs delimited by either `&` or `;`. It can play the role of filtering down data further by asking for a number of records from a specific page. It does just this in the above example, `?page=1&pageSize=20`. Imagine you have 2 million records on this resource, it would take a long time to return all those records. By specifying you want 20 records, the data coming back will return back quickly and will be small in size.
- `fragment`: this is part of the URL that helps us be even more specific. A typical fragment can represent, for example,  how to sort the data you ask for with a certain sort order.

## Routes

Now that we know more about what makes out a URL, how does Express help you to deal with these different parts? You've learned in a previous part how Express lets you associate an HTTP verb with a specific route like `/products`. Express is able to do a lot more, it handles the following things for us:

- **routing parameters**: a routing parameter in a URL expresses that you have a wish to access a specific resource. Looking at the route `/orders/1/items/2`, the routing parameters are `1` and `2`. The `1` signals we want a specific order with the unique key `1`. The `2` asks for a specific order item with the unique key `2`. By expressing yourself this way, you are able to return a specific resource rather than all resources of a specific type.
- **query parameters**: the query part of the URL is set of key-value pairs that happen after the `?` character. Looking at the following route `/products?page=1&pageSize=20` you have the query parameters `page` and `pageSize`. These two parameters work in tandem to help you filter down the size of returned response. Imagine if the route `/products` read up 2 million records from a database. That answer would be huge and it would also take a long time for the user to see the rendered response. Waiting a long time is a poor user experience not to mention a strain on the app itself. A better approach is to utilize query parameters to limit the size of response.
- **general pattern management**: so far you've seen simpler routes like `/products` and `/orders/1/items/2`. There could also be other patterns like `**`, which could mean *catch-all*. You would normally define such a route to ensure that unexpected requests are handled in a graceful way and thereby ensure the user has a great experience even if they mistype routes for example.
- **read and write**: HTTP has different verbs like, GET and POST for example. These verbs represent different intentions like that you want to read or write data. Express has specific methods that let's associate a piece of code to a specific URL fragment and HTTP Verb. You've seen so far how Express is able to respond with data when a request asks for it. Express can also handle when the client is trying to write data. It's relatively straight forward to instruct Express to handle incoming data.

### Routing parameters

Now we understand a bit more about a URL and what it can articulate. How does Express help us with the above? Express provides a powerful way for you to define routes and associate different *handlers* to said route. Handlers are a piece of code that is invoked when a certain path is matched. Express has a pattern handling mechanism built-in that ensures you are able to handle different looking routes. Let's show how different routes can be expressed as route patterns.

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
