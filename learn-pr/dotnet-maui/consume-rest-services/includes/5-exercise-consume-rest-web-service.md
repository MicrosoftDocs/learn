As part of the app that engineers use on customer site-visits, you need to add a feature that enables an engineer to look up the details of electrical components. This information will be held in a database and accessed through a REST web service. You've also been asked to provide an interface that enables an administrator to create, remove, and modify the details of parts held in the database using the same REST web service.

In this exercise, you'll deploy the REST web service to Azure, and then verify that you can access it using a web browser. Then you'll add functionality to an existing app that uses the REST web service to retrieve, add, delete, and update the details of electrical components.

You'll perform this exercise using the Azure sandbox.

[!INCLUDE[OS-specific keyboard shortcuts](../../../includes/azure-cloudshell-copy-paste-tip.md)]

## Deploy the Parts REST web service

1. In the Cloud Shell window, run the following command to clone the repo containing the code for this exercise, including the Parts REST web service:

    > [!NOTE]
    > All of the git repositories will be updated once they are able to be put into the office samples repo closer to the launch date of .NET MAUI.
    >

    ```bash
    git clone https://github.com/JohnPWSharp/maui-modules
    ```

1. Move to the **maui-modules/Consume-REST-services** folder:

    ```bash
    cd maui-modules/Consume-REST-services
    ```

1. Run the command shown to deploy the Parts web service using the Azure Cloud Shell sandbox. This command makes the service available through a unique URL. Make a note of this URL when it's displayed. You'll configure the app to connect to the web service using this URL.

    ```bash
    bash initenvironment.sh
    ```

## Examine the code for the web service

> [!NOTE]
> You'll perform the remainder of this exercise on your local development computer.

1. On your desktop computer, open a command prompt window and clone the repository for this exercise. The code is in the [net-maui-learn-consume-rest-services](https://github.com/ADD-REPO-URL-HERE) repository.

    ```bash
    git clone https://github.com/JohnPWSharp/maui-modules
    ```

1. Move to the **webservice\PartsServer** folder in your clone of the repository, and open the **PartsServer.sln** solution using Visual Studio. This solution contains a copy of the code for the web service that you deployed to Azure in the previous procedure.

1. In the Solution Explorer window, expand the **Models** folder. This folder contains two files:

    - **Part.cs**. The **Part** class represents a part as provided by the REST web service. The fields include the part ID, part name, part type, the availability date (when the part was first supplied), and a list of suppliers. The **Href** property returns the relative URI of the part; a REST client can use this URI to reference this specific part in the REST web service. The **Suppliers** property returns the list of suppliers of the part as a string.

    - **PartsFactory.cs**. The **PartsFactory** class initializes the list of parts provided by the service, using a small set of hard-coded values. In the real world, this data would be retrieved from a database.

1. In the Solution Explorer window, expand the **Controllers** folder. This folder contains the following files:

    - **PartsController.cs**. The **PartsController** class implements the web API for the service. It includes methods that enable a client application to retrieve a list of all parts (**Get**), find the details of a specific part given the part ID (the overloaded version of **Get**), update the details of a part (**Put**), add a new part to the list (**Post**), and remove a part from the list (**Delete**).

    - **LoginController.cs**. The **LoginController** class implements a simple form of authentication for the web service. An app must send an HTTP **GET** request to this controller, which returns an authorization token. This authorization token is used to authenticate the requests sent to the **PartsController**.

    - **BaseController.cs**. The **BaseController** class contains the logic used to authenticate requests. The **PartsController** class inherits from this class. If the client attempts to call methods in the **PartsController** class without providing a valid authentication token, the methods return an HTTP 401 (unauthorized) response.

## Examine the code for the .NET MAUI client app

1. In Visual Studio, close the **PartsServer** solution, and open the **PartsClient** solution under the **exercise1\start\PartsClient** folder in the cloned repository. This solution contains a partial implementation of a .NET MAUI client app that uses the **PartsServer** web service.

1. In the Solution Explorer window, expand the **Data** folder for the **PartsClient** project. This folder contains the code for two classes:

    - **PartsManager.cs**. The **PartsManager** class provides the methods that the client app uses to interact with the REST web service. This class is currently incomplete; you'll add the necessary code during this exercise. When complete, the **GetClient** method connects to the REST web service. The **GetAll** method returns a list of parts from the REST web service. The **Add** method adds a new part to the list of parts managed by the REST web service. The **Update** method modified the details of a part stored by the REST web service, and the **Delete** method removes a part.

    - **Part.cs**. The **Part** class models a part stored in the database. It exposes properties that an application can use to access the **PartID**, **PartName**, **PartAvailableDate**, **PartType**, and **PartSuppliers** fields. The class also provides a utility method named **SupplierString** that an application can use to retrieve a formatted string containing the supplier names.

1. In the Solution Explorer window, expand the **Pages** folder for the **PartsClient** project. This folder contains the markup and code for two MAUI forms:

    - **PartsPage.xaml**. This page uses a **CollectionView** layout with a **DataTemplate** to display the details of the parts available as a list. The **DataTemplate** uses data binding to connect the data displayed to the parts retrieved from the web service. The user can also use this page to update the details of a part and save the changes, and to delete a part. The logic to retrieve, update, and delete parts is contained in the code-behind file for this page.

    - **AddPartPage.xaml**. This page enables the user to enter and save the details for a new part. The user can specify the part name, part type, and an initial supplier. The part ID and part available date are generated automatically. Again, the logic that creates the new part and sends the appropriate HTTP request is contained in the code-behind file for this page.

1. In the Solution Explorer window, open the **AppShell.xaml** file. This file contains the markup for the main page of the application. This page displays a tab bar with tabs for the PartsPage and AddPartsPage. The user can select a tab to display either if the two pages.

1. In the Solution Explorer window, expand the **ViewModels** folder for the **PartsClient** project. This folder contains a class named **PartsViewModel**. The PartsPage and AddPartPage forms use this viewmodel to abstract the connection to the web service. This is good practice, and enables the application to utilize a different data source in the future without impacting the UI logic in the pages. The **PartsViewModel** invokes the methods in the **PartsManager** class to send and receive web service requests and responses.

## Sign in to the service

The REST service requires you to sign in first to get an authorization token. There's no user authentication. You call a specific endpoint first to get an authorization token. Then you send the token back to the server on each subsequent request in the HTTP header.

1. Open the **PartsManager.cs** file in the **Data** folder.

1. Add **BaseAddress** and **Url** static fields as defined in the following code snippet to the **PartsManager** class. Replace the text **URL GOES HERE** with the URL of the REST web service that you noted earlier:

    ```csharp
    public class PartsManager
    {
        static readonly string BaseAddress = "URL GOES HERE";
        static readonly string Url = $"{BaseAddress}/api/parts/";
        ...
    ```

1. Add the following field to the class, after the **Url** field. This field will hold the authorization token returned when the user signs in:

    ```csharp
    private string authorizationKey;
    ```

1. Find the **GetClient** method. This method currently throws a **NotImplementedException** exception. Replace the existing code in this method with the following code. This code creates an **HttpClient** object, and then sends a request to the **login** endpoint of the REST web service. The service should respond with a message that contains the authorization token. Deserialize this token, and add it as a default Authorization request header for subsequent requests sent using the **HttpClient** object:

    ```csharp
    private async Task<HttpClient> GetClient()
    {
        HttpClient client = new HttpClient();
        if (string.IsNullOrEmpty(authorizationKey))
        {
            authorizationKey = await client.GetStringAsync($"{Url}login");
            authorizationKey = JsonConvert.DeserializeObject<string>(authorizationKey);
        }
    
        client.DefaultRequestHeaders.Add("Authorization", authorizationKey);
        client.DefaultRequestHeaders.Add("Accept", "application/json");
        return client;
    }
    ```

## Perform a GET operation to retrieve information for parts

1. In the **PartsManager.cs** file, find the **GetAll** method. This is an asynchronous method that returns an enumerable list of parts. This method isn't yet implemented.

1. In this method, replace the code that throws the **NotImplementedException** exception. Call the **GetClient** method to retrieve an **HttpClient** object to work with. Remember that **GetClient** is asynchronous, so use the **await** operator to capture the object returned by this method.

1. Call the **GetStringAsync** method of the **HttpClient** object and provide the base URL to retrieve an array of parts from the REST web service. The data is returned asynchronously as a JSON string.

1. Deserialize the JSON string returned by this method into a list of **Part** objects using the **JsonSerializer.Deserialize** method. Set the serializer options to be case insensitive. Return this list to the caller.

    The completed method should look like this:

    ```csharp
    public async Task<IEnumerable<Part>> GetAll()
    {
        HttpClient client = await GetClient();
        string result = await client.GetStringAsync(Url);
        JsonSerializerOptions options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
        return JsonSerializer.Deserialize<List<Part>>(result, options);
    }
    ```

1. Build and run the app using an Android emulator or an iOS simulator. When the app starts, the List Parts tab should be displayed and a list of parts retrieved by the **GetAll** method should appear. You can scroll up and down through the list. The following image shows the app running on Android:

    :::image type="content" source="../media/5-browse-data.png" alt-text="A screenshot of the Parts Client app running on Android. The LIST PARTS tab is displayed the parts retrieved from the web service.":::

1. When you have finished browsing the data, close the app and return to Visual Studio.

## Perform a POST operation to add a new part to the database

1. In the **PartManager** class, locate the **Add** method. This method has parameters for the part name, a supplier, and the part type. The method is asynchronous. The purpose of this method is to insert a new part into the database, and return a **Part** object representing the newly created item.

1. In the method, replace the existing code and create a new **Part** object. Populate the fields with the passed-in data:

    - Set the **PartID** field to an empty string. This ID will be generated by the REST web service.
    - Create a new **List** to hold the name of the supplier.
    - Set the **PartAvailableDate** field to **DateTime.Now**.
    - Get an HTTP client from the **GetClient** method.

1. Call the **GetClient** method to retrieve an **HttpClient** object to work with.
1
1. Use the **PostAsync** method of the HTTP client to send the request to the REST web service. Specify the base URL of the REST web service to add the part:

    - Turn the **Part** object into a JSON string by using the **JsonSerializer.Serialize** method. Create a new **StringContent** object that contains the part as JSON. Use the **StringContent** constructor, which also takes an encoding and media type. The encoding is **Encoding.UTF8**. The media type is **application/json**.

    - Capture the response from the **POST** request. The response message contains a JSON string that represents the new part. Deserialize it as a **Part**** object and return this object from the method.

    ```csharp
    public async Task<Part> Add(string partName, string supplier, string partType)
    {
        Part part = new Part()
        {
            PartName = partName,
            Suppliers = new List<string>(new[] { supplier }),
            PartID = string.Empty,
            PartType = partType,
            PartAvailableDate = DateTime.Now.Date
        };

        HttpClient client = await GetClient();
        var response = await client.PostAsync(Url,
            new StringContent(
                JsonSerializer.Serialize(part),
                Encoding.UTF8, "application/json"));

        JsonSerializerOptions options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
        var insertedPart = JsonSerializer.Deserialize<Part>(
            await response.Content.ReadAsStringAsync(), options);
        Console.WriteLine($"{insertedPart.PartID}, {insertedPart.PartName}, {insertedPart.PartType}");
        return insertedPart;
    }
    ```

1. Build and run the app using an Android emulator or an iOS simulator. Select the ADD NEW PART tab and enter a name, type, and supplier to create a new part. Swipe right from the left edge of the panel showing the details for the new part and select **Save Changes**. This action invokes the **Add** method in the **PartsManager** class, which creates the new part in the web service. If the operation is successful, you should see an alert appear with the message **Changes Saved**:

    :::image type="content" source="../media/5-add-data.png" alt-text="A screenshot of the Parts Client app running on Android. The ADD NEW PART tab is displayed. The user has provided the details for a new part to be added through the web service.":::

    > [!NOTE]
    > If you select **Save Changes** more than once, the page will create multiple new parts with the same values that you have entered, but with different part IDs. If you do this accidentally, you will be able to delete the duplicate parts from the **LIST PARTS** tab once you have implemented the delete functionality later in this exercise.
    >
    > You can select the **Clear** command to remove the details displayed by the **ADD NEW PART** page if you want to enter the details for a new part. If you need to amend an existing part, you'll be able to edit the part on the LIST PARTS page after you have completed the next task in this exercise.

1. Close the alert, and select the **LIST PARTS** tab.

1. Scroll to the end of the list and verify that the new part appears. The data for the **Part ID** and **Available** fields are generated when the new part was saved:

    :::image type="content" source="../media/5-data-added.png" alt-text="A screenshot of the Parts Client app running on Android. The LIST PARTS tab is displayed. The new part is highlighted.":::

1. When you have finished browsing the data, close the app and return to Visual Studio.

## Perform a PUT operation to update the details for a part in the database

1. In the **PartsManager** class, find the **Update** method. This is an asynchronous method that takes a **Part** object as the parameter. The method doesn't have an explicit return value. However, the return type is **Task** so that exceptions are properly returned back to the caller. The caller can use the `await` operator to pause the progress of the method until the asynchronous method is finished.

1. In the method, perform the following operations:

    a. Get an HTTP client from the **GetClient** method.
    
    b. Use the **PutAsync** method of the HTTP client to send a JSON-encoded to the REST web service.
        - Serialize the **Part** to a JSON string by using the **JsonSerializer.Serialize** method. Include the encoding and content type as you did before.
        - The URL to which the request should be sent is the base address of the REST web service with the **PartID** field of the **Part** object appended.

    ```csharp
    public async Task Update(Part part)
    {
        HttpClient client = await GetClient();
        await client.PutAsync($"{Url}/{part.PartID}",
            new StringContent(
                JsonSerializer.Serialize(part),
                Encoding.UTF8, "application/json"));
    }
    ```

1. Build and run the app using an Android emulator or an iOS simulator. On the **LIST PARTS** tab, place the cursor in the **PART ID**, **Part Name**, **Part Type**, or **Available** field for any part and modify the value.

    > [!NOTE]
    > The **Suppliers** field contains a list and is read-only in this version of the app.

1. Swipe right from the left edge of the panel showing the details for the edited part and select **Save Changes**. This action calls the **Update** method in the **PartsManager** class to send the changes to the web service. Verify that the message **Changes Saved** appears in an alert:

    :::image type="content" source="../media/5-edit-data.png" alt-text="A screenshot of the Parts Client app running on Android. The LIST PARTS tab is displayed. The user has modified the details for a part and has selected the **Save Changes** command.":::

    > [!NOTE]
    > The part you added in the previous task will not appear on the **LIST PARTS** page. The data used by the app is reset to a list of predefined parts each tome the app runs. This is to provide consistency for testing the app.
    >
    > Don't select the **Delete** command yet. You haven't added the code for this command, and it currently throws a **NotImplementedException**.

1. Experiment with the app:

    - Make any changes you want to other parts and save them.
    - Add a new part, and then use the **LIST PARTS** page to modify the part.

1. When you have finished, close the app and return to Visual Studio.

## Perform a DELETE operation to remove the details for a part from the database

1. In the **PartManager** class, find the **Delete** method. This is an asynchronous method that takes a **Part** object and returns a **Task**.

1. In the method body:

    a. Get an HTTP client from the **GetClient** method.

    b. Call the **DeleteAsync** method of the HTTP client object. The URL to which the request should be sent is the base address of the REST web service with the **PartID** field of the **Part** object appended.

    ```csharp
    public async Task Delete(Part part)
    {
        HttpClient client = await GetClient();
        await client.DeleteAsync($"{Url}/{partID}");
    }
    ```

1. Build and run the app using an Android emulator or an iOS simulator.

1. On the **LIST PARTS** tab, swipe right from the left edge of the panel showing the details for the ant part and select **Delete**. This action runs the **Delete** method in the **PartsManager** class to remove the part from the web service. A **Delete Part?** alert should appear confirming that you actually want to remove the part. Select **Yes** to delete the part, and verify that it disappears from the list of parts.

1. Experiment with the app:

    - Add a new part.
    - Use the **LIST PARTS** page to remove the new part.

1. When you've finished, close the app and return to Visual Studio.
