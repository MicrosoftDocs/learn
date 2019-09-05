Your release pipeline has two stages: _Build_ and _Dev_. Every change you push to GitHub triggers the _Build_ stage to run. The _Dev_ stage runs only when the change is in the release branch. Here, you add the _Test_ stage to the pipeline.

Recall that the team decided to use a scheduled trigger to promote the build from the _Dev_ stage to the _Test_ stage at 3 A.M. each morning. To do so, you:

> [!div class="checklist"]
> * Define the schedule in your build configuration.
> * Define the _Test_ stage, which includes a condition that runs the stage only if the build reason is marked as "Schedule".

For learning purposes, here you'll define the schedule but allow the build to proceed directly from _Dev_ to _Test_ so that you don't have to wait for the schedule to trigger. After you complete this module, you can experiment with different cron expressions so that the _Test_ stage runs only at the scheduled time.

## Promote changes to the Test stage

Here you modify your pipeline configuration to deploy the build to the _Test_ stage.

1. In Visual Studio Code, modify *azure-pipelines.yml* like this.

    [!code-yml[](code/6-azure-pipelines.yml?highlight=5-11,104)]

    The `schedules` section defines one cron expression. You can define more than one expression in your configuration. The expression triggers the pipeline to run against the release branch at 3 A.M. each day. The `always` flag specifies to run the pipeline only when the release branch contains changes from the prior run.

    The `DeployTest` stage defines a condition that runs the stage only when the build reason equals "Schedule". (The built-in variable `Build.Reason` defines the build reason.) If this condition is false, the stage is skipped, but the prior stages continue to run.

    > [!NOTE]
    > The condition is shown here for learning purposes, but it's commented to enable the change to progress from _Dev_ to _Test_ without the need for you to wait for the schedule to trigger.

1. From the integrated terminal, add *azure-pipelines.yml* to the index, commit the change, and push the change up to GitHub.

    > [!TIP]
    > Remember to save *azure-pipelines.yml* before running these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Deploy to the Test stage"
    git push origin release-workflow
    ```

1. In Azure Pipelines, go to the build and trace the build as it runs.
1. After the build completes, press the back button to return to the summary page.

    <!-- TODO: ADD SCREEN CAP ![](../media/6-pipeline-build-stage-summary.png) -->

    You see that the build completed successfully.
1. From a web browser, navigate to the URL that's associated with the App Service instance for your _Test_ environment.

    If you still have the browser tab open, simply refresh the page.

    If you need a refresher, you can find the URL from the App Service details page in the Azure portal.

    You see that the _Space Game_ website has been successfully deployed to App Service and is running.

    <!-- TODO: ADD SCREEN CAP ![](../media/5-deployed-website.png) -->

1. As an optional step, in Azure Pipelines, select **Environments**. Then select the **test** environment.

    Azure Pipelines records your deployment history, which enables you to trace changes in the environment back to code commits and work items.

    <!-- TODO: ADD SCREEN CAP -->

Andy and Mara add the _Test_ stage to the pipeline and then show the results to Amita.

**Amita:** I like the fact that any changes you make are built and deployed for me to test each morning. But what I like most about this is the fact that I still have control over when changes make it to the next stage.

**Mara:** Indeed, deploying through automation is a huge time saver. But remember that changes only includes the scheduled trigger. We'll add a release approval for you when we set up the _Staging_ environment for Tim. That way, changes move to the staging environment only when you're ready.