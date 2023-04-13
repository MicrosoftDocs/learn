Your toy company's security team has asked you to verify that your website is accessible only through HTTPS. In this exercise, you configure your workflow to run a smoke test that checks the security team's requirement.

During the process, you'll do the following tasks:

> [!div class="checklist"]
>
> - Add a test script to your repository.
> - Update your workflow definition to add a test job.
> - Run the workflow and observe the test fail.
> - Fix the Bicep file and observe the workflow run successfully.

## Add a test script

Here, you add a test script to verify that the website is accessible when HTTPS is used and not accessible when the nonsecure HTTP protocol is used.

1. In Visual Studio Code, create a new file in the _deploy_ folder named _Website.Tests.ps1_.

   :::image type="content" source="../media/9-visual-studio-code-website-tests-file.png" alt-text="Screenshot of Visual Studio Code Explorer, with the deploy folder and the test file shown.":::

1. Paste the following test code into the file:

   :::code language="powershell" source="code/9-test.ps1" :::

   The result is a Pester test file. It requires a parameter named `$HostName`. It runs two tests against the host name:

   - Try to connect to the website over HTTPS. The test passes if the server responds with an HTTP response status code between 200 and 299, which indicates a successful connection.
   - Try to connect to the website over HTTP. The test passes if the server responds with an HTTP response status code of 300 or higher.

   For the purposes of this exercise, it's not important that you understand the details of the test file and how it works. We provide links in the summary so you can learn more if you're interested.

## Publish your Bicep file's output as a job output

The test script that you created in the preceding steps requires a host name to test. Your Bicep file already includes an output, but before you can use it in your smoke tests, you need to publish it as a job output.

1. In Visual Studio Code, open the _workflow.yml_ file in the _.github/workflows_ folder.

1. In the **deploy** job, add an `id` to the `Deploy website` step so that you can refer to the step. Also, add a job output that copies the `appServiceAppHostName` output from the deployment step:

   :::code language="yaml" source="code/9-workflow.yml" range="65-87" highlight="5-6, 16" :::

1. Save the file.

## Add a smoke test job to your workflow

Now, you can add a smoke test job that runs your tests.

1. At the bottom of the file, add the following definition for the **smoke-test** job:

   :::code language="yaml" source="code/9-workflow.yml" range="89-102" :::

   This code defines the job. The job contains a step to check out the code, and a step to run tests by using Pester.

   The job definition uses the `needs` property to define a dependency on the **deploy** job. This dependency ensures that the jobs run in the sequence you want. It also enables you to use the outputs of the **deploy** job when you run the smoke tests.

   > [!NOTE]
   > PowerShell and Pester are both preinstalled on GitHub-hosted runners. You don't need to do anything special to use them in a script step.

1. Save the file.

## Verify and commit your workflow definition

1. Verify that your _workflow.yml_ file looks like the following code:

   :::code language="yaml" source="code/9-workflow.yml" highlight="69-70, 80, 89-102" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add test job"
   git push
   ```

## Run the workflow and review the test result

1. In your browser, go to your workflow.

1. Select the most recent run of your workflow.

   Wait until the workflow completes the **lint**, **validate**, and **preview** jobs. Although GitHub Actions automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Select the **Review deployments** button, select the **Website** environment and select **Approve and deploy**.

   Wait for the workflow run to finish.

1. Notice that the **deploy** job finishes successfully. The **smoke-test** job finishes with an error.

   :::image type="content" source="../media/9-workflow-run-jobs-smoketest.png" alt-text="Screenshot of the GitHub interface that shows the workflow run jobs. The Smoke Test job reports failure.":::

1. Select the **smoke-test** job to see its details.

1. Notice that the **smoke-test** output shows that two tests ran. One passed and one failed. The test that failed is listed as **Toy Website.Does not serve pages over HTTP**.

   :::image type="content" source="../media/9-workflow-run-test-results.png" alt-text="Screenshot of the GitHub interface that shows the workflow run's test results, with the failed test highlighted.":::

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

## Run the workflow again

1. In your browser, go to your workflow runs.

1. Select the most recent run.

   Wait until the workflow completes the **lint**, **validate**, and **preview** jobs. Although GitHub automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Select the **preview** job, and review the what-if results again.

   Notice that the what-if command has detected the change in the `httpsOnly` property's value:

   :::code language="plaintext" source="code/9-what-if-output.txt" highlight="25" :::

1. Go back to the workflow run.

1. Select the **Review deployments** button, select the **Website** environment and select **Approve and deploy**.

   Wait for the workflow run to finish.

1. Notice that the entire workflow finishes successfully, including the **smoke-test** job. This success indicates that both tests passed.

   :::image type="content" source="../media/9-workflow-run-success.png" alt-text="Screenshot of the GitHub interface that shows a successful workflow run.":::

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
