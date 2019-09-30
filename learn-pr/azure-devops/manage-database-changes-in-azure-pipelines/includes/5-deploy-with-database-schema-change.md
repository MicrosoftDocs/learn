Tim and Andy are happy with the pipeline and the manual approval of schema changes but they still need to try it with the actual changes that they are working on. Tim has gone to get the database administrator to show them the process and get the approval they need.

## Fetch the branch from GitHub

Here, you fetch the `database-changes` branch from GitHub and checkout, or switch to, that branch.

This branch contains the _Space Game_ project with the changes to the web site code that expects the Profile table to have a `favoriteMap` column. This new column's data will be displayed on the Profile page as **Favorite Galaxy:**. It also has the Azure Pipelines configuration you created in the last unit.

In the Tailspin.SpaceGame.Database project, a change has been made to the Profile table. The `favoriteMap` column has been added. Optionally, if you are on a Windows machine with SQL Server Data Tools installed and open the solution in Visual Studio, you will see a `dbo` folder. This will have the scripts for each of the tables. Open the **Profiles.sql** and see that the new column is there.

1. In Visual Studio Code, open the integrated terminal.
1. Run the following `git` commands to fetch a branch named `database-changes` from Microsoft's repository and switch to that branch.

    ```bash
    git fetch upstream database-change
    git checkout database-change
    ```

1. Use an empty commit to run the pipeline.

    ```bash
    git commit --allow-empty -m "Trigger pipeline for DBA Verification Approval"
    ```

1. Watch the pipeline and wait for the manual approval of the database schema. When the pipeline stops for approval, click on the `DBAVerificationScript` stage and look at the change script that was created. This time there will be an `ALTER TABLE` sql statement for adding the new column to the Profiles table.
1. Go back to the pipeline and select the **waiting** button on the `DBAVerificationApply` stage. Select **Review** and then **Approve**.
1. Allow the pipeline to finish deploying the App Services.
1. You still need to add data to the new column before you can try the new web site.
    1. Navigate back to your [Azure portal](https://portal.azure.com?azure-portal=true) and select **SQL Databases**.
    1. Select your database **tailspindatabaseNNN** where NNN is your numbers.
    1. Select **Query editor** and sign in.
    1. In your local _database-change_ branch you see **FavoriteMapData.sql**. This sql script adds a favorite galaxy string to each profile by filling in the `favoriteMap` column. Copy the contents of this file.
    1. Paste the file contents into **Query 1** and select **Run** to populate the new table.
    1. Verify that the queries ran successfully.
    1. Select **New Query**.
    1. In **Query 2** add the following T-SQL.

        ```sql
        SELECT * FROM dbo.Profiles
        ```

        Verify that the `favoriteMap` column is populated with data.
1. Navigate to the one of your host names, for example **tailspin-space-game-wen-dev-NNN**, and select a player to see the new data on the profile.

 ![The web site with a profile showing the player's favorite galaxy](../media/5-profile-with-favorite-galaxy.png)

**Tim:** I think that went well. We managed to get the DBA involved and they are one tough customer. Score one for DevOps. But I can see a problem here. This pipeline is triggered with every change made to the application. We won't have schema changes every time, but the pipeline will stop and wait for approval even if the change file has no changes. How can we fix that?

**Mara:** Look at you being into DevOps! I have an idea. We already have a change script in the pipeline. Maybe we can check that script for key words that signal a change and only trigger the `DBAVerificationApply` stage if those words are in the file.

**Andy:** I think that could work. We'll need a pipeline variable to check as a triggering condition.

## Checking for database changes

Here you add the following changes to the pipeline to skip the `DBAVerificationApply` stage if there are no changes that need to be applied to the database.

### Check for keywords in the generated script

In this section you add to the PowerShell script that created the change file and check to see if a change to the database is pending. You will know there is a change if the words **CREATE**, **ALTER**, or **DROP** are present in the file. Do not copy this yet. Soon you will replace the entire **azure-pipelines.yml** file contents as you did in the previous exercise.

   ```powershell
   $containsWord = $file | %{$_ -match "CREATE" -or $_ -match "ALTER" -or $_ -match "DROP"}
   ```

### Passing a pipeline variable change between stages

If the keyword search returns a match, create a variable in the pipeline variable group and set its value to true. If the variable is in the pipeline variable group, it can be seen by all stages. Setting a new variable in a stage is only scoped to that stage. Here you use a PowerShell library created by Donovan Brown, [VSTeam](https://www.powershellgallery.com/packages/VSTeam/6.3.5?azure-portal=true), that uses the Azure Pipelines REST API to access Azure Pipelines. Again, do not copy this yet. Soon you will replace the entire **azure-pipelines.yml** file contents as you did in the previous exercise.

  ```powershell
   if ($containsWord -contains $true) {
    Install-Module VSTeam -Scope CurrentUser -Force
    Set-VSTeamAccount –Account $(Acct) -PersonalAccessToken $(PAT)
    $methodParameters = @{
      ProjectName = "$(System.TeamProject)"
      Name = "Release Pipeline"}
    $vg = Get-VSTeamVariableGroup  @methodParameters 
    $vars = @{}
    $vg.value.variables | Get-Member -MemberType *Property | %{$vars.($_.Name) = $vg.value.variables.($_.Name)}
    $varName = "schemaChanged"
    $vars.$varName= @{}
    $vars.$varName.value = "True"
    $vars.$varName.isSecret = $false
    $methodParameters = @{
      id = $vg.value.id
      ProjectName = "$(System.TeamProject)"
      Name = "Release Pipeline"
      Description = "Variables for Tailspin Pipeline"
      Type = "Vsts"
      Variables = $vars}
    Update-VSTeamVariableGroup @methodParameters}
   ```

In the `DBAVerificationApply` stage, you do the same thing, however instead of creating a variable, you remove it.

### Edit the pipeline to use a condition

Here you add a condition to the `DBAVerificationApply` stage to check that the new variable is set to true. The variable will not exist if there are no changes to the database schema and this stage will be skipped. Again, do not copy this yet. Soon you will replace the entire **azure-pipelines.yml** file contents as you did in the previous exercise.

   ```yml
   - stage: DBAVerificationApply
     variables:
      - group: 'Release Pipeline'
     condition: and(succeeded(), eq(variables['schemaChanged'], 'True'))
     dependsOn: DBAVerificationScript
   ```

## Make the changes to the pipeline

The VSTeam library needs to access your Azure DevOps organization, so it will need permission. Here you create a **Personal Access Token** for the VSTeam calls in the powershell script.

1. Navigate to your Azure DevOps organization and select your picture in the upper right corner.
1. Select **Azure DevOps Profile**
1. In the **User Settings** pane on the left, under **Security**, select **Personal access tokens**.

       ![Profile page select personal access token](../media/5-select-personal-access-token.png)

1. Select **+ New Token**
1. Enter **Database Changes** as the name and select **Full access**.
1. Select **Create**.
1. Be sure to copy that token as it will never be shown in plain text again.
1. You need to add two variables to the **Release Pipeline** variable group.
1. Navigate to your **Space Game - web - database** project and select **Pipelines**.
1. Under **Pipelines**, select **Library**.
1. Select **Release Pipeline** and add the following variables:

| Variable name         | Example value                            |
|-----------------------|------------------------------------------|
| **Acct**    | The name of your organization in Azure DevOps    |
| **PAT** | Paste your Personal Access Token - be sure to select the lock icon to encrypt this value. |

1. Open the **azure-pipelines.yml** file you got when you switched to the **database-change** branch.
1. Copy the new pipeline below and replace the code that is already in the **azure-pipelines.yml** file.

    [!code-yml[](code/azure-pipelines2.yml?highlight=131-153,158,1193-219)]

    This pipeline adds to the PowerShell script to check the generated SQL script for the keywords **CREATE**, **ALTER**, or **DROP** and creates a `schemaChanged` variable and updates the pipeline variable group. Then a condition is added to the `DBAVerificationApply` stage to check for this variable. If this variable is `True`, there is a change that needs approval, if it is not there, then there are no changes in the script and this stage is skipped because the condition fails.

1. Push the changes to the pipeline up to origin. This will cause the pipeline to run.

    ```bash
    git add azure-pipelines.yml
    git commit -m "add condition for database approval stage"
    git push origin database-changes
    ```

1. Navigate back to Azure DevOps and watch the pipeline run, See that the `DBAVerificationApply` stage is skipped since there are no schema changes.

## Best Practice

In this exercise, you created a variable to use as a condition for a stage. In reality, the variable must be unique per pipeline run since you may be running this pipeline in parallel. If you are using the **Release Pipeline** editor for your project, you can use the [suggested PowerShell from Donovan Brown](http://donovanbrown.com/post/Passing-variables-from-stage-to-stage-in-Azure-DevOps-release?azure-portal=true) to create a variable that is unique to that specific release. However, since you used the preview multi-stage YAML pipeline in this exercise, it is not possible yet to create this scenario. This is a feature that is promised in the future. It will be added to this exercise when the feature releases.
