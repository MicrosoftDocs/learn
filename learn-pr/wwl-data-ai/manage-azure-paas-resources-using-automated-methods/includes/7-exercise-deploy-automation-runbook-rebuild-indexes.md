You have been hired as a Senior Data Engineer to help automate day to day operations of database administration. This automation is to help ensure that the databases for AdventureWorks continue to operate at peak performance as well as provide methods for alerting based on certain criteria. AdventureWorks utilizes SQL Server in both Infrastructure as a Service and Platform as a Service offerings. 

## Connect to the lab environment

1. When the VM lab environment opens use the password on the **Resources** tab for the **Student** account to sign in to Windows.

1. Select the Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/).

1. The username and password information to sign into the Azure Portal are in the  **Resources** tab above these instructions. If you select the **Username** the environment will type the text for you.

1. Repeat this for the **Password** field.

## Create an Automation Account

1. In the Azure Portal in the search bar type **automation** and then select **Automation Accounts** from the search results.

    :::image type="content" source="../media/dp-3300-module-66-lab-23.png" alt-text="Screenshot of the .":::

    Select **+ Add**.

1. On the **Add Automation Account** page enter this information:

    :::image type="content" source="../media/dp-3300-module-66-lab-25.png" alt-text="Screenshot of the .":::

    - Name: **DP3006Lab06**
    - Resource Group: **DP300-Lab06**
    - Location: Use the default.

1. Select **Create**.

    > [!NOTE]
    > Your automation account should be created in around three minutes.

## Connect to an existing Azure SQL Database

1. In the Azure Portal, navigate back to your database by searching for **sql databases**.

    :::image type="content" source="../media/dp-3300-module-66-lab-24.png" alt-text="Screenshot of the .":::

    Then select the SQL database **sample-db-with-tde**.

    :::image type="content" source="../media/dp-3300-module-66-lab-22.png" alt-text="Screenshot of the .":::  

1. On the **Overview** page select the **Query editor (preview)**.

    :::image type="content" source="../media/dp-3300-module-66-lab-27.png" alt-text="Screenshot of the .":::

1. You will be prompted for credentials to login to your database. Use these credentials:

    :::image type="content" source="../media/dp-3300-module-66-lab-28.png" alt-text="Screenshot of the .":::

    - Login: **labuser**
    - Password: **Azur3Pa$$**

    You may receive an error that a firewall rule needs to be created as shown below.

    :::image type="content" source="../media/dp-3300-module-66-lab-29.png" alt-text="Screenshot of the .":::

1. Select **Set server firewall** at the end of the error message shown above.

    :::image type="content" source="../media/dp-3300-module-66-lab-30.png" alt-text="Screenshot of the .":::

1. Select **Add client IP**, then select **Save**.

1. Return to the Query editor, select **OK**, to login to your database.

1. Navigate in a new tab to the github page for **AdaptativeIndexDefragmentation**. [https://github.com/microsoft/tigertoolbox/blob/master/AdaptiveIndexDefrag/usp_AdaptiveIndexDefrag.sql](https://github.com/microsoft/tigertoolbox/blob/master/AdaptiveIndexDefrag/usp_AdaptiveIndexDefrag.sql)

    :::image type="content" source="../media/dp-3300-module-66-lab-26.png" alt-text="Screenshot of the .":::

    Select **Raw**. This will provide the code in a format where you can copy it. Select all of the text ( <kbd>CTRL</kbd> + <kbd>A</kbd> ) and copy it to your clipboard ( <kbd>CTRL</kbd> + <kbd>C</kbd> ).

1. Paste the text you copied into the Query 1 pane.

    :::image type="content" source="../media/dp-3300-module-66-lab-32.png" alt-text="Screenshot of the .":::

1. Delete the USE msdb and GO statements on lines 5 and 6 of the query (that are highlighted in the screenshot) , and then select **Run**.

    :::image type="content" source="../media/dp-3300-module-66-lab-33.png" alt-text="Screenshot of the .":::

    The query will take around 20 seconds to complete.

## Add an automation to an Automation Account

1. On the Azure Portal, expand the left menu and select **All Services**.

    :::image type="content" source="../media/dp-3300-module-66-lab-34.png" alt-text="Screenshot of the .":::

1. Type **automation** within the search field, and then select **Automation Accounts**.

    :::image type="content" source="../media/dp-3300-module-66-lab-35.png" alt-text="Screenshot of the .":::

    Identity the automation account that has been created in your subscription and select it.

    :::image type="content" source="../media/dp-3300-module-66-lab-36.png" alt-text="Screenshot of the .":::

1. Select **Modules** from the Shared Resources section of the Automation blade.

    :::image type="content" source="../media/dp-3300-module-66-lab-37.png" alt-text="Screenshot of the .":::

1. Select **Browse gallery**.

    :::image type="content" source="../media/dp-3300-module-66-lab-38.png" alt-text="Screenshot of the .":::

1. Search for **sqlserver** within the Gallery.

    :::image type="content" source="../media/dp-3300-module-66-lab-39.png" alt-text="Screenshot of the .":::

1. Select **SqlServer** which will direct to the next screen. Select **Import**.

    :::image type="content" source="../media/dp-3300-module-66-lab-40.png" alt-text="Screenshot of the .":::

1. Select **OK** in the bottom corner of the screen in order to import the module. This will import the PowerShell module into your Automation account.

    :::image type="content" source="../media/dp-3300-module-66-lab-41.png" alt-text="Screenshot of the .":::

1. You will need to create a credential to securely login to your database. From the Automation Account blade navigate to the Shared Resources Section and select **Credentials**.

    :::image type="content" source="../media/dp-3300-module-66-lab-42.png" alt-text="Screenshot of the .":::

    Select **+ Add a Credential**, and then create a credential as shown below. 

    - Name: **SQLUser** 
    - User name: **labadmin**
    - Password: **Azur3Pa**$$
    - Confirm password: **Azur3Pa**$$

    Then select **Create**.

    :::image type="content" source="../media/dp-3300-module-66-lab-43.png" alt-text="Screenshot of the .":::

## Create a PowerShell runbook

1. Scroll to the Process Automation section of the Automation account blade and select **Runbooks** and then **+ Create a runbook**.

    :::image type="content" source="../media/dp-3300-module-66-lab-44.png" alt-text="Screenshot of the .":::

1. Enter the runbook name as **IndexMaintenance** and a runbook type of **Powershell**. You can supply a short description of your choosing. Select **Create**.

    :::image type="content" source="../media/dp-3300-module-66-lab-45.png" alt-text="Screenshot of the .":::

    Once the runbook has been created, the process should drop you directly into the runbook.
‎

1. Copy the Azure SQL server from the overview screen of your Azure SQL Database as shown below.

    :::image type="content" source="../media/dp-3300-module-66-lab-46.png" alt-text="Screenshot of the .":::

1. Using Windows Explorer open the DP300-Lab-Module-6.ps1 file from the D:\LabFIles\Automate Resources folder. The PowerShell IDE will open.

    :::image type="content" source="../media/dp-3300-module-66-lab-47.png" alt-text="Screenshot of the .":::

1. On Line 1 of the file paste in the server name you copied. Select all of the text ( <kbd>CTRL</kbd> + <kbd>A</kbd> ) and copy it to your clipboard ( <kbd>CTRL</kbd> + <kbd>C</kbd> ).

1. Navigate back to your automation runbook, and paste in the PowerShell code you copied from the PowerShell. Then select **Save** and then select **Publish**.

    :::image type="content" source="../media/dp-3300-module-66-lab-48.png" alt-text="Screenshot of the .":::

1. Next you will schedule the runbook to execute on a regular basis. Select **Schedules** in the left hand navigation menu. Then select **+ Add a schedule**.

    :::image type="content" source="../media/dp-3300-module-66-lab-50.png" alt-text="Screenshot of the .":::

1. Select **Link a schedule to your runbook**.

1. Select **Create a new schedule**.

    :::image type="content" source="../media/dp-3300-module-66-lab-51.png" alt-text="Screenshot of the .":::

1. Supply a descriptive schedule name and a description if desired.

1. Specify the start time of **4:00AM** of the following day and in the **Eastern Time zone**. Configure the reoccurrence for every **1** days. Do not set an expiration.

    :::image type="content" source="../media/dp-3300-module-66-lab-52.png" alt-text="Screenshot of the .":::

1. Select **OK**.

1. The schedule is now linked to the runbook.

    :::image type="content" source="../media/dp-3300-module-66-lab-53.png" alt-text="Screenshot of the .":::
