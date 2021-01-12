There's a client-side route **/products** in your front-end application that displays a list of products for your shopping list. When you navigate to **/products** in your app by clicking the **Products** link, your browser's address bar will confirm that you're at **/products**. When you refresh the browser while on this page, you want the app to refresh and display the products once again. However, without a fallback route, you'll see a 404 error stating the page cannot be found.

You see a 404 error when you refresh the page because the browser sends a request to the hosting platform to serve **/products**. There's no page on the server named **products** to serve.

Fortunately, it's easy to resolve this by creating a fallback route. A fallback route is a route that matches all unmatched page requests to the server.

## Configure a fallback route

Azure Static Web Apps supports custom routing rules defined in an optional _routes.json_ file located in the app's artifact folder. You can define a route in the **routes** array. A common fallback route configuration is shown below:

```json
{
  "routes": [
    {
      "route": "/*",
      "serve": "/index.html",
      "statusCode": 200
    }
  ]
}
```

| Setting    | Value         | Description                                                                 |
| ---------- | ------------- | --------------------------------------------------------------------------- |
| route      | `/*`          | The matching rule. The **/\*** is a wildcard route that matches all routes. |
| serve      | `/index.html` | The page to serve.                                                          |
| statusCode | 200           | The status code to return.                                                  |

Routing rules run in the order they appear in the _routes.json_ file's routes array. The fallback route must be listed last in your routing rules, because it catches all routes that aren't caught by the rules that are listed before it.

## Route file location

Azure Static Web Apps expects your _routes.json_ file to be in the `output_location` by default. If your build process copies your _routes.json_ file to the `output_location`, then there is nothing else you need to do.

However, if you want to control where you put your _routes.json_ file, Azure Static Web Apps supports this too. Being explicit about the location of your _routes.json_ file is particularly important if your front-end framework build step doesn't move this file to the `output_location` by default.

You can customize the action that builds and deploys your app to look for the _routes.json_ in any folder in your repository. The `routes_location` property defines the directory location where the _routes.json_ file is found. This location is relative to the root of your repository.
