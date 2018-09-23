At this point, the app is working to get the user's location and is ready to be sent to an Azure function. In this unit, you build the Azure function.

## Create an Azure Functions project

1. Add a new project to the `ImHere` solution by right-clicking on the solution and selecting *Add->New Project...*.

1. From the tree on the left-hand side, select *Visual C#->Cloud*, and then select *Azure Functions* from the panel in the center.

1. Name the project "ImHere.Functions", and then click **OK**.

    ![The Add New Project dialog](../media/5-add-new-functions-project.png)

1. The **New Project** configuration dialog will appear, and it may show a spinner in the bottom-left whilst loading updated templates. If you see this, wait until this has finished loading, then if updated templates are available, click the **Refresh** option that will appear to ensure you get the latest Function templates.

    ![The new project dialog loading the latest templates](../media/5-loading-templates.png)

1. In the **New Project** configuration dialog, ensure the Functions version is set to *Azure Functions v2 (.NET Standard)* (**NOT** _v1 (.NET Framework)_). Select *Http Trigger*, leave the storage account set to *Storage Emulator*, and set the access rights to *Anonymous*. Then click **OK**.

    ![The Azure Function project configuration dialog](../media/5-configure-trigger.png)

    The new project will be created and have a default function called `Function1`.

> [!NOTE]
> This function was created with anonymous access. Once published to Azure, anybody who knows the URL will be able to call this function. In a real-world scenario, you would protect this with some form of authentication, such as [Azure App Service authentication](https://docs.microsoft.com/azure/app-service/app-service-authentication-overview?azure-portal=true) or [Azure Active Directory B2C](https://docs.microsoft.com/azure/active-directory-b2c?azure-portal=true).

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

When data is sent to the Azure function, it will be sent as JSON. The mobile app will serialize data into JSON and the function will deserialize from JSON. To keep this data consistent between the mobile app and the function, create a new project that contains a class to hold the location and phone number data. This project will then be referenced by the app and function.

1. Create a new project under the `ImHere` solution by right-clicking on the solution and selecting *Add->New Project...*.

1. From the tree on the left-hand side, select *Visual C#->.NET Standard*, and then select *Class Library (.NET Standard)* from the panel in the center.

1. Name the project "ImHere.Data", and then click **OK**.

    ![The Add New Project dialog](../media/5-add-new-net-standard-project.png)

1. Delete the auto-generated "Class1.cs" file.

1. Create a new class in the `ImHere.Data` project called `PostData` by right-clicking on the project and then selecting *Add->Class...*. Name the new class "PostData" and click **OK**. Mark this new class as `public`.

1. Add `double` properties for the latitude and longitude, as well as a `string[]` property for the phone numbers to send to.

    ```cs
    public class PostData
    {
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string[] ToNumbers { get; set; }
    }
    ```

1. Add a reference to this project to both the `ImHere.Functions` and `ImHere` projects by right-clicking on the project and then selecting *Add->Reference...*. Select *Projects* from the tree on the left-hand side, and then check the box next to *ImHere.Data*.

    ![Configuring project references](../media/5-configure-project-references.png)

## Read the data sent to the function

In the Azure function, the `req` parameter contains the HTTP request that was made and the data inside this request will be a JSON serialized `PostData` object.

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
[FunctionName("SendLocation")]
public static async Task<IActionResult> Run([HttpTrigger(AuthorizationLevel.Anonymous,
                                                                "get", "post",
                                                         Route = null)]HttpRequest req,
                                                    ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");
    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    PostData data = JsonConvert.DeserializeObject<PostData>(requestBody);
    string url = $"https://www.google.com/maps/search/?api=1&query={data.Latitude},{data.Longitude}";
    log.LogInformation($"URL created - {url}");
    return new OkResult();
}
```

## Run the Azure function locally

Functions can be run locally using a local storage account and local Azure Functions runtime. This local runtime allows you to test out your function before deploying it to Azure.

1. Right-click on the `ImHere.Functions` project in the solution explorer, and then select *Set as StartUp project*.

1. From the *Debug* menu, select *Start Without Debugging*. The local Azure Functions runtime will launch inside a console window and start your function, listening on an available port on `localhost`. If you see a dialog asking for firewall access, allow access to private networks (the default option).

    ![The Azure function running locally](../media/5-function-running-locally.png)

1. Take a note of the port that the function is listening on. You'll need this in the next unit to test out the mobile app. In the image above, the function is listening on port **7071**.

    ```sh
    Listening on http://localhost:7071/
    ```

1. Leave the function running so that you can test the mobile app in the next unit.

## Summary

In this unit, you learned how to create an Azure Functions project in Visual Studio, added a shared project with a data object to be shared between the mobile app and the function, and learned how to create a basic implementation of the function to deserialize the data passed in. You also learned how to run an Azure function locally. In the next unit, you'll call the Azure function from the mobile app.