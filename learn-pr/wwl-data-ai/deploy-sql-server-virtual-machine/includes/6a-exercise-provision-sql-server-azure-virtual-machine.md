You're a database administrator. You need to create a test environment for use in a proof of concept. The proof of concept will use SQL Server on an Azure Virtual Machine.

## Connect to the lab environment

1. When the VM lab environment opens, use the password on the **Resources** tab above for the **Student** account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/) if you are not already there. This should be the home page of the browser.

1. If needed, the username and password information to sign into the Azure portal are in the  **Resources** tab above these instructions. If you select the **Username** it will be filled in for you.

1. Select **Next**.

1. Select the **Password** text in the **Resources** tab to have that filled in for you, then select **Sign in**.

1. Select **Yes** to save the login information.
   
1. On the **Welcome to Azure** popup, select **Maybe later**.


## Provision a SQL Server on an Azure Virtual Machine

1. Locate the search bar at the top of the page. Search for Azure SQL. Select the search result for Azure SQL that appears in the results under Services.

    :::image type="content" source="../media/dp-3300-module-11-lab-09.png" alt-text="Screenshot of Azure portal showing searching for Azure SQL.":::

1. On the Azure SQL blade, select **+ New**.

    :::image type="content" source="../media/dp-3300-module-11-lab-10.png" alt-text="Screenshot of selecting the Add button.":::

1. On the Select SQL deployment option blade, open the drop-down box under SQL virtual machines. Select **Free SQL Server License: SQL 2019 Developer on Windows Server 2019**. Then select **Create**.
  
    :::image type="content" source="../media/dp-3300-module-11-lab-11.png" alt-text="Screenshot of selecting the Free SQL Server License: SQL 2019 Developer on Windows Server 2019 option.":::

1. On the Create a virtual machine page, enter the following information:

    :::image type="content" source="../media/dp-3300-module-11-lab-12.png" alt-text="Screenshot of the information you need to complete to create a virtual machine.":::

    - Resource group: Choose the existing resource group; it should have a name starting with **RG**
    - Virtual machine name:  **azureSQLserverVM**
    - Region: **&lt;your local region, same as the selected region for your resource group&gt;**
    - Availability Options: **No infrastructure redundancy required**
    - Azure spot instance: **No** (don't check the box)
    - Size: Standard **D2s v2** (You will need to select 'see all sizes' to find **D2s v2** -- 2 vCPUs, 7 GiB memory)
    - Administrator account username: **labadmin**
    - Administrator account password: **Azur3Pa$$2020**
    - Selected inbound ports: **RDP (3389)**
    - Would you like to use an existing Windows Server license?: **No** (don't check the box)

1. Navigate to the **Disks** tab and review the configuration.

    :::image type="content" source="../media/dp-3300-module-11-lab-13.png" alt-text="Screenshot of disks tab.":::

1. Navigate to the **Networking** tab and review the configuration.

    :::image type="content" source="../media/dp-3300-module-11-lab-14.png" alt-text="Screenshot of the networking tab.":::

    > [!IMPORTANT]
    > For security, you're going to create a network security group to restrict access to the VM to your machine's IP address.

1. For the **NIC network security group** select **Advanced**.

1. Select **Create new** under the **Configure network security group**.

1. Select the existing rule under the **Inbound rules**.

    :::image type="content" source="../media/dp-3300-module-11-lab-49.png" alt-text="Screenshot of the inbound rules.":::

    In the default-allow-rdp flyout enter this information:

    - Source: **IP Addresses**
    - Source IP addresses/CIDER ranges: **1.1.1.1** (this should be your machine's public facing IP address - for the purpose of this exercise you can enter a dummy IP address)
    - Priority: **100**

    Select **Save**, and then select **OK**.

1. Navigate to the **Management** tab and review the configuration.

    :::image type="content" source="../media/dp-3300-module-11-lab-15.png" alt-text="Screenshot of the management tab.":::



1. Navigate to the **Advanced** tab and review the configuration.

    :::image type="content" source="../media/dp-3300-module-11-lab-16.png" alt-text="Screenshot of advanced tab.":::

1. Navigate to the **SQL Server settings** tab and review the configuration. Then select **Review + create**.

    :::image type="content" source="../media/dp-3300-module-11-lab-17.png" alt-text="Screenshot of the SQL Server settings tab.":::

    > [!NOTE]
    > You can also configure the storage for your SQL Server VM on this screen. By default, the SQL Server Azure VM template creates one premium disk with read caching for data, one premium disk without caching for transaction log, and uses the local SSD (D:\ on Windows) for the tempdb.

1. On the **Review + create** tab select **Create**.  
‎
    :::image type="content" source="../media/dp-3300-module-11-lab-18.png" alt-text="Screenshot of review + create page.":::

1. On the deployment blade, wait until the deployment is complete. The VM will take approximately 5-10 minutes to deploy. Then select **Go to resource**.

    :::image type="content" source="../media/dp-3300-module-11-lab-19.png" alt-text="Screenshot of deployment blade.":::

1. On the overview page for the virtual machine, scroll through the menu options for the resource to review what is available.

    :::image type="content" source="../media/dp-3300-module-11-lab-20.png" alt-text="Screenshot of overview page of the new SQL server.":::

1. Select **SQL Server configuration** from the left navigation, then select **Manage SQL virtual machine**.

1. Review the information available in Azure about your SQL Server installation.

    :::image type="content" source="../media/dp-3300-module-11-lab-50.png" alt-text="Screenshot of SQL server configuration information.":::

The Azure portal gives you powerful tools to manage a SQL Server hosted in a virtual machine. These tools include control over automated patching, automated backups, and giving you an easy way to setup high availability.

To finish this exercise select **Done** below.
