At this point, the app is working to get the user's location and is ready to be sent to the Azure Functions. In this unit, you build your own Azure Functions.

## Create an Azure Functions project

1. Right-click on the `ImHere` solution and select *Add > New Project...*.

1. Search for *Azure Functions*, select it, and click **Next**.

1. Name the project "ImHere.Functions", and then click **Create**.

    :::image type="content" source="../media/5-add-new-functions-project.png" alt-text="Screenshot of the Add New Project dialog.":::

1. The **New Project** configuration dialog will appear, and it may show a spinner in the bottom-left whilst loading updated templates. If you see this, wait until this has finished loading, then if updated templates are available, click the **Refresh** option that will appear to ensure you get the latest Function templates.

1. In the **New Project** configuration dialog, ensure the Functions version is set to *.NET 6*. Select *Http Trigger*, leave the storage account set to *Storage Emulator*, and set the authorization level to *Anonymous*. Then click **Create**.

    :::image type="content" source="../media/5-configure-trigger.png" alt-text="The Azure Functions project configuration dialog.":::

    The new project will be created and have a default function called `Function1`.

> [!NOTE]
> This function was created with anonymous access. Once published to Azure, anybody who knows the URL will be able to call this function. In a real-world scenario, you would protect this with some form of authentication, such as [Azure App Service authentication](/azure/app-service/app-service-authentication-overview?azure-portal=true) or [Azure Active Directory B2C](/azure/active-directory-b2c?azure-portal=true).

## Create the function

The Azure Functions project is created with a single HTTP trigger function called `Function1`. HTTP triggers allow you to invoke your functions using HTTP requests. The function itself is implemented as a static `Run` method in the `Function1` class.

1. Rename the file in Solution Explorer from "Function1.cs" to "SendLocation.cs". When prompted to rename all references to the code element `Function1`, click **Yes**.

1. Rename the function name in the attribute to "SendLocation".

    ```cs
    [FunctionName("SendLocation")]
    ```

1. Delete the contents of the function, except the first line that writes an information message to the logger.

    ```cs
    public static async Task<IActionResult> Run([HttpTrigger(AuthorizationLevel.Anonymous,
                                                             "get", "post",
                                                             Route = null)]HttpRequestMessage req,
                                                ILogger log)
    {
        log.LogInformation("C# HTTP trigger function processed a request.");
    }
    ```

## Create a class to share data between the mobile app and function

When data is sent to the Azure Functions, it will be sent as JSON. The mobile app will serialize data into JSON and the function will deserialize from JSON. To keep this data consistent between the mobile app and the function, create a new project that contains a class to hold the location and phone number data. This project will then be referenced by the app and function.

1. Create a new project under the `ImHere` solution by right-clicking on the solution and selecting *Add > New Project...*.

1. Search for *Class Library (.NET Standard)*, select it, and click **Next**.

    :::image type="content" source="../media/5-add-new-net-standard-project.png" alt-text="Screenshot of the Add New Project dialog with the Class Library option highlighted.":::

1. Name the project "ImHere.Data", and then click **Next**.

1. For the Class Library Framework, select *.NET Standard 2.0*, and then click **Create**.

1. Delete the auto-generated "Class1.cs" file.

1. Right-click on the `ImHere.Data` project and select *Add > Class...* to create a new class.

1. Name the new class "PostData" and click **Add**. Mark this new class as `public`.

1. Add `double` properties for the latitude and longitude, as well as a `string[]` property for the phone numbers to send to.

    ```cs
    public class PostData
    {
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string[] ToNumbers { get; set; }
    }
    ```

1. Add a reference to this project in both the `ImHere.Functions` and `ImHere` projects by right-clicking on the project and then selecting *Add->Reference...*. Select *Projects* from the tree on the left-hand side, and then check the box next to *ImHere.Data*.

    :::image type="content" source="../media/5-configure-project-references.png" alt-text="Configuring project references.":::

## Read the data sent to the function

In the Azure Functions, the `req` parameter contains the HTTP request that was made and the data inside this request will be a JSON serialized `PostData` object.

1. Open the `SendLocation` class in the `ImHere.Functions` project.

1. Read the contents of the HTTP request into a string, then deserialize it into a `PostData` object, adding a using directive for the `ImHere.Data` namespace.

    ```cs
    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    PostData data = JsonConvert.DeserializeObject<PostData>(requestBody);
    ```

1. Construct a Google Maps URL using the latitude and longitude from the `PostData`.

   ```cs
   string url = $"https://www.google.com/maps/search/?api=1&query={data.Latitude},{data.Longitude}";
   ```

1. Log the URL.

    ```cs
    log.LogInformation($"URL created - {url}");
    ```

1. Return a 200 status code to show the function completed without error.

    ```cs
    return new OkResult();
    ```

The complete function is shown below.

  ```cs

    using System.IO;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Azure.WebJobs;
    using Microsoft.Azure.WebJobs.Extensions.Http;
    using Microsoft.AspNetCore.Http;
    using ImHere.Data;
    using System.Threading.Tasks;
    using Microsoft.Extensions.Logging;
    using Newtonsoft.Json;

    namespace ImHere.Functions
    {
        public static class SendLocation
        {
            [FunctionName("SendLocation")]
            public static async Task<IActionResult> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post",
                                                             Route = null)]HttpRequest req, ILogger log)
            {
                log.LogInformation("C# HTTP trigger function processed a request.");
                string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
                PostData data = JsonConvert.DeserializeObject<PostData>(requestBody);
                string url = $"https://www.google.com/maps/search/?api=1&query={data.Latitude},{data.Longitude}";
                log.LogInformation($"URL created - {url}");
                return new OkResult();
            }
        }
    }

 ```

## Run the Azure Functions locally

Functions can be run locally using a local storage account and local Azure Functions runtime. This local runtime allows you to test out your function before deploying it to Azure.

1. Right-click on the `ImHere.Functions` project in the solution explorer, and then select *Set as StartUp project*.

1. From the *Debug* menu, select *Start Without Debugging*. The local Azure Functions runtime will launch inside a console window and start your function, listening on an available port on `localhost`. If you see a dialog asking for firewall access, allow access to private networks (the default option).

    :::image type="content" source="../media/5-function-running-locally.png" alt-text="The Azure Functions running locally.":::

1. Take a note of the port that the function is listening on. You'll need this in the next unit to test out the mobile app. In the image above, the function is listening on port **7071**.

    ```bash
    Listening on http://localhost:7071/
    ```

1. Leave the function running so that you can test the mobile app in the next unit.

## Summary

In this unit, you learned how to create an Azure Functions project in Visual Studio, added a shared project with a data object to be shared between the mobile app and the function, and learned how to create a basic implementation of the function to deserialize the data passed in. You also learned how to run the Azure Functions locally. In the next unit, you'll call the Azure Functions from the mobile app.
