To demonstrate shifting a Node.js Express API to Azure Functions, this learning module uses the [Refactor Node.js Express to Azure Functions](https://github.com/MicrosoftDocs/mslearn-module-shifting-nodejs-express-apis-to-serverless) sample project on GitHub. 

The following screenshot shows the Angular Vacation Wishlist app with a list of vacations.

![Screenshot of the Vacation Wish List sample application.](../media/vacation-wish-list-app.png)

The sample project repository has the following source code: 

* Frontend Angular app: `./src`
* Backend Express app: `./server`
    * Routes: `./server/routes`
    * In-memory data: `./server/services/data.ts`

The goal of the learning module is to shift the Express functionality to a serverless Azure Functions app. The frontend code remains the same. 