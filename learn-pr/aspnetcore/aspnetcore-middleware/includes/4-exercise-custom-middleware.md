Developers can create custom middleware components to add functionality to an ASP.NET Core app. Custom middleware can be inserted anywhere in the middleware pipeline and can be used with built-in middleware components, as seen in this example:

:::image type="content" source="../media/middleware-pipeline.svg" alt-text="A diagram showing the flow of a request through the pipeline.":::

Your company's network operations team is troubleshooting performance issues in the production environment. Your team lead tasked you to implement some features to better support real-time monitoring of the app. The app should log request details to the console. For each request, it should log the request method, path, and response status code.

In this exercise, you create a custom middleware component that logs request details to the console.

## Add custom middleware 

Let's modify the existing ASP.NET Core app to include custom middleware that logs request details to the console.

1. Open the *Program.cs* file if it's not open already.
1. Immediately before `app.Run()`, insert the following code:

    ```csharp
    app.Use(async (context, next) =>
    {
        Console.WriteLine($"{context.Request.Method} {context.Request.Path} {context.Response.StatusCode}");
        await next(); 
    });
    ```

    In the preceding code:

    - `app.Use()` adds a custom middleware component to the pipeline. The component takes a `HttpContext` object and a `RequestDelegate` object as parameters.
    - The delegate writes the request method, path, and response status code to the console.
    - `await next()` calls the next middleware component in the pipeline.

## Test the changes

1. Press **Ctrl+Shift+F5** to rebuild and restart the app.
1. When the browser window opens, note the root URL displays "Welcome to Contoso!"
1. Add `/history` to the URL and press **Enter**. The browser will redirect to the `/about` page.
1. In Visual Studio Code, press **Ctrl+Shift+P** to open the command palette. Search for and select **Debug Console: Focus on Debug Console View** to switch to the **Debug Console** tab in the bottom panel. Note the following lines:

    ```output
    GET / 200
    GET /about 200
    ```

    The console output shows the request method, path, and response status code for each request. The first line shows the request for the root URL, and the second line shows the request for the `/about` page.
    
    > [!NOTE]
    > Your browser might also request `/favicon.ico`. This is a standard request for a website's favicon and can be ignored.

1. Leave the app running for the next exercise.

## Change the order of middleware

The app seems to work, but there's a problem. You requested the `/history` page, but the console output doesn't show it. This behavior is because the custom middleware component that logs request details was added after the URL rewriter middleware. The URL rewriter middleware redirects requests from `/history` to `/about` and sends the response, and the custom middleware component doesn't see the request. Let's fix this.

1. Move the `app.Use()` line you added to immediately before the `app.UseRewriter()` line.

    The full *Program.cs* file should look like this:

    ```csharp
    using Microsoft.AspNetCore.Rewrite;
    
    var builder = WebApplication.CreateBuilder(args);
    var app = builder.Build();
    
    app.Use(async (context, next) =>
    {
        Console.WriteLine($"{context.Request.Method} {context.Request.Path} {context.Response.StatusCode}");
        await next(); 
    });
    
    app.UseRewriter(new RewriteOptions().AddRedirect("history", "about"));
    
    app.MapGet("/", () => "Hello World!");
    app.MapGet("/about", () => "Contoso was founded in 2000.");
    
    app.Run();
    ```

    Now the custom middleware component is added before the URL rewriter middleware. The custom middleware component logs the request details before the URL rewriter middleware processes the request and redirects it.

1. Restart the app again and test it as before. This time, the **Debug Console** output should include the request for the `/history` page.

    ```output
    GET / 200
    GET /history 200
    GET /about 200
    ```

    The console output now shows the request for the `/history` page right before it redirects to the `/about` page.

## Fix the status code

The app is almost ready, but there's one more issue. The status code in the console output is always 200, even when the app redirects the request. The status code for the `/history` request should be a 302 redirect. The reason for this behavior is another order issue in which the middleware components are processed.

The custom middleware component logs the details to the console, then calls `await next()` to pass to the next middleware component. The problem is, the `StatusCode` property of the `Response` object is set after the terminal middleware component starts the response. Let's change the code to fix this.

1. In the delegate you added, move the `Console.WriteLine()` line to after the `await next()` line.

    The updated code should look like this:

    ```csharp
    app.Use(async (context, next) =>
    {
        await next(); 
        Console.WriteLine($"{context.Request.Method} {context.Request.Path} {context.Response.StatusCode}");
    });
    ```

    Now the custom middleware component will log the request details after the terminal middleware component sets the response status code.

1. Restart and test the `/history` request again. The **Debug Console** output should now show the correct status code.

    ```output
    GET / 200
    GET /history 302
    GET /about 200
    ```


    
    