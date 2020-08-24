Your shopping list web app needs an API. In this exercise, you'll build and run your API using an Azure Functions project. From there, you'll extend the API with a new function using the Azure Functions extension for Visual Studio Code.

In this exercise, you'll complete the following steps:

1. Create a branch as you prepare to make changes to your web app
1. Explore the Azure Function project
1. Create the HTTP GET function
1. Replace the function starter code with logic to get products
1. Configure the web app to proxy HTTP requests to the API
1. Run the API and the web app

## Get the Function app

Now, you'll add an API and connect it to your front-end app. The _Api_ project includes an incomplete Azure Functions project. You'll complete that now.

### Create an api branch

Before making changes to an app, it's good practice to create a new branch for the changes. You're about to complete the API for your app, so now is a good time to create a branch.

1. In Visual Studio, navigate to the **Git** menu and click _New Branch_.
1. Type **api** for the new branch name and press <kbd>Enter</kbd>

You just created the **api** git branch.

### Complete the Azure Functions API

The **Api** project contains your Azure Functions project, along with three functions.

| Class                 | Method | Route          |
| --------------------- | ------ | -------------- |
| _ProductsPost_        | POST   | `products`     |
| _ProductsPut_         | PUT    | `products/:id` |
| _ProductsDelete_      | DELETE | `products/:id` |

Your API has routes for manipulating the products for the shopping list, but it lacks a route for getting the products. You'll add that next.

## Create the HTTP GET function

1. In Visual Studio, right click on the **Api** project and choose _Add -> New Azure Function_
1. Enter **ProductsGet** as the name of the function
1. Use **Http trigger** as the function type
1. Select **Anonymous** as the authentication level

:::image type="content" source="../media/new-azure-function.png" alt-text="Creating a new Azure Function":::

You just extended your Azure Function app with a function to get your products!

### Configure the HTTP Method and route endpoint

Notice the folder `Run` method of the newly created C# class has a `HttpTrigger` attribute on the first argument, the `HttpRequest`. This attribute is used to define the access level of the Function, as well as the HTTP method(s) to listen for and the route endpoint.

The route endpoint will be `null` by default, meaning that the endpoint will use the value of the `FunctionName` attribute, which is `ProductsGet`. However, you want the endpoint to be **products**, which you can do by setting the `HttpTrigger`'s `Route` property to `"products"`.

Now your function is triggered on an HTTP `GET` request to **products**. Your `Run` method should look like the following code:

```csharp
[FunctionName("ProductsGet")]
public static async Task<IActionResult> Run(
    [HttpTrigger(AuthorizationLevel.Function, "get", Route = "products")] HttpRequest req,
    ILogger log)
```

### Update the route logic

The body of the `Run` method is what will be executed when the Function is executed.

You'll need to update the logic to get your products. There is data access logic in the `ProductData.cs` file as a class called `ProductData`, which is available via Dependency Injection as the `IProductData` interface. The interface has a method on it called `GetProducts` which will return a `Task<IEnumerable<Product>>` that asynchronously returns a list of products.

Now, change the function endpoint to return the products:

1. Open _ProductsGet.cs_
1. Replace its contents with the following code:

```csharp
public class ProductsGet
{
    private readonly IProductData productData;

    public ProductsGet(IProductData productData)
    {
        this.productData = productData;
    }

    [FunctionName("ProductsGet")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "products")] HttpRequest req,
        ILogger log)
    {
        var products = await productData.GetProducts();
        return new OkObjectResult(products);
    }
}
```

You have now turned the class from a static to an instance class, added the interface to the constructor so it can be injected by the Dependency Injection framework and configured the Function to return the product list when called.

### Configure CORS locally

You won't have to worry about CORS when you publish to Azure Static Web Apps. Azure Static Web Apps automatically configures your app so it can communicate with your API on Azure using a reverse proxy. But when running locally, you need to configure CORS to allow your web app and API to communicate.

Now, tell Azure Functions to allow your web app to make HTTP requests to the API, on your computer.

1. Create a file named _local.settings.json_ in the **Api** project
1. Add the following contents to the file

   ```json
   {
     "Host": {
       "CORS": "https://localhost:44382/"
     }
   }
   ```

> [!NOTE]
> The _local.settings.json_ file is listed in the _.gitignore_ file, which prevents this file from being pushed to GitHub. This is because you could store secrets in this file you would not want that in GitHub. This is why you had to create the file when you created your repo from the template.

### Run the API and web app

Now it's time to watch your web app and Azure Functions project work together. Start by running your Azure Functions project locally by following these steps:

> [!NOTE]
> Please be sure to install the [Azure Functions for Visual Studio](https://docs.microsoft.com/azure/azure-functions/functions-develop-vs) support is installed.

1. In Visual Studio, right-click on the _ShopAtHome_ solution
1. Select **Set Startup Projects**
1. Choose the _Multiple startup projects_ option and set _Api_ and _Client_ to have **Start** as their _Action_ then click _Ok_
1. Press <kbd>F5</kbd> to launch the debugger

### Browse to your app

It's time to see your application running locally against the Azure Functions API.

Browse to `https://localhost:44382/`.

You built your application and now it's running locally making HTTP GET requests to your API.

Now stop your running app and API by disconnecting the debugger in Visual Studio.

## Next steps

Your app works locally and your next step is to publish the app with the API together.
