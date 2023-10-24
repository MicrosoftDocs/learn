Node.js, or Node for short, is an open-source, server-side JavaScript runtime environment. You can use Node.js to run JavaScript applications and code in many places outside of a browser, such as on a server or in a CI/CD pipeline.

Node.js is a wrapper around a JavaScript engine called [V8](https://nodejs.dev/en/learn/the-v8-javascript-engine/) that [powers many browsers](https://caniuse.com/mdn-api_node), including Google Chrome, Opera, Safari, Microsoft Edge, Firefox and much more. You can use Node.js to run JavaScript by using the V8 engine outside of a browser. Node.js also contains many V8 optimizations that applications running on a server might need. For example, Node.js adds a [**Buffer**](https://nodejs.org/api/buffer.html#buffer) class that allows V8 to work with files. This feature makes Node.js a good choice for building a web server.

Even if you've never used JavaScript as a primary programming language, it might be the right choice for writing robust, modular applications. JavaScript also offers some unique advantages. For example, because browsers use JavaScript, you can use Node.js to share logic like form-validation rules between the browser and the server.

JavaScript has become more relevant with the rise of single-page applications (SPAs) and supports the widely used JavaScript Object Notation (JSON) data-exchange format. Many database technologies, including SQL and no-SQL, use JavaScript and JSON as a format for queries and schemas. 

**SQL databases** which use JavaScript JSON objects include: 

* [PostgreSQL](https://www.postgresql.org/docs/9.3/datatype-json.html)
* [MySQL](https://dev.mysql.com/doc/refman/8.0/en/json.html)
* [Microsoft SQL Server](https://docs.microsoft.com/en-us/sql/relational-databases/json/json-data-sql-server?view=sql-server-ver15)

**NoSQL databases** which use JavaScript JSON objects include:

* [MongoDB](https://docs.mongodb.com/manual/core/document/)
* [CouchDB](https://docs.couchdb.org/en/stable/json.html)
* [Cassandra](https://docs.datastax.com/en/cql-oss/3.3/cql/cql_using/useInsertJSON.html)


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
