Now the time has come for you to create an API for your shopping list app, but first you need to create API app.

## Azure Functions

One of the greatest benefits of Azure Static Web Apps is that it hosts your web app and an API built with Azure Functions together! Azure Static Web Apps geographically distributes your web app's static assets and hosts your API in Azure Functions. With this setup, you gain the availability and speed that comes with global distribution of your web app assets. 

What you don't get is also important.

You don't need a full server for your front-end or back-end to configure and maintain. This is the sweet spot for Azure Static Web Apps: you get the ease of publishing your app and API with minimal configuration and maintenance.

Azure Functions serves your route endpoints, doesn't require a full back-end server to configure or maintain, and provides automatic scaling out and scaling in based on demand. This makes Azure Functions a great API partner for your shopping list web app that serves static assets.

Azure Static Web Apps generates a unique URL for your site, which you can find on the _Overview_ tab in the portal. The API is available through this same URL by appending _/api_ to the URL.

### Your shopping list API


Your shopping list app lets people get, add, update, and delete items from their list. So it makes sense that your API will have endpoints matching these needs.

Here are the four endpoints that you'll create:

| Methods | Route endpoints | Full API endpoint  |
| ------- | --------------- | ------------------ |
| GET     | `products`      | `api/products`     |
| POST    | `products`      | `api/products`     |
| PUT     | `products/:id`  | `api/products/:id` |
| DELETE  | `products/:id`  | `api/products/:id` |

Notice that you HTTP GET requests will route to _api/products_. The _api_ prefix is reserved for your API endpoints in the app. You can define any other routes to fit the needs of your site, but _api_ always points to the Azure Functions app.

### Create an API for the web app

So far you've been using a front-end framework. Soon you'll add an API and connect it to your front-end app. Your repository has an _api-starter_ folder that contains an incomplete Azure Functions project and HTTP endpoints for PUT, POST, and DELETE of your products.
The API is missing the HTTP GET function. You'll complete the Azure Functions project's API and add the missing function. Then, you'll connect your API to your front-end web app.

### Previewing changes to your web app

Before making changes to an app, it's good practice to create a new branch for the changes. You'll be making several changes when you complete the API for your app, so you'll create a branch for these changes.

After you make the changes you'll want to see them running before deciding to merge the changes. Once you create a pull request from your new branch to the **master** branch, the GitHub Action will build your app and API and deploy them both to a preview URL. This allows you to leave your web app running with Azure Static Web Apps, but also see a second preview URL with the results from your pull request.

## Next steps

Now you're ready to create your API and configure your HTTP endpoints for your shopping list app.
