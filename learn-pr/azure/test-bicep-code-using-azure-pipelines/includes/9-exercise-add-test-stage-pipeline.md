Your toy company's security team have asked you to verify that your website is only accessible by using HTTPS. In this exercise, you configure your pipeline to run a smoke test that checks the security team's requirement.

During the process, you'll: 

> [!div class="checklist"]
> * Add a test script to your repository.
> * Update your pipeline definition to add a test stage.
> * Run the pipeline and observe the test fail.
> * Fix the Bicep file and observe the pipeline run successfully.

## Add a test script

Here, you add a test script to verify that the website is accessible when HTTPS is used, and not accessible when accessed using the insecure HTTP protocol.

1. In Visual Studio Code, create a new file in the *deploy* folder named *Website.Tests.ps1*.

   :::image type="content" source="../media/9-visual-studio-code-website-tests-file.png" alt-text="Screenshot of the Visual Studio Code Explorer, with the deploy folder and the Website dot Tests dot P S 1 file shown.":::

1. Paste the following test code into the file:

   :::code language="powershell" source="code/9-test.ps1" :::

   This is a Pester test file. It requires a parameter named `$HostName`, and when it's executed, it runs two tests against the host name:
   - Try to connect to the website over HTTPS. The test passes if the server responds with an HTTP response status code of between 200 and 299, which indicates a successful connection.
   - Try to connect to the website over HTTP. The test passes if the server responds with an HTTP response status code of 300 or higher.

   > [!NOTE]
   > It's not important that you understand the details of the test file and how it works, but we provide links in the summary so you can learn more if you're interested.

## Publish your Bicep file's output as a stage output variable

The test script you created in the preceding steps requires a host name to test. Your Bicep file already includes an output, but before you can use it in your smoke tests you need to publish it as a stage output variable.

1. In Visual Studio Code, open the *deploy/azure-pipelines.yaml* file.

1. In the **Deploy** stage, update the `inlineScript` to the following:

   :::code language="bash" source="code/9-pipeline.yml" range="75-81" :::

   Now, your deployment process still uses the same Azure CLI command as it did previously, but the output of that command is stored in a script variable named `deploymentOutput`. The output of Azure CLI commands is formatted as JSON.

   After the deployment completes, the script accesses the value of the `appServiceAppHostName` output from the Bicep deployment. It does this by using the `jq` tool to access the relevant part of the JSON output. Then, it publishes the value to a stage output variable named `appServiceAppHostName`.

1. Save the file.

## Add a smoke test stage to your pipeline

Now, you can add a smoke test stage that runs your tests.

1. At the bottom of the file, add the following definition for the **SmokeTest** stage:

   :::code language="yaml" source="code/9-pipeline.yml" range="83-88" :::

   This code defines the stage and a job. It also creates a variable in the job named `appServiceAppHostName`, which takes its value from the output variable you created in the preceding section.

1. At the bottom of the file, add the following step definition to the **SmokeTest** stage:

   :::code language="yaml" source="code/9-pipeline.yml" range="89-101" :::

   This step runs a PowerShell script to execute the test script you wrote above by using the Pester testing tool.

1. At the bottom of the file, add the following step definition to the **SmokeTest** stage:

   :::code language="yaml" source="code/9-pipeline.yml" range="103-109" :::

   This step takes the test results file from Pester and publishes it as test results to the pipeline. You'll see how this is displayed shortly.

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

1. Select the **Review** button and then select **Approve**.

   Wait for the pipeline execution to finish.

1. Notice that the **Deploy** stage completes successfully. The **SmokeTest** stage completes with an error.

   :::image type="content" source="../media/9-pipeline-run-stages-smoketest.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline run stages. The SmokeTest stage reports it failed.":::

1. Select the **Tests** tab.

   :::image type="content" source="../media/9-pipeline-run-test-tab.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline run, with the 'Tests' tab highlighted.":::

1. Notice that the test summary shows that two tests ran: one passed and one failed. The test that failed is listed as *Toy Website.Does not serve pages over HTTP*.

   :::image type="content" source="../media/9-pipeline-run-test-results.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline run test results, with the failed test highlighted.":::

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

1. Select the most recent run.

   Wait until the pipeline completes the **Lint**, **Validate**, and **Preview** stages. While Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Select the **Preview** stage, and review the what-if results again.

   Notice that the what-if command has detected the change in the `httpsOnly` property's value:

   :::code language="output" source="code/9-what-if-output.txt" highlight="13" :::

1. Go back to the pipeline run.

1. Select the **Review** button and then select **Approve**.

   Wait for the pipeline execution to finish.

1. Notice that the entire pipeline completes successfully, including the **SmokeTest** stage. This indicates that both tests passed.

   :::image type="content" source="../media/9-pipeline-run-success.png" alt-text="Screenshot of the Azure DevOps interface showing the successful pipeline run.":::

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
