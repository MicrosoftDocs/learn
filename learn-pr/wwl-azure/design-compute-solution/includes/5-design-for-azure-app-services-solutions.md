[Azure App Service](/azure/app-service/overview) is an HTTP-based service that lets you build and host web apps, background jobs, mobile backends, and RESTful APIs. You can use the programming language of your choice and build automated deployments from GitHub, Azure DevOps, or any Git repo. App Service offers automatic scaling and high availability.

### Things to know about Azure App Service

With Azure App Service, all your apps share [common benefits](/azure/app-service/overview). These benefits make App Service the ideal compute solution for any hosted web application to support new workloads and migrate data.  

:::image type="content" source="../media/select-azure-app-service.png" alt-text="Flowchart that shows the decision tree for selecting Azure App Service to build new workloads and to support lift and shift migrations." border="false":::

- Azure App Service is a platform as a service (PaaS) environment. You focus on the website development and API logic. Azure handles the infrastructure to run and scale your web apps.

- App Service supports development in multiple languages and frameworks, and offers integrated deployment and management with secured endpoints.

- App Service offers built-in load balancing and traffic management at global scale with high availability. 

- App Service provides [built-in authentication and authorization capabilities](/azure/app-service/overview-authentication-authorization) (sometimes referred to as _Easy Auth_). You can sign in users and access data by writing minimal or no code.

#### Continuous deployment

Azure App Service enables continuous deployment. [Azure DevOps](/azure/devops/user-guide/what-is-azure-devops) provides developer services for support teams to plan work, collaborate on code development, and build and deploy applications. Whenever possible when continuously deploying your code, use [deployment slots](/azure/app-service/deploy-staging-slots) for a new production build. 

:::image type="content" source="../media/container-slots.png" alt-text="Diagram that shows container slots for development, staging, primary, and production when using Azure App Service." border="false":::

When you choose a Standard App Service Plan tier or better, you can deploy your app to a staging environment, validate your changes, and do performance tests. When you're ready, you can swap your staging and production slots. The swap operation triggers the necessary worker instances to match your production scale.

#### Azure App Service costs

You pay for the Azure compute resources your app uses while it processes requests. The cost is based on the [Azure App Service plan](/azure/app-service/overview-hosting-plans) you choose. The App Service plan determines how much hardware is devoted to your host. The plan specifies whether you're using dedicated or shared hardware and how much memory is reserved. You can have different app service plans for different apps, and your plan can be scaled up and down at any time. 

### Things to consider when using Azure App Service

Let's look at some scenarios for using Azure App Service. As you review these options, think about how you can integrate Azure App Service in the Tailwind Traders infrastructure.

- **Consider web apps**. Create web apps with App Service by using ASP.NET, ASP.NET Core, Java, Ruby, Node.js, PHP, or Python. You can choose either Windows or Linux as the host operating system.

- **Consider API apps**. Build API apps similar to REST-based web APIs with your choice of language and framework. Azure App Service offers full Swagger support, and the ability to package and publish your API in Azure Marketplace. The apps can be consumed from any HTTP or HTTPS client.

- **Consider WebJobs**. Use the App Service [WebJobs](/azure/app-service/webjobs-create) feature to run a program or script. Program examples include Java, PHP, Python, or Node.js. Script examples include cmd, bat, PowerShell, or Bash. WebJobs can be scheduled or run by a trigger. WebJobs are often used to run background tasks as part of your application logic.

- **Consider Mobile apps**. Exercise the Mobile Apps feature of Azure App Service to quickly build a backend for iOS and Android apps. On the mobile app side, App Service provides SDK support for native iOS and Android, Xamarin, and React native apps. With just a few steps in the Azure portal, you can:
   - Store mobile app data in a cloud-based SQL database.
   - Authenticate customers against common social providers, such as MSA, Google, Twitter, and Facebook.
   - Send push notifications.
   - Execute custom back-end logic in C# or Node.js.

- **Consider continuous deployment**. Choose the Standard App Service Plan tier or better to enable continuous deployment of your code. Deploy your app to a staging slot and validate your app with test runs. When the app is ready for release, swap your staging and production slots. The swap operation warms up the necessary worker instances to match your production scale, which eliminates downtime.

- **Consider authentication and authorization**. Take advantage of the built-in authentication capabilities in Azure App Service. You don't need any language, SDK, security expertise, or even any code to use the functionality in your web app or API. You can integrate with multiple sign-in providers, such as Microsoft Entra ID, Facebook, Google, and Twitter. Azure Functions offers the same built-in authentication features that are available in App Service.

- **Consider multiple plans to reduce costs**. Configure different Azure App Service plans for different apps. Scale your plan up and down at any time. Start testing your web app in a Free App Service plan and pay nothing. When you want to add your custom DNS name to the web app, just scale your plan up to the Shared tier.
