The team needs to create the Azure SQL Database off of Mara's prototype. She has given them a *bacpac* file so that they can create the database with data in it. After that, they want to test the changes to the application locally using the Azure SQL Database they created.

**TODO**: This is the first time we're referencing the term "bacpac". We might need to introduce it here to avoid confusion with "dacpac".

Here, you follow along with Andy, Mara, and Tim as they create the database and run the application locally.

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

1. Optionally, in Visual Studio Code, open the *azure-pipelines.yml* file, and familiarize yourself with the initial configuration.

    The configuration resembles the ones that you created in the previous modules in this learning path. It builds only the application's **Release** configuration. For brevity, it also omits the triggers, manual approvals, and tests you set up in previous modules.

    [!include[](../../shared/includes/pipeline-branches-note.md)]

## Create the database

Here, you set up Azure SQL Database and verify that it contains sample data. You do so through the Azure portal because it's a great way to explore Azure services. In a future learning path, you'll learn how to automate the process.

> [!IMPORTANT]
> Remember that you need your own Azure subscription to complete the exercises in this module.

### Get the bacpac file and upload it to Azure storage

Mara has created the development database with test data in it. She exported this database for you to use. The export is in a file format called *.bacpac*. This format has the database schema and the data. You need to get this file and put it in blob storage on Azure so your SQL Server logical instance can create a database from it.

> [!NOTE]
> If you haven't worked with blob storage on Azure, just follow along. We'll point you to more resources at the end of this module.

1. Download the [bacpac file](https://learnmodulestorage.blob.core.windows.net/moduleblobs/tailspindatabase.bacpac?azure-portal=true).

    You'll need to upload this file to your storage account later.
1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true). Then select **Storage accounts** on the left.
1. On the **Storage account** page select **+ Add**
1. Fill in the **Create storage account*    * page as follows:

    | Property  | Value  |
    |---|---|
    | Subscription | < your subscription > |
    | Resource Group | Select **Create new** and name it **tailspin-space-game-rg**. |
    | Storage account name | This must have a unique name across Azure. We suggest using something like **spacegamedbstorageNNN**, where *NNN* is a random number. |
    | Location | Choose a location near you that supports this kind of resource. |

   You can leave the rest as the default values.

1. Select **Review and create**. Then select **Create**.
1. Wait for the storage account to be created and select **Go to resource**.
1. Under **Services**, select **containers**.
![Screenshot of the services section of the containers page](../media/4-select-containers.png)
1. On the **Containers** page, select **+ Container**.
1. In the **Name** field, enter **bacpac** and select **OK**.
1. Select the **bacpac** container.
1. On the **bacpac** page, select **Upload**.
1. Upload the *tailspindatabase.bacpac* file that you downloaded earlier.

### Create the SQL Server logical instance and the database

Here you create the SQL Server that holds your new database.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true). Then select **+ Create a Resource**.
1. In the search bar, enter **SQL server (logical server)**.
1. On the **SQL server (logical server)** page, select **Create**.
1. Fill in the *Create SQL database server* page as follows:

    | Property  | Value  |
    |---|---|
    | Subscription | < your subscription > |
    | Resource Group | **tailspin-space-game-rg** |
    | Server name | **tailspin-space-game-sql** |
    | Server admin login | **azuresql** |
    | Password | Enter a password that meets the requirements. |
    | Confirm password | Confirm your password. |

1. Select **Review + create**, then select **Create**.
1. After the server is created, select **Go to resource**.

### Populate your database

Here, you import the *bacpac* file that you uploaded to blob storage to your SQL Server database. You fetch the *bacpac* file from the blob storage you set up earlier.

1. Select **Import database**.
![Screenshot of the import database menu selection](../media/4-import-database-menu.png)
1. On the *Import database* page select your subscription and then select **Storage - Configure required settings**.
![Screenshot of the import database page highlighting configure storage settings](../media/4-configure-storage-settings.png)
1. On your **Storage accounts** page select **spacegamedbstorageNNN**, where **NNN** is your number.
1. On the **Containers** page, select **bacpac**.
1. Highlight the **tailspindatabase.bacpac** file and then choose **Select**.
1. Back on the **Import database** page, enter **azuresql** for the admin username and the password you used to set up the SQL Server instance.
1. Select **OK** and wait for the database to be created.
1. Select **Go to resource**.

### Explore the database

Here you explore the database you just imported. You need to set a firewall rule to access the database from your local machine.

1. Navigate back to the Azure portal home page and select **SQL databases** on the left.
1. Choose the **tailspindatabase**.
1. At the top of the **tailspindatabase** page, select **Set server firewall**.
1. Your current IP address is printed next to **Client IP address**. Enter the following rule:

  | Property  | Value  |
  |---|---|
  | Rule name| LocalIP |
  | Start IP | Your IP address |
  | End IP | Your IP address |

1. Select **Save** at the top and then **OK**.
1. Navigate back to the **tailspindatabase** page and select select **Query editor**.
1. Enter **azuresql** for the admin username and your password for the password.

    > [!NOTE]
    > If you get an error message that contains an IP address, copy that IP address to your clipboard. Then click the link in the error message to return to the firewall rules. Update the IP addresses in the **LocalIP** firewall rule with the contents of the clipboard.
    > 
    > Then click **Save** and then **OK**. Then repeat this step.
1. Expand **Tables**, and then expand each table in turn. You should see four tables **dbo.Profile**, **dbo.Scores**, **dbo.Achievements**, and **dbo.ProfileAchievements**, together with the columns and keys for each table.

![Screenshot of the tables in the tailspin database](../media/4-database-tables.png)

1. In the **Query 1** pane, enter the following SQL statement, and then select **Run**.

    ```SQL
    SELECT * FROM dbo.Profiles
    ```

    This statement retrieves the data from the **Profiles** table. The results window should display 20 rows.

    ![Screenshot of the query editor in the Azure portal, showing the data retrieved from the Profiles table](../media/4-select-all-profiles.png)

1. Change the query as follows, and then select **Run**.

    ```SQL
    SELECT * FROM dbo.Scores
    ```

    This time you should see the scores in the **Results** window. There are 25 rows. Notice that the Score entry is related to the Profile by the ProfileID. The is the ID from the Profile table.
1. Change the query as follows, and then select **Run**.

    ```SQL
    SELECT * FROM dbo.Achievements
    ```

    This time you should see the list of possible Achievements in the **Results** window. There are 10 rows. Notice that they are not related to any profile. This is because profiles and achievements are a many-to-many relationship. This means a profile can have many achievements, and an achievement and show up on many profiles. To get the right achievements with the right profiles a ProfileAchievements table relates them.
1. Change the query as follows, and then select **Run**.

    ```SQL
    SELECT * FROM dbo.ProfileAchievements
    ```

    Each row is a correlation of the Profile Id and the Achievement Id.

### See the queries in the code

1. In the Tailspin-SpaceGame-Web project and open the **RemoteDBRepository.cs** file.
1. Notice the methods use SQL commands to get the data from the database. For example:

    ```C#
    sql = string.Format("Select a.description from dbo.Achievements a JOIN dbo.ProfileAchievements pa on a.id = pa.achievementid Where pa.profileid = {0}", profileId);
    command = new SqlCommand(sql, conn);
    using (SqlDataReader reader = command.ExecuteReader())
    ```

  This query gets the achievements for a specific profile. This is used to populate the achievements section of the player profile popup on the web site.

  Explore some of the other queries in the code file.

  Notice the `conn` variable. This is the connection to the database. We get this using a connection string. Next, you set up the connection to the database in your local environment so you can test the web site locally.

## Set up your local environment

Here you set up your environment to run the web site locally using the Azure SQL Database you created. The web site project is already set up to use the *secrets.json* file mentioned in the last unit. You need to put your connection string into a *secrets.json* file so that the project can find it.

1. Navigate to the **tailspindatabase** page in the Azure portal, select **Connection strings**, and copy this connection string.

   ![Azure portal selecting connection strings page](../media/4-get-connection-string.png)

    Notice that the connection string doesn't show your username and password. You'll need to fill those in when you're ready to use this string.
1. Open your local **Tailspin.SpaceGame.Web.csproj** file. Notice the entry for `UserSecretsId`. This is how the web project will find your *secrets.json* file. You will create a *secrets.json* file in a directory with that GUID in the name.

    ```xml
    <UserSecretsId>d7faad9d-d27a-4122-89ff-b9376c13b153</UserSecretsId>
    ```

1. Create the *secrets.json* file.
    1. Make sure you are in the directory containing the *Tailspin.SpaceGame.Web.csproj* file. In a terminal window in Visual Studio Code run this command.

          ```bash
          cd Tailspin.SpaceGame.Web
          ```

    1. The `dotnet` command from the .NET Core SDK has a `user-secrets` parameter that will create the directory structure and the file you need using the GUID it finds in your project. If you are on a Mac, the location for the file is `~/.microsoft/usersecrets/(GUID)/secrets.json`. If you are on Windows, the location for the file is `%APPDATA%\Microsoft\UserSecrets\(GUID)\secrets.json`. Run this command to create and populate the *secrets.json* file.

        ```bash
        dotnet user-secrets set "ConnectionStrings:DefaultConnection" "Your connection string"
        ```

        Make sure you have replaced the `{your_username}` and `{your_password}` with the username and password you set up when you created the server.
    1. Run the following command to read the secrets.json file and see that your connection string is there.

        ```bash
        dotnet user-secrets list
        ```

1. Build the application using the following `dotnet` command.

    ```bash
     dotnet build
     ```

1. Run the application using the following `dotnet` command.

    ```bash
     dotnet run
     ```

  Watch the output for "Now listening on (your local link)." For example, `Now listening on: http://localhost:64164`.
1. Hold the `control` key and click the link. This will open a browser at the locally hosted SpaceGame web page. Verify the web site is running locally.
1. In the bash terminal type `control-c` to shut down the application.

**Mara:** Great! We have it running locally. Let's put it on the pipeline.

--------------------------------
**New Unit**

At this point, the team's pipeline has four stages. The first stage produces the build artifact and the second stage deploys the _Space Game_ web application to App Service in the _dev_ environment. The third and fourth stages deploy the _Space Game_ web application to the _test_ and _staging_ environments. We have taken out the triggers and approvals from the previous module to concentrate on just this section of the pipeline.

Here, you follow along with Andy, Mara, and Tim as they modify the pipeline to add stages that will script the database changes for the DBA, and apply those changes after approval.

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

    ```azurecli
    az configure --defaults location=<REGION>
    ```

    Here's an example that sets **westus2** as the default region.

    ```azurecli
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

    ```azurecli
    az appservice plan create \
      --name tailspin-space-game-asp \
      --resource-group tailspin-space-game-rg \
      --sku B1
    ```

    The `--sku` argument specifies the **B1** plan, which runs on the **Basic** tier.

    > [!IMPORTANT]
    > If the **B1** SKU is not available as part of your Azure subscription, [choose a different plan](https://azure.microsoft.com/pricing/details/app-service/linux/), such as **S1** (**Standard**).

1. Run the following `az webapp create` commands to create the three App Service instances, one for each of the  _Dev_, _Test_, and _Staging_ environments.

    ```azurecli
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

    ```azurecli
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

### Configure the App Service to use the connection string

1. Configure the connection string to the database in each App Service. Use the names of the app services you discovered above. Be sure to replace the **NNN** with your random number. Replace \<paste your connection string here\> with your connection string. Make sure you have replaced the `{your_username}` and `{your_password}` with the username and password you set up when you created the database.

    ```azurecli
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

    This will create an application setting called **DefaultConnection** that the application can use to connect to the database. This allows us to use the connection string without having to set it in the appSettings.json file and have it in plain text in source control. Anyone with read access to the App Service can read this configuration file. You will normally set permissions on the App Service to restrict who has read access. You can use an Azure key vault to store the string as well. More information on that is provided in the links in the summary of this module.

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
    | **adminPassword**     | The password you assigned when you created the SQL server instance|
    | **subscription**      | **Resource Manager - Tailspin - SpaceGame**  |
    | **servername**        | **tailspinserverNNN**  |
    | **databasename**      | **tailspindatabase**  |

    Be sure to replace each example value with the App Service instance that corresponds to your environment.

1. Select **Save** near the top of the page to save your variables to the pipeline.

    Your variable group resembles this one:

    > ![Azure Pipeline showing the variable group](../media/4-variables-library.png)

## Add the database stage to the pipeline

Here you add the pipeline stage that will check for database schema changes so the database administrator can approve or edit the proposed changes. In this exercise, there won't be any schema changes. You do that in the next exercise.

1. Open the **azure-pipelines.yml** file from the **database** branch.
1. Copy the new pipeline below and replace the code that is already in the **azure-pipelines.yml** file.

    [!code-yml[](code/azure-pipelines1.yml?highlight=78-94,96-130,132-160)]

    This pipeline adds a new build job for the Tailspin.SpaceGame.Database project. This will result in a `.dacpac` file being created that contains information about the database schema. That `.dacpac` file will be copied to a staging directory in the pipeline and then published as an artifact called **dropDacpac**.

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

    The `DBAVerificationScript` stage will read the `.dacpac` file and create a change script for the database. Then you use a powershell script to write out that change script so the database administrator can approve the changes before the changes are applied to the database.

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
1. Under **Instructions to approvers**, enter **Approve this change to the database schema**.
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
