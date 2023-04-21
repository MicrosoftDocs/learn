An application has various resources, like products or orders. Divide your application into sections for the resources. Using sections helps you maintain and extend the app.

An easy way to extend a web app is to make sure that resources are accessible through dedicated URLs. Two URLs trigger two different parts of code in your web app.  

This unit describes understand what a URL is, along with other concepts for creating an API.

## URL

A URL is an address that a user enters into a client, like a browser, to locate a specific server and a specific resource. Knowing how the URL works helps you organize your app around it. 

Here's a typical URL:

```bash
http://localhost:8000/products/1?page=1&pageSize=20
```

The URL conforms to a syntax that looks like this:

```bash
scheme:[//authority]path[?query][#fragment]
```

Let's explain the parts.

### Scheme

The scheme part of a URL indicates the protocol. In the preceding example of a typical URL, the scheme is `http`. Other examples of schemes are `https`, `ftp`, `irc`, and `file`.

### Authority

The authority consists of optional user info (*username@password*) and a host. In the example URL, `localhost` is the host part and points to your own machine as the web server. On the web, the host part is usually a domain name, like `google` or `microsoft`.

The host is a friendly name that you specify instead of an IP address. The IP address is the actual web address. It's a series of numbers, such as `127.0.0.1`. An IP address makes it easy for routers to route requests from one part of the web to another. However, it's not human friendly. Hosts and domain names exist so that we can remember them.

### Path

The path portion of the URL consists of zero to many segments. Each segment is separated by a slash (`/`). In the example URL, the only segment is `/products`. A segment filters down the exact resources you're interested in.

### Query

A query is an optional part of the URL that's defined after the question mark (`?`) character. It consists of query parameter/value pairs delimited by either an ampersand (`&`) or a semicolon (`;`). It filters data further by asking for many records from a specific page.

The query in the example URL is `?page=1&pageSize=20`. Imagine that you have 2 million records on a resource. It would take a long time to return all those records. If you specify that you want 20 records, the data returns quickly and is small in size.

### Fragment

The fragment part of the URL helps you be even more specific. For example, a fragment can sort the data that you ask for in a particular order.

## Route

A route is a subsection of a URL that usually points to a specific resource. Express handles the following concepts for routes that help you be more intentional.

### Route parameter

A route parameter in a URL signals that you want to access a specific resource from a collection.

Look at the route `/orders/1/items/2`. The route parameters are `1` and `2`. The `1` signals that you want a specific order with the unique key `1`. The `2` asks for a specific order item with the unique key `2`. These route parameters return a specific resource rather than all resources of a specific type.

Express defines routes and associates different *handlers* with them. Handlers are code that's invoked when a certain path is matched. Express has a pattern-handling mechanism to manage different-looking routes. The following table shows different routes expressed as route patterns.

| Route                        | Express route pattern         |
|------------------------------|-------------------------------|
| /products                    | products/                     |
| /products/1 and products/114 | products/:id                  |
| /orders/1/items/2            | orders/:orderId/items/:itemId |
| xyz                          | **                            |

Write code to match the table for `/products/114`, like this:

```javascript
app.get('/products/:id', (req, res) => {
  // handle this request `req.params.id`
})
```

Route parameters are written to a `params` property on the `req` request object. A request of `/products/114` would have `req.params.id` that contains `114`.

### Query parameter

The query part of the URL is a set of key/value pairs that exist after the `?` character. The route example, `/products?page=1&pageSize=20`, shows the query parameters `page` and `pageSize`. These two parameters work in tandem to help you filter down the size of a returned response. 
  
Imagine if the route `/products` returned 2 million records from a database. That response would be huge, and it would take a long time to appear. That time creates a poor user experience and a strain on the app. A better approach is to use query parameters to limit the size of the response.

Express has an easy way of handling query parameters. Given the route `/products?page=1&pageSize=20`, the query parameters are written to a query object on the `res` request object, like the following example:

```javascript
app.get('/products', (req, res) => {
  // handle this request `req.query.page` and `req.query.pageSize`
})
```

To create a request with the route `/products?page=1&pageSize=20`, `req.query` has the following value:

```javascript
{
  page: 1,
  pageSize: 20
}
```

### General pattern management

So far, you've seen simple routes like `/products` and `/orders/1/items/2`. There are other patterns, like `**`, which can mean *catch-all*. You would normally define such a route to make sure that unexpected requests, like typos, are handled in a graceful way. This route helps provide a good user experience.

### HTTP verb

An HTTP verb expresses the *what*. HTTP verbs like `get` and `post` represent different intentions. By using the verb `get`, you're saying that you want to read data from the resource. The verb `post` means that you want to write data toward the resource.

Express has specific methods that let you associate code with a specific URL fragment and HTTP verb.
