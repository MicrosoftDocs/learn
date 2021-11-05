You are a developer on a company, you and the company have heard all this hype about the new minimal API, is it better than sliced bread? Your manager has asked you to create a project for it so you can discuss whether to use it on your next project.

## Scaffold a project

First, you need to scaffold a project. You've installed .NET 6 and you are ready to go. 

1. Create a web API by running `dotnet new`:

   ```bash
   dotnet new web -o PizzaStore -f net6.0
   ```

   You should see a directory _PizzaStore_. Next, run the app. 

1. Run the app by calling `dotnet run`, it will build the app and host it on a port from 5000-5300, and HTTPS will have a port selected for it in the range 7000-7300.

   > [!NOTE]
   > if you want to override the random port selection behavior, you can set the ports to use in _launchSettings.json_.

   ```bash
   dotnet run
   ```

   Here's what the output can look like in the terminal:

   ```output
   Building...
    info: Microsoft.Hosting.Lifetime[14]
          Now listening on: https://localhost:7200
    info: Microsoft.Hosting.Lifetime[14]
          Now listening on: http://localhost:5100
    info: Microsoft.Hosting.Lifetime[0]
          Application started. Press Ctrl+C to shut down.
    info: Microsoft.Hosting.Lifetime[0]
          Hosting environment: Development
    info: Microsoft.Hosting.Lifetime[0]
          Content root path: /<path>/PizzaStore
   ```

1. In your browser, go to the indicated port according to the terminal `http://localhost:{PORT}`, you should see the text "Hello World!"

Congrats, you've managed to create an API using minimal API template.

## Add Swagger

Next, use Swagger to ensure that you have a self-documenting API, where the docs change when you change the code:

1. Install the Swashbuckle package:

    ```bash
    dotnet add package Swashbuckle.AspNetCore --version 6.1.4
    ```

    Verify the install by opening up _PizzaStore.csproj_, you should have an entry that looks like so:

    ```xml
    <PackageReference Include="Swashbuckle.AspNetCore" Version="6.1.4" />
    ```

   Next, configure your project to use Swagger. 

1. Open _Program.cs_ and add the following code (highlighted):

   :::code language="csharp" source="../code/create-minimal-api-add-swagger.cs" highlight="1, 5-9, 18-22":::

1. Rerun the project and go to the app's address, `http://localhost:5100/swagger`. 

   You should see the following output:

   :::image type="content" source="../media/swagger.png" alt-text="Screenshot of a Swagger UI for your API.":::
