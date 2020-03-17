Consider the following scenario. Your company has a website that provides access to vacation planning to their customers. Your customers will view, edit, add, and remove their vacation plans from their wish list. All of the data requests use standard HTTP requests to your API server, running Node.js and Express. Your API server is critical to the success of the application.

Your company wants their application to go live, so you need to deploy it to a server, and soon. But have you considered everything you'll need? You'll need to maintain your application. You'll need to scale it up and down as needed. And you'll also need to budget for the cost. There is a lot for you to think about!

What if you could reduce some of these burdens without rewriting your entire API? You can shift the API to a serverless model using Azure Functions and gain many benefits for this scenario. You'll gain many benefits with serverless: no server to maintain, reduced cost, and your application will scale up and down when needed. Plus, you may write less code!

Your objective in this module is to refactor your Node.js and Express APIs from a server-based architecture to serverless APIs with Azure Functions.

## Learning objective

You'll start by exploring and running the Node and Express APIs in the sample project. Then you'll create an Azure Functions application followed by refactoring the Express routes and data calls to the Azure Functions application. Finally, you'll explore and launch your application, as shown below.

![Vacation Wish List sample application](../media/vacation-wish-list-app.png)

## Planning the Shift to Serverless

Before you shift your Express.js APIs to the serverless model, you should consider why you might consider shifting and what effort it takes for you to make the shift.

Your Express application requires a server, which you must configure, maintain, and scale. You'll have a cost associated with deploying your server, too. Serverless eases some of this effort and cost for you.

You'll import a series of middleware and write your logic to start your Express.js server. Azure Functions starts up with no additional code. What does this mean to you, in a concrete example? Well, when using Azure Functions the _server.ts_ file that you write in your Express application effectively goes away.

Why would you make this shift? Overall there's less to think about with serverless.

## About the Project You'll Build

The project represents a Node Express application in TypeScript that is shifted to Azure Functions.

What's in the [sample project on GitHub](https://github.com/MicrosoftDocs/mslearn-module-shifting-nodejs-express-apis-to-serverless) that you'll learn about in this module? That's a great question!

But what if you aren't using TypeScript? That's fine. If your Express app is using JavaScript, feel free to shift it to Azure Functions using JavaScript.

The client application is Angular. However you could easily have written it with Vue.js, React.js, or any of your favorite frameworks. You'll learn how to create the Azure Functions application in this module. You'll learn to run and debug them and your Angular application locally on your computer. And you'll have refactored your application and its API with all the benefits of serverless technology!
