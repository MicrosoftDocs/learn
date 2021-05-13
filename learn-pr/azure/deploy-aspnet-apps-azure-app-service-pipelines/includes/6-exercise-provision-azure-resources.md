To proceed with testing the use of Azure Pipelines for the deployment of your company's ASP.NET applications to Azure App Service, you next need to provision the target Azure environment. In this exercise, you'll configure and run an Azure DevOps pipeline that implements Azure web and database resources, including:

- An Azure logical SQL server
- An Azure SQL database
- An Azure App Service plan
- An Azure App Service web app

These resources will host the sample ASP.NET app that you'll deploy by using the same Azure DevOps pipeline in the next exercise.

To allow the Azure App Service web app to access the Azure SQL database, you'll also modify default firewall settings of the Azure logical SQL server.

## Identify unique names for Azure resources

Every Azure resource that has a public endpoint requires a globally unique name. Such resources include Azure logical SQL servers and Azure App Service web apps. Before you can provision them, you need to identify available names that you can use for their deployment.

1. Within the web browser window displaying the Azure DevOps project, open another web browser tab and browse to the [Azure portal](https://portal.azure.com). If prompted, sign in with a user account that has the Owner role in the Azure subscription and the Global Administrator role in the Azure AD tenant associated with that subscription.
1. In the Azure portal, open the **Cloud Shell** pane by selecting the toolbar icon next to the search textbox.
1. If prompted to select either **Bash** or **PowerShell**, select **Bash**.

   > [!NOTE]
   > If this is the first time you're starting **Cloud Shell**, you'll be presented with the **You have no storage mounted** message. To mount storage, select the subscription you're using in this exercise and select **Create storage**.

1. In the Azure portal, in the Bash session on the **Cloud Shell** pane, run the following code to identify an available name you can assign to the Azure logical SQL server that you'll provision in this exercise. Replace the `<sqlserver_name>` placeholder with any name likely to be unique that consists of between 1 and 63 lowercase letters or digits, including non-leading and non-trailing hyphens.

   ```bash
   SQLSVRNAME=<sqlserver_name>
   dig $SQLSVRNAME.database.windows.net +short
   ```

1. If the **dig** tool doesn't return any output, you can use the name you specified. Otherwise, choose a different name and repeat the previous step until you find an available name.
1. In the Azure portal, in the Bash session on the **Cloud Shell** pane, run the following code to identify an available name you can assign to the Azure App Service web app that you'll provision in this exercise. Replace the `<webapp_name>` placeholder with any name likely to be unique that consists of between 2 and 60 lowercase letters or digits, including non-leading and non-trailing hyphens.

   ```bash
   WEBAPPNAME=<webappname_name>
   dig $WEBAPPNAME.azurewebsites.net +short
   ```

1. If the **dig** tool doesn't return any output, you can use the name you specified. Otherwise, choose a different name and repeat the previous step until you find an available name.

## Configure Azure Pipeline group variables

Next, configure Azure Pipeline variables that you'll use subsequently when provisioning Azure resources.

1. Within the web browser window displaying the Azure portal, switch to the web browser tab displaying the DevOps project. In the vertical menu bar along the left edge of the project page, in the **Pipelines** section, select **Library**.
1. On the **Library** page, select **+ Variable group**.
1. On the properties page of the variable group, in the **Variable group name** textbox, enter **AzureResourcesVariableGroup**, ensure that the **Allow access to all pipelines** switch is selected, and, in the **Variables** section, use the **+ Add** link to add the following variables with the corresponding values (replace the `<Azure_region>` placeholder with the name of the Azure region into which you want to deploy Azure resources):

   > [!NOTE]
   > To identify the names of Azure regions, in the **Cloud Shell**, at the PowerShell prompt, run `az account list-locations --query "sort_by([].{DisplayName:displayName, Name:name}, &DisplayName)" --output table`.

   > [!NOTE]
   > The padlock icon you can select for each variable indicates whether this variable is considered secret.

   |Name|Value|Lock|
   |----|-----|------|
   |DBNAME|**tododb**|disabled|
   |LOCATION|`<Azure_region>`|disabled|
   |RESOURCEGROUPNAME|**aspdevops-rg**|disabled|
   |SQLSRVNAME|The available Azure SQL server name you identified in the previous task|disabled|
   |SVCPLANNAME|aspdevopsplan|disabled|
   |WEBAPPNAME|The available Azure App Service web app name you identified in the previous task|disabled|
   |USERNAME|student|enabled|
   |PASSWORD|Pa55w.rd1234|enabled|

   > [!NOTE]
   > The last two variables are locked to designate them as secrets.

    :::image type="content" source="../media/6-sample-variable-group.png" alt-text="The Library pane including the list of variables within the AzureResourcesVariableGroup variable group.":::

1. On the properties page of the variable group, after you've added all variables, select **Save** in the toolbar.

## Divide the Azure Pipeline into stages

Before you add a task to the existing pipeline that provisions Azure resources required to deploy the sample ASP.NET app, you apply a few modifications that will:

- Allow for referencing variables included in the **AzureResourcesVariableGroup** variable group you created earlier in this exercise.
- Divide the pipeline into separate stages, including **Build** and **DeployAzureResources**.

  > [!NOTE]
  > In the next exercise, you'll add another stage named **DeployASPNETApp**, which will contain tasks to deploy ASP.NET into the Azure App Service web app deployed during the **DeployAzureResources** stage.

1. Within the browser window, on the browser tab displaying the Azure DevOps project, in the vertical menu bar along the left edge of the project page, in the **Pipelines** section, select **Pipelines**. On the **Pipelines** pane, select the entry representing the autogenerated pipeline, and then select **Edit**.

    > [!NOTE]
    > If prompted, agree to **Leave** the current webpage and then, on the page **Azure Pipelines by Microsoft would like permission to**, select **Authorize Azure Pipelines**.

1. On the **azure-pipelines.yml** editor pane, directly above the `trigger: none` entry, add the following section to allow for referencing variables included in the **AzureResourcesVariableGroup** variable group you created earlier in this exercise:

   ```yaml
   variables: 
   - group: AzureResourcesVariableGroup
   ```

1. On the **azure-pipelines.yml** editor pane, directly below the `trigger: none` entry, add the following section to define the **Build** stage consisting of a single job named **Build**:

   ```yaml
   stages:
   - stage: Build
     jobs: 
     - job: Build
   ```

   > [!NOTE]
   > YAML requires proper indentation of its content. You'll need to indent all existing content following the newly defined stage and job elements by four spaces (equivalent to two tabs).

   > [!NOTE]
   > Any syntactically invalid elements of the YAML file will be underlined with a wavy line.

1. On the **azure-pipelines.yml** editor pane, directly below the newly added stage and job elements, select all the remaining content and select the **Tab** key twice. On the **azure-pipelines.yml** editor pane, select **Save**, and on the **Save** pane, select **Save** again.

## Configure an Azure DevOps service connection

For the Azure DevOps pipeline to access your Azure subscription, you need to set up a service connection.

1. Within the browser window displaying the Azure DevOps portal, in the vertical menu bar along the left edge of the project page, select the gearwheel icon representing **Project settings**.
1. On the **Project settings** pane, in the vertical menu bar, in the **Pipelines** section, select **Service connections**.
1. On the **Service connections** pane, select **New service connection**.
1. On the **New service connection** pane, select the **Azure Resource Manager** option and select **Next**.
1. On the **New Azure service connection** pane, ensure that the **Service principal (automatic)** option is selected and select **Next**.
1. On the **New Azure service connection** pane, ensure that the **Scope level** is set to **Subscription**. The target subscription you intend to use in this exercise appears in the **Subscription** drop-down list. In the **Service connection name**, enter **labAzureSubscription**, verify that the **Grant access permissions to all pipelines** check box is selected, and select **Save**.

## Configure the Azure Pipeline to provision Azure resources

Now, it's time to configure the Azure Pipeline you created in the previous exercise to provision Azure resources.

1. Within the browser window displaying the **Project Settings** pane in the Azure DevOps portal, in the vertical menu bar along the left edge of the project page, select **Pipelines**. On the **Pipelines** pane, select the pipeline you're using in this lab, and then select **Edit**.
1. On the **azure-pipelines.yml** editor pane, place the mouse pointer at the very end of the file and select the **Enter** key to start a new line.
1. On the **azure-pipelines.yml** editor pane, add the following content to create the **DeployAzureResources** stage and job elements:

   ```yaml
   - stage: DeployAzureResources
     jobs: 
     - job: DeployAzureResources
       pool: 
         vmImage: 'windows-latest'
       steps:
   ```

1. On the **azure-pipelines.yml** editor pane, place the mouse pointer at the very end of the file and select the **Enter** key to start a new line.
1. On the **azure-pipelines.yml** editor pane, in the **Tasks** section, in the **Search tasks** text box, enter **Azure CLI**, and in the list of results, select the **Azure CLI** task entry.
1. Select the newly added **Azure CLI** task. On the **Azure CLI** pane, in the **Azure Resource Manager connection** drop-down list, select the entry representing the **labAzureSubscription** service connection you created earlier in this exercise.
1. On the **azure-pipelines.yml** editor pane, on the **Tasks** tab, on the **Azure CLI** pane, in the **Script type** drop-down list, select **Shell**. In the **Script Location** drop-down list, select **Inline script**, and in the **Inline script** enter the following script and select **Add**:

   ```bash
   # create a resource group
   az group create -l $LOCATION -n $RESOURCEGROUPNAME
   
   # create and configure Azure SQL logical server and Azure SQL database
   az sql server create -l $LOCATION -g $RESOURCEGROUPNAME -n $SQLSRVNAME -u $(USERNAME) -p $(PASSWORD)
   az sql db create -g $RESOURCEGROUPNAME -s $SQLSRVNAME -n $DBNAME --service-objective Basic
   az sql server firewall-rule create -g $RESOURCEGROUPNAME -s $SQLSRVNAME -n allowazure --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0
   
   # create and configure an Azure App Service plan and an Azure web app
   az appservice plan create -g $RESOURCEGROUPNAME -n $SVCPLANNAME --sku FREE
   az webapp create -g $RESOURCEGROUPNAME -p $SVCPLANNAME -n $WEBAPPNAME
   ```

   :::image type="content" source="../media/6-azure-cli-pipeline-task.png" alt-text="The azure-pipelines.yml editor pane including the Azure CLI task with its parameters set.":::

1. On the **azure-pipelines.yml** editor pane, select the newly added task, and select the **Tab** key twice to indent it within the **DeployAzureResources** stage and job section.

   > [!NOTE]
   > At this point, the pipeline should have the content, which resembles the following listing:

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
           azureSubscription: 'Azure Pass - Sponsorship(11111111-1111-1111-1111-111111111111)'
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
   ```

1. On the **azure-pipelines.yml** editor pane, select **Save**, and on the **Save** pane, select **Save**.

## Run the Azure Pipeline to provision Azure resources

With the new stage of the Azure Pipeline created, you can now invoke execution of its tasks. You can target this specific stage separately, because it doesn't have any dependencies on the artifacts generated by the build.

1. On the **azure-pipelines.yml** editor pane, select **Run**.
1. On the **Run pipeline** pane, select **Stages to run**. On the **Stages to run** pane, clear the **Build** check box, and select **Use select stages**.

   :::image type="content" source="../media/6-stages-to-run.png" alt-text="The Stages to run pane with the build stage check box cleared.":::

1. Back on the **Run pipeline** pane, select **Run**.
1. On the **Run pipeline** pane, note that the **Build** stage was skipped.

   :::image type="content" source="../media/6-skipped-build-stage.png" alt-text="The pipeline run with the build stage skipped.":::

1. On the **Run pipeline** pane, in the **Stages** section, select the rectangle representing the **DeployAzureResources** stage and track the progress of the pipeline execution for that stage.
1. Verify that the **Azure CLI** task completed successfully.

:::image type="content" source="../media/6-completed-deployazureresources-job.png" alt-text="The Azure DevOps Pipeline job execution logs displaying a successfully completed DeployAzureResources job.":::

## Examine the outcome of the Azure Pipeline run

To conclude this exercise, let's examine the outcome of the execution of the Azure Pipeline.

1. Within the browser window, switch to the web browser tab displaying the Azure portal.
1. In the Azure portal, use the **Search resources, services, and docs** textbox in the toolbar to search for and navigate to the **aspdevops-rg** resource group blade.
1. On the **aspdevops-rg** resource group blade, review the list of its resources and verify that it contains a SQL server, SQL database, App Service plan, and App Service.

:::image type="content" source="../media/6-azure-resources.png" alt-text="The Azure portal displaying the list of Azure resources deployed by the pipeline.":::

## Results

In this exercise, you configured and ran an Azure DevOps pipeline to provision Azure web and database resources, including:

- An Azure logical SQL server
- An Azure SQL database
- An Azure App Service plan
- An Azure App Service web app

## Keep your web browser windows open if continuing the module exercises

If you plan to perform the next exercises in this module, keep your web browser windows open.
