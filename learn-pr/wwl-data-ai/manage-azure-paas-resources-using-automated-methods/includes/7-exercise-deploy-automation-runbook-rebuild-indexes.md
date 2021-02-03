You have been hired as a Senior Data Engineer to help automate day to day operations of database administration. This automation is to help ensure that the databases for AdventureWorks continue to operate at peak performance as well as provide methods for alerting based on certain criteria. AdventureWorks utilizes SQL Server in both Infrastructure as a Service and Platform as a Service offerings. 

## Connect to the lab environment

1. When the VM lab environment opens, use the password on the **Resources** tab above for the **Student** account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/). This should be the home page of the browser.

1. The username and password information to sign into the Azure portal are in the  **Resources** tab above these instructions. If you select the **Username** it will be filled in for you.

1. Select **Next**.

1. Select the **Password** text in the **Resources** tab to have that filled in for you, then select **Sign in**.

1. Select **Yes**.

1. On the **Welcome to Azure** popup, select **Maybe later**.

## Create an Automation Account

1. In the Azure portal in the search bar type **automation** and then select **Automation Accounts** from the search results.

    :::image type="content" source="../media/dp-3300-module-66-lab-23.png" alt-text="Screenshot of selecting the Automation Accounts.":::

    Select **+ Add**.

1. On the **Add Automation Account** page enter this information:

    :::image type="content" source="../media/dp-3300-module-66-lab-25.png" alt-text="Screenshot of the Add Automation Account screen.":::

    - Name: **autoAccount**
    - Resource Group: **automateLab**
    - Location: Use the default.

1. Select **Create**.

    > [!NOTE]
    > Your automation account should be created in around three minutes.

## Connect to an existing Azure SQL Database

1. In the Azure portal, navigate back to your database by searching for **sql databases**.

    :::image type="content" source="../media/dp-3300-module-66-lab-24.png" alt-text="Screenshot of searching for existing SQL databases.":::

    Then select the SQL database **sample-db-with-tde**.

    :::image type="content" source="../media/dp-3300-module-66-lab-22.png" alt-text="Screenshot of selecting the sample-db-with-tde SQL database.":::  

1. On the **Overview** page select the **Query editor (preview)**.

    :::image type="content" source="../media/dp-3300-module-66-lab-27.png" alt-text="Screenshot of selecting the Query editor (preview).":::

1. You will be prompted for credentials to sign in to your database. Use these credentials:

    - Login: **labadmin**
    - Password: **Azur3Pa$$**

    :::image type="content" source="../media/dp-3300-module-66-lab-29.png" alt-text="Screenshot of the sign in error.":::

1. Select **Set server firewall** at the end of the error message shown above.

    :::image type="content" source="../media/dp-3300-module-66-lab-30.png" alt-text="Screenshot of adding the client IP.":::

1. Select **Add client IP**, then select **Save**.

1. Return to the Query editor, select **OK**, to sign in to your database.

1. Open a new tab in your browser and navigate to the GitHub page for **AdaptativeIndexDefragmentation**. [https://github.com/microsoft/tigertoolbox/blob/master/AdaptiveIndexDefrag/usp_AdaptiveIndexDefrag.sql](https://github.com/microsoft/tigertoolbox/blob/master/AdaptiveIndexDefrag/usp_AdaptiveIndexDefrag.sql)

    :::image type="content" source="../media/dp-3300-module-66-lab-26.png" alt-text="Screenshot of selecting Raw in GitHub.":::

    Select **Raw**. This will provide the code in a format where you can copy it. Select all of the text ( <kbd>CTRL</kbd> + <kbd>A</kbd> ) and copy it to your clipboard ( <kbd>CTRL</kbd> + <kbd>C</kbd> ).

1. Close the GitHub browser tab and return to the Azure portal.

1. Paste the text you copied into the Query 1 pane.

    :::image type="content" source="../media/dp-3300-module-66-lab-32.png" alt-text="Screenshot of selecting commands to delete.":::

1. Delete `USE msdb` and `GO` on lines 5 and 6 of the query (that are highlighted in the screenshot) , and then select **Run**.

    The purpose for running this code is to create stored procedures on a SQL database that can perform an intelligent defragmentation on one or more indexes. The code will also update statistics if needed.

1. Expand the **Stored Procedures** folder to see what was created.

    :::image type="content" source="../media/dp-3300-module-66-lab-33.png" alt-text="Screenshot of the new stored procedures.":::

## Add an automation to an Automation Account

1. On the Azure portal, in the top search box, type **automation**.

    :::image type="content" source="../media/dp-3300-module-66-lab-23.png" alt-text="Screenshot of selecting the Automation Accounts.":::

1. Then select **Automation Accounts**.

1. Select the automation account that you created.

    :::image type="content" source="../media/dp-3300-module-66-lab-36.png" alt-text="Screenshot of selecting the autoAccount automation account.":::

1. Select **Modules** from the Shared Resources section of the Automation blade.

    :::image type="content" source="../media/dp-3300-module-66-lab-37.png" alt-text="Screenshot of selecting the Modules menu.":::

1. Select **Browse gallery**.

    :::image type="content" source="../media/dp-3300-module-66-lab-38.png" alt-text="Screenshot of browsing the gallery.":::

1. Search for **sqlserver** within the Gallery.

    :::image type="content" source="../media/dp-3300-module-66-lab-39.png" alt-text="Screenshot of selecting the SqlServer module.":::

1. Select **SqlServer** which will direct to the next screen. Select **Import**.

    :::image type="content" source="../media/dp-3300-module-66-lab-40.png" alt-text="Screenshot of selecting import.":::

1. Select **OK** in the bottom corner of the screen in order to import the module. This will import the PowerShell module into your Automation account.

    :::image type="content" source="../media/dp-3300-module-66-lab-41.png" alt-text="Screenshot of selecting OK.":::

1. You'll need to create a credential to securely sign in to your database. From the blade for the Automation Account navigate to the **Shared Resources** section and select **Credentials**.

    :::image type="content" source="../media/dp-3300-module-66-lab-42.png" alt-text="Screenshot of adding account credentials.":::

    Select **+ Add a Credential**, and then create a credential with these properties: 

    - Name: **SQLUser**
    - User name: **labadmin**
    - Password: **Azur3Pa$$**
    - Confirm password: **Azur3Pa$$**

    Then select **Create**.

    :::image type="content" source="../media/dp-3300-module-66-lab-43.png" alt-text="Screenshot of the New Credential pop put.":::

## Create a PowerShell runbook

1. In the Azure portal, navigate back to your database by searching for **sql databases**.

    :::image type="content" source="../media/dp-3300-module-66-lab-24.png" alt-text="Screenshot of navigating back to the sql database.":::

    Then select the SQL database **sample-db-with-tde**.

    :::image type="content" source="../media/dp-3300-module-66-lab-22.png" alt-text="Screenshot of selecting the SQL database.":::  

1. On the **Overview** page copy the **Server name** of your Azure SQL Database as shown below. You'll paste this in later steps.

    :::image type="content" source="../media/dp-3300-module-66-lab-46.png" alt-text="Screenshot of copying the server name.":::

1. On the Azure portal, in the top search box, type **automation**.

    :::image type="content" source="../media/dp-3300-module-66-lab-23.png" alt-text="Screenshot of selecting the Automation Accounts.":::

1. Then select **Automation Accounts**.

1. Select the automation account that you created.

    :::image type="content" source="../media/dp-3300-module-66-lab-36.png" alt-text="Screenshot of selecting the autoAccount automation account.":::

1. Scroll to the Process Automation section of the Automation account blade and select **Runbooks** and then **+ Create a runbook**.

    :::image type="content" source="../media/dp-3300-module-66-lab-44.png" alt-text="Screenshot of the Runbooks page, selecting Create a runbook.":::

1. Enter the runbook name as **IndexMaintenance** and a runbook type of **PowerShell**. You can supply a short description of your choosing. Select **Create**.

    :::image type="content" source="../media/dp-3300-module-66-lab-45.png" alt-text="Screenshot of creating a runbook.":::

    Once the runbook has been created, the process should drop you directly into the runbook.
‎
1. Using Windows Explorer open the **create-db-credentials.ps1** file from the **D:\LabFIles\Automate Resources** folder. The PowerShell IDE will open.

    :::image type="content" source="../media/dp-3300-module-66-lab-47.png" alt-text="Screenshot of editing the PowerShell command and adding the SQL server name.":::

1. On Line 1 of the file paste in the **Server name** you copied in the steps above. Select all of the text ( <kbd>CTRL</kbd> + <kbd>A</kbd> ) and copy it to your clipboard ( <kbd>CTRL</kbd> + <kbd>C</kbd> ).

1. Navigate back to your automation runbook in the Microsoft Edge browser, and paste in the PowerShell code you copied. 

1. Select **Save**, and then select **Publish**.

    :::image type="content" source="../media/dp-3300-module-66-lab-48.png" alt-text="Screenshot of pasting the PowerShell into the Azure portal.":::

## Create a schedule for a runbook

Next you will schedule the runbook to execute on a regular basis.

1. Under Resources in the left hand navigation, select **Schedules**. Then select **+ Add a schedule**.

    :::image type="content" source="../media/dp-3300-module-66-lab-50.png" alt-text="Screenshot of the Schedules page, selecting Add a schedule.":::

1. Select **Link a schedule to your runbook**.

    :::image type="content" source="../media/link-schedule-runbook.png" alt-text="Screenshot of selecting Link as schedule to your runbook.":::

1. Select **Create a new schedule**.

    :::image type="content" source="../media/dp-3300-module-66-lab-51.png" alt-text="Screenshot of the create a schedule link.":::

1. Supply a descriptive schedule name and a description if desired.

1. Specify the start time of **4:00AM** of the following day and in the **Eastern Time zone**. Configure the reoccurrence for every **1** days. Do not set an expiration.

    :::image type="content" source="../media/dp-3300-module-66-lab-52.png" alt-text="Screenshot of the New Schedule pop out completed with example information.":::

1. Select **Create**, and then select **OK**.

1. The schedule is now linked to the runbook.

    :::image type="content" source="../media/dp-3300-module-66-lab-53.png" alt-text="Screenshot of the created schedule.":::

By completing this exercise you've automated the defragging of indexes on a SQL server database, every day, at 4am.

To finish this exercise select **Done** below.
