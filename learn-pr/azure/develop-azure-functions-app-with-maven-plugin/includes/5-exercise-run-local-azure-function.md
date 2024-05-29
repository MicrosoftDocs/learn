In previous units, you learned how to create a serverless web service Azure Function from a Maven archetype. You also learned how to build and run your function in the Cloud Shell, and how to configure your shell environment to test your function.

In this exercise, you apply the knowledge you gained to open an HTTP port in the Cloud Shell for testing your function. Then, build and run your function in the Cloud Shell, and create an API URL to test your function using a web browser.

## Opening an HTTP port for testing

Before you can test your function remotely, you need to open a port so that HTTP requests are mapped to your function. This action generates a public URL that you use later in this exercise to test your function.

1. In the Azure Cloud Shell, use the following cURL command to open an HTTP port for testing:

    ```bash
    curl -X POST http://localhost:8888/openPort/7071
    ```

1. When the port is open, you see a JSON response that resembles the following example:

    ```json
    {"message":"Port 7071 is open","url":"https://gateway.westus.console.azure.com/n/cc-12345678/cc-12345678/proxy/7071/"}
    ```

    The JSON response is concatenated into a single line as illustrated in the preceding example. However, the following example demonstrates what the JSON response would resemble if it was formatted:

    ```json
    {
        "message": "Port 7071 is open",
        "url": "https://gateway.westus.console.azure.com/n/cc-12345678/cc-12345678/proxy/7071/"
    }
    ```

    This example should help you examine the data that is contained in the response.

1. Copy the URL from the JSON response in your instance of the Cloud Shell. Later in this exercise, you use that URL to test your function in a web browser.

## Building and running your function in the Cloud Shell

After you open your port for testing, you're able to build and run your function.

1. In the Azure Cloud Shell, change to the root folder for your application. For example:

    ```bash
    cd ~/event-reporting
    ```

1. Use the following Maven command to clean your project directory and build your function:

    ```bash
    mvn clean package
    ```

    Maven displays a running status of the build process. The first time that you build your function, Maven downloads dozens of supporting files; these files are the dependencies that are listed in your *pom.xml* and *host.json* files. The following excerpt shows an abbreviated example of a successful build:

    ```output
    [INFO] Scanning for projects...
    [INFO]
    [INFO] ------------------------------------------------------------------------
    [INFO] Building Azure Java Functions 1.0-SNAPSHOT
    [INFO] ------------------------------------------------------------------------
    [INFO]
    . . .
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time: 8.509 s
    [INFO] Finished at: 2020-01-01T04:55:05+00:00
    [INFO] Final Memory: 57M/306M
    [INFO] ------------------------------------------------------------------------
    ```

1. When Maven finishes building and packaging your function, use the following Maven command to run your function:

    ```bash
    mvn azure-functions:run
    ```

    Maven displays a running status of the startup process. The following excerpt shows an abbreviated example of a successful startup:

    ```output
    [INFO] Scanning for projects...
    [INFO]
    [INFO] ------------------------------------------------------------------------
    [INFO] Building Azure Java Functions 1.0-SNAPSHOT
    [INFO] ------------------------------------------------------------------------
    [INFO]
    [INFO] --- azure-functions-maven-plugin:1.4.1:run (default-cli) @ event-reporting ---
    [INFO] Azure Function App's staging directory found at: /home/user/event-reporting/target/azure-functions/event-reporting-20200101063700664
    [INFO] Azure Functions Core Tools found.
    
                      %%%%%%
                     %%%%%%
                @   %%%%%%    @
              @@   %%%%%%      @@
           @@@    %%%%%%%%%%%    @@@
         @@      %%%%%%%%%%        @@
           @@         %%%%       @@
             @@      %%%       @@
               @@    %%      @@
                    %%
                    %
    
    Azure Functions Core Tools (2.7.2184 Commit hash: 5afacc827c2848e4debc23bb96604f1ffce09cc7)
    Function Runtime Version: 2.0.12961.0
    . . .
    Hosting environment: Production
    Content root path: /home/user/event-reporting/target/azure-functions/event-reporting-20200101063700664
    Now listening on: http://0.0.0.0:7071
    Application started. Press Ctrl+C to shut down.
    
    Http Functions:
    
            HttpExample: [GET,POST] http://localhost:7071/api/HttpExample
    
    ```

    Your serverless function is now listening for HTTP requests.

1. Copy the URL section following the HTTP port; for example:

    ```
    /api/HttpExample
    ```

   You use that URL excerpt in the next section of this exercise to test your function in a web browser.

## Testing the function from your web browser

Earlier in this exercise, you opened an HTTP port for testing; this port enables you to test your application in a web browser. To do so, use the following steps.

1. Construct the URL for your function's API:

    1. Retrieve the URL that you copied earlier in the **Opening an HTTP port for testing** section of this exercise; for example:

        ```
        https://gateway.westus.console.azure.com/n/cc-12345678/cc-12345678/proxy/7071/
        ```

    1. Append the excerpt from your function's API URL that you copied earlier in the **Building and running your function in the Cloud Shell** section of this exercise; for example:

        ```
        https://gateway.westus.console.azure.com/n/cc-12345678/cc-12345678/proxy/7071/api/HttpExample
        ```

    1. Append a query string that passes a name to the API URL; for example:

        ```
        https://gateway.westus.console.azure.com/n/cc-12345678/cc-12345678/proxy/7071/api/HttpExample?name=Bob
        ```

    1. Copy this fully constructed URL for use in the following steps.

1. Open a new tab in your web browser, and paste the fully constructed URL from the previous steps into the address field.

1. When you instruct your web browser to request the URL, you see a plaintext message returned to your web browser that is personalized for the name you passed in the query string. For example:

    ```output
    Hello, Bob
    ```

    In the Azure Cloud Shell, you should see a status message that is similar to the following example, which indicates that the request was successfully processed:

    ```output
    [1/1/20 7:08:11 AM] Executing HTTP request: {
    [1/1/20 7:08:11 AM]   "requestId": "12345678-1234-1234-1234-123456789abc",
    [1/1/20 7:08:11 AM]   "method": "GET",
    [1/1/20 7:08:11 AM]   "uri": "/api/HttpExample"
    [1/1/20 7:08:11 AM] }
    [1/1/20 7:08:12 AM] Executing 'Functions.HttpExample' (Reason='This function was programmatically called via the host APIs.', Id=12345678-1234-1234-1234-123456789abc)
    [1/1/20 7:08:12 AM] Java HTTP trigger processed a request.
    [1/1/20 7:08:12 AM] Function "HttpExample" (Id: 12345678-1234-1234-1234-123456789abc) invoked by Java Worker
    [1/1/20 7:08:12 AM] Host lock lease acquired by instance ID '00000000000000000000000052DF09EB'.
    [1/1/20 7:08:12 AM] Executed 'Functions.HttpExample' (Succeeded, Id=12345678-1234-1234-1234-123456789abc)
    [1/1/20 7:08:13 AM] Executed HTTP request: {
    [1/1/20 7:08:13 AM]   "requestId": "12345678-1234-1234-1234-123456789abc",
    [1/1/20 7:08:13 AM]   "method": "GET",
    [1/1/20 7:08:13 AM]   "uri": "/api/HttpExample",
    [1/1/20 7:08:13 AM]   "identities": [
    [1/1/20 7:08:13 AM]     {
    [1/1/20 7:08:13 AM]       "type": "WebJobsAuthLevel",
    [1/1/20 7:08:13 AM]       "level": "Admin"
    [1/1/20 7:08:13 AM]     }
    [1/1/20 7:08:13 AM]   ],
    [1/1/20 7:08:13 AM]   "status": 200,
    [1/1/20 7:08:13 AM]   "duration": 1759
    [1/1/20 7:08:13 AM] }
    ```

If you don't see any errors, then you successfully tested your function locally!

Before continuing, switch back to the Cloud Shell and press <kbd>Ctrl+C</kbd> to close the test server.

In the next unit, you learn how to deploy your function to Azure Functions.
