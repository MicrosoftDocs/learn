You now have everything you need to run your Terraform plan in Azure Pipelines. Automated provisioning helps you to run each phase of your deployment &mdash; build, test, provision, and deploy &mdash; all from the pipeline.

In this section, you run your Terraform plan in Azure Pipelines. During the process, you:

> [!div class="checklist"]
> * Add your service principal details and information about your Azure Blob storage account to pipeline variables.
> * Add a job to your Azure Pipelines configuration that provisions your infrastructure.
> * Visit your website to verify the deployment.
> * Remove a piece of your infrastructure and watch Terraform repair your environment.

## Create pipeline variables in Azure Pipelines

In the [Deploy applications with Azure DevOps](https://docs.microsoft.com/learn/paths/deploy-applications-with-azure-devops?azure-portal=true) learning path, you added variables to your pipeline to store the names of your web apps in Azure App Service. Here, instead of adding the names of your web apps, you add your service principal details and information about your Blob storage account.

To add the variables:

1. In Azure DevOps, go to your **Space Game - web - Terraform** project.
1. Under **Pipelines**, select **Library**.

    ![Azure Pipelines showing the Library menu option](../../create-release-pipeline/media/5-pipelines-library.png)
1. Select **+ Variable group**.
1. Under **Properties**, enter **Release** for the variable group name.
1. Under **Variables**, select **+ Add**.
1. Add the following variables:

    > [!div class="mx-tableFixed"]
    > | Variable name             | Example value                            |
    > |---------------------------|------------------------------------------|
    > | **ARM_CLIENT_ID**         | **00000000-1111-0000-0000-000000000000** |
    > | **ARM_CLIENT_SECRET**     | **00000000-2222-0000-0000-000000000000** |
    > | **ARM_TENANT_ID**         | **00000000-3333-0000-0000-000000000000** |
    > | **ARM_SUBSCRIPTION_ID**   | **00000000-4444-0000-0000-000000000000** |
    > | **StorageAccountName**    | **tfsa4962** |
    > | **ResourceGroupLocation** | **westus** |

    Select the ![Secret](../../shared/media/secret-variable-icon.png) lock icon next to  **ARM_CLIENT_SECRET** to encrypt this value.

1. Select **Save**.

    Your variable group looks like this:

    ![The final variable group in Azure Pipelines](../media/8-pipelines-library.png)

## Provision infrastructure in Azure Pipelines

Modify your pipeline configuration by adding a job that runs Terraform to provision infrastructure to run the _Space Game_ website.

1. In Visual Studio Code, modify *azure-pipelines.yml* by adding a job during the _dev_ stage.
    > [!Tip]
    > You can replace the entire file or just update the part that's highlighted.

    [!code-yml[](code/8-azure-pipelines.yml?highlight=72-107,109-111)]

    This configuration resembles the one you built in the [Deploy applications with Azure DevOps](https://docs.microsoft.com/learn/paths/deploy-applications-with-azure-devops?azure-portal=true) learning path. Here's a brief summary of what's new:

    * The _dev_ stage includes a new job, **Provision**, that runs before the deployment job.
    * The **Provision** job:
        * Writes *terraform.tfvars* and *backend.tfvars*, just as you did from Cloud Shell.
        * Uses the `-input=false` argument to close Terraform with an error status if there are any variables whose values could not be set.
        * Initializes Terraform and provisions your Azure infrastructure.
        * Uses the `##vso[]` syntax to write the `WebAppNameDev` variable to the pipeline.
        * Adds the service principal credentials to the script's environment so that Terraform can access them securely.
    * The **Deploy** deployment job reads the ``WebAppNameDev`` variable from the **RunTerraform** task in the provisioning job.

1. From the integrated terminal, add *azure-pipelines.yml* to the index, commit the change, and push the change to GitHub.

    > [!TIP]
    > Remember to save *azure-pipelines.yml* before running these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add provisioning job to the Dev stage"
    git push origin terraform
    ```

1. In Azure Pipelines, go to the build and trace the build as it runs.
1. After the build finishes, select the back button to return to the summary page.

    ![Azure Pipelines showing the completed stages](../media/8-pipelines-run.png)

    You see that the deployment finished successfully.

## Verify the result

Here, you see your website to verify the deployment.

1. From the Azure portal, select **Resource groups**.
1. Select **tailspin-space-game-rg**.
1. From the list of resources, select your App Service instance.

    The name of your App Service instance begins with **tailspin-space-game-web-dev-**, followed by a number. This is the instance that Terraform provisioned for you in the pipeline.
1. From the top of the page, select the URL to go to your website.

    You see the _Space Game_ website deployed to App Service.

    ![The Space Game website](../media/8-space-game-home-page.png)

> [!NOTE]
> For learning purposes, you use the default network settings here. The default settings make your site accessible from the internet. 
>
> In practice, you can configure an Azure virtual network that places your website in a non-internet routable network that's accessible only to you and your team. Later, when you're ready, you can reconfigure your network to make the website available to your users.

## Repair your infrastructure

Recall that Terraform operations are idempotent. This means that Terraform applies configuration changes only when the configuration defined in your plan differs from the running environment. This behavior enables you to repair your infrastructure if a piece is removed or changed by another process.

To see this repair process in action, here you delete your App Service instance from the Azure portal. You then manually trigger the pipeline to run.

1. Return to the Azure portal. You should still be on the page that details your App Service instance.

    If you're not, repeat the steps from the previous section to get there.
1. From the top of the page, select **Delete**.
1. Enter the name of your App Service instance, such as **tailspin-space-game-web-dev-2860**, in the input box. Then select **Delete**.
1. From the top of the page, select your resource group, **tailspin-space-game-rg**.
1. Wait for the App Service instance to be removed from the list.

    You can periodically select the **Refresh** button to update the status. Note that your App Service plan is not deleted. Only your web app is deleted.
1. As an optional step, refresh the web browser tab that shows the _Space Game_ website.

    You see that the website is no longer available.
1. From Azure Pipelines, go to your pipeline.
1. Select the **Run pipeline** button.
1. Select the **terraform** branch, and then select **Run**.
1. Go to the build and trace the build as it runs.
1. After the build finishes, select the back button to return to the summary page.

    ![Azure Pipelines showing the completed stages](../media/8-pipelines-run.png)

    You see that the deployment finished successfully.
1. Refresh the web browser tab that shows the _Space Game_ website.

    You see that the _Space Game_ website is redeployed to App Service.

    ![Space Game in App Service](../media/8-space-game-home-page.png)

    Because the state file holds your random number, Terraform can bring up a new App Service instance that has the same name.

## The result

**Tim:** I think we've got this! Let's show the team.
