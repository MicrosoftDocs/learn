Node.js, or Node for short, is an open source server-side JavaScript runtime environment. Node.js allows JavaScript to be used in so many places outside of the browser, like on the server-side for instance. There are several notable features offered by Node.js, which makes it of great interest.

Node.js is a wrapper around a JavaScript engine called V8. V8 powers many browsers, including Google Chrome, Opera, and Microsoft Edge. Node.js allows you to execute JavaScript with the V8 engine outside of the browser. In addition, it contains many optimizations to V8 that applications running on a server might need. For instance, Node.js adds something called a "Buffer" to V8. This "Buffer" allows V8 to work with files. This makes it a marvelous choice for building something like a Web Server.

If you've never used JavaScript as a primary programming language before, you might be thinking, "is this really a good idea?"

JavaScript is a **great** choice as a main programming language! Not only can you write robust, modular applications with JavaScript, but there are other advantages that _only_ JavaScript has. For example, because browsers use JavaScript as well, Node.js makes it possible to share logic like form validation rules between the browser and the server. 

JavaScript is more relevant nowadays due to the rise of Single Page Applications. In addition, JSON (JavaScript Object Notation) is a widely used data exchange format and JavaScript happens to have native support for it. Many NoSQL database technologies such as CouchDB and MongoDB use JavaScript and JSON as a query and schemas format. Using Node.js means that you are already using the same language and technologies that many modern services and frameworks are using as well.

Applications you can build with Node.js:

- HTTP Web Servers.
- Microservices or Serverless API backends.
- Drivers for database access and querying.
- Interactive command-line interfaces.
- Desktop applications.
- Real-time IoT client and server libraries.
- Plugins for Desktop applications.
- Shell scripts for file manipulations or network access, etc.
- Machine learning libraries and models.

:::image type="content" source="../media/npm.png" alt-text="Node.js and NPM registry":::

The Node.js ecosystem is also rich thanks to NPM, a package manager for Node.js where everyone can share their own Node.js libraries.

Also, imagine that you want to build a device to be able to send control commands to your standing desk; isn't that cool? Node.js would be a perfect fit for this use case as well. Node.js is fast and performant and can handle real-time applications and heavy data flows. You would install Node.js on your IoT board, or use a device that comes with Node.js preinstalled. Then write your application logic in JavaScript and deploy it on the device, that's it.

:::image type="content" source="../media/iot-example.jpeg" alt-text="Node.js IoT example":::


In the next section, we'll pull back the lid on Node.js and take a good look at its architecture, and how it works.
