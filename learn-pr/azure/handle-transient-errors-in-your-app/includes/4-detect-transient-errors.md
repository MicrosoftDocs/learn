After exploring the possible transient faults your company's applications could face, you want to add code to detect them. Any application that makes use of external services should be built to detect issues when they arise. If the cloud-based service is well-written and designed, it might come with a well-documented transient fault contract. This contract can give your app some steps that it can take to handle and recover from the fault.  

Representational State Transfer (REST), is an approach for writing client and server applications. RESTful services are stateless, the client and server don't keep track of the state of the other. A REST request is sent from a client, and a response is returned. REST requests are normally sent via HTTP requests (for example GET and POST), so standard HTTP errors can be returned in the response for example:

- **404**: URI unavailable, the server can't find the requested resource on the server.
- **408**: Request timeout, client hasn't sent a request in time for the server.
- **449**: Microsoft-specific return code that gives the client information that can be used to retry the operation.
- **503**: The service is temporarily unable to handle the request received.
- **504**: Gateway timeout, upstream services have been unable to respond quick enough.

For your companies apps that make use of REST services, these transient errors need to be handled. Your company has made the decision to use Azure. Depending on the features being used, Azure has some well-defined errors that need to be handled.

Azure connections in ASP.NET can receive `WebExceptionStatus.ConnectionClosed`, `WebExceptionStatus.Timeout`, or `WebExceptionStatus.RequestCanceled` responses.

Azure Cosmos DB databases are RESTful services, so they can return all of the standard HTTP errors plus a specific **429** error code that notifies the client that the request rate is too high. This error can be returned when the throughput is too low, or the number and size of requests are too high.

Azure SQL Database also has well-defined error codes, for example, **40501**: The service is currently busy. Retry the request after **X** seconds.

Your team's chat app implements a virtual white board. People can leave messages for the whole team to read. It uses an Azure Cosmos DB database as the message store, created with the MongoDB API. The team could quickly create clients for the chat app in .NET Core using C#, Java, and Node using their previous MongoDB knowledge.

The chat app should detect the following types of errors:

- Lost connections to Azure Cosmos DB.
- Any service unavailability.
- Handle exceptions raised by other parts of the app.

Whatever the error returned by a service, apps need to catch a returned error, check what it is, and then take appropriate steps to handle it. All programming languages have features available to developers to handle errors in code.

## Detecting errors in code

::: zone pivot="csharp"
In C# the mechanism for detecting and handling errors is a `try catch` block. You can define different ways to handle different errors by specifying the exception you wish to handle.

```csharp
    try {

        // Some C# code

    }
    catch (an error) {

        // Some C# code to handle the specific error

    }
    catch (a different error) {

        // Some C# code to handle the specific error

    }
```

All errors inherit from the Exception class. `catch` blocks should be defined in order of most specific to most general. The last `catch` block should be similar to the following block:

```csharp
    catch (Exception e) {

        // Will always match any exception that is raised

    }
```

Using this `catch` block enables a program to handle unexpected errors, and do more logging if necessary. In your company's chat app, there are transient errors that can be returned from the MongoDB database:

- `MongoDB.Driver.MongoConnectionException`: A password, credential, or other Mongo DB issue has occurred.
- `System.TimeoutException`: A problem with the database connection has occurred.

::: zone-end
::: zone pivot="java"
In Java the mechanism for detecting and handling errors is a `try catch` block. You can define many catches specifying the exception you wish to handle.

```java
    try {

        // Some JAVA code

    }
    catch (an error) {

        // Some JAVA code to handle the specific error

    }
    catch (a different error) {

        // Some JAVA code to handle the specific error

    }
```

All errors inherit from the Exception class. `catch` blocks should be defined in order of most specific to most general. The last `catch` block should be:

```java
    catch (Exception e) {

        // Will always match any exception that is raised

    }
```

Using this `catch` block enables a program to handle unexpected errors, and do more logging if necessary. In your company's chat app, there are transient errors that can be returned from the MongoDB database:

- `com.mongodb.MongoCommandException`: A problem with the database connection has occurred, the command can't be executed.
- `com.mongodb.MongoSecurityException`: A password or credential issue has occurred, or the database is unreachable.

::: zone-end
::: zone pivot="node"
In Node the mechanism for detecting and handling errors depends on the context. There's a `try catch` block for synchronous code. If an exception is raised while the code is running, you can define catches that specify the exception you wish to handle.

```javascript
    try {

        //Some javascript code

    }
    catch (error) {

        if (error.code === 'specific error') {

            //Some javascript code to handle the specific error

        } else {

            //Handle all other errors

        }
    }
```

However, Node is built to be asynchronous. To handle errors that happen in asynchronous code, the language defines the concept of *promises*. If you call an async function, you can use a `catch()` promise that executes if the function returns any errors.

```javascript
    async-function-call()
        .then( () => {
            // handle response
            }
        )
        .catch( err => {
            // handle any raised exceptions
            }
        )
```

In your company's chat app, there are transient errors that can be returned from the MongoDB database:

- `MongoNetworkError`:  A problem with the database connection has occurred.
- `MongoError`: A password, credential, or other database issue has occurred.

::: zone-end

In the case where an error is detected, and the error is classified as transient. The app needs to decide if it can retry the operation in a way that's safe for the app and for the service.
