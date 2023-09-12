MEAN is a development stack for building and hosting web applications. Recall that MEAN is an acronym for its component parts: MongoDB, Express, AngularJS, and Node.js.

In this module, you learned when the MEAN stack is a good choice for web development and when you might want to choose something else. The main reason you might consider MEAN is if you're familiar with JavaScript.

To see the MEAN stack in action, you created an Ubuntu virtual machine on Azure and installed the MEAN stack on it for web development.

With your MEAN stack in place, you created a basic book inventory web application. To summarize, the web application uses:

* **MongoDB** to store information about books.
* **Express.js** to route each HTTP request to the appropriate handler.
* **AngularJS** to connect the user interface with the program's business logic.
* **Node.js** to host the server-side application.

You can [find the source code for the web application](https://github.com/MicrosoftDocs/mslearn-build-a-web-app-with-mean-on-a-linux-vm?azure-portal=true) on GitHub.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Learn more

In this module, you got a sense of how the MEAN stack works and brought up a basic web application that uses it. The next step is to start building applications that solve your own business challenges. You can then deploy your applications to Azure and use automated processes to monitor your applications and make them better. Here are some resources where you can learn more.

### Learn more about MEAN stack application development

Learn more about the MEAN stack components and other Node.js packages you used in this module.

* [MongoDB](https://www.mongodb.com?azure-portal=true)
* [Express.js](https://expressjs.com?azure-portal=true)
* [AngularJS](https://angularjs.org?azure-portal=true)
* [Node.js](https://nodejs.org?azure-portal=true)
* [npm](https://www.npmjs.com?azure-portal=true)
* [Mongoose](https://www.npmjs.com/package/mongoose?azure-portal=true)
* [body-parser](https://www.npmjs.com/package/body-parser?azure-portal=true)

### Learn about the Azure Web Apps service

In this module, you used a VM to host your web application. A VM gives you more control over the environment and might best fit how you currently manage your deployments. However, there are other ways to host web applications. Check out [Create a Node.js web app in Azure](/azure/app-service/app-service-web-get-started-nodejs?azure-portal=true) to learn how to use the Azure Web Apps service to simplify your deployments.

### Automate your deployments

Also in this module, you used a mainly manual process to configure your VM and run your app. As your process matures, you can use a more automated process to deploy changes more quickly and more reliably. Check out [Create a CI/CD pipeline for Node.js with the Azure DevOps Project](/azure/devops-project/azure-devops-project-nodejs?azure-portal=true) to learn how to use Azure DevOps to deploy your Node.js application as part of a continuous integration and continuous delivery (CI/CD) pipeline.
