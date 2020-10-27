You're a database administrator. You need to create a test environment for use in a proof of concept. The proof of concept will use SQL Server on an Azure Virtual Machine.

## Create a Resource Group

1. When the VM lab environment opens use the password on the Resources tab for the Student account.

1. Select the Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/).

1. The username and password information to sign into the Azure Portal are in the  **Resources** tab above these instructions. If you select the **Username** the environment will type the text for you.

1. Repeat this for the password field.

1. From the Home screen, select **Resource Groups**.  
‎
    :::image type="content" source="../media/dp-3300-module-11-lab-06.png" alt-text="Screenshot of the Azure Portal home page.":::

1. Review your existing Resource Groups and then select **Add** to create a new Resource Group.  
‎
    :::image type="content" source="../media/dp-3300-module-11-lab-07.png" alt-text="Screenshot of selecting Add on the resource group pane.":::

1. Complete the Create a Resource Group wizard with the required information:

    :::image type="content" source="../media/dp-3300-module-11-lab-08.png" alt-text="Screenshot showing the Basics tab on a create a resource group page.":::

    - Enter **DP-300-Lab01** for the name of the Resource Group.
    - For the purposes of this lab, select the **Region** nearest to your physical location.
    - Select the **Review + create**.
    - Select **Create**.

## Provision a SQL Server on an Azure Virtual Machine

1. Locate the search bar at the top of the page. Search for Azure SQL. Select the search result for Azure SQL that appears in the results under Services.

    :::image type="content" source="../media/dp-3300-module-11-lab-09.png" alt-text="Screenshot of Azure Portal showing searching for Azure SQL.":::

1. On the Azure SQL blade, select **+ Add**.

    :::image type="content" source="../media/dp-3300-module-11-lab-10.png" alt-text="Screenshot of selecting the Add button.":::

1. On the Select SQL deployment option blade, open the drop-down box under SQL virtual machines. Select **Free SQL Server License: SQL 2019 Developer on Windows Server 2019**. Then select **Create**.
  
    :::image type="content" source="../media/dp-3300-module-11-lab-11.png" alt-text="Screenshot of selecting the Free SQL Server License: SQL 2019 Developer on Windows Server 2019 option.":::

1. On the Create a virtual machine blade, enter the following information:

    :::image type="content" source="../media/dp-3300-module-11-lab-12.png" alt-text="Screenshot of the information you need to complete to create a virtual machine.":::

    - Resource group: **DP-300-Lab01**
    - Virtual machine name:  **dp300sqlvmlab01**
    - Region: **&lt;your local region, same as the selected region for your resource group&gt;**
    - Availability Options: **No infrastructure redundancy required**
    - Azure spot instance: **No**
    - Size: Standard **D2s v3** (2 vCPUs, 8 GiB memory)
    - Administrator account username: **dp300sqlvmlab01admin**
    - Administrator account password: **enter a strong password**
    - Selected inbound ports: **RDP (3389)**
    - Would you like to use an existing Windows Server license?: **No**

1. Navigate to the Disks tab and review the configuration.

    :::image type="content" source="../media/dp-3300-module-11-lab-13.png" alt-text="Screenshot of disks tab.":::

1. Navigate to the Networking tab and review the configuration.

    :::image type="content" source="../media/dp-3300-module-11-lab-14.png" alt-text="Screenshot of the networking tab.":::

1. Navigate to the Management tab and review the configuration.

    :::image type="content" source="../media/dp-3300-module-11-lab-15.png" alt-text="Screenshot of the management tab.":::

1. Navigate to the Advanced tab and review the configuration.

    :::image type="content" source="../media/dp-3300-module-11-lab-16.png" alt-text="Screenshot of advanced tab.":::

1. Navigate to the SQL Server settings tab and review the configuration. Then select **Review + create**.

    :::image type="content" source="../media/dp-3300-module-11-lab-17.png" alt-text="Screenshot of the SQL Server settings tab.":::

    > [!NOTE]
    > You can also configure the storage for your SQL Server VM on this screen. By default, the SQL Server Azure VM templates create one premium disk with read caching for data, one premium disk without caching for transaction log, and uses the local SSD (D:\ on Windows) for tempdb.

1. On the Review + create tab select **Create**.  
‎
    :::image type="content" source="../media/dp-3300-module-11-lab-18.png" alt-text="Screenshot of ":::

1. On the deployment blade, wait until the deployment is complete. The VM will take approximate 5-10 minutes to deploy. Then select **Go to resource**.

    :::image type="content" source="../media/dp-3300-module-11-lab-19.png" alt-text="Screenshot of ":::

1. On the overview page for the virtual machine, scroll through the menu options for the resource to review what is available.

    :::image type="content" source="../media/dp-3300-module-11-lab-20.png" alt-text="Screenshot of ":::

1. Select **SQL Server configuration**. Review the information available in Azure about your SQL Server installation.

    :::image type="content" source="../media/dp-3300-module-11-lab-48.png" alt-text="Screenshot of ":::
