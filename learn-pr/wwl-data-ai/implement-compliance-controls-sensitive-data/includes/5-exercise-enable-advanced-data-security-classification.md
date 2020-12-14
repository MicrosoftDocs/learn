You've been hired as a Senior Database Administrator help ensure the security of the database environment. These tasks will focus on Azure SQL Database. You will learn how to configure advanced security and classification.

## Enable Advanced Data Security and Data Classification

1. When the VM lab environment opens use the password on the **Resources** tab for the Student account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/). This should be the home page of the browser.

1. The username and password information to sign into the Azure portal are in the  **Resources** tab above these instructions. If you select the **Username**, it will be filled in for you.

1. Select **Next**.

1. Select the **Password** field to have that filled in for you, then select **Sign in**.

1. Select **Yes**.

1. On the **Welcome to Azure** popup, select **Maybe later**.

1. On the Azure portal home page, select **All resources**.

    :::image type="content" source="../media/dp-3300-module-33-lab-19.png" alt-text="Screenshot of the Azure portal home page, selecting All resources":::

1. Select the Azure SQL Database server starting with **azurelsq-lab**.

    :::image type="content" source="../media/dp-3300-module-33-lab-20.png" alt-text="Screenshot of selecting the Azure SQL server.":::

1. From the main blade of your Azure SQL server, navigate to the **Security** section, and select **Security Center**.

    :::image type="content" source="../media/dp-3300-module-33-lab-24.png" alt-text="Screenshot of selecting the Security Center.":::

1. Select the toggle switch under **AZURE DEFENDER FOR SQL** to **ON**, and then select **Storage account**.

    :::image type="content" source="../media/dp-3300-module-33-lab-21.png" alt-text="Screenshot of switching on AZURE DEFENDER FOR SQL.":::

    On the **Choose storage account** page, select **+ Create new**.

1. On the **Create storage account** page, in the **Name** field enter a unique name starting with **securesqllab** and append some additional random numbers until you have a valid name.

    :::image type="content" source="../media/dp-3300-module-33-lab-22.png" alt-text="Screenshot of creating a storage account.":::

1. Select **OK** and wait for the storage account to be created.

1. Toggle the switch for **Periodic recurring scans** to **ON**. Enter the Azure account email in the **Send scan reports to** and **Send alerts to** dialog boxes. Deselect **Also send email notification to admins and subscription owners**.

    Select **Advanced Threat Detection types** and review the selections. Leave all of the boxes checked and select **OK**.

    :::image type="content" source="../media/dp-3300-module-33-lab-25.png" alt-text="Screenshot of entering email details.":::    

1. Select **Save**

## Enable data classification on an Azure SQL database

1. In the left navigation, select **Overview**.

1. Copy the **Server name** to use later in this exercise.

    :::image type="content" source="../media/copy-servername.png" alt-text="Screenshot of copying the server name":::

1. Navigate to the **AdventureWorksLT** database in the Azure portal by scrolling down in the overview screen for Azure SQL server and select the database name.

    :::image type="content" source="../media/dp-3300-module-33-lab-27.png" alt-text="Screenshot showing selecting the AdventureWOrksLT database.":::

1. Navigate to the Security section of the main blade for your Azure SQL Database and select **Data Discovery & Classification**.

    :::image type="content" source="../media/dp-3300-module-33-lab-28.png" alt-text="Screenshot showing the Data Discovery & Classification":::

1. On the **Data Discovery & Classification** screen you will see an informational message that reads **We have found 15 columns with classification recommendations**. Select that link.

    :::image type="content" source="../media/dp-3300-module-33-lab-29.png" alt-text="Screenshot showing the Classification Recommendations":::

1. On the next **Data Discovery & Classification** screen select the check box next to **Select all**, select **Accepted selected recommendations**, and then select **Save** to save the classifications into the database.

    :::image type="content" source="../media/dp-3300-module-33-lab-30.png" alt-text="Screenshot showing the Accept selected recommendations.":::

## View data classification in SQL Server Management Studio

> [!NOTE]
> If you'd like to copy and paste the code you can find the code in the **D:\LabFiles\Secure Environment\exercise_steps.sql** file.

1. Open SQL Server Management Studio by navigating to **Microsoft SQL Server Tools 18** > **SQL Server Management Studio** from the Start menu. Paste in the name of your Azure SQL database server and login with these credentials:

    - Server admin login: **labadmin**
    - Password: **Azur3Pa$$**

    :::image type="content" source="../media/dp-3300-module-33-lab-05.png" alt-text="Screenshot showing the Connecting to Server.":::

    Select **Connect**.

1. You'll be prompted to add your client IP address as a new firewall rule. Sign in with the Azure credentials in the Resources tab. Then select **OK**.

1. In the **Object Explorer**, expand the server node, and expand the **Databases** node.

    :::image type="content" source="../media/new-query.png" alt-text="Screenshot showing the New Query option.":::  

1. Right-click on the **AdventureWorksLT** database, and select **New Query**.

1. Execute the following query in the new query window.

    ```sql
    SELECT o.name AS [Table Name]
    ,ac.name AS [Column Name]
    ,sc.label
    ,sc.information_type
    FROM sys.sensitivity_classifications sc
    INNER JOIN sys.objects o ON o.object_id = sc.major_id
    INNER JOIN sys.all_columns ac ON ac.column_id = sc.minor_id
    WHERE ac.object_id = o.object_id;
    ```

    This query will return the results of your classified columns as shown below.

    :::image type="content" source="../media/dp-3300-module-33-lab-31.png" alt-text="SQL Query results.":::

Note that the results show that the 15 classifications have been created in the database.

In this exercise you've seen how the Azure portal can automatically classify sensitive columns in a database table for you.

To finish this exercise select **Done** below.
