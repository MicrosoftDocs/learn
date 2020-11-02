You've been hired as a Senior Database Administrator help ensure the security of the database environment. These tasks will focus on Azure SQL Database. You will learn how to configure advanced security and classification.

## Enable Advanced Data Security and Data Classification

1. When the VM lab environment opens use the password on the **Resources** tab for the Student account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/).

1. The username and password information to sign into the Azure Portal are in the  **Resources** tab above these instructions. If you select the **Username** the environment will type the text for you.

1. Repeat this for the **Password** field.

1. On the Azure portal home page select **All resources**.

    :::image type="content" source="../media/dp-3300-module-33-lab-19.png" alt-text="Screenshot of the Azure portal home page, selecting All resources":::

1. Select the Azure SQL Database server **dp300-lab-xx**, where **xx** is a random string.

1. From the main blade of your Azure SQL server navigate to the **Security** section and select **Security Center**.

    :::image type="content" source="../media/dp-3300-module-33-lab-24.png" alt-text="Security":::

1. Select the toggle switch under **AZURE DEFENDER FOR SQL** to **ON**, and then select **Storage account**.

    :::image type="content" source="../media/dp-3300-module-33-lab-25.png" alt-text="Advanced Data Security":::

    You will be prompted to create a storage account.

1. Add a new storage account. Storage account names need to be unique, start the account name with dp300module7 and append some additional random characters until you have a valid name.

1. Select **OK** and wait for the storage account to be created.

1. Toggle the switch for **Periodic recurring scans** to **ON**. Enter the azure account email in the **Send scan reports to** and **Send alerts to** dialog boxes. Deselect **Also send email notification to admins and subscription owners**.

    Select **Advanced Threat Detection types** and review the selections. Leave all of the boxes checked and select **OK**.

1. Select **Save**, and on the left navigation select **Overview**.

1. Navigate to the **AdventureWorksLT** database in the Azure portal by scrolling down in the overview screen for Azure SQL server and select the database name.

    :::image type="content" source="../media/dp-3300-module-33-lab-27.png" alt-text="dp300-lab-adw server":::

1. Navigate to the Security section of the main blade for your Azure SQL Database and select **Data Discovery & Classification**.

    :::image type="content" source="../media/dp-3300-module-33-lab-28.png" alt-text="Data Discovery & Classification":::

1. On the **Data Discovery & Classification** screen you will see an informational message that reads **We have found 15 columns with classification recommendations**. Select that link.

    :::image type="content" source="../media/dp-3300-module-33-lab-29.png" alt-text="Classification Recommendations":::

1. On the next **Data Discovery & Classification** screen select the check box next to **Select all**, select **Accepted selected recommendations**, and then select **Save** to save the classifications into the database.

    :::image type="content" source="../media/dp-3300-module-33-lab-30.png" alt-text="Accept selected recommendations":::

1. Open SQL Server Management Studio. Launch a new query window from the AdventureWorksLT database and execute the following query.

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

    :::image type="content" source="../media/dp-3300-module-33-lab-31.png" alt-text="SQL Query results":::
