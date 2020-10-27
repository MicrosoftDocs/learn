You've been hired as a Senior Data Engineer to help automate day to day operations of database administration. This automation is to help ensure that the databases for AdventureWorks continue to operate at peak performance and provide methods for alerting based on certain criteria. AdventureWorks uses SQL Server in both Infrastructure as a Service and Platform as a Service offerings. 

## Deploy an Azure SQL Database

1. When the VM lab environment opens use the password on the **Resources** tab for the Student account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to the following GitHub repository:

    [https://github.com/Azure/azure-quickstart-templates/tree/master/201-sql-database-transparent-encryption-create](https://github.com/Azure/azure-quickstart-templates/tree/master/201-sql-database-transparent-encryption-create)

    :::image type="content" source="../media/dp-3300-module-66-lab-05.png" alt-text="Screenshot of the GitHub repository.":::

1. Right-click **azuredeploy.json**, and select **Open link in new tab**.

1. Review the file, when finished close the tab.

    :::image type="content" source="../media/dp-3300-module-66-lab-11.png" alt-text="Screenshot of the GitHub repository showing the Deploy to Azure link.":::

1. Scroll down the page and select **Deploy to Azure**. You may be prompted to sign in to the Azure portal. Sign in with the Azure credentials on the **Resources** tab.

1. You'll see the following screen. To deploy this template, complete the blank fields with this information:

    :::image type="content" source="../media/dp-3300-module-66-lab-06.png" alt-text="Screenshot of Provision a SQL Database with TDE page in the Azure portal.":::

    - Resource group: **DP300-Lab06**
    - Sql Administrator Login: **labadmin**
    - Sql Administrator Login Password: Enter a strong password

1. Select **Review + create**, and then select **Create**.

    Your deployment will take 5-10 minutes to deploy. If you select the link above, you'll be able to track your deployment.

    :::image type="content" source="../media/dp-3300-module-66-lab-08.png" alt-text="Screenshot of the deployment status screen.":::

1. Upon completion, the screen will update with a link to your newly created resources.

    :::image type="content" source="../media/dp-3300-module-66-lab-09.png" alt-text="Screenshot of the deployment success screen.":::

    Select **Go to resource group**. You'll be taken to the Azure Resource Group your deployment just created.

    :::image type="content" source="../media/dp-3300-module-66-lab-10.png" alt-text="Screenshot of the resource group page.":::
