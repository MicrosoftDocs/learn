So far you've been educated on the capabilities of the http module in Node.js. It's a perfectly valid choice for smaller web applications. As soon as applications grows big comes the need to be able to architect your application in a scalable way. Sometimes a framework can help with that. Additionally, once you've built a few web applications you'll notice how you seem to solve the same problems over and over again. Problems like route management, authentication and authorization, error management and more. When you come to this point you start looking for a library or framework that addresses or some or all of these problems.

## Express features

The Express web framework for Node.js does not a have strong opinion on architecture but comes with a set of well thought out features. These features address some common problems that you are likely to encounter developing a web application. It's also a well used and battle tested framework and currently used by 6.8 million projects according to GitHub. It's therefore safe to say that it is trusted by many projects and developers. Why is this? What features does it have that is so compelling? Let's list some of its features and comment on how it can help you succeed in building an application:

- **Robust routing**, Express offers different types of routing like routing via route parameters and query parameters. This enables you to have complex routing schemes as well as it helps the user express what and how much data they can ask for.
- **Test coverage**, having many test and high coverage on important parts means that you as a developer are not likely to encounter unexpected bugs and can focus solely on building out your app.
- **HTTP helpers (redirection, caching, etc)**, as your app grows with you are likely to have to care about smart techniques enhancing performance such ass caching. A deployed application sometimes needs to move resources it is able to serve to a client. Express has built-in support to handle such scenarios.
- **View system supporting 14+ template engines**, as you develop a web application using HTML you most likely want to separate markup and logic. A way to address that is to place the markup in a template and the logic and data content in a separate file. Then you would use template engine to ensure that logic and data content is fused together with the markup. This means that you enable markup and logic to be developed separately.  
- **Executable for generating applications quickly**, when building a web application you seldom want to start on a blank screen. There are things in an app you are likely to always need. Express comes with support to generate an app for you to speed up your development work and time to market.

## Handling requests

The Web has the concept of URLs, addresses, that when entered takes the user to a place on the Web. Part of that address is referred to as a route. A route is a concept that's commonly used when developing a web application. It's a concept that's important to know about cause it's something you will use to organize your app around. Let's first explain the difference between a route and URL. This address is an example of a URL:

```bash
http://localhost:8000/products
```

The above is an address that will return a specific resource or resources when navigated to. Think of an address as a physical address where a physical address has properties such as country, city and street address. If someone knows your full physical address they can then send mail to you. In the case of the URL it represents something similar. The `localhost` could be likened to a country or even city. The port, the `:80` part could be a specific district and `/products` is more like the exact street. The `/products` part is the route in this case.

So why would I want to organize my app around a route? As mentioned the route part takes you to a more exact part.  Think of it this way. The user knows they want to interact with your web server, that would be the `localhost:8000` part. However they also want something specific from you, the route `/products`. By organizing your app around routes it's like setting up small shops or islands the user could go to to get specific information. The route `/products` could give the user a list of products and `/orders` could give the user a list of orders.

### HTTP Verbs

Routes is one thing, it helps us to create islands of information the user can query from. Another thing the HTTP protocol gives us are HTTP Verbs. So what are verbs? Verbs representing something you do. Depending on what you want to do you could be using a specific verb. HTTP has many verbs for expressing many things like fetching data, creating data, updating data and more. As a web developer there's no need for you to use all of these verbs but as a rule of thumb the more exact you are in your verb usage the easier it is predict from the client side what is the likely outcome of you making a request towards a server. Let's list some of these verbs that you are likely to want to use:

- GET, this verb represent an intention to read data from the server. When navigate `http://google.com` in your browser it actually carries out a request with GET as the verb and the address being `http://google.com`.
- POST, this verb represents your intention to want to send some data from client to server. This means the client prior to sending the request populates a *body* that is then transmitted towards the server once the request is performed. If you for example make a request towards `http://localhost:8080/products` with a body of `{ name: 'DVD' }` you likely want to create a resource on the server side using the *posted* body.
- PUT, this verb represents an intention to want to update something on the server side. Just like with POST you want to populate the body with some data representing the changed resource.
- DELETE, this verb says you want to remove a resource on the server side. You are most likely communicating what resource to remove through the URL. A URL would then for example look like this `http://localhost:8080/products/1` accompanied by the DELETE verb. Note how the example url ends with the number `1`, this could be a unique identifier for the resource you intend to remove.

There are more verbs than this in HTTP but the above are the most common one you are likely to encounter and want to incorporate in your app.

### Route management in Express

How does Express help us with route management and HTTP verbs? The Express framework has dedicated methods for handling both different HTTP Verbs but also a smart system for associating different routes with different pieces of your code. Consider the below code example:

```javascript
app.get('/products', (req, res) => {
  // handle the request
})
```

Note above how the `get()` method is used. This means that Express helps you handle requests that are not only aimed towards a route with address `/products` but also with HTTP Verb GET. Express has dedicated methods for all the four HTTP Verbs mentioned above. That means Express sees a POST towards `/products` is different from a GET towards `/products`, as shown in the below code example:

```javascript
app.get('/products', (req, res) => {
  // handle the request
})

app.post('/products', (req, res) => {
  // handle the request
})
```

## Create an Express application

To start developing a Node.js application using Express framework you need to install it as a dependency. It's also recommended that you first initialize a Node.js project so that any downloaded dependencies end up the `package.json` file. This is a general recommendation for any apps developed for the Node.js runtime. The benefits of doing so comes when pushing the code to a repository like GitHub. Anyone fetching the code from GitHub could easily use the code you write by first installing it's dependencies.  

### Steps

There are steps involved when creating a web application using the Express framework. Those are:

1. **Instantiate the app**, this involves creating an web application instance. At this point it's not runnable but you have something you can extend.
1. **Route definitions**, a route is a part of URL. For example in the URL `http://localhost:8000/products`. The route part is the `/products`. Express has the concept of thinking in routes and the different routes should execute different pieces of code. This is the step where you would define what routes the application should listen to. Other examples of routes are  `/`, also known as the default route and `/orders`. Routes is a concept that will be explored further in the upcoming routes unit in this module.
1. **Configure middleware**, middleware is a piece of code that can before or after a request and can be used to handling things like authentication/authorization or adding a capability to your app.
1. **Start the app**, to start the app you define a port and instruct it to listen to that port. Now the app is ready to receive requests.  
