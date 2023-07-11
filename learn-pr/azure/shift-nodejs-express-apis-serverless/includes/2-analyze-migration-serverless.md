To use your current Express application and server, you must:

- Include the necessary middleware and logic to start the server.
- Configure and maintain the physical server.
- Manage scaling your app up and down as demand fluctuates.
- Manage the costs of deploying and running the server.

Serverless architecture handles server maintenance, scaling, and cost management for you. Often there's very little middleware and less code required. Overall, there's less to worry about when you build a serverless app. You can easily shift your Express.js API to the serverless model.

This learning module uses the [Refactor Node.js Express to Azure Functions](https://github.com/MicrosoftDocs/mslearn-module-shifting-nodejs-express-apis-to-serverless) project on GitHub, which builds a Node.js Express application in TypeScript.

![Screenshot of the Vacation Wish List sample application.](../media/vacation-wish-list-app.png)

This client application is developed with Angular, but the same process works with Vue.js, React.js, or any other frontend framework you choose. The goal is to shift the project APIs to an Azure Functions app and migrate the Express server to a serverless model. The finished application and its API feature all the benefits of serverless technology.
