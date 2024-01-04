Your release pipeline still has two stages, but they're now different than before. The stages are *Build* and *Dev*. Every change you push to GitHub triggers the *Build* stage to run. The *Dev* stage runs only when the change is in the *release* branch. Here, you add the *Test* stage to the pipeline.

Recall that the team decided to use a scheduled trigger to promote the build from the *Dev* stage to the *Test* stage at 3 A.M. each morning. To set up the scheduled trigger:

> [!div class="checklist"]
> - Define the schedule in your build configuration.
> - Define the *Test* stage, which includes a condition that runs the stage only if the build reason is marked as `Schedule`.

For learning purposes, here, you define the schedule but allow the build to go directly from *Dev* to *Test*. This setup avoids the need to wait for the schedule to be triggered. After you complete this module, try experimenting with different cron expressions to run the *Test* stage only at the scheduled time.

## Promote changes to the Test stage

Here, you modify your pipeline configuration to deploy the build to the *Test* stage.

1. In Visual Studio Code, modify *azure-pipelines.yml* as follows:

    [!code-yml[](code/5-azure-pipelines.yml?highlight=8-14,106-128)]

    The `schedules` section defines one cron expression. You can define more than one expression in your configuration. The expression triggers the pipeline to run against the release branch at 3 A.M. each day. The `always` flag is set to `false` so that the pipeline runs only when the release branch contains changes from the prior run.

    The `Test` stage defines a condition that runs the stage only when the build reason equals `Schedule`. (The built-in variable `Build.Reason` defines the build reason.) If this condition is false, the stage is skipped, but the prior stages continue to run.

    > [!NOTE]
    > This condition is shown for learning purposes. It's commented to enable the change to go from *Dev* to *Test* without waiting for the schedule to be triggered.

1. From the integrated terminal, to the index, add *azure-pipelines.yml*. Then, commit the change, and push it up to GitHub.

    > [!TIP]
    > Before you run these Git commands, save *azure-pipelines.yml*.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Deploy to the Test stage"
    git push origin release
    ```

1. In Azure Pipelines, go to the build. Trace the build as it runs.
1. After the build finishes, to return to the summary page, select the back button.

    :::image type="content" source="../media/5-pipeline-test-stage-summary.png" alt-text="A screenshot of Azure Pipelines showing three completed stages: Build, Dev, and Test.":::

    You see that the deployment finished successfully.
1. From a web browser, go to the URL associated with the App Service instance for your *Test* environment.

    If you still have the browser tab open, refresh the page. If you don't remember the URL, find it in the Azure portal, on the **App Service details** page.

    You see that the *Space Game* website is deployed to App Service, and it's running.

    :::image type="content" source="../media/5-app-service-test.png" alt-text="A screenshot of a web browser showing the Space Game website in the Test environment.":::

1. As an optional step, in Azure Pipelines, select **Environments**. Then, select the **test** environment.

    Azure Pipelines records your deployment history. In the history, you can trace changes in the environment back to code commits and work items.

    :::image type="content" source="../media/5-environment-test.png" alt-text="A screenshot of Azure Pipelines showing the deployment history. The history shows one successful deployment.":::

Andy and Mara add the *Test* stage to the pipeline. They show the results to Amita.

**Amita:** I like that changes are built and deployed so that I can test them each morning. But I don't see how I can control when changes arrive at *Staging*.

**Mara:** Yes, deploying through automation saves lots of time. Remember that we included only the scheduled trigger. Let's add a release approval for you when we set up the *Staging* environment for Tim. That way, changes move to *Staging* only when you're ready.