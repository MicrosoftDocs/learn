Your toy company's security team has asked you to verify that your website is accessible only through HTTPS. In this exercise, you'll configure your pipeline to run a smoke test that checks the security team's requirement.

During the process, you'll:

> [!div class="checklist"]
> - Add a test script to your repository.
> - Update your pipeline definition to add a test stage.
> - Run the pipeline and observe the test fail.
> - Fix the Bicep file and observe the pipeline run successfully.

## Add a test script

Here, you'll add a test script to verify that the website is accessible when HTTPS is used and not accessible when the nonsecure HTTP protocol is used.

1. In Visual Studio Code, create a new file in the _deploy_ folder named _Website.Tests.ps1_.

   :::image type="content" source="../media/9-visual-studio-code-website-tests-file.png" alt-text="Screenshot of Visual Studio Code Explorer, with the deploy folder and the test file shown.":::

1. Paste the following test code into the file:

   :::code language="powershell" source="code/9-test.ps1" :::

   This code is a Pester test file. It requires a parameter named `$HostName`. It runs two tests against the host name:
   - Try to connect to the website over HTTPS. The test passes if the server responds with an HTTP response status code between 200 and 299, which indicates a successful connection.
   - Try to connect to the website over HTTP. The test passes if the server responds with an HTTP response status code of 300 or higher.

   For the purposes of this exercise, it's not important that you understand the details of the test file and how it works. We'll provide links in the summary so you can learn more if you're interested.

## Publish your Bicep file's output as a stage output variable

The test script that you created in the preceding steps requires a host name to test. Your Bicep file already includes an output, but before you can use it in your smoke tests, you need to publish it as a stage output variable.

1. In Visual Studio Code, open the _azure-pipelines.yml_ file in the _deploy_ folder.

1. In the **Deploy** stage, update the deployment step to publish the outputs to a variable:

   :::code language="yaml" source="code/9-pipeline.yml" range="71-82" highlight="12" :::

   Now, your deployment process still uses the same task as it did previously, but the outputs from the deployments are stored in a pipeline variable named `deploymentOutputs`. The output variable is formatted as JSON.

1. To convert the JSON-formatted outputs into pipeline variables, add the following script step below the deployment step:

   :::code language="yaml" source="code/9-pipeline.yml" range="84-89" :::

   If the deployment completes successfully, the script accesses the value of each output from the Bicep deployment. The script uses the `jq` tool to access the relevant part of the JSON output. Then, the value is published to a stage output variable with the same name as the Bicep deployment output.

   > [!NOTE]
   > Pester and jq are both preinstalled on Microsoft-hosted agents for Azure Pipelines. You don't need to do anything special to use them in a script step.

1. Save the file.

## Add a smoke test stage to your pipeline

Now, you can add a smoke test stage that runs your tests.

1. At the bottom of the file, add the following definition for the **SmokeTest** stage:

   :::code language="yaml" source="code/9-pipeline.yml" range="91-96" :::

   This code defines the stage and a job. It also creates a variable in the job named `appServiceAppHostName`. This variable takes its value from the output variable that you created in the preceding section.

1. At the bottom of the file, add the following step definition to the **SmokeTest** stage:

   :::code language="yaml" source="code/9-pipeline.yml" range="97-109" :::

   This step runs a PowerShell script to run the test script that you wrote earlier by using the Pester testing tool.

1. At the bottom of the file, add the following step definition to the **SmokeTest** stage:

   :::code language="yaml" source="code/9-pipeline.yml" range="111-117" :::

   This step takes the test results file that Pester creates and publishes it as pipeline test results. You'll see how the results are displayed shortly.

   Notice that the step definition includes `condition: always()`. This condition indicates to Azure Pipelines that it should always publish the test results, even if the preceding step fails. This condition is important because any failing test will cause the test step to fail, and normally the pipeline stops running after a failing step.

1. Save the file.

## Verify and commit your pipeline definition

1. Verify that your _azure-pipelines.yml_ file looks like the following code:

   :::code language="yaml" source="code/9-pipeline.yml" highlight="82-117" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add test stage"
   git push
   ```

## Run the pipeline and review the test result

1. In your browser, go to your pipeline.

1. Select the most recent run of your pipeline.

   Wait until the pipeline completes the **Lint**, **Validate**, and **Preview** stages. Although Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Select the **Review** button and then select **Approve**.

   Wait for the pipeline run to finish.

1. Notice that the **Deploy** stage finishes successfully. The **SmokeTest** stage finishes with an error.

   :::image type="content" source="../media/9-pipeline-run-stages-smoketest.png" alt-text="Screenshot of the Azure DevOps interface that shows the pipeline run stages. The SmokeTest stage reports failure.":::

1. Select the **Tests** tab.

   :::image type="content" source="../media/9-pipeline-run-test-tab.png" alt-text="Screenshot of the Azure DevOps interface that shows the pipeline run, with the Tests tab highlighted.":::

1. Notice that the test summary shows that two tests ran. One passed and one failed. The test that failed is listed as **Toy Website.Does not serve pages over HTTP**.

   :::image type="content" source="../media/9-pipeline-run-test-results.png" alt-text="Screenshot of the Azure DevOps interface that shows the pipeline run's test results, with the failed test highlighted.":::

   This text indicates that the website hasn't been correctly configured to meet your security team's requirement.

## Update the Bicep file

Now that you've identified that your Bicep definition doesn't meet your security team's requirement, you'll fix it.

1. In Visual Studio Code, open the _main.bicep_ file in the _deploy_ folder.

1. Find the definition for the Azure App Service app, and update it to include the `httpsOnly` property in its `properties` area:

   :::code language="bicep" source="code/9-fixed.bicep" range="57-76" highlight="6" :::

1. Save the file.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Configure HTTPS on website"
   git push
   ```

## Run the pipeline again

1. In your browser, go to your pipeline.

1. Select the most recent run.

   Wait until the pipeline completes the **Lint**, **Validate**, and **Preview** stages. Although Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Select the **Preview** stage and review the what-if results again.

   Notice that the what-if command has detected the change in the `httpsOnly` property's value:

   :::code language="plaintext" source="code/9-what-if-output.txt" highlight="13" :::

1. Go back to the pipeline run.

1. Select the **Review** button, then select **Approve**.

   Wait for the pipeline run to finish.

1. Notice that the entire pipeline finishes successfully, including the **SmokeTest** stage. This success indicates that both tests passed.

   :::image type="content" source="../media/9-pipeline-run-success.png" alt-text="Screenshot of the Azure DevOps interface that shows a successful pipeline run.":::

## Clean up the resources

Now that you've completed the exercise, you can remove the resources so you aren't billed for them.

In the Visual Studio Code terminal, run the following command:

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
