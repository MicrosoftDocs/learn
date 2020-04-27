Now as the time has come for you to create an API for your shopping list app. But before you can publish your API with your web app to Azure Static Web Apps, you need to create your API.

## Azure Functions

One of the greatest benefits of Azure Static Web Apps is that it can host your web app and an API built with Azure Functions, together! your web app is globally distributed and your back-end won't require a full server to configure and maintain. This is the sweet spot for Azure Static Web Apps: you get the ease of publishing your app and API with minimal configuration and maintenance!

Azure Functions provides automatic scaling out and scaling in based on demand. This makes Azure Functions a great API partner for your shopping list web app that serves static assets.

### Your shopping list API

Your API will include HTTP GET, POST, PUT, and DELETE endpoints so you can fully manage your shopping list.

Your shopping list app lets people get, add, update, and delete items from their list. So it makes sense that your API will have endpoints matching these needs.

Here are the four endpoints that you'll create:

| Methods | Route endpoints |
| ------- | --------------- |
| GET     | `products`      |
| POST    | `products`      |
| PUT     | `products:id`   |
| DELETE  | `products/:id`  |

### Create an API for the web app

You'll need an Azure Functions project for your API, with your HTTP endpoints for your shopping list app. Your repository has an **api** branch that contains an Azure Functions project and HTTP endpoints for PUT, POST, and DELETE of your products.

You'll get and then extend the Azure Functions project, before connecting your API to your front-end web app.

## Next steps

Now you're ready to create your API and configure your HTTP endpoints for your shopping list app.
