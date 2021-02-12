In this unit, you'll use the .NET CLI to compile and run a web app within the Cloud Shell's command shell. The app will be deployed to a public endpoint on Azure. Finally, you'll tour the running app to understand the UI experience it provides.

The .NET CLI:

* Offers the simplest way to create, compile, and run an ASP.NET Core web app.
* Is already installed in the Cloud Shell environment.
* Provides a consistent experience across Windows, Linux, and macOS.

## Run the Razor Pages project and explore its UI

### Compile and run the project

1. Run the following .NET CLI command in the command shell:

    ```dotnetcli
    dotnet run
    ```

    The preceding command:

    * Locates the project file at the current directory.
    * Retrieves and installs any required project dependencies for this project.
    * Compiles the project code.
    * Hosts the web app with ASP.NET Core's Kestrel web server at both `http://localhost:5000` and `https://localhost:5001`.

    This module uses the secure localhost URL beginning with `https`. You can't view the app's pages in a browser, since it isn't yet hosted on a public endpoint. You'll host the app on a public endpoint in a following step.

    A variation of the following output displays to indicate your app is running:

    ```console
    info: Microsoft.Hosting.Lifetime[0]
          Now listening on: https://localhost:5001
    info: Microsoft.Hosting.Lifetime[0]
          Now listening on: http://localhost:5000
    info: Microsoft.Hosting.Lifetime[0]
          Application started. Press Ctrl+C to shut down.
    info: Microsoft.Hosting.Lifetime[0]
          Hosting environment: Development
    info: Microsoft.Hosting.Lifetime[0]
          Content root path: /home/<user>/aspnet-learn/src/ContosoPets.Ui
    ```

1. Press <kbd>Ctrl+C</kbd> to stop the app.

If running this app on your own machine, you could direct a browser to `https://localhost:5001` to view the resulting page. To view the app, deploy it to a public endpoint hosted on Azure App Service.

### Deploy your app to Azure App Service

Run the following command in the command shell:

```azurecli
az webapp up
```

The preceding Azure CLI command this project to Azure App Service. Be patient, as the initial app deployment takes longer. A variation of the following output eventually displays:

```console
Starting zip deployment. This operation can take a while to complete ...
```

Once your project has been successfully hosted, a variation of the following output appears:

```console
You can launch the app at http://webapp<random instance ID number here>.azurewebsites.net
```

Now that your app is deployed, let's tour the unfinished app.

## Tour the app

1. Open the app in your browser by selecting the URL provided in the "**You can launch the app at...**" text.

1. Select the **:::no-loc text="Products Admin":::** link near the top of the page.

    The following page appears:

    :::image type="content" source="../media/4-run-razor-pages-project/products-admin.png" alt-text="The ASP.NET Core Razor Pages app's products administration page." border="true" lightbox="../media/4-run-razor-pages-project/products-admin.png":::

    This screenshot represents the rendered *:::no-loc text="Index.cshtml":::* Razor page located in the *:::no-loc text="Pages/Products":::* directory. The URL ends with *:::no-loc text="Products":::*. By convention, Razor Pages apps map page routes to the files within the *:::no-loc text="Pages":::* directory structure.

    This Razor page has requested a list of available products from the web API. Currently, you can only choose to read the current list of products and edit or delete an existing product.

You've verified you can successfully compile, run, and deploy the project. Let's modify it so the user can create new product entries that are validated and sent to the web API.
