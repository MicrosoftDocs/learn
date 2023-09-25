Node.js, or Node for short, is an open-source, server-side JavaScript runtime environment. You can use Node.js to run JavaScript applications and code in many places outside of a browser, such as on a server.

Node.js is a wrapper around a JavaScript engine called [V8](https://nodejs.dev/en/learn/the-v8-javascript-engine/) that powers many browsers, including Google Chrome, Opera, and Microsoft Edge. You can use Node.js to run JavaScript by using the V8 engine outside of a browser. Node.js also contains many V8 optimizations that applications running on a server might need. For example, Node.js adds a **Buffer** class that allows V8 to work with files. This feature makes Node.js a good choice for building something like a web server.

Even if you've never used JavaScript as a primary programming language, it might be the right choice for writing robust, modular applications. JavaScript also offers some unique advantages. For example, because browsers use JavaScript, you can use Node.js to share logic like form-validation rules between the browser and the server.

JavaScript has become more relevant with the rise of single-page applications (SPAs) and supports the widely used JavaScript Object Notation (JSON) data-exchange format. Many NoSQL database technologies like CouchDB and MongoDB also use JavaScript and JSON as a format for queries and schemas. Node.js uses the same language and technologies that many modern services and frameworks use.

You can build the following types of applications by using Node.js:

- HTTP web servers
- Microservices or serverless API backends
- Drivers for database access and querying
- Interactive command-line interfaces
- Desktop applications
- Real-time Internet of Things (IoT) client and server libraries
- Plug-ins for desktop applications
- Shell scripts for file manipulation or network access
- Machine learning libraries and models

:::image type="icon" source="../media/npm.png" alt-text="Image that shows the Node J S and N P M registry logos." border="false":::

The Node.js environment also offers an npm registry that you can use to find Open source Node.js packages to use, or share your own Node.js library.

Node.js is fast, high-performing, and able to handle real-time applications and heavy data flows. An example use case might be building a device that can send control commands to your standing desk. You could install Node.js on your IoT board, or use a device that comes with Node.js preinstalled. You'd then write your application logic in JavaScript and deploy it on the device.

:::image type="content" source="../media/iot-example.jpeg" alt-text="Image of an example use case showing an Internet of Things desktop controller that uses Node J S to run JavaScript.":::

In the next unit, we'll take a closer look at the Node.js architecture and how it works.
