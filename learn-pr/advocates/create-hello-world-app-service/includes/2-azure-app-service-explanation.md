In this unit, we take a dive into Azure App Service and how it works when deploying web apps.

## What is Azure App Service?

Azure App Service is a fully managed platform for building, deploying, and scaling web apps. It supports multiple programming languages and frameworks and enables developers to focus on coding while Azure manages the infrastructure and scaling automatically.

Azure App Service offers built-in integration with popular development tools, continuous integration, and deployment capabilities, making it easier to create web and mobile applications with minimal setup.

### Key features of Azure App Service

- **Multiple Language Support**: Azure App Service supports a wide variety of programming languages and frameworks, including ASP.NET, Java, Python, Node.js, PHP, and Ruby. This flexibility enables developers to choose the best tools for their projects.

- **Built-in DevOps**: Azure App Service offers seamless integration with CI/CD pipelines using GitHub, Bitbucket, Azure DevOps, and other popular services. This support ensures continuous deployment and automated testing in your app's lifecycle.

- **Global Scaling**: Azure App Service enables developers to scale their applications globally with a few clicks. It offers automatic scaling based on demand, ensuring that your apps can handle traffic spikes without manual intervention.

- **Security and Compliance**: With App Service, applications are automatically secured by TLS/SSL, providing secure connections. The platform also complies with various industry standards such as ISO, SOC, and PCI DSS, which are crucial for sensitive applications.

### Parts of your deployment to App Service

When deploying a Java application to Azure App Service, there are three levels of resources you work with to ensure that your application is organized, scalable, and easy to manage. These levels - resource groups, app service plans, and web apps - act like nested containers, each serving a unique role in the deployment process:

- **Resource Group**: Think of a resource group as a "container" or "bucket" that holds all the related resources for a project. When deploying an application, you create a resource group to keep everything organized. This way, you can manage resources collectively and delete everything in the resource group at once if you no longer need them.

- **App Service Plan**: The app service plan is the "bucket" where the application's compute resources - like memory, CPU, and scale options - are defined. It determines the pricing tier and performance capacity for your app. Think of it as setting up the infrastructure that runs your app.

- **Web App**: The web app is the environment where your Java application runs. It connects the app's code to the compute resources specified in the app service plan. When you deploy a Java application, you're essentially putting it into this "bucket" so that it can be accessed online.

:::image type="content" source="../media/azure-structure-chart.png" alt-text="Diagram of the Azure deployment hierarchy with resources inside a resource group, which is inside a subscription, which is inside an account.":::

In the upcoming units, you create and deploy your own resource group, App Service plan, and then finally an Azure App Service instance to host your web app.
