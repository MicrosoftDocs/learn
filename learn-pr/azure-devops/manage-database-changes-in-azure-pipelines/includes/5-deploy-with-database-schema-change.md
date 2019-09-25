Tim and Andy are happy with the pipeline and the manual approval of schema changes but they still need to try it with the actual changes that they are working on. Tim has gone to get the database administrator to show her the process and get the actual approval they need.

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
    Get this from Thomas
    ```

1. Watch the pipeline and wait for the manual approval of the database schema. When the pipeline stops for approval, click on the `DBAVerificationScript` stage and look at the change script that was created. This time there will be an `ALTER TABLE` sql statement for adding the new column to the Profiles table.
1. Go back to the pipeline and select the **waiting** button on the `DBAVerificationApply`. Select **Review** and then **Approve**.
1. Allow the pipeline to finish deploying the App Services.
1. You still need to add data to the new column before you can try the new web site.
    1. Navigate back to your [Azure portal](https://portal.azure.com?azure-portal=true) and select **SQL Databases**.
    1. Select your database **tailspindatabaseNNN** where NNN is your numbers.
    1. Select **Query editor** and sign in.
    1. In the _database-change_ branch you see **FavoriteMapData.sql**. This sql script adds a favorite galaxy string to each profile by filling in the `favoriteMap` column. Copy the contents of this file.
    1. Paste the file contents into **Query 1** and select **Run** to the new data to the table.
    1. Verify that the queries ran successfully.
    1. Select **New Query**.
    1. In **Query 2** add the following T-SQL.

        ```sql
        SELECT * FROM dbo.Profiles
        ```

        Verify that the `favoriteMap` column is populated with data.
1. Navigate to the one of your host names, for example **tailspin-space-game-wen-dev-NNN**, and select a player to see the new data on the profile.

**(Screenshot)**

**Tim:** I think that went well. We managed to get the DBA involved and she is one tough customer. Score one for DevOps. But I can see a problem here. This pipeline is triggered with every change made to the application. We won't have schema changes every time, but the pipeline will stop and wait for approval even if the change file has no changes. How can we fix that?

**Mara:** Look at you being into DevOps! I have an idea. We already have a change script in the pipeline. Maybe we can check that script for key words that signal a change and only trigger the `DBAVerificationApply` stage if those words are in the file.

**Andy:** I think that could work. We'll need a pipeline variable to check as a triggering condition.

## Edit the pipeline to use a condition

<!-- Here you make the changes you need to the variable group and pipeline to skip the `DBAVerificationApply` stage if there are no changes to verify.

To add the variable:

1. In Azure DevOps, go to your **Space Game - web - Database** projecet.
1. Under **Pipelines**, select **Library**.

    ![Azure Pipelines showing the Library menu option](../../create-release-pipeline/media/5-pipelines-library.png)
1. Select **+ Variable group**.
1. Select **Release Pipeline**.
1. Under **Variables**, select **+ Add**.
1. Enter **SCHEMA_CHANGED** as the name of your variable. Enter `1` as the value. -->

Edit the pipeline:

1. Open the **azure-pipelines.yml** file you got when you switched to the **database-change** branch.
1. Copy the new pipeline below and replace the code that is already in the **azure-pipelines.yml** file.

    [!code-yml[](code/azure-pipelines2.yml)]

    This pipeline adds t... that will now check the generated SQL script for the keywords **CREATE**, **ALTER**, or **DROP** and set ... to `0` if any of these words exist. Then a condition is added to the `DBAVerificationApply` stage to check if this variable is `0`. If it is, there is a change that needs approval, if it is still `1` then there are no changes in the script and this stage is skipped.

    ```yml

    ```

1. Push the changes to the pipeline up to origin. This will cause the pipeline to run.

    ```bash
    git add azure-pipelines.yml
    git commit -m "add condition for database approval stage"
    git push origin database-changes
    ```

1. Navigate back to Azure DevOps and watch the pipeline run, See that the ... job in  `DBAVerificationApply` stage is skipped since there are no schema changes.
