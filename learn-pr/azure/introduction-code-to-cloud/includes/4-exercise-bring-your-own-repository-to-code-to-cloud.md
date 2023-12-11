If you have a GitHub repository and want to one click deploy, don’t worry, with code-to-cloud, you can connect to your repository, which will instantly analyze your code base, suggest Azure deployment resources and deploy your work.

In this exercise, you deploy a Shopping List from your GitHub account on a Code-to-Cloud instance.

### Create a repository

1. This step makes it easy for you to create a new repository by using a GitHub template, which contains a starter app built with different front-end frameworks (Angular, React, Svelte, Vue)

2. Go to the [create from template page](https://github.com/new?template_name=mslearn-staticwebapp&template_owner=MicrosoftDocs). If you get a 404: Page Not Found error, first, sign in to GitHub then try again.
:::image type="content" source="../media/4-create-repo.png" alt-text="Screenshot showing creating a new repository in your GitHub account.":::

a. Select your GitHub account from the Owner drop-down.

b. Give your repository a name

c. Click ‘Create repository’ to create a copy of the repository in your GitHub account.

### Create a Code to Cloud instance

1. Now, sign in to the Azure portal by navigating to <https://portal.azure.com> and enter your credentials.
2. Enter App Spaces in the search box on the Navigation bar, select **App Spaces.**
3. Click on ‘Start deploying’.

    :::image type="content" source="../media/4-start-deploying.jpg" alt-text="Screenshot showing the first option selected to deploy an App Space from a GitHub repository.":::

> [!NOTE]
> If you’re not logged in, it will show a text saying “Connect to GitHub by authorizing Azure App Service Container Apps to access your GitHub Account”

4. Now, select the GitHub Organization, Repository and Branch

    :::image type="content" source="../media/4-connect-to-github.jpg" alt-text="Screenshot showing GitHub configuration for a new repository.":::

5. After that, Code-to-Cloud will analyze the repository and will recommend a service to deploy your repository with.

    :::image type="content" source="../media/4-analyze-repo.jpg" alt-text="Screenshot showing an App Space analyzing your code to recommend the appropriate deployment resources.":::

6. This repository has multiple apps built using multiple frameworks as shown below: -

    :::image type="content" source="../media/4-frameworks.jpg" alt-text="Screenshot showing frontend framework options in the sample.":::

    Code to cloud detects one framework, and recommend deploying it to Static Web Apps. For this exercise, we proceed with the Angular app

    :::image type="content" source="../media/4-angular-detected.jpg" alt-text="Screenshot showing the default selection from App Space, which is a static web app.":::

    Code to Cloud also allows you to select another framework before deployment.

    :::image type="content" source="../media/4-select-framework.jpg" alt-text="Screenshot showing the option to choose another framework.":::

    If you want to change your application for Azure Static Web Apps, go to ‘Select another framework’ and change for the appropriate framework.

    :::image type="content" source="../media/4-all-frameworks.png" alt-text="Screenshot showing a list of available frameworks to choose from.":::

    By default, Code to Cloud recommended Static Web Apps, but you also have the flexibility to choose a different Azure deployment service for your app.

    :::image type="content" source="../media/4-choose-azure-service.jpg" alt-text="Screenshot showing the option to choose another deployment service.":::

    To change the desired Azure service, go to ‘Choose another Azure Service’ and select the most appropriate service.

    :::image type="content" source="../media/4-azure-options.png" alt-text="Screenshot showing a list of available deployment services to choose from.":::

    This repository selects the **Starter | starting Free, for Dev/ Test** pricing plan by default, but provides you with the option to compare plans and select a different plan.

    :::image type="content" source="../media/4-pricing.png" alt-text="Screenshot showing the option to select a pricing plan for your deployment.":::

7. For the Code to Cloud configuration, add the details below for your deployment instance:

    1. **App Space name:** You can leave the default name provided, or change as desired
    1. **App location:** By default, code to cloud points to the directory location of your app
    1. **API location:** This repository doesn’t have an api, so we  leave this blank. If your app has an api, point to the directory with your /api
    1. **Output Location:** By default, code to cloud points to the directory location of your build output folder

    :::image type="content" source="../media/4-app-space-config.png" alt-text="Screenshot showing app space configuration.":::

8. Select an Azure destination.
    1. **Subscription:** Select your Azure subscription
    1. **Azure Region:** Choose an Azure region. We recommend you choose a region closest to you for best app performance.

9. Review the details and click ‘Deploy’ in the lower left corner to Deploy your instance.

    :::image type="content" source="../media/4-app-space-deploy.jpg" alt-text="Screenshot showing the Deploy button for an App Space resource.":::

### Deploy the app

At this point, you see an overview page where Azure is deploying the various cloud resources that make out your deployed app. After a few minutes, all resources required for the application are created and deployed.

Once successfully deployed, you see a green check mark on your App Space Overview labeled **Succeeded**

:::image type="content" source="../media/4-app-space-deployed.jpg" alt-text="Screenshot showing an app space successfully deployed":::

Congratulations on deploying from your GitHub repository to Code-to-Cloud. We are excited to see how you use this new tool.

### Check your work

At this point, you’ve deployed the app. Let’s ensure we know how to locate the various parts that have been deployed.

#### Navigate to the app

To open the Shopping List App, take the following steps:

1. Locate the navigation bar under Components on the left and expand the Hosting category.
2. Select the app service (Named app-)
3. Select the "Browse” option to see the app.

The **My Shopping List Application** – A web app that lists sample shopping products and an about page.
:::image type="content" source="../media/4-my-shopping-list.png" alt-text="Screenshot showing My Shopping List sample Application.":::

To view your deployment workflow, click on Deployment, to see the Azure Static Web Apps workflow file.
:::image type="content" source="../media/4-view-deployment.jpg" alt-text="Screenshot showing a view deployment workflow on Azure.":::
Clicking the workflow file directs you to GitHub Actions and you can further inspect the workflow.

:::image type="content" source="../media/4-view-deployment-github.png" alt-text="Screenshot showing a view deployment workflow on GitHub.":::

Congratulations, you’ve now deployed your own GitHub repository to Code to Cloud. Now, let’s take a deeper look at how to manage your created resources.
