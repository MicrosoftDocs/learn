Code in client apps has to connect to, and authenticate with, Azure Relay before sending and receiving messages.

You've created a relay for your credit-checking service. Now you want to enable your on-premises listener component to connect to the relay, so it receives requests and can send responses. You also want to complete the code in the client app, which will send credit check requests to the relay and wait for responses. By connecting to the relay service in this way, you expose the service to components in the cloud, without opening a port on your on-premises firewall, which protects the credit-checking service.

Here, you'll write the Azure Relay code in both the sender and listener applications.

## Clone the sample apps

You have two command-line apps that will send messages to, and listen for messages from, the relay you created earlier. Most of the code is finished, but you must add the Azure Relay code to the apps. Let's start by obtaining the code:

1. Start a command prompt on your local machine and create a new directory:

    ```ms-dos
    mkdir CreditCheckApps
    cd CreditCheckApps
    ```

1. Now, use `git` to clone the sample apps:

    <!-- TODO: The link here won't work until my PR is merged with it. Until then, you can use: https://github.com/alistairmatthews/mslearn-expose-hybrid-services-with-azure-relay -->

    ```ms-dos
    git clone https://github.com/MicrosoftDocs/mslearn-expose-hybrid-services-with-azure-relay.git
    ```

## Configure the listener app

First, let's ensure that the listener app can connect to the relay. The app needs the address of the namespace, the name of the hybrid connection, the key name, and the primary connection key you saved, in a text file:

1. Change directory into the starter code for the listener app, and then start Visual Studio Code:

    ```ms-dos
    cd mslearn-expose-hybrid-services-with-azure-relay/starter/listener
    code .
    ```

1. In the **Explorer** window, click **Program.cs**.
1. Locate the comment `// Details of the Azure Relay`. Immediately after that comment, add this code:

    ```c#
    private const string RelayNamespace = "<namespace>.servicebus.windows.net";
    private const string ConnectionName = "creditcheckconnection";
    private const string KeyName = "RootManageSharedAccessKey";
    private const string Key = "<your key here>";
    ```

1. In the code, replace `<namespace>` with the name of the relay you created earlier. Then copy the key from the **AccessKeys.txt** file you saved, and paste it to replace `<your key here>`.

The listener app now has all the information it needs to connect to and authenticate with the relay in Azure.

## Respond to requests in the listener app

You must add the credit-checking service to your relay as a listener, so that it receives requests sent to the relay. Your code must configure the listener to subscribe to events, process any requests, and formulate responses. The credit-checking service, for example, must obtain the name from the request, and then respond with the credit history for that person. When you've set up the listener, call the `OpenAsync()` method to start listening for requests:

1. In the **Program.cs** code file for the listener app, locate the comment `\\ Subscribe to the status events`. Immediately after that comment, add this code:

    ```c#
    listener.Connecting += (o, e) => { Console.WriteLine("Connecting"); };
    listener.Offline += (o, e) => { Console.WriteLine("Credit check service is offline"); };
    listener.Online += (o, e) => { Console.WriteLine("Credit check service is online"); };
    ```

1. Locate the comment `\\ Obtain the name from the request`. Immediately after that comment, add this code: 

    ```c#
    TextReader tr = new StreamReader(context.Request.InputStream);
    String requestedName = tr.ReadToEnd();
    Console.WriteLine("A request was received to check credit for: " + requestedName);
    ```

1. Locate the comment `\\ Formulate and send the response`. Immediately after that comment, add this code: 

    ```c#
    context.Response.StatusCode = HttpStatusCode.OK;
    context.Response.StatusDescription = "Credit check successful";
    using (var sw = new StreamWriter(context.Response.OutputStream))
    {
        sw.WriteLine("Credit check for {0}: {1}", requestedName, creditStatuses[index]);
    }
    ```

1. Locate the comment `\\ Open the listener`. Immediately after that comment, add this code: 

    ```c#
    await listener.OpenAsync();
    Console.WriteLine("Server listening");
    ```

## Configure the sender app

Apps that want to check a customer's credit record send a request to the relay, which forwards it to the listener. As for the listener, you configure the sender app with connection details for the relay:

1. In the command prompt, change directory into the starter code for the sender app, and then start another instance of Visual Studio Code:

    ```ms-dos
    cd ../sender
    code .
    ```

1. In the **Explorer** window, click **Program.cs**.
1. Locate the comment `// Details of the Azure Relay`. Immediately after that comment, add this code:

    ```c#
    private const string RelayNamespace = "<namespace>.servicebus.windows.net";
    private const string ConnectionName = "creditcheckconnection";
    private const string KeyName = "RootManageSharedAccessKey";
    private const string Key = "<your key here>";
    ```

1. In the code, replace `<namespace>` with the name of the relay you created earlier. Then copy the key from the **AccessKeys.txt** file you save and paste it to replace `<your key here>`.

The sender app now has all the information it needs to connect to and authenticate with the relay in Azure.

## Send requests from the sender app

To request a credit check, the sender app sends a name in an HTTP GET request to the relay. Let's write the code that formulates that request:

1. In the **Program.cs** code file for the sender app, locate the comment `// Create an HttpClient and formulate the request`. Immediately after that comment, add this code:

    ```c#
    var client = new HttpClient();
    var request = new HttpRequestMessage()
    {
        RequestUri = uri,
        Method = HttpMethod.Get,
        Content = new StringContent(name)
    };
    request.Headers.Add("ServiceBusAuthorization", token);
    ```

1. Locate the comment `// Send the request`. Immediately after that comment, add this code: 

    ```c#
    var response = await client.SendAsync(request);
    ```

1. Locate the comment `// Display the result`. Immediately after that comment, add this code: 

    ```c#
    Console.WriteLine(await response.Content.ReadAsStringAsync());
    ```

## Test the apps

The listener and sender apps are complete. You can now run both apps, use the sender to request a credit check, and then observe the results in both apps:

1. Switch to the instance of Visual Studio Code that shows the listener app. 
1. On the **Debug** menu, click **Start Debugging**. A new command prompt is shown to run the app. Wait until the message **Server listening** is displayed.
1. Switch to the instance of Visual Studio Code that shows the sender app.
1. On the **Debug** menu, click **Start Debugging**. A new command prompt is shown to run the app. Wait until the message **Enter a name to check:** is displayed.
1. In the sender app, type a name of your choice, and then press Enter. 
1. In the listener app, the name you typed should be displayed with the result of the credit check.
1. In the sender app, the reply from the listener is displayed.
