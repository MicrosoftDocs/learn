You have now created an Azure Function's project using the Azure Maven archetype. Now you'll need to build it, run it, and test that it works.

In this unit, you'll learn why the Azure Functions core tools let you run and test functions locally, how to open a port to enable testing, and finally, how to run and test the function.

## What are the Azure Functions Core Tools

The Azure Function Core is a suite of tools for building and test Azure functions locally using a terminal emulator or command prompt.  Any developed functions can access live Azure services.  When you're ready, you can then deploy the application function to your Azure subscription.

There are two versions of the Azure Functions Core Tools.  It's recommended to use the latest version when developing functions for deployment to Azure.  The latest version requires .NET Core 2.x and above.  You can negate the need to have .NET Core installed on a target machine by using the extension bundles plugin in your project build files.

## Opening port 7071 using the Azure CLI

So far, you've used the Maven azure functions plugin to build an Azure Functions archetype in your Azure Cloud Shell. Before you can run the application, you'll need to open port 7071 using the curl command:

```BASH
curl -X POST http://localhost:8888/openPort/7071
```

When you've completed your testing, you can close the port using this curl command:

```BASH
curl -X POST http://localhost:8888/closePort/7071
```

## Executing the function

Now that the port is open, it's time to run the application.  

To run the application, you'll use another Maven command.  From the root of the project folder, use this command:

```BASH
mvn azure-functions:run
```

To stop the server, use a CTRL+C command from the Azure Cloud command line.

## Testing the function

To test if the web function is running correctly, you'll need to open a new tab in your web browser.  Because the function provides a cloud-based service, Curl can't be used to test this function.  Into the URL address line, you should enter the URL shown from the running function.

```URL
https://gateway12.northeurope.console.azure.com/n/cc-b1b1d78b/cc-b1b1d78b/proxy/7071/api/HttpTrigger-Java?name=Bill
```

The function will accept the name parameter 'Bill' and will return a message saying 'Hello, Bill'.
