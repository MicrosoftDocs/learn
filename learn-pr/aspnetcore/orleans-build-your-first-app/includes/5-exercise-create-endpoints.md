Your application is set up to use Orleans and you've defined the necessary grains. However, you still need to add web service endpoints for the user to interact with. In this step you'll create two endpoints:

- An endpoint to create and return a shortened URL to the user.
- An endpoint to redirect users to the full URL when they use the shortened URL.

## Create the endpoint to shorten URLs

You'll build the endpoint to create and return shortened URLs first. This method accepts the full URL the user would like to reach as a path segment, and then returns a shortened version for them to use in the future.

1) Below the existing "Hello World" `Get` endpoint, add the following code:

    ```csharp
    app.MapGet("/shorten/{*path}", async (HttpContext context, string path) =>
    {
        return Results.Ok();
    });
    ```

    This method is also marked as async to properly support the behavior of Orleans. Currently the method just returns an empty 200 OK, so you'll fix that next.

1) Update the body of the GET method you created to match the following code:

    ```csharp
    app.MapGet("/shorten/{*path}", async (HttpContext context, string path) =>
    {
        var shortenedRouteSegment = Guid.NewGuid().GetHashCode().ToString("X");
        var shortenerGrain = grainFactory.GetGrain<IUrlShortenerGrain>(shortenedRouteSegment);
        await shortenerGrain.SetUrl(shortenedRouteSegment, path);
        var resultBuilder = new UriBuilder(context.Request.GetEncodedUrl())
        {
            Path = $"/go/{shortenedRouteSegment}"
        };
    
        return Results.Ok(resultBuilder.Uri);
    });
    ```
    
    The code above performs several tasks:
    * First, a GUID is used to create a random shortened route segment from its hashcode as a hexadecimal string.
    * The shortened route segment is then used as an identifier by the grain factory to create a new grain.
    * The grain instance stores the shortened route segment and the original target URL so that it can be retrieved later.
    * Finally, a new URL with the shortened route segment is assembled and returned to the user.
    
## Create the endpoint to handle redirects

Next you need to create the endpoint that will redirect shortened URLs to the full address.

1) Below the `shorten` endpoint, add another endpoint to handle redirecting the user. This endpoint expects the user to pass in the shortened route segment that was creating using the `shorten` method as a URL path parameter.

    ```csharp
    app.MapGet("/go/{shortenedRouteSegment}", async (string shortenedRouteSegment) =>
    {
        var shortenerGrain = grainFactory.GetGrain<IUrlShortenerGrain>(shortenedRouteSegment);
        var url = await shortenerGrain.GetUrl();
    
        return url is not null ? Results.Redirect(url) : Results.NotFound();
    });
    ```

    This code performs the following tasks to handle the user's request.

    * The grain that holds the redirect information for the provided alias is pulled from the grain factory using the alias as a key.
    * The full URL string is retrieved from the grain.
    * If an appropriate URL was found, the user is redirected to that address, otherwise a 404 is returned.

## Testing the app

The core functionality of the app should now work as expected, so now you can test your code.

1) Inside the Visual Studio Code terminal, run the `dotnet run` command again to launch the app.

    ```dotnetcli
    dotnet run
    ```

    The app should launch in the browser and display the familiar `Hello world!` text.

2) In the browser address bar, test the `shorten` endpoint by entering a URL path such as `{localhost}/shorten/https://microsoft.com`. The page should reload and provide a shortened URL. Copy the shortened URL to your clipboard.

3) Paste the shortened URL into the address bar and press enter. The page should reload and redirect you to *https://microsoft.com*. 

The app is progressing nicely, but there's still room for improvement. In the next step, you'll explore how adding state persistence can improve the durability of your app.
