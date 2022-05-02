Many modern web services implement the REST architecture. This structure enables a web service to expose operations and data through a series of well-defined endpoints. The requests that client apps send to a REST web service to retrieve, modify, or create, or delete data use a predefined set of **verbs**. A REST web service responds to these requests in a standard manner. This approach makes it easier to construct client apps.

The REST model is built on top of the HTTP protocol. A .NET MAUI application can send requests to a REST web service by using the `HttpClient` class. In this unit, you'll learn about `HttpClient`, and how to use it to interact with a REST web service.

## What is the HttpClient class?

`HttpClient` is a .NET class that an app can use to send HTTP requests and receive HTTP responses from a REST web service. The resources that the web service exposes are identified by a set of URIs. A URI combines the address of the web service with the name of a resource available at that address.

The `HttpClient` class uses a task-based API for performance, and gives you access to information in requests messages such as HTTP headers, status codes, as well as message bodies that contain the actual data being send and received.

![Diagram showing how a client app uses an HttpClient object to send and receive HTTP messages and responses](..\media\3-http-client.png)

The `HttpClient` class is available in the `System.Net.Http` namespace. An app can create an `HttpClint` object using the default constructor:

```csharp
using System.Net.Http;
...

var client = new HttpClient();
```

## Perform CRUD operations with an HttpClient object

A REST web service enables a client to perform operations against data through a set of HTTP verbs. The job of the HTTP verb is to indicate the desired action to be performed on a resource. There are many HTTP verbs, but the four most common are `POST`, `GET`, `PUT`, and `DELETE`. A service can implement these verbs to enable a client application to manage the lifecycle of objects by performing Create, Read, Update, and Delete (CRUD) operations, as follows:

- The `POST` verb indicates that you want to create a new resource.

- The `GET` verb indicates that you want to retrieve a resource.

- The `PUT` verb indicates that you want to update a resource.

- The `DELETE` verb indicates that you want to delete a resource.

![Diagram showing the basic CRUD operations that a REST service can implement, including get, post, put and delete.](..\media\3-data-operations.png)

### Create a new resource with HttpClient

To create a new resource by using `HttpClient`, use the `PostAsync` method. The following code shows an example:

```csharp
HttpClient client = new HttpClient();

StringContent content = new StringContent(JsonSerializer.Serialize(data),Encoding.UTF8, "application/json");

HttpResponseMessage response = await client.PostAsync("https://...", content);
```

This code fragment performs the following tasks:

- It creates an instance of `HTTPClient` called **client** that it uses to issue the `POST` request.

- It creates an instance of `StringContent` called **content**. This object represents the data that the app will send to the web service as a string. This object also specifies details data such as the encoding type and data format, to ensure that the web service interprets the data correctly. In this example, the app sends the data in JSON format. Note that the variable **data** is contains the original data to be used. It's held in a serializable object. The app converts this data into JSON by using the `JsonSerializer` class in the **System.Text.Json** namespace.

- It calls the `PostAsync` method of the `HTTPClient` object. The first parameter is the URI. The second parameter is the body of the message, which contains our data in JSON format. The `PostAsync` method returns an `HttpResponseMessage` object, which contains information such as the status code and a reference to the newly created object.

### Read a resource with HTTPClient

To read a resource by using `HTTPClient`, use the `GetStringAsync` method as shown in the next example:

```csharp
HttpClient client = new HttpClient();

string text = await client.GetStringAsync("https://...");
```

The `GetStringAsync` method takes a URI that references the resource, and returns a response as a string. The string response is the resource the app requested. The format of the response data will be the default for the requested service, such as JSON or XML. An app can tell the web service that it requires the data to be returned in a specific format by adding the `MediaTypeWithQualityHeaderValue` header. For example, if the app requests that data is sent back in JSON format, it can use he following code:

```csharp
HttpClient client = new HttpClient();

client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

```

In this example, the result is returned as a string and only contains the response message body. To get the entire response including headers, body, and status code, call the `GetAsync` method. The data is returned as an `HttpResponseMessage` object.

### Update a resource with HTTPClient

To update a resource by using HTTPClient, use the `PutAsync` method. The following code is similar to that required to create a new resource except that it uses the `PutAsync` method:

```csharp
HttpClient client = new HttpClient();

StringContent content = new StringContent(JsonSerializer.Serialize(data),Encoding.UTF8, "application/json");

HttpResponseMessage response = await client.PutAsync("https://...", content);
```

> [!NOTE]
> The fundamental difference between `POST` and `PUT` is idempotency. If you repeat the same `PUT` request several times, the same resource will be updated with the same data, and the effect is the same as if the request had been sent only once. If you issues the same `POST` request several times, the result will be multiple copies of the resource being created by the REST service.

### Delete a resource with HTTPClient

To delete a resource by using `HTTPClient`, call the `DeleteAsync` method:

```csharp
HttpClient client = new HttpClient();

HttpResponseMessage response = await client.DeleteAsync("https://...");
```

In this example, the app passes in the URI of the resource to be deleted. The response contains the headers, status code, and deleted object.

### Handle responses from a request

All HTTP requests return a response message. The data in the response depends on which verb was sent by the app. For example, the response body of an HTTP `GET` request contains the data for the requested resource.

The response body `POST` request returns a copy of the resource that was created, but the response body of a `PUT` request should be empty.

You should always check and handle the status code in the response message. If this status code is in the 200 range (200, 201, 202, and so on), then the operation is deemed to have been successful, although further information may be required later.

A status code in the 300 range indicates that the request may have been redirected by the web service to a different address, possibly as the result of a resource moving to a different location.

A status code in the 400 range indicates a client or application error. For example, status code 403 means that the web service requires the user to be authenticated, but the app hasn't done so. Status code 404 occurs when the app attempts to access a resource that doesn't exist.

Status codes in the 500 range are indicative of a server-side error, such as the service being unavailable or too busy to handle the request.

The `HttpResponseMessage` object returned by a request submitted through an `HttpClient` object can abstract much of the complexity of handling the different status codes. This code fragment shows how to verify that the status code in a response message indicates success, and handle status codes that indicate some sot of failure.

```csharp
static readonly HttpClient client = new HttpClient();

...
// Call asynchronous network methods in a try/catch block to handle exceptions.
try
{
    HttpResponseMessage response = await client.GetAsync("http://www.contoso.com/");
    response.EnsureSuccessStatusCode(); // Check that the status code is in the 200 range. Throw an HttpRequestException if not
    string responseBody = await response.Content.ReadAsStringAsync();
    // The preceding three lines can be replaced with the helper method below
    // string responseBody = await client.GetStringAsync(uri);

    ... // Handle the response
}
catch(HttpRequestException e)
{
    ... // Handle any status codes that indicate an error. 
        // The status code is available in the field e.StatusCode
}
```