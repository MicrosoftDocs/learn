Node.js, or Node for short, is an open source server-side JavaScript runtime environment. Node.js allows JavaScript to be used in so many places outside of the browser, like on the server-side for instance. There are several notable features offered by Node.js, which makes it of great interest.

Node.js is a wrapper around the infamous JavaScript runtime V8. V8 powers many browsers including Google Chrome, Opera, and Microsoft Edge. Node.js brought many optimizations to V8 allowing it to work outside of the browser. For instance, when using Node.js to run a Web server, manipulating binary files and content is often mandatory; Node.js has enriched V8 with a Buffer API for these use cases.

Even if it's not related to Node.js, the fact that JavaScript was chosen as the main programming language for the Node.js runtime was a great choice! Whether we like it or not, browsers support only a restricted set of technologies to build front-end Web application. If we want to share some code, for example, forms validations rules, between the browsers and the server, JavaScript is the only choice. This is more relevant nowadays due to the rise of Single Page Applications, where JavaScript is the Lingua Franca in front-end development. In addition, JSON (JavaScript Object Notation) is a widely used data exchange format and JavaScript happens to have native support for it. Many NoSQL database technologies such as CouchDB and MongoDB use JavaScript and JSON as a query and schemas format.

Applications you can build with Node.js:

- HTTP Web Servers.
- Microservices or Serverless API backends.
- Drivers for database access and querying.
- Interactive command-line interfaces, such as hexa.run.
- Desktop applications, such as VS Code or Slack (using Electron).
- Real-time IoT client and server libraries, such as Johnny-Five.
- Plugins for Desktop applications, such as SketchApp and Adobe XD.
- Shell scripts for file manipulations or network access, etc.
- Machine learning libraries and models.

:::image type="content" source="../media/npm.png" alt-text="Node.js and NPM registry":::

The Node.js ecosystem is also rich thanks to NPM, a package manager for Node.js where everyone can share their own Node.js libraries.

Let's imagine you have many data you need to expose to users or to third-party services. You would start off by using Node.js to create the REST API backend, and implement CRUD (Create, Read, Update, Delete) operations. Then, you would model your data and store it in a NoSQL database.

:::image type="content" source="../media/iot-example.jpeg" alt-text="Node.js IoT example":::

Also, imagine that you want to build a device to be able to send control commands to your standing desk; isn't that cool? Node.js would be a perfect fit for this use case as well. Node.js is fast and performant and can handle real-time applications and heavy data flows. You would install Node.js on your IoT board, or use a device that comes with Node.js preinstalled. Then write your application logic in JavaScript and deploy it on the device, that's it.

The use cases are endless.
