Your web app doesn't have an API at this point. Instead, your app is using mock data. Mock data is a great strategy that lets you develop a web app before an API exists. But now the time has come for you to create an API for your shopping list.

## Azure Functions

Your shopping list app needs to make HTTP requests to an API. So far your web app isn't using traditional servers. Rather it's serving the static file assets for HTML, CSS, and JavaScript. Now you must consider if your API will use traditional servers or a Serverless architecture with Azure Functions.

Azure Functions provides automatic scaling out and scaling in based on demand. This makes Azure Functions a great API partner for a web app that serves static assets.

Your shopping list app will pair with an Azure Functions project to host the shopping list API.

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

## Next steps

Thinking ahead, you'll need to create an Azure Functions project for your API. This will enable you to set up your HTTP endpoints for your shopping list app.
