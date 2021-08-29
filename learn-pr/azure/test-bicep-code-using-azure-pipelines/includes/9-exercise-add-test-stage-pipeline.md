TODO

During the process, you'll: 

> [!div class="checklist"]
> * Add a test script to your repository.
> * Update your pipeline definition to add a test stage.
> * Run the pipeline and observe the test fail.
> * Fix the Bicep file and observe the pipeline run successfully.

## Add a test script

Here, you add a test script to verify that the website is accessible when HTTPS is used, and not accessible when accessed using the insecure HTTP protocol.

1. In Visual Studio Code, create a new file in the *deploy* folder named *Website.Tests.ps1*.

1. Paste the following test code into the file:

   :::code language="powershell" source="code/9-test.ps1" :::

   > [!NOTE]
   > TODO explain the test

## Add a smoke test stage to your pipeline

1. In Visual Studio Code, open the *deploy/azure-pipelines.yaml* file.

1. In the **Deploy** stage, update the `inlineScript` to the following:

   :::code language="bash" source="code/9-pipeline.yml" range="75-81" :::

   > [!NOTE]
   > TODO explain this

1. At the bottom of the file, add the following definition for the **SmokeTest** stage:

   :::code language="yaml" source="code/9-pipeline.yml" range="83-109" :::

   > [!NOTE]
   > TODO explain this

1. Save the file.

## Verify and commit your pipeline definition

1. Verify that your *azure-pipelines.yml* file looks like the following:

   :::code language="yaml" source="code/9-pipeline.yml" highlight="75-81, 83-109" :::

   If it doesn't, update it to match this example, then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add test stage"
   git push
   ```

## Run the pipeline and review the test result

1. In your browser, navigate to your pipeline. 

1. Select the most recent run of your pipeline.

   Wait until the pipeline completes the **Lint**, **Validate**, and **Preview** stages. While Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Select the **Review** button.

1. Select **Approve**. Wait for the pipeline execution to finish.

   Notice that the **Deploy** stage completes successfully. The **SmokeTest** stage completes with an error.

1. Select the **Tests** tab.

   Notice that the test summary shows that two tests ran: one passed and one failed.

1. Notice that the test that failed is listed as *Toy Website.Does not serve pages over HTTP*.

   This indicates that the website hasn't been correctly configured to meet your security team's requirement.

## Update the Bicep file

1. In Visual Studio Code, open the *deploy/main.bicep* file.

1. Find the definition for the App Service app, and update it to include the `httpsOnly` property in its `properties`:

   :::code language="bicep" source="code/9-fixed.bicep" range="46-65" highlight="6" :::

1. Save the file.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Configure HTTPS on website"
   git push
   ```

## Run the pipeline again

1. In your browser, navigate to your pipeline. 

1. Select the most recent run of your pipeline.

   Wait until the pipeline completes the **Lint**, **Validate**, and **Preview** stages. While Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

   <!-- TODO mention review what-if to see the new property -->

1. Select the **Review** button.

1. Select **Approve**. Wait for the pipeline execution to finish.

   Notice that the entire pipeline completes successfully, including the **SmokeTest** stage. This indicates that both tests passed.

## Clean up the resources

Now that you've completed the exercise, you can remove the resources so you aren't billed for them.

In the Visual Studio Code **Terminal**, run the following command:

::: zone pivot="cli"

```azurecli
az group delete --resource-group ToyWebsiteTest --yes --no-wait
```

The resource group is deleted in the background.

::: zone-end

::: zone pivot="powershell"

```azurepowershell
Remove-AzResourceGroup -Name ToyWebsiteTest -Force
```

::: zone-end
