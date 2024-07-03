Your application is set up to use Orleans and you defined the necessary grains. However, you still need to add web service endpoints for the user to interact with. In this step you create two endpoints:

- An endpoint to create and return a shortened URL to the user.
- An endpoint to redirect users to the full URL when they use the shortened URL.

## Create the endpoint that shortens URLs

You build the endpoint to create and return shortened URLs first. This method accepts the full URL the user would like to reach as a path segment, and then returns a shortened version for them to use in the future.

1. Below the existing "Hello World" `Get` endpoint, add the following code:

    ```csharp
    app.MapGet("/shorten",
        static async (IGrainFactory grains, HttpRequest request, string url) =>
    {
        return Results.Ok();
    });
    ```

    This method is marked as async to properly support the behavior of Orleans and injects the grain factory that was previously registered with the dependency injection container. Currently the method just returns an empty 200 OK, so you fix that next.

1. Update the body of the GET method you created to match the following code:

    ```csharp
    app.MapGet("/shorten",
        static async (IGrainFactory grains, HttpRequest request, string url) =>
        {
            var host = $"{request.Scheme}://{request.Host.Value}";
    
            // Validate the URL query string.
            if (string.IsNullOrWhiteSpace(url) &&
                Uri.IsWellFormedUriString(url, UriKind.Absolute) is false)
            {
                return Results.BadRequest($"""
                    The URL query string is required and needs to be well formed.
                    Consider, ${host}/shorten?url=https://www.microsoft.com.
                    """);
            }
    
            // Create a unique, short ID
            var shortenedRouteSegment = Guid.NewGuid().GetHashCode().ToString("X");
    
            // Create and persist a grain with the shortened ID and full URL
            var shortenerGrain =
                grains.GetGrain<IUrlShortenerGrain>(shortenedRouteSegment);
    
            await shortenerGrain.SetUrl(url);
    
            // Return the shortened URL for later use
            var resultBuilder = new UriBuilder(host)
            {
                Path = $"/go/{shortenedRouteSegment}"
            };
    
            return Results.Ok(resultBuilder.Uri);
        });
    ```

    The preceding code performs several tasks:

    - Ensures that the URL query string is well formed and not empty.
    - A unique, short ID is created using the `Guid` class.
    - The `IUrlShortenerGrain` is retrieved for the shortened route segment.
    - The full URL is stored in the grain.
    - The shortened URL is returned to the user on the `/go` route.

## Create the endpoint that handles redirects

Next you need to create the endpoint that will redirect shortened URLs to the full address.

1. Below the `shorten` endpoint, add another endpoint to handle redirecting the user. This endpoint expects the user to pass in the shortened route segment that was creating using the `shorten` method as a URL path parameter.

    ```csharp
    app.MapGet("/go/{shortenedRouteSegment:required}",
        static async (IGrainFactory grains, string shortenedRouteSegment) =>
        {
            // Retrieve the grain using the shortened ID and url to the original URL
            var shortenerGrain =
                grains.GetGrain<IUrlShortenerGrain>(shortenedRouteSegment);
    
            var url = await shortenerGrain.GetUrl();
    
            // Handles missing schemes, defaults to "http://".
            var redirectBuilder = new UriBuilder(url);
    
            return Results.Redirect(redirectBuilder.Uri.ToString());
        });
    ```

    This code performs the following tasks to handle the user's request.

    - The shortened route segment is used to retrieve the corresponding `IUrlShortenerGrain` instance.
    - The full URL is retrieved from the grain.
    - The full URL is used to redirect the user to the correct location.

## Test the app

The core functionality of the app should now work as expected, so now you can test your code.

1. Inside the Visual Studio Code terminal, run the `dotnet run` command again to launch the app.

    ```dotnetcli
    dotnet run
    ```

    The app should launch in the browser and display the familiar `Hello world!` text.

1. In the browser address bar, test the `shorten` endpoint by entering a URL path such as `{localhost}/shorten?url=microsoft.com`. The page should reload and provide a shortened URL. Copy the shortened URL to your clipboard.

1. Paste the shortened URL into the address bar and press enter. The page should reload and redirect you to *<https://microsoft.com>*.

The app is progressing nicely, but there's still room for improvement. In the next step, you'll explore how adding state persistence can improve the durability of your app.
