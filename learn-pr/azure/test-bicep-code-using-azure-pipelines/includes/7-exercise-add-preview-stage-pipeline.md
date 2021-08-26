You want to add an extra stage to your pipeline so you can check what changes will be made to your Azure environment. During the process you will: 

- Add a second service principal with read permissions on your resource group and a corresponding service connection.
- Update your original service connection to need an approval.
- Update the pipeline YAML file to add a new what-if preview stage.
- Update the Bicep file to make a change.
- Run the pipeline and observe the what-if outputs.
- Approve the pipeline run.
- Observe the successful deployment.

## Update your service connection to need an approval

1. In your browser, navigate to your **Project settings**.

   :::image type="content" source="../media/6-project-settings.png" alt-text="Screenshot of the Azure DevOps interface, with the Project settings highlighted." border="false":::

1. Select **Service connections**.

   :::image type="content" source="../media/6-service-connections.png" alt-text="Screenshot of the Azure DevOps interface, with the Service connections menu item highlighted." border="false":::

1. Select your **ToyWebsite** service connection.

   :::image type="content" source="../media/6-service-connection.png" alt-text="Screenshot of the Azure DevOps interface, Service connections screen, with the ToyWebsite Service connection highlighted." border="false":::

1. Select the **Three dots** button and select **Approvals and checks** from the popup menu.

   :::image type="content" source="../media/6-three-dots.png" alt-text="Screenshot of the Azure DevOps interface, Service connection detail screen, with the three dots button and Approvals and checks menu item highlighted." border="false":::

1. Select **Approvals**.

   :::image type="content" source="../media/6-approvals-and-checks.png" alt-text="Screenshot of the Azure DevOps interface, Approvals and checks screen, with the Approvals option highlighted." border="false":::

1. Fill out your own user name in the **Approvers** textbox. Select the **down arrow** next to **Advanced** and notice that by default approvers are allowed to approve their own runs. We will keep this checkbox checked. 

   :::image type="content" source="../media/6-Approvals.png" alt-text="Screenshot of the Azure DevOps interface, Approvals flyout, with the Approvers textbox, the Advanced dropdown and the Allow approvers to approve their own runs checkbox highlighted." border="false":::

1. Select **Create**.

   :::image type="content" source="../media/6-Approval-create.png" alt-text="Screenshot of the Azure DevOps interface, Approvers flyout, with the Create button highlighted." border="false":::

## Update the pipeline YAML file to add a new what-if preview stage

1. Select **Pipelines**. 

   :::image type="content" source="../media/6-pipelines.png" alt-text="Screenshot of the Azure DevOps interface, with the Pipelines menu item highlighted." border="false":::

1. Select the **bicep** pipeline.

   :::image type="content" source="../media/6-pipeline-bicep.png" alt-text="Screenshot of the Azure DevOps interface, Pipelines screen, with the bicep pipeline highlighted." border="false":::

1. Select **Edit**.

   :::image type="content" source="../media/6-edit.png" alt-text="Screenshot of the Azure DevOps interface, pipeline runs screen, with the Edit button highlighted." border="false":::

1. Select **Variables**.

   :::image type="content" source="../media/6-variables.png" alt-text="Screenshot of the Azure DevOps interface, pipeline detail screen, with the Variables button highlighted." border="false":::

1. Select the **Plus** button.

   :::image type="content" source="../media/6-variables.png" alt-text="Screenshot of the Azure DevOps interface,Variables flyout, with the plus button highlighted." border="false":::

1. Fill out **serviceConnectionReadOnly** as the name for the variable and **ToyWebsiteReadOnly** as the value for the variable. Select **Ok**.

   :::image type="content" source="../media/6-variable.png" alt-text="Screenshot of the Azure DevOps interface, New variable flyout, with the Name and Value textboxes and the Ok button highlighted." border="false":::

1. Select **Save**.

   :::image type="content" source="../media/6-save.png" alt-text="Screenshot of the Azure DevOps interface, Variables flyout, with the Save button highlighted." border="false":::

1. Go to Visual Studio Code and open your **azure-pipelines.yml** file. 

1. Add the following WhatIf stage after your PreFlight stage, but before your Deploy stage: 

   ```yaml
   - stage: WhatIf
     jobs: 
     - job: WhatIf
       steps:
         - task: AzureCLI@2
           displayName: Run what-if checks
           inputs:
             azureSubscription: $(serviceConnectionReadOnly)
             scriptType: 'bash'
             scriptLocation: 'inlineScript'
             inlineScript: 'az deployment group what-if --resource-group $(resourcegroup) --template-file deploy/main.bicep -p environmentType=$(environment)'
   ```

1. In the PreFlight stage, change the **azureSubscription** parameter name to **serviceConnectionReadOnly**: 

   ```yaml
   azureSubscription: $(serviceConnectionReadOnly)
   ```

1. Your full azure-pipelines.yml file should now look like this: 

   :::code language="json" source="code/6-azure-pipelines.yml" :::

1. Save the file. 

## Update the Bicep file to make a change

1. Open your bicep.main template and add the following resource at the bottom of the file: 

   ```bicep
   resource secondStorageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
     name: '${storageAccountName}2'
     location: location
     kind: 'StorageV2'
     sku: {
       name: 'Standard_LRS'
     }
   }
   ```

1. Save your changes.

1. Commit and push your changes to your Git repository by using the following commands: 

   ```bash
   git add .
   git commit -m "Added resource"
   git push
   ```

## Run the pipeline and observe the what-if outputs

1. In your browser, navigate to your pipeline runs. 

   :::image type="content" source="../media/4-pipeline-runs.png" alt-text="Screenshot of the Azure DevOps interface, with the Pipelines menu item and the pipeline highlighted." border="false":::

1. You will notice that your pipeline is now running multiple stages one after the other. At the **Deploy** stage execution will halt and a message will be shown asking you to **Review** the changes.  It might be that you need to refresh your page to see this message. You will also receive an email in your mailbox for this approval. 

   :::image type="content" source="../media/4-approve.png" alt-text="Screenshot of the Azure DevOps interface, Pipeline run screen, with the halted Deploy stage and the Review message highlighted." border="false":::

1. Select the **WhatIf** stage. 

   :::image type="content" source="../media/4-what-if.png" alt-text="Screenshot of the Azure DevOps interface, Pipeline run screen, with the WhatIf stage highlighted." border="false":::

1. Select the **Run what-if checks** section of the WhatIf stage. Inspect the changes that the what-if command reports on. 

   :::image type="content" source="../media/4-what-if-checks.png" alt-text="Screenshot of the Azure DevOps interface, Pipeline run details screen, with the Run what-if checks section highlighted." border="false":::

> [!NOTE]
> It might be that you see more changes reported by the what-if command than changes you performed in your main.bicep file. This happens because during deployment certain defaults are taken for resource parameters without you needing to specify these values in your Bicep file. 

## Approve the pipeline run

1. Navigate back to your pipeline run details screen. 

   :::image type="content" source="../media/4-run-details.png" alt-text="Screenshot of the Azure DevOps interface, Pipeline run output screen, with the run details link highlighted." border="false":::

1. Select the **Review** button.

   :::image type="content" source="../media/4-review.png" alt-text="Screenshot of the Azure DevOps interface, Pipeline run details screen, with the Review button highlighted." border="false":::

1. Select **Approve**.

   :::image type="content" source="../media/4-approve.png" alt-text="Screenshot of the Azure DevOps interface, Approval flyout, with the Approve button highlighted." border="false":::

## Observe the successful deployment

1. Once approved, you will notice the **Deploy** stage starting execution. 

   :::image type="content" source="../media/4-deploy.png" alt-text="Screenshot of the Azure DevOps interface, Pipeline run details screen, with the running Deploy stage highlighted." border="false":::

1. The Deploy stage will successfully deploy your resources. 
