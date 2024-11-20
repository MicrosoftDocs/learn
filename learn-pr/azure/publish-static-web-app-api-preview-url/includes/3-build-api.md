Now it's time for you to create an API for your shopping list app.

## Azure Functions

One of the greatest benefits of Azure Static Web Apps is that it hosts your web app and an API built with Azure Functions together. Azure Static Web Apps globally distributes your web app's static assets and hosts your API in Azure Functions. With this setup, you gain the availability and speed that comes with global distribution of your web app assets.

What you don't get is also important.

You don't need a full server for your front-end or back-end to configure and maintain. With Azure Static Web Apps, you hit the sweet spot: you get the ease of publishing your app and API with minimal configuration and maintenance.

Azure Functions serves your route endpoints, doesn't require a full back-end server to configure or maintain, and provides automatic scaling out and scaling in based on demand. These features make Azure Functions a great API partner for your shopping list web app that serves static assets.

Azure Static Web Apps generates a unique URL for your site, which you can find on the *Overview* tab in the portal. The API is available through this same URL by appending */api* to the URL.

### Your shopping list API

Your shopping list app lets people get, add, update, and delete items from their list. So it makes sense that your API should have endpoints matching these needs.

Here are the four endpoints that you create:

| Methods | Route endpoints | Full API endpoint  |
| ------- | --------------- | ------------------ |
| GET     | `products`      | `api/products`     |
| POST    | `products`      | `api/products`     |
| PUT     | `products/:id`  | `api/products/:id` |
| DELETE  | `products/:id`  | `api/products/:id` |

Notice that your HTTP GET requests route to `api/products`. The *api* prefix is reserved for your API endpoints in the app. You can define any other routes to fit the needs of your site, but *api* always points to the Azure Functions app.

### Create an API for the web app

So far you've been using a front-end framework. Soon you can add an API and connect it to your front-end app. Your repository has an `api-starter` folder that contains an incomplete Azure Functions project and HTTP endpoints for PUT, POST, and DELETE of your products.
The API is missing the HTTP GET function. Complete the Azure Functions project's API and add the missing function. Then, connect your API to your front-end web app.

### Previewing changes to your web app

Before making changes to an app, it's good practice to create a new branch for the changes. Since you're making several changes to complete the API for your app, you should create a branch for these changes.

After you make the changes, you'll want to see them running before deciding to merge the changes. Once you create a pull request from your new branch to the **main** branch, the GitHub Action builds your app and API, and deploys them to a preview URL. This feature allows you to leave your web app running with Azure Static Web Apps, but also see a second preview instance with the results from your pull request.

### Communicating between your web app and API

When you run your API locally with Azure Functions, it runs on port 7071 by default. Your web app runs on a different local port. When your web app tries to make an HTTP request from its port to your API's port 7071, the request is called Cross-Origin Resource Sharing (CORS). Your browser prevents the HTTP request from completing unless the API server allows the request to proceed.

When you publish to Azure Static Web Apps, you don't have to worry about CORS. Azure Static Web Apps automatically configures your app so it can communicate with your API on Azure using a reverse proxy. A reverse proxy is what allows your web app and API to appear to come from the same web domain. So you only have to set up CORS when you run locally.

## Next steps

Now you're ready to create your API and configure your HTTP endpoints for your shopping list app.
