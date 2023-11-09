As a developer, moving your code to deployment often includes managing your frontend, backend, APIs, databases etcetera separately. When building a complex system, having to independently manage all these components can be daunting and time consuming.

### Code to Cloud

Code to Cloud is an intelligent Azure service, for developers that reduces the complexity of creating and managing web applications. Code to Cloud suggests the Azure services to use based on what code, and frameworks and libraries it detects from your GitHub repository. With one click, you can provision a Code-to-Cloud deployment pipeline, allowing you to focus on developing brilliant applications and not worrying about deploying them to the right resources on Microsoft Cloud.

:::image type="content" source="../media/2-app-space-intro.gif" alt-text="GIF showing Code to Cloud/ App Space service on Azure.":::

### Addressing the problem, adopting “Code to Cloud” service

To address the problem that the lead engineer at the travel company would face while deploying all micro-services as individual components, we introduce Code to Cloud, a new service by Microsoft. Code to Cloud can help you easily deploy and manage all these microservices by reducing the complexity of your deployment process. Code to Cloud is a deployment option that analyses your code base and detects the right services for you. Alongside the core Azure Service, deploying with Code to Cloud also provisions tools for monitoring and scaling your applications to deliver a smooth experience for your user base as it grows.

### How does it work?

When deploying to a Code to Cloud instance, you can select one of two approaches, see Figure below:

1.  **Use existing code**, connect to your codebase on GitHub (Bring your own repository), if you already have existing code you want to use.

1. **Sample application**, if you are a developer just getting started with no repository yet, we have sample applications (templates), that create a starter repository in your GitHub account and deploy it to the appropriate Azure services.

    :::image type="content" source="../media/2-code-to-cloud-options.jpg" alt-text="Screenshot showing App Space deployment options.":::

Thereafter, you connect it to Azure and can select how it will be deployed on Azure. Your choices are to deploy it using App Services, Azure Container Apps or Azure Static Apps. Each choice comes with their own benefits, so select the deployment approach that fits your needs.

### Code to Cloud benefits

As a developer, you no longer have to worry about decisions on what cloud services will be required for your projects.

The benefits to using Code to Cloud for your project are:

- **Saves set up and deployment time**, Code to Cloud handles deployment pipeline for you by relying on GitHub actions to deploy.
- **Simplified management**, Code to Cloud shows a consolidated view of your application making it easier to have a great overview on all the parts.

#### Saves setup and deployment time

Code to Cloud allows you to focus on development (writing your code) by offering a simplified deployment process comprising the following steps:

1. Identify code to deploy. Select a GitHub repository, select your organization, repository and branch and connect it to Code to Cloud.
2. Configure Code to Cloud: Configure what services will be used to deploy your app.
Define deployment details. Code to cloud immediately recommends deployment services for your code, but still gives you an option to change selected services if you would wish to, based on your needs and preferences.
3. Assign Azure destination: Select a subscription and region for the deployment.

Without being an expert on hundreds of different Azure services, Code to Cloud gives you an app-first approach for your development and reduces your deployment time to minutes.

Once you deploy, Code to Cloud uses GitHub Actions to configure a deployment pipeline so that next time you push changes to your applications, they will immediately be pushed to your Azure Services.

#### Simplified management

Code to Cloud offers a consolidated view to manage your applications, Fig 3 below.

1. The Components menu holds a list of cloud services provisioned.

2. The Overview section holds high level information on the app space with links to browse to the deployed resources or access advanced configuration options.

3. The Deployment section with deployment information, GitHub actions with all steps of the workflows.

    :::image type="content" source="../media/2-app-spaces-management.jpg" alt-text="Screenshot showing a simplified and consolidated view to manage your App Space resources.":::
