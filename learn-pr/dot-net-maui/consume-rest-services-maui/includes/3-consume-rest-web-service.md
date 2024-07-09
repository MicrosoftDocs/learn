Many modern web services implement the REST architecture. This structure enables a web service to expose operations and data through a series of well-defined endpoints. The requests that client apps send to a REST web service to retrieve, modify, or create, or delete data use a predefined set of **verbs**. A REST web service responds to these requests in a standard manner. This approach makes it easier to construct client apps.

The REST model is built on top of the HTTP protocol. A .NET MAUI application can send requests to a REST web service by using the `HttpClient` class. In this unit, you'll learn about `HttpClient` and how to use it to interact with a REST web service.

## What is the HttpClient class?

`HttpClient` is a .NET class that an app can use to send HTTP requests and receive HTTP responses from a REST web service.  A set of URIs identifies the resources that the web service exposes. A URI combines the address of the web service with the name of a resource available at that address.

The `HttpClient` class uses a task-based API for performance, and gives you access to information in request messages such as HTTP headers and status codes, as well as message bodies that contain the actual data being sent and received.

![Diagram showing how a client app uses an HttpClient object to send and receive HTTP messages and responses](..\media\3-http-client.png)

The `HttpClient` class is available in the `System.Net.Http` namespace. An app can create an `HttpClient` object using the default constructor:

```csharp
using System.Net.Http;
...

var client = new HttpClient();
```

## Perform CRUD operations with an HttpClient object

A REST web service enables a client to perform operations against data through a set of HTTP verbs. The HTTP verb's job is to indicate the desired action to be performed on a resource. There are many HTTP verbs, but the four most common are `POST`, `GET`, `PUT`, and `DELETE`. A service can implement these verbs to enable a client application to manage the lifecycle of objects by performing Create, Read, Update, and Delete (CRUD) operations, as follows:

- The `POST` verb indicates that you want to create a new resource.

- The `GET` verb indicates that you want to retrieve a resource.

- The `PUT` verb indicates that you want to update a resource.

- The `DELETE` verb indicates that you want to delete a resource.

![Diagram showing the basic CRUD operations that a REST service can implement, including get, post, put and delete.](..\media\3-data-operations.png)

### Create a new resource with HttpClient

To create a new resource by using `HttpClient`, you can use the `SendAsync` method passing it an `HttpRequestMessage` object.

The `HttpRequestMessage` is meant to model the request that is sent to the web service. You specify the HTTP verb, the web service's URL, and populate any payload to send via the `HttpRequestMessage.Content` property.

```csharp
HttpClient client = new HttpClient();

HttpRequestMessage message = new HttpRequestMessage(HttpMethod.Post, url);
message.Content = JsonContent.Create<Part>(part);

HttpResponseMessage response = await client.SendAsync(message);
```

This code fragment performs the following tasks:

- It creates an instance of `HttpClient` called **client** that it uses to send a message.
- It creates an instance of `HttpRequestMessage` called **message** that it uses to model the message. The **message** has the HTTP verb and URL.
- It sets the `Content` property of the `HttpRequestMessage`, using the `JsonContent.Create` function. That function automatically serializes the **part** variable into JSON suitable for sending to the web service.
- It sends the message using the `HttpClient` object. An `HttpResponseMessage` is returned that contains information such as the status code and information returned by the web service.

### Read a resource with HttpClient

You could read a resource from a web service using the same technique as previously described, except initializing the `HttpRequestMessage` with an `HttpMethod.Get`. However, the `HttpClient` has a couple of convenience methods that provide shortcuts.

To read a resource by using `HTTPClient`, use the `GetStringAsync` method as shown in the next example:

```csharp
HttpClient client = new HttpClient();

string text = await client.GetStringAsync("https://...");
```

The `GetStringAsync` method takes a URI that references the resource and returns a response as a string. The string response is the resource the app requested. The response-data format is the default for the requested service, such as JSON or XML. An app can tell the web service that it requires the data to be returned in a specific format by adding the `MediaTypeWithQualityHeaderValue` header. For example, if the app requests that data is sent back in JSON format, it can use the following code:

```csharp
HttpClient client = new HttpClient();

client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

```

In this example, the result is returned as a string and only contains the response message body. To get the entire response including headers, body, and status code, call the `GetAsync` method. The data is returned as an `HttpResponseMessage` object.

### Update a resource with HttpClient

To update a resource by using `HttpClient`, use an `HttpRequestMessage` initialized with a **PUT** verb. The following code is similar to that required to create a new resource:

```csharp
HttpClient client = new HttpClient();
HttpRequestMessage message = new HttpRequestMessage(HttpMethod.Put, url);

message.Content = JsonContent.Create<Part>(part);

HttpResponseMessage response = await client.SendAsync(message);
```

> [!NOTE]
> The fundamental difference between `POST` and `PUT` is idempotency. If you repeat the same `PUT` request several times, the same resource will be updated with the same data, and the effect is the same as if the request had been sent only once. If you issue the same `POST` request several times, the result will be the REST service creating multiple copies of the resource.

### Delete a resource with HttpClient

To delete a resource by using `HttpClient`, call `SendAsync` with an `HttpRequestMessage` initialized with a **DELETE** verb:

```csharp
HttpClient client = new HttpClient();
HttpRequestMessage message = new HttpRequestMessage(HttpMethod.Delete, url);

HttpResponseMessage response = await client.SendAsync(message);
```

The response contains the headers, status code, and deleted object.

### Handle responses from a request

All HTTP requests return a response message. The data in the response depends on which verb the app sent. For example, the response body of an HTTP `GET` request contains the data for the requested resource.

The response body of a `POST` request returns a copy of the resource that was created, but the response body of a `PUT` request should be empty.

You should always check and handle the status code in the response message. If this status code is in the 200 range (200, 201, 202, and so on), then the operation is deemed to have been successful, although further information might be required later.

A status code in the 300 range indicates that the request might have been redirected by the web service to a different address, possibly as the result of a resource moving to a different location.

A status code in the 400 range indicates a client or application error. For example, status code 403 means that the web service requires the user to be authenticated, but the app hasn't done so. Status code 404 occurs when the app attempts to access a resource that doesn't exist.

Status codes in the 500 range are indicative of a server-side error, such as the service being unavailable or too busy to handle the request.

The `HttpResponseMessage` object returned by a request submitted through an `HttpClient` object can abstract much of the complexity of handling the different status codes. This code fragment shows how to verify that the status code in a response message indicates success, and handle status codes that indicate some sort of failure.

```csharp
static readonly HttpClient client = new HttpClient();

...
// Call asynchronous network methods in a try/catch block to handle exceptions.
try
{
    //... Initiate the HttpRequest

    HttpResponseMessage response = await client.SendAsync(msg);
    response.EnsureSuccessStatusCode(); // Check that the status code is in the 200 range. Throw an HttpRequestException if not
    
    string responseBody = await response.Content.ReadAsStringAsync();
    
    ... // Handle the response
}
catch(HttpRequestException e)
{
    ... // Handle any status codes that indicate an error. 
        // The status code is available in the field e.StatusCode
}
```