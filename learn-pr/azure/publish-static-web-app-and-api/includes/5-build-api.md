Motivation - You want a real API and you want fast and secure.

Your app is using mock data for its shopping list. Next, you'll explore the benefits and your motivation before creating an API.

- Your app is using mock data for its shopping list. You want to use an API to get and save your shopping list data. Next, you'll build an API. Your API will include HTTP GET, POST, PUT, and DELETE endpoints so you can fuly manage your shopping list.
- Serverless architecture is fast and cheap, we'll use Azure Functions to host the APIs

While the app is ready to run, you'll first step back what's in the project.

## Your shopping list API

Your shopping list app lets people get, add, update, and delete items from their list. So it makes sense that your API will have endpoints matching these needs.

Here are the four endpoints that you'll create:

| Methods | Route endpoints |
| ------- | --------------- |
| GET     | `products`      |
| POST    | `products`      |
| PUT     | `products:id`   |
| DELETE  | `products/:id`  |

## Next steps

Next, you'll run the application and test our HTTP endpoints.
