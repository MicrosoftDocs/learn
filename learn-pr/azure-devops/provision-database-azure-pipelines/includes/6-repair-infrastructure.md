In this exercise, you destroy resources in your deployment and watch Azure Resource Manager repair your infrastructure.

Recall that Azure Resource Manager templates are idempotent. This means that Resource Manager applies infrastructure changes only when the configuration defined in your template differs from the running environment. This behavior enables you to repair your infrastructure if a piece is removed or changed by another process.

To see this repair process in action, here you delete your App Service instance from the Azure portal. You then manually trigger the pipeline to run.

## Delete your App Service instance

Here, you manually delete your App Service instance from the Azure portal to simulate a process that accidentally deleted a resource.

1. From the Azure portal, select **Resource groups**.
1. Select **tailspin-spacegame-web-rg**.
1. From the list of resources, select your App Service instance.

    ![](../media/6-portal-select-app-service.png)

    > [!NOTE]
    > You can also select other resources if you'd like. Just be sure not to select your Key Vault. Your Resource Manager template requires data from Key Vault to provision your infrastructure.

1. From the top of the page, select **Delete**. Then enter *Yes* in the text box and then select **Delete**.

    > [!NOTE]
    > Be sure to select **Delete** and not **Delete resource group**.

1. Wait for the App Service instance to be removed from the list.

    You can periodically select the **Refresh** button to update the status.
1. As an optional step, refresh the web browser tab that shows the _Space Game_ website.

    You see that the website is no longer available.

## Manually trigger the pipeline

Here, you manually trigger the pipeline to run so that Resource Manager can repair your infrastructure. In practice, you could push a change to GitHub to trigger the same process.

1. From Azure Pipelines, go to your pipeline.
1. Select the **Run pipeline** button.
1. Select the **provision-db** branch, and then select **Run**.
1. Go to the build and trace the build as it runs.
1. After the build finishes, select the back button to return to the summary page.

    ![Azure Pipelines showing the completed stages](../media/5-pipeline-stages-overview.png)


    You see that the deployment finished successfully.
1. Refresh the web browser tab that shows the _Space Game_ website.

    You see that the _Space Game_ website is redeployed to App Service.

    ![The Space Game website](../media/5-space-game-home-page.png)