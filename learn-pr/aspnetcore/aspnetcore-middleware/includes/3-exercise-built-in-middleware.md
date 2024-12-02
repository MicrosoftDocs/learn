ASP.NET Core includes a set of built-in middleware components that handle common tasks, such as routing, authentication, and HTTP logging. You can use these components to add functionality to your app without writing custom middleware.

Your team lead tasked you to create a barebones website for your company. The website should display a welcome message on the main page, and display a brief history of the company on a separate `/about` page. A previous version of the app had the company history at the `/history` URL, so you need to redirect requests from `/history` to `/about` to maintain compatibility with existing links.

You'll use the built-in `MapGet` method and `UrlRewriter` middleware to accomplish these tasks.

## Create an ASP.NET Core app

You need an ASP.NET Core app to play the role of your team's app. Let's create a new ASP.NET Core app using the C# Dev Kit extension in Visual Studio Code.

1. Launch Visual Studio Code.
1. Press **Ctrl+Shift+P** to open the command palette.
1. Search for and select **.NET: New Project...**.
1. Search for and select **ASP.NET Core Empty**.

    :::image type="content" source="../media/aspnet-core-empty.png" alt-text="A screenshot of the command palette with ASP.NET Core Empty selected."  lightbox="../media/aspnet-core-empty.png":::

1. Select or create a folder for the new project.
1. Name the new app *MyWebApp*.
1. Select **Create project** to create the project.
1. When the new project opens, expand the `Solution Explorer` pane to view the project files.

## Run the app

Test the app to make sure it runs.

1. In Visual Studio Code, press **F5** to build and run the app.
    1. When prompted, select **C#** as the debugger.
    1. When prompted, select **C#: MyWebApp [Default Configuration]** as the launch configuration to use. 

    This command starts the app and hosts it on a local web server. A browser window opens and displays, "Hello, World!"

1. Close the browser window and stop the app by pressing **Shift+F5** in Visual Studio Code.

## Map endpoints and add a URL rewriter 

Now that you have a working app, let's add a welcome message to the main page.

1. Open the *Program.cs* file.
1. On the `app.MapGet("/", () => "Hello World!");` line, change the "Hello World!" message to "Welcome to Contoso!"

    ```csharp
    app.MapGet("/", () => "Welcome to Contoso!");
    ```

    `app.MapGet()` maps an HTTP GET request to a specified path. This feature of ASP.NET Core is called **endpoint routing**. This code adds a branch to the pipeline. If the request path is `/`, the endpoint routing middleware routes the request to this endpoint, which then writes "Welcome to Contoso!" to the response.

1. On the next line, add the following code:

    ```csharp
    app.MapGet("/about", () => "Contoso was founded in 2000.");
    ```
    
    This code adds another endpoint. If the request path is `/about`, the endpoint writes "Our company was founded in 2000." to the response.

1. **Before** the first `app.MapGet()`, add the following code:

    ```csharp
    app.UseRewriter(new RewriteOptions().AddRedirect("history", "about"));
    ```

    This code adds a URL rewriter middleware component that redirects requests from `/history` to `/about`. The `AddRedirect()` method takes two parameters: a regular expression pattern to match the request path, and the replacement path to redirect to.


1. Add the following directive to the top of the file:

    ```csharp
    using Microsoft.AspNetCore.Rewrite;
    ```

    This directive resolves the reference to the `RewriteOptions` class.

## Test the changes

1. Save all your changes and run the app as before.
1. When the browser window opens, note the root URL displays "Welcome to Contoso!" Add `/about` to the URL and press **Enter**. The browser should display "Contoso was founded in 2000."
1. Replace `/about` with `/history` in the URL and press **Enter**. The browser should redirect to `/about`.
1. Leave the app running for the next exercise.
