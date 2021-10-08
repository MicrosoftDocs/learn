[Azure App Service ](/azure/app-service/overview)is an HTTP-based service that lets you build and host web apps, background jobs, mobile backends, and RESTful APIs. App Service lets you use the programming language of your choice. Azure App Services offers automatic scaling and high availability. App Service enables automated deployments from GitHub, Azure DevOps, or any Git repo. 

:::image type="content" source="../media/select-azure-app-service.png" alt-text="Flowchart to select Azure App Services.":::


**Important**: Azure App Service is platform as a service (PaaS) environment. You focus on the website development and API logic. Azure handles the infrastructure to run and scale your web applications.

### Types of app services

With Azure App Service, all your apps share [common benefits](/azure/app-service/overview) including:

- Development in multiple languages and frameworks.

- Integrated deployment and management with secured endpoints.

- Global scale with high availability. 

- Built-in load balancing and traffic management. 

These benefits make App Service the ideal choice for any hosted web application.

### Azure App Service costs

You pay for the Azure compute resources your app uses while it processes requests. The cost is based on the [App Service plan](/azure/app-service/overview-hosting-plans) you choose. The App Service plan determines how much hardware is devoted to your host. For example, the plan determines whether it's dedicated or shared hardware and how much memory is reserved. You can have different app service plans for different apps. 

Your App Service plan can be scaled up and down at any time. For example, you can start testing your web app in a Free App Service plan and pay nothing. When you want to add your custom DNS name to the web app, just scale your plan up to the Shared tier.

### Use App Services deployment slots for continuous deployment

[Azure DevOps](/azure/devops/user-guide/what-is-azure-devops) provides developer services for support teams to plan work, collaborate on code development, and build and deploy applications. Whenever possible when continuously deploying your code, use [deployment slots](/azure/app-service/deploy-staging-slots) for a new production build. 

:::image type="content" source="../media/container-slots.png" alt-text="Container slots are used for development, staging, and production.":::


When using a Standard App Service Plan tier or better, you can deploy your app to a staging environment, validate your changes, and do smoke tests. When you’re ready, you can swap your staging and production slots. The swap operation warms up the necessary worker instances to match your production scale, thus eliminating downtime.

### Consider authentication and authorization options

Implementing a secure solution for authentication (signing-in users) and authorization (providing access to secure data) can take significant effort. Azure App Service provides [built-in authentication and authorization capabilities](/azure/app-service/overview-authentication-authorization) (sometimes referred to as "Easy Auth"). So, you can sign in users and access data by writing minimal or no code. Here are some benefits.

- Azure App Service provides built-in auth capabilities for your web app or API. You don’t need to implement the authentication yourself. 

- It’s built directly into the platform. You don’t need any language, SDK, security expertise, or even any code to utilize.

- You can integrate with multiple sign-in providers. For example, Azure AD, Facebook, Google, and Twitter.

> [!TIP]
> The built-in authentication features for App Service is the same for Azure Functions.

### When to use web apps

App Service supports web apps using ASP.NET, ASP.NET Core, Java, Ruby, Node.js, PHP, or Python. You can choose either Windows or Linux as the host operating system.

### When to use API apps

Much like hosting a website, you can build REST-based web APIs by using your choice of language and framework. You get full Swagger support and the ability to package and publish your API in Azure Marketplace. The produced apps can be consumed from any HTTP- or HTTPS-based client.

### When to use WebJobs

You can use the [WebJobs](/azure/app-service/webjobs-create) feature to run a program or script. Program examples include Java, PHP, Python, or Node.js. Script examples include cmd, bat, PowerShell, or Bash. WebJobs can be scheduled or run by a trigger. WebJobs are often used to run background tasks as part of your application logic.

### When to use Mobile apps

Use the Mobile Apps feature of App Service to quickly build a back end for iOS and Android apps. With just a few steps in the Azure portal, you can:

- Store mobile app data in a cloud-based SQL database.

- Authenticate customers against common social providers, such as MSA, Google, Twitter, and Facebook.

- Send push notifications.

- Execute custom back-end logic in C# or Node.js.

On the mobile app side, there's SDK support for native iOS and Android, Xamarin, and React native apps.
