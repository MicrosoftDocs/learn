The team has a plan and is ready to begin implementing their release management workflow. You have an Azure DevOps project set up and Azure App Service instances that are ready to receive build artifacts.

At this point, the team's pipeline has two stages. The first stage produces the build artifact and the second stage deploys the _Space Game_ web application to App Service. Here, you follow along with Andy and Mara as they modify the pipeline to deploy to the App Service environment that corresponds to the _Dev_ stage.

This branch you work with serves as the _release_ branch that triggers the deployment to the _Dev_ stage. In practice, you would choose an appropriate name for your release branch, such as `release`. As your process matures, you can trigger releases as changes make their way into the `master` branch.

## Fetch the branch from GitHub

Here, you fetch the `release-workflow` branch from GitHub and checkout, or switch to, that branch.

This branch serves as your _release_ branch. It contains the _Space Game_ project you worked with in the previous modules and an Azure Pipelines configuration to start with.

1. In Visual Studio Code, open the integrated terminal.
1. Run the following `git` commands to fetch a branch named `release-workflow` from Microsoft's repository and switch to that branch.

    ```bash
    git fetch upstream release-workflow
    git checkout release-workflow
    ```

    The format of this command enables you to get starter code from Microsoft's GitHub repository, known as `upstream`. Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

1. As an optional step, open *azure-pipelines.yml* from Visual Studio Code and familiarize yourself with the initial configuration.

    The configuration resembles the basic one you created in the [Create a release pipeline with Azure Pipelines](/learn/modules/create-release-pipeline?azure-portal=true) module. It builds only the application's Release configuration. For learning purposes, this configuration does not run the quality or security checks that you set up in previous modules.

## Promote changes to the Dev stage

Here you modify your pipeline configuration to deploy the build to the _Dev_ stage.

1. In Visual Studio Code, modify *azure-pipelines.yml* like this.

    [!code-yml[](code/4-azure-pipelines.yml?highlight=1-3,67-72,90)]

    This configuration resembles the one you built in the previous module, where you and the team built a proof of concept around continuous deployment. However, note these differences, which are highlighted in the code example:

    1. This configuration defines variables at the top of the file that are used throughout the pipeline. These variables define which configuration to build (**Release**) and the name of your release branch (**release-workflow**).
    1. The **DeployDev** stage uses a condition that specifies to run the stage only when the previous stage succeeds and the current branch is **release-workflow**. This ensures that release features only are deployed to the _Dev_ environment.
    1. The deployment step uses the variable name **WebAppNameDev** to deploy to the App Service instance that's associated with the _Dev_ environment.

1. From the integrated terminal, add *azure-pipelines.yml* to the index, commit the change, and push the change up to GitHub.

    > [!TIP]
    > Remember to save *azure-pipelines.yml* before running these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Deploy to the Dev stage"
    git push origin release-workflow
    ```

1. In Azure Pipelines, go to the build and trace the build as it runs.
1. After the build completes, press the back button to return to the summary page.

    <!-- TODO: ADD SCREEN CAP ![](../media/5-pipeline-build-stage-summary.png) -->

    You see that the build completed successfully.
1. From a web browser, navigate to the URL that's associated with the App Service instance for your _Dev_ environment.

    If you still have the browser tab open, simply refresh the page.

    If you need a refresher, you can find the URL from the App Service details page in the Azure portal.

    You see that the _Space Game_ website has been successfully deployed to App Service and is running.

    <!-- TODO: ADD SCREEN CAP ![](../media/5-deployed-website.png) -->

1. As an optional step, in Azure Pipelines, select **Environments**. Then select the **dev** environment.

    Azure Pipelines records your deployment history, which enables you to trace changes in the environment back to code commits and work items.

    <!-- TODO: ADD SCREEN CAP -->