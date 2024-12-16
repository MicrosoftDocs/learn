The team has a plan and is ready to begin implementing their release pipeline. Your Azure DevOps project is set up, and your Azure App Service instances are ready to receive build artifacts.

At this point, remember that the team's pipeline has only two stages. The first stage produces the build artifact. The second stage deploys the *Space Game* web app to App Service. Here, you follow along with Andy and Mara as they modify the pipeline. They're going to deploy to the App Service environment that corresponds to the *Dev* stage.

The *Dev* stage resembles the deployment stage that you made in the [Create a release pipeline in Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true) module. There, you used a CI trigger to start the build process. Here you do the same.

## Fetch the branch from GitHub

Here, you fetch the `release` branch from GitHub. You also check out, or switch to, the branch.

This branch serves as your *release* branch. It contains the *Space Game* project used in previous modules. It also contains an Azure Pipelines configuration to start with.

To fetch and switch to the branch:

1. In Visual Studio Code, open the integrated terminal.
1. To fetch a branch named `release` from the Microsoft repository, and to switch to that branch, run the following `git` commands.

    ```bash
    git fetch upstream release
    git checkout -B release upstream/release
    ```

    The format of these commands enables you to get starter code from the Microsoft GitHub repository, known as `upstream`. Shortly, you're going to push this branch up to your GitHub repository, known as `origin`.

1. As an optional step, from Visual Studio Code, open *azure-pipelines.yml*. Familiarize yourself with the initial configuration.

    The configuration resembles the basic one that you created in the [Create a release pipeline with Azure Pipelines](/training/modules/create-release-pipeline?azure-portal=true) module. It builds only the app's release configuration. For learning purposes, this configuration doesn't run the quality or security checks that you set up in previous modules.

    [!include[](../../shared/includes/pipeline-branches-note.md)]

## Promote changes to the Dev stage

Here, you modify your pipeline configuration to promote the build to the *Dev* stage.

1. In Visual Studio Code, modify *azure-pipelines.yml*.

    [!code-yml[](code/4-azure-pipelines.yml?highlight=6,69,72-77,95)]

    This configuration resembles the one that you built in the previous module. There, you and the team built a proof of concept for continuous deployment. But note these differences, which are highlighted in the preceding code example:

    - This configuration defines variables at the beginning of the file. The variables are used throughout the pipeline. They define which configuration to build (`Release`). They also define the name of your release branch (`release`).
    - The **Deploy** stage from the proof of concept is now named **Dev**.
    - The **Dev** stage uses a condition that directs the system to run the stage only when the previous stage succeeds and the current branch is `release`. This setup ensures that release features are deployed only to the *Dev* environment.
    - The deployment step uses the `WebAppNameDev` variable to deploy to the App Service instance associated with the *Dev* environment.

    > [!NOTE]
    > In practice, you might deploy from some other branch, such as `main`. You can include logic that allows changes to be promoted to the *Dev* stage from multiple branches, such as `release` and `main`.

1. From the integrated terminal, add *azure-pipelines.yml* to the index. Commit the change, and push it up to GitHub.

    > [!TIP]
    > Before you run these Git commands, save *azure-pipelines.yml*.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Deploy to the Dev stage"
    git push origin release
    ```

1. In Azure Pipelines, go to the build. As it runs, trace the build.
1. After the build finishes, to return to the summary page, select the back button.

    :::image type="content" source="../media/4-pipeline-dev-stage-summary.png" alt-text="A screenshot of Azure Pipelines showing the completed stages.":::

    You see that the deployment finished successfully.
1. From a web browser, go to the URL associated with the App Service instance for your *Dev* environment.

    If you still have the browser tab open, refresh the page. If you don't remember the URL, find it in the Azure portal, on the **App Service details** page.

    You see that the *Space Game* website is deployed to App Service, and is running.

    :::image type="content" source="../media/4-app-service-dev.png" alt-text="A screenshot of a web browser showing the Space Game web site in the Dev environment.":::

1. As an optional step, in Azure Pipelines, select **Environments**. Then, select the **dev** environment.

    Azure Pipelines records your deployment history. In the history, you can trace the environment's changes back to code commits and work items.

    :::image type="content" source="../media/4-environment-dev.png" alt-text="A screenshot of Azure Pipelines showing the deployment history. The history shows one successful deployment.":::
