Now let's explore how to add .NET Aspire to an existing ASP.NET Core web app. Along the way, you'll learn how to add the .NET Aspire stack to an existing ASP.NET Core web app and then run the app. You'll also see how to call microservices from the ASP.NET Core app.

## Set up your environment

To add .NET Aspire to an existing demo ASP.NET Core web app, you need to first obtain the existing app.

In a terminal window:

1. Set the current working directory to where you want to store your code.
1. Clone the repository into a new folder named *ExampleApp*:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-aspire-starter ExampleApp
    ```

## Explore the example app

Use Visual Studio to explore the demo app.

1. Open Visual Studio, then select **Open a project or solution**.
1. In the **Open Project/Solution** dialog, navigate to the *ExampleApp/eShopAdmin* folder, then select *EShopAdmin.sln*.
1. Select **Open**.

    :::image type="content" source="../media/explore-demo-app.png" alt-text="A screenshot of Visual Studio showing the three projects in the demo solution.":::

    The demo app is a .NET 8 solution with three projects:

    - **Data Entities**. A class library that defines the **Product** class used in the Web App and Web API.
    - **Products**. A Web API that returns a list of products in the catalog with their properties.
    - **Store**. A Blazor Web App displays these products to website visitors.

To successfully run the app, change the projects that start up:

1. From the menu, select **Project** > **Configure Startup Projects...**.
1. In the **Solution Property Pages** dialog, select **Multiple startup projects**.

    :::image type="content" source="../media/visual-studio-startup-projects.png" alt-text="A screenshot of the dialog to choose startup projects. Products and Store are set to Start." lightbox="../media/visual-studio-startup-projects.png":::

1. In the **Action** column, set **Products** and **Store** to *Start*.
1. Select **OK**.
1. Run the app by pressing <kbd>F5</kbd>, or by selecting **Start** in the toolbar.

    The app opens two instances of your default web browser. One shows the JSON output of the Web API, and the other shows the Blazor Web App.

1. In the web app, select **Products** from the menu. You should see this error.

    :::image type="content" source="../media/web-app-error.png" alt-text="A screenshot showing that the products can't be loaded." lightbox="../media/web-app-error.png":::

1. Stop the app by pressing <kbd>Shift</kbd>+<kbd>F5</kbd>, or select **Stop Debugging** in the toolbar.

This app is new to you. You're not sure how the endpoints and services are configured. Let's add .NET Aspire orchestration and see if it can help diagnose the problem.

## Enlist the existing app in .NET Aspire orchestration

In Visual Studio:

1. In **Solution Explorer**, right-click the **Store** project, then select **Add** > **.NET Aspire Orchestrator Support...**.

    :::image type="content" source="../media/orchestration-dialog.png" alt-text="A screenshot of the orchestration dialog in Visual Studio.":::

1. In the **Add .NET Aspire Orchestrator Support** dialog, select **OK**.

    Now you can see the **AppHost** and **ServiceDefaults** projects are added to the solution. The **AppHost** project is also set as the startup project.

1. Run the app by pressing <kbd>F5</kbd>, or by selecting **Start** in the toolbar.

    This time, the solution opens a single browser window showing the .NET Aspire dashboard.

    :::image type="content" source="../media/example-app-dashboard.png" alt-text="A screenshot of the .NET Aspire dashboard.":::

1. Select the endpoint for the **store** project, and then select **Products**. You should see the same error as before.

1. Return to the dashboard.

    :::image type="content" source="../media/dashboard-showing-error.png" alt-text="A screenshot showing an error notification on the store project.":::

1. Select the red error notification next to **Running**, and then in the **Details** column, select **View**.

    :::image type="content" source="../media/view-error-details.png" alt-text="A screenshot of the dashboard showing the error details." lightbox="../media/view-error-details.png":::

1. Scroll through the error details until you can see the **exception.message**. The Web app is struggling to connect to **localhost:5200**. Port 5200 is the port the front end thinks the products API is running on.

1. Stop the app by pressing <kbd>Shift</kbd>+<kbd>F5</kbd>, or select **Stop Debugging** in the toolbar.

## Update the orchestration to include the products API

There are many ways to resolve this issue. You could explore the code, work out how the front end is configured, edit the code, or change the **launchSettings.json** or **appsettings.json** files.

With .NET Aspire, you can change the orchestration so that the products API responds on port 5200.

In Visual Studio:

1. To add the *Products* project to the orchestration, in **Solution Explorer**, right-click the *Products* project, then select **Add** > **.NET Aspire Orchestrator Support...**.

    :::image type="content" source="../media/orchestrator-already-exists.png" alt-text="A screenshot of the Visual Studio dialog. A .NET Aspire orchestrator project already exists in the solution.":::

1. In the dialog, select **OK**.
1. In **Solution Explorer**, open the *AppHost* project, then open the *Program.cs* file.

    Explore the code and see how the **Products** project is added to the orchestration:

    ```csharp
    var builder = DistributedApplication.CreateBuilder(args);
    
    builder.AddProject<Projects.Store>("store");
    
    builder.AddProject<Projects.Products>("products");
    
    builder.Build().Run();
    ```

    Next configure .NET Aspire to add a new end point for the products API.

1. Replace the `builder.AddProject<Projects.Products>("products");` line with this code:

    ```csharp
    builder.AddProject<Projects.Products>("products")
           .WithHttpEndpoint(port: 5200, name: "products");
    ```

1. Run the app by pressing <kbd>F5</kbd>, or by selecting **Start** in the toolbar.

    The **products** project is now listed on the dashboard with two endpoints.

    :::image type="content" source="../media/updated-dashboard.png" alt-text="A screenshot of the dashboard showing the products and store projects." lightbox="../media/updated-dashboard.png":::

1. Select the endpoint for the **Store** project, and then select **Products**.

    The products are now displayed in the web app.

    :::image type="content" source="../media/web-app-products.png" alt-text="A screenshot showing the products in the web app." lightbox="../media/web-app-products.png":::

1. Stop the app by pressing <kbd>Shift</kbd>+<kbd>F5</kbd>, or select **Stop Debugging** in the toolbar.

This approach resolves the configuration issue, but it isn't the best way to fix the problem. If you decide to use .NET Aspire, you should also use .NET Aspire service discovery.

## Update the web app to use .NET Aspire service discovery

In Visual Studio:

1. In **Solution Explorer**, open the **AppHost** project, then open the *Program.cs* file.
1. Replace the code in the file with this code:

    ```csharp
    var builder = DistributedApplication.CreateBuilder(args);

    var products = builder.AddProject<Projects.Products>("products");
    
    builder.AddProject<Projects.Store>("store")
           .WithReference(products);
    
    builder.Build().Run();
    ```

    The above code reorders the projects. The products API is now passed as a project reference to the front end Store web app.

1. In **Solution Explorer**, open the **Store** project, then open the *appsettings.json* file.
1. Delete the endpoint configuration lines:

    ```json
    "ProductEndpoint": "http://localhost:5200",
    "ProductEndpointHttps": "https://localhost:5200"
    ```

    The settings are now:

    ```json
    {
      "DetailedErrors": true,
      "Logging": {
        "LogLevel": {
          "Default": "Information",
          "Microsoft.AspNetCore": "Warning"
        }
      },
      "AllowedHosts": "*"
    }
    ```

1. In **Solution Explorer**, under the **Store** project, open the *Program.cs* file.
1. Replace this line:

    ```csharp
    var url = builder.Configuration["ProductEndpoint"] 
	    ?? throw new InvalidOperationException("ProductEndpoint is not set");
    ```

    with this line:

    ```csharp
    var url = "http://products";
    ```

1. Run the app by pressing <kbd>F5</kbd>, or by selecting **Start** in the toolbar.

1. Select the endpoint for the **Store** project, then select **Products**.

The app is still working as expected, but the front end is now using .NET Aspire service discovery to get information about the products API endpoint.
