Your release pipeline still has two stages but they're now different than before. The stages are: _Build_ and _Dev_. Every change you push to GitHub triggers the _Build_ stage to run. The _Dev_ stage runs only when the change is in the _release_ branch. Here, you add the _Test_ stage to the pipeline.

Recall that the team decided to use a scheduled trigger to promote the build from the _Dev_ stage to the _Test_ stage at 3 A.M. each morning. To do this, you:

> [!div class="checklist"]
> * Define the schedule in your build configuration.
> * Define the _Test_ stage, which includes a condition that runs the stage only if the build reason is marked as "Schedule".

For learning purposes, here you define the schedule but allow the build to proceed directly from _Dev_ to _Test_ so that you don't have to wait for the schedule to trigger. After you complete this module, you can experiment with different cron expressions so that the _Test_ stage runs only at the scheduled time.

## Promote changes to the _Test_ stage

Here you modify your pipeline configuration to deploy the build to the _Test_ stage.

1. In Visual Studio Code, modify *azure-pipelines.yml* like this.

    [!code-yml[](code/6-azure-pipelines.yml?highlight=5-11,103-125)]

    The `schedules` section defines one cron expression. You can define more than one expression in your configuration. The expression triggers the pipeline to run against the release branch at 3 A.M. each day. The `always` flag is set to `false` so that the pipeline runs only when the _release_ branch contains changes from the prior run.

    The `Test` stage defines a condition that runs the stage only when the build reason equals "Schedule". (The built-in variable `Build.Reason` defines the build reason.) If this condition is false, the stage is skipped, but the prior stages continue to run.

    > [!NOTE]
    > Remember, the condition is shown here for learning purposes, but it's commented to enable the change to progress from _Dev_ to _Test_ without the need for you to wait for the schedule to trigger.

1. From the integrated terminal, add *azure-pipelines.yml* to the index, commit the change, and push the change up to GitHub.

    > [!TIP]
    > Remember to save *azure-pipelines.yml* before running these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Deploy to the Test stage"
    git push origin release
    ```

1. In Azure Pipelines, go to the build and trace the build as it runs.
1. After the build completes, press the back button to return to the summary page.

    ![Azure Pipelines showing the completed stages](../media/5-pipeline-test-stage-summary.png)

    You see that the deployment completed successfully.
1. From a web browser, navigate to the URL that's associated with the App Service instance for your _Test_ environment.

    If you still have the browser tab open, simply refresh the page. If you need a refresher, you can find the URL from the App Service details page in the Azure portal.

    You see that the _Space Game_ website has been successfully deployed to App Service and is running.

    ![A browser showing the Space Game website in the Test environment](../media/5-app-service-test.png)

1. As an optional step, in Azure Pipelines, select **Environments**. Then select the **test** environment.

    Azure Pipelines records your deployment history, which enables you to trace changes in the environment back to code commits and work items.

    ![Azure Pipelines showing the deployment history](../media/5-environment-test.png)

Andy and Mara add the _Test_ stage to the pipeline and then show the results to Amita.

**Amita:** I like the fact that any changes you make are built and deployed for me to test each morning. But I don't see how I have control over when changes make it to _Staging_.

**Mara:** Indeed, deploying through automation is a huge time saver. Remember though that, so far, we've only included the scheduled trigger. We'll add a release approval for you when we set up the _Staging_ environment for Tim. That way, changes move to _Staging_ only when you're ready.