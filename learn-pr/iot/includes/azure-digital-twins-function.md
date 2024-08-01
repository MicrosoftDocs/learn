---
author: baanders
ms.author: baanders
ms.date: 03/15/2024
ms.topic: include
ms.service: azure-digital-twins
---

3. Add the following variables to the top of your class, before the function declaration. These class variables will be used to authenticate your function with Azure Digital Twins. There are no placeholders to replace; just paste them in as shown.

    ```csharp
    private static readonly HttpClient httpClient = new HttpClient();
    private static string adtServiceUrl = Environment.GetEnvironmentVariable("ADT_SERVICE_URL");  //This will be populated at runtime by the environment variable you set up earlier for the Azure function app. adtServiceUrl will ultimately be set to "https://<host-name-of-your-Azure-Digital-Twins-instance>".
    ```

    :::image type="content" source="../synchronize-azure-digital-twins-with-iot-device-data/media/3-code-2.png" alt-text="Screenshot of code in Visual Studio, showing the new variables." lightbox="../synchronize-azure-digital-twins-with-iot-device-data/media/3-code-2.png":::

4. In the `Run` method, add the following code after the log line. This code snippet uses the authentication variables above to set up a `DigitalTwinsClient`, which contains methods to retrieve and update digital twin information. For more information about this class, see [DigitalTwinsClient Class (.NET SDK)](/dotnet/api/azure.digitaltwins.core.digitaltwinsclient).

    ```csharp
    var credentials = new DefaultAzureCredential();
    DigitalTwinsClient client = new DigitalTwinsClient(
        new Uri(adtServiceUrl), credentials, new DigitalTwinsClientOptions
        { Transport = new HttpClientTransport(httpClient) });
    log.LogInformation($"ADT service client connection created.");
    ```

    :::image type="content" source="../synchronize-azure-digital-twins-with-iot-device-data/media/3-code-3.png" alt-text="Screenshot of code in Visual Studio, showing the the DigitalTwinsClient." lightbox="../synchronize-azure-digital-twins-with-iot-device-data/media/3-code-3.png":::