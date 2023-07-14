Your `azd` template is complete and ready for provisioning and deployment. When the workflow completes, your application will be running in Azure. Follow the steps below to run your template:

> [!NOTE]
> When you provision an existing `azd` template, you must start by running the `azd init` command to clone the template and configure some initial settings. However, since you already ran `azd init` to create your new template, you can skip that step for this workflow.

1. Run the `azd auth login` command to launch a browser window you can use to sign in to your Azure account.

    ```azdeveloper
    azd auth login
    ```

1. Run the `azd up` command to provision and deploy the template resources to Azure. When prompted, select the subscription and location you would like to deploy to.

    ```azdeveloper
    azd up
    ```

The `azd up` command may a few minutes to run. You should see updates printed out in the console as the process runs. When it completes, a link to the deployed site will be displayed. You should also see a link to the deployment process in Azure, which you can visit to view additional deployment information.

The deployed application should look similar to the following screenshot:

:::image type="content" source="../media/deployed-app.png" alt-text="A screenshot showing the deployed web application.":::

You can also view the resources that were created in Azure by navigating to your resource group in the Azure Portal:

1. In the main Azure portal search bar, search for the resource group `azd` created for you by typing `rg-starter`. By convention, the resource group will be the environment name you specified prefixed with `rg-`.
2. Select the resource group from the results to navigate to the overview page.

    :::image type="content" source="../media/deployed-resources.png" alt-text="A screenshot showing the deployed resources.":::

Congratulations! You created, provisioned and deployed your first `azd` template. Next, you'll learn how to update the template and deploy your changes.
