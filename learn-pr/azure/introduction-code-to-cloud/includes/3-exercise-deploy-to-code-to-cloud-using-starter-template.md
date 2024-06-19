In this exercise, you will deploy a To Do application (React web app), an Express API and a MongoDB hosted on Azure Cosmos DB using a starter template. Selecting this template creates a repository in your GitHub account and deploys the sample application to Azure.

1. Sign into the Azure portal by navigating to <https://portal.azure.com> and enter your credentials.
2. Enter **App Spaces** in the search box on the Navigation bar and select App Spaces. This ensures your sample is deployed on App Spaces for its deployment.
3. Select the ‘Static React Web App with Node.js API and Mongo DB’ template from the four options provided. We have four templates to deploy with Code to Cloud, select which one is most appropriate for your purpose and deploy with code-to-cloud.

    :::image type="content" source="../media/3-select-template.jpg" alt-text="Screenshot showing the Static React Web App with Node.js API and MongoDB template as the selected option.":::

Next, you are taken to a deployment page.

### Connect to GitHub to import your repository

Code to cloud will connect to the sample app in a GitHub repository and set up CI/CD pipelines as well. For this step, you need to allow Azure to connect your GitHub and select the organization you want the sample app to be stored in.

### Continuing with the deployment

You’ve selected a sample app; next step is to connect to GitHub. You should see a deployment screen showing what account you’re logged in as.
> [!NOTE]
> If you’re not logged in, it will show a text saying “Connect to GitHub by authorizing Azure App Service Container Apps to access your GitHub Account”

_Select a GitHub organization where it says Organization:_ Select a GitHub organization.
Once you select a GitHub organization, the user interface presents a full form with values prefilled like so:
    :::image type="content" source="../media/3-connect-to-github.jpg" alt-text="Screenshot showing the option to connect to your GitHub account.":::

If you want to, you can change any of the above prefilled values to suit your needs, if you want to change for example region, name of app, GitHub info etc.

### Deploy the app

Select the blue “Deploy” button in the left bottom corner to deploy the app.

Azure portal displays status messages indicating that it’s creating GitHub repository and allocating cloud resources. At this point, you see an overview page where Azure is deploying the various cloud resources that make out your deployed app.
    :::image type="content" source="../media/3-app-spaces-workflow-azure.jpg" alt-text="Screenshot showing the provisioning of Azure resources in progress.":::

After a few minutes, all resources required for the application are created and deployed.

Once successfully deployed, you see a green check mark on your App Space Overview labeled **Succeeded**
    :::image type="content" source="../media/3-app-space-succeeded.jpg" alt-text="Screenshot showing the provisioning of Azure resources succeeded.":::

Congratulations on deploying your first Code-to-Cloud. We are excited to see how you use this new tool.

### Check your work

At this point, you’ve deployed the app. Let’s ensure we know how to locate the various parts that have been deployed.

#### Navigate to the app

To open the To Do App, take the following steps:

1. Locate the navigation bar under Components on the left and expand the Hosting category.
2. Select the app service (Named web-service)
3. Select the "Browse” option to see the app.

A To Do Web Application – A web app that allows you to add a list, add an item into a list and complete an item.

:::image type="content" source="../media/3-todo-web-app.jpg" alt-text="Screenshot showing a deployed to-do sample application where you can manage tasks in a list.":::

#### Inspect the endpoint

To look at the API endpoint, and inspect the results:

1. Expand the Hosting category, found in the Components section on the left side.
2. Select the API service (Named api-service).
3. Select the "Browse” option to be taken to the endpoint.

    :::image type="content" source="../media/3-todo-api-browse.jpg" alt-text="Screenshot showing the deployed App Space with the option to Browse being highlighted.":::

    You can inspect your API with the OpenAPI interface (formerly known as Swagger) depicted in below image:

    :::image type="content" source="../media/3-todo-api.png" alt-text="Screenshot showing the deployed API on OpenAPI Swagger listing all available endpoints.":::

#### More details

To see more information on a specific resource or to access advanced configuration options, with the component selected, click Go to advanced view.

:::image type="content" source="../media/3-todo-api-advanced-view.jpg" alt-text="Screenshot showing the deployed App Space with the option to go to advanced view being highlighted.":::

Congratulations, you’ve now deployed a sample to Code to Cloud. Now, let’s deploy from an existing GitHub repository.
