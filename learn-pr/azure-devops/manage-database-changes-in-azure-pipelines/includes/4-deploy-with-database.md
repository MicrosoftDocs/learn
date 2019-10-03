At this point, the team's pipeline has four stages. The first stage produces the build artifact and the second stage deploys the _Space Game_ web application to App Service in the _dev_ environment. The third and fourth stages deploy the _Space Game_ web application to the _test_ and _staging_ environments. We have taken out the triggers and approvals from the previous module to concentrate on just this section of the pipeline.

Here, you follow along with Andy, Mara, and Tim as they modify the pipeline to add their stages to script the database changes for the DBA and to apply those changes after approval.

## Fetch the branch from GitHub

Here, you fetch the `database` branch from GitHub and checkout, or switch to, that branch.

This branch serves as your _release_ branch. It contains the _Space Game_ project you worked with in the previous modules and an Azure Pipelines configuration to start with.

1. In Visual Studio Code, open the integrated terminal.
1. Run the following `git` commands to fetch a branch named `database` from Microsoft's repository and switch to that branch.

    ```bash
    git fetch upstream database
    git checkout database
    ```

    The format of this command enables you to get starter code from Microsoft's GitHub repository, known as `upstream`. Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

1. As an optional step, open *azure-pipelines.yml* from Visual Studio Code and familiarize yourself with the initial configuration.

    The configuration resembles the basic one you created in the [Create a release management workflow with Azure Pipelines](/learn/modules/create-a-release-management-workflow?azure-portal=true) module. It builds only the application's Release configuration and deploys the build to _dev_, _test_, and _staging_ environments. For learning purposes, this configuration does not run the quality or security checks nor does it contain the schedules and triggers that you set up in previous modules.

## Create the database

> [!IMPORTANT]
> Remember that you need your own Azure subscription to complete the exercises in this module.

Here you use [Azure portal](https://portal.azure.com?azure-portal=true) to create the database. In later learning paths you will create your infrastructure using the pipeline.

1. Navigate to your [Azure portal](https://portal.azure.com?azure-portal=true) and create a new Azure SQL database, database server and resource group for the resources you will need in this and the next exercise.
 1. In the left pane, select **+ Create a resource**, **Databases**, and then **SQL Database**.

    ![The "New" page in the Azure portal showing the databases options that are available in the Azure Marketplace](../media/3-new-database-annotated.png)

1. On the **Create SQL Database** page, specify the values in the following table for the database properties.

    | Property  | Value  |
    |---|---|
    | Subscription | < your subscription > |
    | Resource Group | Create a new resource group and call it **tailspin-space-game-rg** |
    | Database name | The database must have a unique name. We suggest using something like **tailspindatabaseNNN**, where *NNN* is a random number. |
    | Server | Select **Create new**, and enter the details that are in the following table. |
    | Want to use SQL elastic pool? | No |
    | Compute + storage | General purpose |

    For the server, specify the following details in the **New server** pane, and then click **Select**.

    | Property  | Value  |
    |---|---|
    | Server name | **tailspinserver<em>NNN</em>**, where *NNN* is the same number that you selected for the database |
    | Server admin login | **azuresql** |
    | Password | Enter a password that meets the requirements. |
    | Confirm password | Confirm your password. |
    | Location | Enter a location near you. |
    | Allow Azure services to access server | Checked |

1. Select **Review + create**.

1. Select **Create**, and wait for the server and database to be created before you continue.

1. Once the server, database and storage has been created, select **Go to resource**.

1. On the **tailspindatabaseNNN** page, select **Connection strings**. Copy this connection string. You will need it to connect your App Service to the Azure SQL database.

   ![Azure portal selecting connection strings page](../media/4-get-connection-string.png)

    Notice that the connection string doesn't show your username and password. You'll need to fill those in when you're ready to use this string.

1. In order to access the database you just created, you need to set a firewall rule to allow your IP address.
    1. Select **SQL databases** on the far left side menu in your Azure portal.
    1. Select **tailspindatabaseMNNN** where NNN is your random number.
    1. At the top, select **Set server firewall**.
    1. Your current IP address is printed next to **Client IP address**. Enter the following rule:

    | Property  | Value  |
    |---|---|
    | Rule name| LocalIP |
    | Start IP | Enter your IP address |
    | End IP | Enter your IP address. |

    1. Select **Save** at the top and then **OK**.

## Create the tables

You can now create the tables to store the data.

1. Select **SQL databases** on the far left side menu.
1. Select **tailspindatabaseMNNN** where NNN is your random number.
1. On the **tailspoindatabaseNNN** page, select **Query editor**.

1. On the **tailspindatabaseNNN - Query editor** page, enter the following details, and then select **OK** to connect to the database service.

    | Property  | Value  |
    |---|---|
    | Authorization type | SQL server authentication |
    | Login | azuresql |
    | Password | Specify the password that you used when you created this user. |

1. In your local **database** branch, find the **CreateTables** file and copy the entire contents to the clipboard. In the **Query 1** pane in the Query Editor, paste the SQL statements you copied, and then select **Run**. This statement creates the new tables to hold the profile and score data for the SpaceGame web site. Verify that the statement runs without any errors.

1. In the database window, select the **Refresh** button on the toolbar. Expand **Tables**, and then expand each table in turn. You should see the four tables (**dbo.Profile**, **dbo.Scores**, **dbo.Achievements**, and **dbo.ProfileAchievements**), together with the columns and keys for each table.

    > [!NOTE]
    > *dbo* stands for *database owner*. It's the default schema in the database. All four tables were created in this schema.

    ![The Query editor window in the Azure portal. The user has entered a statement to create the Courses table](../media/4-create-tables.png)

## Import the data

1. Back in Visual Studio Code, open the **Data** folder and notice four **.csv** files. Each .csv file there holds the test data the web site will need and corresponds to a table you just created. Open a terminal and make sure that you're in the **Data** folder.

    ```bash
    cd Data
    ```

1. Create the variables that you will use in the later steps. Replace `NNN` with the number that you used for your database and server and use the password you created.

    ```bash
    export DATABASE_NAME=tailspindatabaseNNN
    export DATABASE_SERVER=tailspinserverNNN
    export AZURE_USER=azuresql
    export AZURE_PASSWORD=[enter your password]
    ```

1. Run the following command to import the data in the **profiles.csv** file to the dbo.Profiles table.

    ```bash
    bcp Profiles in profiles.csv -S "$DATABASE_SERVER.database.windows.net" -d $DATABASE_NAME -U $AZURE_USER -P $AZURE_PASSWORD -q -c -t ,
    ```

    Verify that `bcp` utility imports 20 rows and doesn't report any errors.

1. Run the following command to import the data in the **scores.csv** file to the dbo.Scores table.

    ```bash
    bcp Scores in scores.csv -S "$DATABASE_SERVER.database.windows.net" -d $DATABASE_NAME -U $AZURE_USER -P $AZURE_PASSWORD -q -c -t ,
    ```

    Verify that this command imports 24 rows.

1. Run the following command to import the data in the **achievements.csv** file to the dbo.Achievements table.

    ```bash
    bcp Achievements in achievements.csv -S "$DATABASE_SERVER.database.windows.net" -d $DATABASE_NAME -U $AZURE_USER -P $AZURE_PASSWORD -q -c -t ,
    ```

    Verify that this command imports 10 rows.

1. Run the following command to import the data in the **profileAchievements.csv** file to the dbo.ProfileAchievements table.

    ```bash
    bcp ProfileAchievements in profileAchievements.csv -S "$DATABASE_SERVER.database.windows.net" -d $DATABASE_NAME -U $AZURE_USER -P $AZURE_PASSWORD -q -c -t ,
    ```

    Verify that this command imports 121 rows.

### Query the data in the database

1. Return to the Azure portal and the query editor.

1. At the top, select **New Query**.

1. In the **Query 2** pane, enter the following SQL statement, and then select **Run**.

    ```SQL
    SELECT * FROM dbo.Profiles
    ```

    This statement retrieves the data from the **Profiles** table. The results window should display 20 rows.

    ![Screenshot of the query editor in the Azure portal, showing the data retrieved from the Profiles table](../media/4-select-all-profiles.png)

1. Change the query as follows, and then select **Run**.

    ```SQL
    SELECT * FROM dbo.Scores
    ```

    This time you should see the scores in the **Results** window. There are 24 rows.

## Create the Azure App Service environments

In [Create a release management workflow with Azure Pipelines](/learn/modules/create-a-release-management-workflow?azure-portal=true), you created one App Service instance that corresponds to each of the _Dev_, _Test_, and _Staging_ environments. There you worked through it step by step. Here we will create them all quickly using the command-line interface (CLI) through Azure Cloud Shell.

### Bring up Cloud Shell through the Azure portal

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. From the menu bar, select Cloud Shell. Make sure to select **Bash** from the drop-down menu at the upper left of the cloud shell.

    ![Selecting Cloud Shell from the menu bar](../../shared/media/azure-portal-menu-cloud-shell.png)

    > [!NOTE]
    > Cloud Shell requires an Azure storage resource to persist any files you create while working in Cloud Shell. On first launch, Cloud Shell prompts to create a resource group, storage account, and Azure Files share on your behalf. This is a one-time step and will be automatically attached for all future Cloud Shell sessions.

### Select an Azure region

To make the commands easier to run, start by selecting a default region. After you specify the default region, later commands use that region unless you specify a different region.

1. Run `az configure` to set your default region. Replace **\<REGION>** with the name of the region you chose for your database.

    ```bash
    az configure --defaults location=<REGION>
    ```

    Here's an example that sets **westus2** as the default region.

    ```bash
    az configure --defaults location=westus2
    ```

### Create the App Service instances

Here, you create the App Service instances for the three stages you'll deploy to: _Dev_, _Test_, and _Staging_.

To do so, you:

> [!div class="checklist"]
> * Generate a random number that makes your web app's domain name unique.
> * Create an App Service plan.
> * Create the App Service instances, one for each of the  _Dev_, _Test_, and _Staging_ environments.
> * Set an Application Configuration key/value pair to store the connection string to the database .
> * Get the hostname for each of your environments.
> * Verify that each environment is running and that the home page is accessible.

1. From Cloud Shell, generate a random number that makes your web app's domain name unique

    ```bash
    webappsuffix=$RANDOM
    ```

1. Run the following `az appservice plan create` command to create an app service plan that's named **tailspin-space-game-asp**.

    ```bash
    az appservice plan create \
      --name tailspin-space-game-asp \
      --resource-group tailspin-space-game-rg \
      --sku B1
    ```

    The `--sku` argument specifies the **B1** plan, which runs on the **Basic** tier.

    > [!IMPORTANT]
    > If the **B1** SKU is not available as part of your Azure subscription, [choose a different plan](https://azure.microsoft.com/pricing/details/app-service/linux/), such as **S1** (**Standard**).

1. Run the following `az webapp create` commands to create the three App Service instances, one for each of the  _Dev_, _Test_, and _Staging_ environments.

    ```bash
    az webapp create \
      --name tailspin-space-game-web-dev-$webappsuffix \
      --resource-group tailspin-space-game-rg \
      --plan tailspin-space-game-asp

    az webapp create \
      --name tailspin-space-game-web-test-$webappsuffix \
      --resource-group tailspin-space-game-rg \
      --plan tailspin-space-game-asp

    az webapp create \
      --name tailspin-space-game-web-staging-$webappsuffix \
      --resource-group tailspin-space-game-rg \
      --plan tailspin-space-game-asp
    ```

1. Run the following `az webapp list` command to list the hostname and state of each App Service instance.

    ```blah
    az webapp list \
      --resource-group tailspin-space-game-rg \
      --query "[].{hostName: defaultHostName, state: state}" \
      --output table
    ```

    Note the hostname for each running service. You'll need these hostnames to set the connection string to the database and later when you verify your work. Here's an example:

    ```output
    HostName                                                 State
    -------------------------------------------------------  -------
    tailspin-space-game-web-dev-21017.azurewebsites.net      Running
    tailspin-space-game-web-test-21017.azurewebsites.net     Running
    tailspin-space-game-web-staging-21017.azurewebsites.net  Running
    ```

1. Configure the connection string to the database in each App Service. Use the names of the app services you discovered above. Be sure to replace the **NNN** with your random number. Replace \<paste your connection string here\> with your connection string. Make sure you have replaced the `{your_username}` and `{your_password}` with the username and password you set up when you created the database.

    ``` bash
    az webapp config connection-string set \
        -n tailspin-space-game-web-dev-NNN -g tailspin-space-game-rg \
        --settings "DefaultConnection=<paste your connection string here>" \
        --connection-string-type SQLAzure

    az webapp config connection-string set \
        -n tailspin-space-game-web-test-NNN -g tailspin-space-game-rg \
        --settings "DefaultConnection=<paste your connection string here>" \
        --connection-string-type SQLAzure

    az webapp config connection-string set \
        -n tailspin-space-game-web-staging-NNN -g tailspin-space-game-rg \
        --settings "DefaultConnection=<paste your connection string here>" \
        --connection-string-type SQLAzure
    ```

    This will create an application setting called **DefaultConnection** that the application can use to connect to the database. This allows us to use the connection string without having to set it in the appSettings.json file and have it in plain text in source control.

> [!IMPORTANT]
> Remember, the [Clean up your Azure DevOps environment](/learn/modules/create-a-release-management-workflow/6-clean-up-environment?azure-portal=true) page in this module contains important cleanup steps. Cleaning up helps ensure that you're not charged for Azure resources after you complete this module. Be sure to perform the cleanup steps even if you don't complete this module.

## Create a service connection

Here, you create a service connection that enables Azure Pipelines to access your Azure subscription. Azure Pipelines uses this service connection to deploy the website to App Service. You created a similar service connection in the previous module.

> [!IMPORTANT]
> Make sure that you're signed in to both the Azure portal and Azure DevOps under the same Microsoft account.

1. In Azure DevOps, go to your **Space Game - web - Database** project.
1. Select **Project settings** from the bottom corner of the page.
1. Under **Pipelines**, select **Service connections**.
1. Select **+ New service connection** and then choose **Azure Resource Manager**.

    The **Add an Azure Resource Manager service connection** dialog appears.
1. From the dialog, ensure **Service Principal Authentication** is selected. Then fill in these fields:

    | Field               | Value                                        |
    |---------------------|----------------------------------------------|
    | **Connection name** | **Resource Manager - Tailspin - SpaceGame** |
    | **Scope level**     | **Subscription**                             |
    | **Subscription**    | Your Azure subscription                      |
    | **Resource Group**  | **tailspin-space-game-rg**                   |

    During the process, you might be prompted to sign in to your Microsoft account.

1. Select **OK**.

    Azure DevOps performs a test connection to verify that it can connect to your Azure subscription. If Azure DevOps is unable to connect, you'll have the chance to sign in a second time.

## Create pipeline variables in Azure Pipelines

In [Create a release pipeline with Azure Pipelines](/learn/modules/create-release-pipeline?azure-portal=true), you added a variable to your pipeline that stores the name of your web app in App Service. Here, you do the same. However, this time, you add one variable for each of the App Service instances that corresponds to the _Dev_, _Test_, and _Staging_ stages in your pipeline.

You will also need to create variables for the username and password for your Azure SQL instance. The pipeline will need this to make schema changes on your behalf.

To add the variable:

1. In Azure DevOps, go to your **Space Game - web - Database** project.
1. Under **Pipelines**, select **Library**.

    ![Azure Pipelines showing the Library menu option](../../create-release-pipeline/media/5-pipelines-library.png)
1. Select **+ Variable group**.
1. Under **Properties**, enter **Release Pipeline** for the variable group name.
1. Under **Variables**, select **+ Add**.
1. Enter **WebAppNameDev** as the name of your variable. Enter the name of the App Service instance that corresponds do your _Dev_ environment, such as **tailspin-space-game-web-dev-1234**, as its value.
1. Repeat steps 5 and 6 to create variables for your _Test_ and _Staging_ environments as well as the pipeline access to Azure SQL, as shown in this table:

    | Variable name         | Example value                            |
    |-----------------------|------------------------------------------|
    | **WebAppNameTest**    | **tailspin-space-game-web-test-NNN**    |
    | **WebAppNameStaging** | **tailspin-space-game-web-staging-NNN** |
    | **adminlogin**        | **azuresql** |
    | **adminPassword**     | The password you assigned when you created the database |
    | **subscription**      | **Resource Manager - Tailspin - SpaceGame**  |
    | **servername**        | **tailspinserverNNN**  |
    | **databasename**      | **tailspindatabaseNNN**  |

    Be sure to replace each example value with the App Service instance that corresponds to your environment.

1. Select **Save** near the top of the page to save your variables to the pipeline.

    Your variable group resembles this one:

    > ![Azure Pipeline showing the variable group](../media/4-variables-library.png)

## Add the database stage to the pipeline

Here you add the pipeline stage that will check for database schema changes so the database administrator can approve or edit the proposed changes. In this exercise, there will not be any schema changes. You do that in the next exercise.

1. Open the **azure-pipelines.yml** file you got when you switched to the **database** branch.
1. Copy the new pipeline below and replace the code that is already in the **azure-pipelines.yml** file.

    [!code-yml[](code/azure-pipelines1.yml?highlight=78-94,96-130,132-160)]

    This pipeline adds a new build job for the Tailspin.SpaceGame.Database project. This will result in a `.dacpac` file being created that contains information about the database schema. That `.dacpac` file will be copied and saved off as an artifact called **dropDacpac**.

    ```yml
    - task: VSBuild@1
      displayName: 'Build project Tailspin.SpaceGame.Database/Tailspin.SpaceGame.Database.sqlproj'
      inputs:
        project: Tailspin.SpaceGame.Database/Tailspin.SpaceGame.Database.sqlproj
    - task: CopyFiles@2
      displayName: 'Copy dacpac file to Staging'
      inputs:
        Contents: |
          Tailspin.SpaceGame.Database/bin/**/*.dacpac
        TargetFolder: '$(Build.StagingDirectory)'  
    - task: PublishBuildArtifacts@1
      displayName: 'Publish Artifact'
      inputs:
        PathtoPublish: '$(build.artifactstagingdirectory)'
        artifactName: dropDacpac
      condition: succeededOrFailed()
    ```

    The new stages are `DBAVerificationScript` and `DBAVerificationApply`.

    The `DBAVerificationScript` stage will read the `.dacpac` file and create a change script for the database. We then write out that change script so the database administrator can approve the changes before the changes are applied to the database.

    ```yml
    - task: SqlAzureDacpacDeployment@1
        displayName: Generate Auto Gen DB Update Script
        inputs:
            azureSubscription: 'Resource Manager - Tailspin - Space Game'
            AuthenticationType: 'server'
            ServerName: 'tailspinsvr.database.windows.net'
            DatabaseName: 'Tailspin'
            SqlUsername: '$(adminlogin)'
            SqlPassword: '$(adminPassword)'
            deployType: 'DacpacTask'
            DeploymentAction: 'Script'
            DacpacFile: '$(Pipeline.Workspace)/dropDacpac/Tailspin.SpaceGame.Database/bin/Debug/Database.dacpac'
            IpDetectionMethod: 'AutoDetect'

    - task: PowerShell@2
        displayName: Show Auto Generated SQL Script
        inputs:
            targetType: 'inline'
            script: |
            Write-Host "Auto Generated SQL Update Script:"
            Get-Content d:\a\1\s\GeneratedOutputFiles\Tailspin_Script.sql | foreach {Write-Output $_}
    ```

The `DBAVerificationApply` stage will read the auto generated file and apply the change script to the database.

   ```yml
        steps:
        - download: current
        artifact: dropDacpac
        patterns: '**/*'
        - task: SqlAzureDacpacDeployment@1
        displayName: 'Deploy SQL Schema'
        inputs:
            azureSubscription: 'Resource Manager - Tailspin - SpaceGame'
            AuthenticationType: 'server'
            ServerName: '$(servername).database.windows.net'
            DatabaseName: '$(databasename)'
            SqlUsername: '$(adminlogin)'
            SqlPassword: '$(adminPassword)'
            deployType: 'DacpacTask'
            DeploymentAction: 'Publish'
            DacpacFile: '$(Pipeline.Workspace)/dropDacpac/Tailspin.SpaceGame.Database/bin/Debug/tailspin.SpaceGame.Database.dacpac'
            IpDetectionMethod: 'AutoDetect'
   ```

1. Save the file and commit it, but do not push it to origin yet. You still have some setup to do in Azure DevOps.

    ```bash
    git add azure-pipelines.yml
    git commit -m "add database schema checks to the pipeline"
    ```

### Create an environment for manual approval

Here you create the manual approval for the `DBAVerificationApply` stage. You learned about manual approvals in the last module. Recall that you need to set up an environment and add an approver.

1. From Azure Pipelines, select **Environments**
1. Select **New environment**.
1. Under **Name**, enter **dbavarification**.
1. Leave the remaining fields at their default values.
1. Select **Create**.
1. On the **dbaverification** environment page, select the drop down menu, then select **Checks**.

    ![Azure Pipelines showing the Checks menu option](../media/4-add-check-to-environment.png)

1. On the **Use manual approvals** page, select **Create**.
1. Under **Approvers**, select **Add users and groups** and then select your account.
1. Under **Instructions to approvers**, enter:

    > Approve this change to the database schema.
1. Select **Create**.

## Run the pipeline

1. Push the changes to the pipeline up to origin. This will cause the pipeline to run.

    ```bash
    git push origin database
    ```

1. Select the pipeline and wait for the manual approval of the database schema. When the pipeline stops for approval, click on the `DBAVerificationScript` stage and look at the change script that was created. It will be in the **Show automated SQL Script** section. The script should not have any changes since we didn't change anything in the database yet. You will know there are no changes because you do not see **CREATE**, **ALTER**, or **DROP** statements in the script.
1. Go back to the pipeline and select the **waiting** button on the `DBAVerificationApply`. Select **Review** and then **Approve**.
1. Wait for the pipeline to finish deployments.

    ![Azure Pipelines showing the pipeline stages](../media/4-pipeline-run.png)

1. Check at least one of the web addresses to see that the application has been deployed and is working with the database.

**Tim:** Great! I feel good about going to the DBA with this so far. Let's try it with the schema change we have been working on.
