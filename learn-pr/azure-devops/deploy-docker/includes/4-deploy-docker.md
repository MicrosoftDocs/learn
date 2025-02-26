Your project came with a release pipeline that builds the projects in the solution and deploys the web app to its App Service. Now, it's time to update that pipeline build and deploy the project as a container instead.

In this unit, you'll:

> [!div class="checklist"]
> * Define some pipeline variables to make the build pipeline easier to maintain.
> * Replace the existing **Build** tasks with a unified task to build and push a Docker container.
> * Replace the existing **Deploy** task with one that updates the App Service Web App with the new container image.
> * Save the pipeline to trigger a build and release.

## Define variables to be shared within the pipeline

Here, you'll add a new pipeline variable to your existing YAML pipeline defined in *azure-pipelines.yml*.

1. From Azure DevOps, navigate to **Pipelines**.
1. Select the pipeline.
1. Select **Edit**. Ensure that the branch is set to **main** by selecting it from the drop-down menu. This brings up your *azure-pipelines.yml* file.
1. Add the highlighted line below to add a pipeline variables named `webRepository` and `tag`. These will be used in multiple tasks to uniquely identify the specific version of the container being referenced. You can also remove the `buildConfiguration` variable; you won't need it anymore.

    [!code-yml[](code/4-1-azure-pipelines.yml?highlight=5-7)]

## Replace the build stage tasks

**Andy:** I don't think we need any of these build tasks anymore, because the Dockerfile in the project folder already defines the build we want. However, I haven't had the chance to see what we can use to build the image using a Dockerfile yet. Any ideas?

**Mara:** I was just looking that up. It seems like should be able to build the container and even push it to the repository with a single task. Let's add it now.

### Docker task

You can use the [Docker task](/azure/devops/pipelines/tasks/build/docker?azure-portal=true) to build and deploy Docker images. Replace the entire **Build** stage with the YAML snippet below.

* **command**: Specifies the Docker command to run.
* **buildContext**: Specifies the path to the build context.
* **repository**: Specifies the name of the repository.
* **dockerfile**: Specifies the path to the Dockerfile.
* **containerRegistry**: Specifies the name of the Docker registry service connection.
* **tags**: Specifies a list of tags on separate lines. These tags are used in build, push, and buildAndPush commands.

[!code-yml[](code/4-2-azure-pipelines.yml)]

## Replace the deploy stage task

**Andy:** Well, that seems pretty straightforward. Now all we need is to find a task that will instruct App Service to use the newly pushed version of the container image.

**Mara:** I'm already on it. It's a bit different from deploying a build to Azure Pipelines, but still direct enough that we can get the job done in one task. Let's add it now.

### Azure Web App for Container task

The [Azure Web App for Container task](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app-containers?azure-portal=true) is designed to deploy Docker containers to Azure App Service. Replace the entire **Deploy** stage with the YAML snippet below.

* **appName**: Specifies the name of an existing Azure App Service.
* **azureSubscription**: Specifies the name of the Azure Resource Manager subscription for the deployment.
* **imageName**: Specifies the fully qualified container image name; for example, `myregistry.azurecr.io/nginx:latest` or `python:3.7.2-alpine/`.

[!code-yml[](code/4-3-azure-pipelines.yml)]

## Save the pipeline to trigger a build and release

1. Select **Save** from the top-right corner of the page. Type your commit message and select **Save** to confirm.
1. Select **Run**, and make sure your branch is set to *main*. Select **Run** when you're done.
1. Select your pipeline to view the logs. After the build has succeeded, select the *AzureWebAppContainer* task and then select the *App Service Application URL* to view your deployed web app.

    :::image type="content" source="../media/4-deploy-url.png" alt-text="Screenshot of Azure Pipelines showing the location of the website URL.":::

1. You should see your web app running on App Service.

    :::image type="content" source="../media/4-space-game.png" alt-text="Screenshot of the Space Game website.":::

**Andy:** This turned out great! I think adopting containers could be a huge win for our team.
