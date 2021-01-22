To complete your testing, you need to validate the last steps of the process of deploying apps into the Azure App Service. In this exercise, you'll use an Azure DevOps release pipeline to deploy the artifacts generated in the first exercise of this module into the Azure App Service web app you provisioned in the previous exercise.

## Configure the Azure Pipeline to deploy the sample ASP.NET web app to the Azure App Service web app

Now, it's time to configure the Azure Pipeline you used to provision Azure resources to deploy the sample ASP.NET web app. To start, you'll add another stage named **DeployASPNETApp**, which will contain tasks to deploy the ASP.NET into the Azure App Service web app deployed during the **DeployAzureResources** stage.

1. Within the browser window displaying the Azure DevOps portal, in the vertical menu bar along the left edge of the project page, select the **Pipelines** entry, on the **Pipelines** pane, select the pipeline you're using in this lab, and then select **Edit**.
2. On the **azure-pipelines.yml** editor pane, place the mouse pointer at the very end of the file and select the **Enter** key to start a new line.
3. On the **azure-pipelines.yml** editor pane, add the following code to create the **DeployASPNETApp** stage and job elements:

   ```yaml
   - stage: DeployASPNETApp
     jobs: 
     - job: DeployASPNETApp
       pool: 
         vmImage: 'windows-latest'
       steps:
   ```
4. On the **azure-pipelines.yml** editor pane, place the mouse pointer at the very end of the file and select the **Enter** key to start a new line.
5. On the **azure-pipelines.yml** editor pane, in the **Tasks** section, in the **Search tasks** text box, enter **Download build artifacts**, and in the list of results, select the **Download build artifacts** task entry.
6. On the **Download build artifacts** pane, in the **Artifact name**, enter **drop**, and then select **Add**.

   :::image type="content" source="../media/8-download-build-artifacts-task.png" alt-text="The azure-pipelines.yml editor pane including the download build artifacts task with its parameters set.":::

7. On the **azure-pipelines.yml** editor pane, with the newly added task selected, select the **Tab** key twice to indent it.
8. On the **azure-pipelines.yml** editor pane, replace the last line `downloadPath: '$(System.ArtifactsDirectory)'` of the newly added task with `downloadPath: '$(System.DefaultWorkingDirectory)'`

   > [!NOTE]
   > This is necessary to match the artifact location referenced by the next task you add to the pipeline.

9. On the **azure-pipelines.yml** editor pane, place the mouse pointer at the very end of the file and select the **Enter** key to start a new line.
10. On the **azure-pipelines.yml** editor pane, in the **Tasks** section, in the **Search tasks** text box, enter **App Service**, and in the list of results, select the **Azure App Service deploy** task entry.
11. On the **Azure App Service deploy** pane, ensure that the **labAzureSubscription** appears in the **Azure subscription** dropdown list, in the **App Service name** dropdown list, enter **$(WEBAPPNAME)**, and select **Add**.

   > [!NOTE]
   > This is one of the variables designating the name of the Azure App Service web app that's included in the **AzureResourcesVariableGroup** you created in the previous exercise of this module.

12. On the **azure-pipelines.yml** editor pane, with the newly added task selected, select the **Tab** key twice to indent it.
13. On the **azure-pipelines.yml** editor pane, place the mouse pointer at the very end of the file and select the **Enter** key to start a new line.
14. On the **azure-pipelines.yml** editor pane, in the **Tasks** section, in the **Search tasks** text box, enter **App Service**, and, in the list of results, select the **Azure App Service Settings** task entry.
15. On the **Azure App Service Settings** pane, in the **Azure subscription** dropdown list, select the **labAzureSubscription** entry. In the **App Service name** dropdown list, enter **$(WEBAPPNAME)**. In the **Resource group** dropdown list, enter **$(RESOURCEGROUPNAME)**. In the **Connection Strings** text box, enter the following text, and then select **Add**.


   ```json
   [
      {
       "name": "MyDbConnection",
       "value": "Server=tcp:$(SQLSRVNAME).database.windows.net,1433;Initial Catalog=tododb;Persist Security Info=False;User ID=$(USERNAME);Password=$(PASSWORD);MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
       "type": "SqlAzure",
       "slotSetting": false
      }
   ]
   ```

   :::image type="content" source="../media/8-azure-app-service-settings-task.png" alt-text="The azure-pipelines.yml editor pane including the azure app service settings task with its parameters set.":::

16. On the **azure-pipelines.yml** editor pane, with the newly added task selected, select the **Tab** key twice to indent it.

   > [!NOTE]
   > At this point, the pipeline should have the following content:

   ```yaml
   # ASP.NET
   # Build and test ASP.NET projects.
   # Add steps that publish symbols, save build artifacts, deploy, and more:
   # https://docs.microsoft.com/azure/devops/pipelines/apps/aspnet/build-aspnet-4

   variables: 
   - group: AzureResourcesVariableGroup

   trigger: none

   stages:
   - stage: Build
     jobs: 
     - job: Build

       pool:
         vmImage: 'windows-latest'

       variables:
         solution: '**/*.sln'
         buildPlatform: 'Any CPU'
         buildConfiguration: 'Release'

       steps:
       - task: NuGetToolInstaller@1

       - task: NuGetCommand@2
         inputs:
           restoreSolution: '$(solution)'

       - task: VSBuild@1
         inputs:
           solution: '$(solution)'
           msbuildArgs: '/p:DeployOnBuild=true /p:WebPublishMethod=Package /p:PackageAsSingleFile=true /p:SkipInvalidConfigurations=true /p:PackageLocation="$(build.artifactStagingDirectory)"'
           platform: '$(buildPlatform)'
           configuration: '$(buildConfiguration)'

       - task: PublishBuildArtifacts@1
         inputs:
           PathtoPublish: '$(Build.ArtifactStagingDirectory)'
           ArtifactName: 'drop'
           publishLocation: 'Container'

   - stage: DeployAzureResources
     jobs: 
     - job: DeployAzureResources
       pool: 
         vmImage: 'windows-latest'
       steps:

       - task: AzureCLI@2
         inputs:
           azureSubscription: 'Azure Pass - Sponsorship(c788d895-700e-4ce4-b89e-dbb85fac2154)'
           scriptType: 'bash'
           scriptLocation: 'inlineScript'
           inlineScript: |
             # create a resource group
             az group create -l $LOCATION -n $RESOURCEGROUPNAME
         
             # create and configure Azure SQL logical server and Azure SQL database
             az sql server create -l $LOCATION -g $RESOURCEGROUPNAME -n $SQLSRVNAME -u $(USERNAME) -p $(PASSWORD)
             az sql db create -g $RESOURCEGROUPNAME -s $SQLSRVNAME -n $DBNAME --service-objective Basic
             az sql server firewall-rule create -g $RESOURCEGROUPNAME -s $SQLSRVNAME -n allowazure --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0
          
             # create and configure an Azure App Service plan and an Azure web app
             az appservice plan create -g $RESOURCEGROUPNAME -n $SVCPLANNAME --sku FREE
             az webapp create -g $RESOURCEGROUPNAME -p $SVCPLANNAME -n $WEBAPPNAME

   - stage: DeployASPNETApp
     jobs: 
     - job: DeployASPNETApp
       pool: 
         vmImage: 'windows-latest'
       steps:

       - task: DownloadBuildArtifacts@0
         inputs:
           buildType: 'current'
           downloadType: 'single'
           artifactName: 'drop'
           downloadPath: '$(System.DefaultWorkingDirectory)'

       - task: AzureRmWebAppDeployment@4
         inputs:
           ConnectionType: 'AzureRM'
           azureSubscription: 'labAzureSubscription'
           appType: 'webApp'
           WebAppName: '$(WEBAPPNAME)'
           packageForLinux: '$(System.DefaultWorkingDirectory)/**/*.zip'

       - task: AzureAppServiceSettings@1
            inputs:
           azureSubscription: 'labAzureSubscription'
           appName: '$(WEBAPPNAME)'
           resourceGroupName: '$(RESOURCEGROUPNAME)'
           connectionStrings: |
             [
               {
                 "name": "MyDbConnection",
                 "value": "Server=tcp:$(SQLSRVNAME).database.windows.net,1433;Initial Catalog=tododb;Persist Security Info=False;User ID=$(USERNAME);Password=$(PASSWORD);MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
                 "type": "SqlAzure",
                 "slotSetting": false
               }
             ]
   ```

17. On the **azure-pipelines.yml** editor pane, select **Save**, and on the **Save** pane, select **Save**.

## Run the Azure Pipeline to provision Azure resources

With the new stage of the Azure Pipeline created, you can now invoke execution of its tasks. You can exclude the second stage, because the required Azure resources have already been provisioned in the previous exercise of this module.

1. On the **azure-pipelines.yml** editor pane, select **Run**.
1. On the **Run pipeline** pane, select **Stages to run**, on the **Stages to run** pane, clear the **DeployAzureResources** check box, and select **Use select stages**.

   :::image type="content" source="../media/8-stages-to-run.png" alt-text="The Stages to run pane with the deployazureresources stage check box cleared.":::

1. Back on the **Run pipeline** pane, select **Run**.
1. On the pipeline run pane, note that the **DeployAzureResources** stage was skipped.

   :::image type="content" source="../media/8-skipped-deployazureresources-stage.png" alt-text="The pipeline run pane with the build stage skipped.":::

1. On the pipeline run pane, in the **Stages** section, select the rectangle representing the **DeployASPNETApp** stage and track the progress of the pipeline execution for that stage.
1. Verify that all tasks of the **DeployASPNETApp** stage completed successfully.

:::image type="content" source="../media/8-completed-deployaspnetapp-job.png" alt-text="The Azure DevOps Pipeline job execution logs displaying a successfully completed DeployASPNETApp job.":::

## Examine the outcome of the Azure Pipeline run

Verify that the sample ASP.NET web app has been successfully deployed to the Azure App Service web app.

1. Within the browser window, on the browser tab displaying the Azure DevOps project, switch to the web browser tab displaying the Azure portal.
1. In the Azure portal, on the **aspdevops-rg** resource group blade, select the entry representing the App Service web app.
1. On the App Service web app blade, select the **URL** link. This will automatically open a new web browser tab displaying the sample ASP.NET web app **Todos** interface.
1. On the **Todos** page, select **Create New** and step through the process of creating a few **To do** entries.

:::image type="content" source="../media/8-todos-aspnet-app.png" alt-text="A web browser displaying the sample ASP.NET app deployed into an Azure web app.":::

## Reenable continuous integration

To validate the DevOps CI/CD functionality, you'll reenable continuous integration.

1. Within the browser window displaying the Azure DevOps portal, in the vertical menu bar along the left edge of the project page, select the **Pipelines** entry, on the **Pipelines** pane, select the pipeline you're using in this lab, and then select **Edit**.
1. On the **azure-pipelines.yml** editor pane, replace the `trigger: none` entry with the following content:

   ```yaml
   trigger:
   - main
   ```

1. On the **azure-pipelines.yml** editor pane, select **Save**, and on the **Save** pane, select **Save**.

   > [!NOTE]
   > This will automatically trigger a new deployment.

1. Within the browser window displaying the Azure DevOps portal, navigate back to the **Pipelines** pane, select the pipeline you're using in this lab, then select the entry representing the current pipeline run, and monitor its progress until successful completion.

## Trigger continuous integration and continuous deployment

To conclude this exercise, you'll trigger integration and deployment by modifying the code hosted in the GitHub repository.

1. Within the web browser window displaying the Azure DevOps portal, switch to the browser tab displaying the fork of the GitHub repository you created in the first exercise of this lab.
1. Within the web browser window displaying the GitHub repository you created in the first exercise of this lab, select the **Code** tab header.
1. Within the repository hierarchy, navigate to the **/DotNetAppSqlDb/Views/Shared/_Layout.cshtml** file.
1. On the page displaying the content of **_Layout.cshtml**, select the **Edit this file** pencil-shaped icon.
1. Change the content of line **27** from `<p>&copy; @DateTime.Now.Year - MS Learn Sample ASP.NET Application</p>` to `<p>&copy; @DateTime.Now.Year - MS Learn Sample Azure ASP.NET Application</p>` and select **Commit changes**.
1. Within the web browser window displaying the GitHub repository, switch back to the web browser tab displaying the Azure DevOps portal, in the vertical menu bar along the left edge of the project page, select the **Pipelines** entry.
1. Within the browser window displaying the Azure DevOps portal, on the **Pipelines** pane, select the pipeline you're using in this lab, then select the entry representing the current pipeline run, and monitor its progress until successful completion.
1. Within the web browser window displaying the Azure DevOps portal, switch to the web browser tab displaying the sample ASP.NET web app page.
1. Refresh the web browser page and verify that the footer of the page changed according to the change you made in the GitHub repository.

:::image type="content" source="../media/8-todos-azure-aspnet-app.png" alt-text="A web browser displaying the sample ASP.NET app deployed into an Azure web app following changes to the GitHub repo.":::

## Results
In this exercise you used an Azure DevOps release pipeline to deploy artifacts into the Azure App Service web app.

## Clean up your environment

You successfully completed all exercises in this module. To clean up your lab environment, you should delete the Azure DevOps project and the Azure resources you provisioned in the first two exercises.

> [!NOTE]
> Remember to remove any Azure resources that you no longer use. Removing unused resources avoids unexpected charges.

### Delete the Azure DevOps project

1. Within the browser window displaying the Azure DevOps portal, in the vertical menu bar along the left edge of the project page, select the gearwheel icon representing **Project settings**.
1. On the **Project details** pane, scroll down to the bottom and select **Delete**.
1. In the **Delete project** popup window, in the confirmation text box, enter the project name, and select **Delete**.

### Delete the Azure resources

1. Within the browser window, on the browser tab displaying the Azure DevOps project, switch to the web browser tab displaying the Azure portal.
1. Within the web browser window displaying the Azure portal, open the **Bash** session within the **Cloud Shell** pane by selecting the toolbar icon next to the search text box.
1. Within the web browser window displaying the Azure portal, in the Bash session on the **Cloud Shell** pane, run the following code to verify the name of the resource group you created in the second exercise of this module:

   ```bash
   az group show --resource-group 'aspdevops-rg' --query name --output tsv
   ```

1. Within the web browser window displaying the Azure portal, in the Bash session on the **Cloud Shell** pane, run the following code to delete the resource group you created in the second exercise of this module, along with its resources:

   ```bash
   az group show --resource-group 'aspdevops-rg' --query name --output tsv | xargs -L1 bash -c 'az group delete --name $0 --no-wait --yes'
   ```

> [!NOTE]
> The command executes asynchronously (as determined by the --nowait parameter), so while you'll be able to run another Azure CLI command immediately afterwards within the same Bash session, it will take a few minutes before the resource group is removed.
