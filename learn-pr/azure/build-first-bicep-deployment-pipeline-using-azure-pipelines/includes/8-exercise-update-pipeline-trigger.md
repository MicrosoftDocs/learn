You have a pipeline that can execute a Bicep deployment to your Azure environment. We will now make this pipeline run automatically. In this exercise you will: 

In this exercise, you'll:

> [!div class="checklist"]
> * Update your pipeline so that it triggers automatically whenever files change in the _deploy_ folder and on the **main** branch.
> * Make a change to your Bicep file.
> * Verify that the pipeline runs automatically.

## Update the trigger to be branch-based

1. In Visual Studio Code, open the _deploy/azure-pipelines.yml_ file.

1. Remove the manual trigger on the first line.

1. Add the following trigger definition in its place:

   :::code language="yaml" source="code/8-pipeline.yaml" range="1-4" :::

1. Save the changes to the file.

1. Commit your changes and push them to Azure Repos.

   ```bash
   git add .
   git commit -m 'Add branch trigger'
   git push
   ```

## Verify the pipeline is running

1. In Azure DevOps, select **Pipelines**.

1. Select your pipeline.

   Notice that the pipeline has automatically been triggered because the pipeline detected the commit you just made.

## Add a Bicep module and make it intentionally invalid

1. In Visual Studio Code, open the _main.bicep_ file.

1. Below the `toyManualsStorageAccountName` variable definition, add the following variable definition:

   :::code language="bicep" source="code/8-main-broken.bicep" range="21" :::

1. Update the `appServiceApp` resource definition to include the highlighted lines below:

   :::code language="bicep" source="code/8-main-broken.bicep" range="60-83" highlight="13-20" :::

1. At the bottom of the file, add an Application Insights resource: 

   :::code language="bicep" source="code/8-main-broken.bicep" range="92-99" :::

   > [!NOTE]
   > Visual Studio Code might tell you the Bicep resource is invalid. It is! Here, you're intentionally adding an invalid resource. You'll fix it soon.

1. Save your changes to the file.

1. Commit your changes by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m 'Add Application Insights instance to Bicep file'
   git push
   ```

## Verify the pipeline fails

1. In Azure DevOps, (TODO need to confirm exact instructions for where the user is)

1. Notice that the pipeline run failed. This is because the Application Insights resource in the Bicep file isn't valid. It uses an unsupported version of the Application Insights resource type.

## Fix the Bicep file and see the pipeline triggered again

1. In Visual Studio Code, update the Application Insights definition's API version:

   :::code language="bicep" source="code/8-main-fixed.bicep" range="92" :::

1. Save the changes to the file.

1. Use the Visual Studio Code terminal to commit your changes and push them:

   ```cmd
   git add -A
   git commit -m 'Fix Application Insights resource definition'
   git push
   ```

## Verify the pipeline succeeds

1. In Azure DevOps, (TODO need to confirm exact instructions for where the user is)

1. Notice that the pipeline run succeeded, because you fixed the resource definition and now have a valid Bicep file.
