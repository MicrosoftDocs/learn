To send and receive messages through Azure Relay, you must understand how to write the necessary code.

Let's suppose you created the relay for the credit-checking service in Azure Relay. Now you want to modify your credit-checking service and the clients that call it, so that they can send messages through the relay. You need to know how to write this code.

In this unit, we use classes such as `HybridConnectionListener` and `HttpRequestMessage` to send and respond to messages.

## Use TokenProvider to pass credentials

The listener and sender components must identify themselves to Azure Relay when they connect. For any hybrid connection, you use the .NET `TokenProvider` class to pass this information. When you created a shared access policy in your namespace, Azure created a primary and secondary key. This key is the credential that you add to the `TokenProvider` to secure the communications.

This code shows how to configure the credentials and add them to `TokenProvider`:

```csharp
// Store credentials. In production code, keep these values in a secure location, such as Azure Key Vault.
private const string KeyName = "RootManageSharedAccessKey";
private const string Key = "<your key here>";

// Create and configure TokenProvider.
var tokenProvider = TokenProvider.CreateSharedAccessSignatureTokenProvider(KeyName, Key);
```

## Connect a listener to Azure Relay

To connect a listener to the Azure Relay service, you create and configure an instance of the `HybridConnectionListener` class. Pass the URI for the relay and the `TokenProvider` to the constructor.

```csharp
// Store the connection details.
private const string RelayNamespace = "{RelayNamespace}.servicebus.windows.net";
private const string ConnectionName = "{HybridConnectionName}";

// Create and configure the listener.
var listener = new HybridConnectionListener(new Uri(string.Format("sb://{0}/{1}", RelayNamespace, ConnectionName)), tokenProvider);
```

Next, you subscribe to relevant events in the relay, such as connection events.

```csharp
listener.Connecting += (o, e) => { Console.WriteLine("Connecting"); };
listener.Offline += (o, e) => { Console.WriteLine("Offline"); };
listener.Online += (o, e) => { Console.WriteLine("Online"); };
```

To configure how the listener responds to messages, use its `RequestHandler` property. To send a response, use `StreamWriter`.

```csharp
listener.RequestHandler = (context) =>
{
    // Configure the response status.
    context.Response.StatusCode = HttpStatusCode.OK;
    context.Response.StatusDescription = "OK";
    // Use a stream writer to send text back.
    using (var sw = new StreamWriter(context.Response.OutputStream))
    {
        sw.WriteLine("hello!");
    }
    // Remember to close the context.
    context.Response.Close();
};
```

When you configure the listener, you open it to begin listening for messages. Because the relay, listener, and sender are all hosted in different locations, they might take some time to respond to messages. It's important to use asynchronous code for these messages to ensure that your app doesn't appear to stop responding as it waits for responses. Notice the asynchronous `await` keyword and asynchronous method names in the following code:

```csharp
await listener.OpenAsync()
```

Remember to close the listener at an appropriate point in your code:

```csharp
await listener.CloseAsync();
```

## Connect a sender to Azure Relay

For the sender, there's no Azure Relay-specific object. You can use a standard `HttpRequestMessage` object, as you would when you call any web service.

```csharp
// Store the connection details.
private const string RelayNamespace = "{RelayNamespace}.servicebus.windows.net";
private const string ConnectionName = "{HybridConnectionName}";

// Formulate the URI.
var uri = new Uri(string.Format("https://{0}/{1}", RelayNamespace, ConnectionName));

// Create and configure the client. Use the Content property to specify the message text.
var client = new HttpClient();
var request = new HttpRequestMessage()
{
    RequestUri = uri,
    Method = HttpMethod.Get,
    Content = new StringContent("Obtain credit check for Sara McMurray")
};
```

To pass the token, add it to the request headers:

```csharp
// Create the token from the token provider.
var token = (await tokenProvider.GetTokenAsync(uri.AbsoluteUri, TimeSpan.FromHours(1))).TokenString;

// Add the token to the headers.
request.Headers.Add("ServiceBusAuthorization", token);
```

Now you can send a message by using the `SendAsync` method, and obtain a response asynchronously:

```csharp
// Send the request.
var response = await client.SendAsync(request);

// Display the result.
Console.WriteLine(await response.Content.ReadAsStringAsync());
```
