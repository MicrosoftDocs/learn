Code in client apps has to connect to and authenticate with Azure Relay before the apps can send and receive messages.

You created a relay for your credit-checking service. Now you want to enable your on-premises listener component to connect to the relay, so that it can receive requests and send responses. You also want to complete the code in the client app, which sends credit-check requests to the relay and wait for responses. By connecting to the relay service in this way, you expose the service to components in the cloud, without having to open a port on your on-premises firewall. This approach helps protect the credit-checking service.

In this unit, you write the Azure Relay code in both the sender and listener applications.

## Clone the sample apps

You have two command-line apps that send messages to and listen for messages from the relay that you created earlier. Most of the code is finished, but you must add the Azure Relay code to the apps. Let's start by obtaining the code:

- In Azure Cloud Shell at the right, use `git` to clone the sample apps:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-expose-hybrid-services-with-azure-relay.git
    ```

## Configure the listener app

First, let's ensure that the listener app can connect to the relay. The app needs the address of the namespace, the name of the hybrid connection, the key name, and the primary connection key, which you saved earlier in a text file.

1. Change the directory into the starter code for the listener app, then start the code editor:

    ```bash
    cd ~/mslearn-expose-hybrid-services-with-azure-relay/starter/listener
    code Program.cs
    ```

1. In the code, look for the "// Details of the Azure Relay" comment. Immediately after the comment, add this code:

    ```csharp
    private const string RelayNamespace = "<namespace>.servicebus.windows.net";
    private const string ConnectionName = "creditcheckconnection";
    private const string KeyName = "RootManageSharedAccessKey";
    private const string Key = "<your key here>";
    ```

1. In the code, replace `<namespace>` with the name of the relay you created earlier, then copy the key from the saved *AccessKeys.txt* file and paste it to replace `<your key here>`.

The listener app now has all the information it needs to connect to and authenticate with the relay in Azure.

## Respond to requests in the listener app

You must add the credit-checking service to your relay as a listener, so that it receives requests that are sent to the relay. Your code must configure the listener to subscribe to events, process any requests, and formulate responses. The credit-checking service, for example, must obtain the name from the request and then respond with the credit history for that person. When you set up the listener, call the `OpenAsync()` method to start listening for requests.

1. Look for the "// Subscribe to the status events" comment in the *Program.cs* code file for the listener app. Immediately after the comment, add this code:

    ```csharp
    listener.Connecting += (o, e) => { Console.WriteLine("Connecting"); };
    listener.Offline += (o, e) => { Console.WriteLine("Credit check service is offline"); };
    listener.Online += (o, e) => { Console.WriteLine("Credit check service is online"); };
    ```

1. Look for the "// Obtain the name from the request" comment. Immediately after the comment, add this code:

    ```csharp
    TextReader tr = new StreamReader(context.Request.InputStream);
    String requestedName = tr.ReadToEnd();
    Console.WriteLine("A request was received to check credit for: " + requestedName);
    ```

1. Look for the "// Formulate and send the response" comment. Immediately after the comment, add this code:

    ```csharp
    context.Response.StatusCode = HttpStatusCode.OK;
    context.Response.StatusDescription = "Credit check successful";
    using (var sw = new StreamWriter(context.Response.OutputStream))
    {
        sw.WriteLine("Credit check for {0}: {1}", requestedName, creditStatuses[index]);
    }
    ```

1. Look for the "// Open the listener" comment. Immediately after the comment, add this code:

    ```csharp
    await listener.OpenAsync();
    Console.WriteLine("Server listening");
    ```

1. Save your changes by selecting <kbd>Ctrl+S</kbd>, then close the editor by selecting <kbd>Ctrl+Q</kbd>.

## Configure the sender app

Apps that want to check a customer's credit record send a request to the relay, which forwards it to the listener. As for the listener, you configure the sender app with connection details for the relay.

1. In Cloud Shell, change the directory into the starter code for the sender app, and then start the code editor:

    ```bash
    cd ~/mslearn-expose-hybrid-services-with-azure-relay/starter/sender
    code Program.cs
    ```

1. In the **FILES** window, select **Program.cs**.

1. Look for the "// Details of the Azure Relay" comment. Immediately after the comment, add this code:

    ```csharp
    private const string RelayNamespace = "<namespace>.servicebus.windows.net";
    private const string ConnectionName = "creditcheckconnection";
    private const string KeyName = "RootManageSharedAccessKey";
    private const string Key = "<your key here>";
    ```

1. In the code, replace `<namespace>` with the name of the relay you created earlier, then copy the key from the *AccessKeys.txt* file that you saved earlier and paste it to replace `<your key here>`.

> [!TIP]
> Don't forget to delete the *AccessKeys.txt*. In production code, keep these values in a secure location, such as [Azure Key Vault](/azure/key-vault/).

The sender app now has all the information it needs to connect to and authenticate with the relay in Azure.

## Send requests from the sender app

To request a credit check, the sender app sends a name in an HTTP GET request to the relay. Let's write the code that formulates that request.

1. Look for the "// Create an HttpClient and formulate the request" comment in the *Program.cs* code file for the sender app. Immediately after the comment, add this code:

    ```csharp
    var client = new HttpClient();
    var request = new HttpRequestMessage()
    {
        RequestUri = uri,
        Method = HttpMethod.Get,
        Content = new StringContent(name)
    };
    request.Headers.Add("ServiceBusAuthorization", token);
    ```

1. Look for the "// Send the request" comment. Immediately after the comment, add this code: 

    ```csharp
    var response = await client.SendAsync(request);
    ```

1. Look for the "// Display the result" comment. Immediately after the comment, add this code: 

    ```csharp
    Console.WriteLine(await response.Content.ReadAsStringAsync());
    ```

1. Save your changes by selecting <kbd>Ctrl+S</kbd>, then close the editor by selecting <kbd>Ctrl+Q</kbd>.

## Start the apps

The listener and sender apps are complete. You can now run both apps, use the sender to request a credit check, and then observe the results in both apps. To run both apps at once, use a second instance of Cloud Shell to host the sender.

1. In Cloud Shell, to build and run the listener app, run these commands:

    ```bash
    cd ~/mslearn-expose-hybrid-services-with-azure-relay/starter/listener
    dotnet run
    ```

1. After you receive the "Server listening" message, you can start the sender. Open a new instance of your browser, and go to the [Welcome to Azure Cloud Shell](https://shell.azure.com) page.

1. If you're asked to select a directory, choose *Microsoft Learn Sandbox*.

1. To build and run the sender app, run these commands:

    ```bash
    cd ~/mslearn-expose-hybrid-services-with-azure-relay/starter/sender
    dotnet run
    ```

## Test the apps

Now that the apps are both running in separate instances of Cloud Shell, let's test them by checking a credit record.

1. To see both apps at the same time, arrange your browser windows.

1. In the sender app, type a name, and then press <kbd>Enter</kbd>.

   In the listener app, the name you entered should appear.

   In the sender app, the reply from the listener appears with the result of the credit check.

1. To exit the sender app, press <kbd>Enter</kbd>. You can run the app again to check other names. When you're finished, close the browser window.

1. To exit the listener app, select <kbd>Ctrl+C</kbd>.
