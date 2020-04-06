Your company is launching a vacation planning website that helps customers view, edit, add, and remove plans from their wish list. Your API, which powers these features, runs on Node.js and Express is critical to the success of the application

Your API server is critical to the success of the application. The APIs are hosted on a server running Node.js and Express. You need to launch your application and it must scale up and down as needed while minimizing costs. There is a lot for you to think about!

What if you could reduce some of these burdens without rewriting your entire API? By shifting the API to a serverless model using Azure Functions you enjoy the following benefits:

- No server to maintain
- Cost reductions
- Application scaling up and down as needed

Plus, you could write less code!

## Learning objective

In this tutorial, you move from an Express API to a serverless architecture through the following steps:

1. You'll begin by exploring and running the Node and Express APIs in the sample project
2. Next, you'll create an Azure Functions application
3. Then, you'll refactor the Express routes and data calls to use the Azure Functions application
4. Finally, you'll explore and launch your application, as shown below

![Vacation Wish List sample application](../media/vacation-wish-list-app.png)

## Planning the Shift to Serverless

Before you shift your Express.js APIs to the serverless model, consider why you might make these changes and what effort is required to update your app.

Your Express application requires a server, which you must configure, maintain, and scale. You'll have a cost associated with deploying your server, too. Serverless eases some of this effort and cost for you.

You'll import a series of middleware and write your logic to start your Express.js server. Azure Functions starts up with no additional code. What does this mean to you, in a concrete example? Well, when using Azure Functions the _server.ts_ file that you write in your Express application effectively goes away.

Why would you make this shift? Overall there's less to think about with serverless.

## About your project

The project represents a Node Express application in TypeScript that is shifted to Azure Functions.

> If your Express app is using JavaScript instead of TypeScript, create an Azure Functions app using JavaScript.

What's in the [sample project on GitHub](https://github.com/MicrosoftDocs/mslearn-module-shifting-nodejs-express-apis-to-serverless) that you'll learn about in this module? That's a great question!

The client application is developed with Angular, however you could easily have written it with Vue.js, React.js, or any of your favorite frameworks. In this module, you learn to create the Azure Functions app which you'll run and debug along side the Angular application locally on your computer. When you're done, you'll have refactored your application and its API with all the benefits of serverless technology!

Next, we'll get the sample application, install it's dependencies, and build it locally.
