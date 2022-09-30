## Before you start

To complete these exercises, you must have:

- Created a resource group (see Module 1, Unit 5)
- Created an Azure Database for MySQL Flexible Server (see Module 1, Unit 5)
- If you stopped Azure Database for MySQL in the Azure portal at the end of Module 1, restart the instance now.
- Downloaded the scripts for this exercise from [GitHub](https://github.com/MicrosoftLearning/mslearn-mysql/tree/main/labfiles).

## Download MySQL Workbench

1. Open a browser window and navigate to [MySql Community Downloads](https://dev.mysql.com/downloads/workbench/).

    :::image type="content" source="../media/mysql-community-downloads.png" alt-text="Screenshot showing the MySQL Community Downloads for MySQL Workbench page." lightbox="../media/mysql-community-downloads.png":::

1. Select your **Operating System** from the drop-down list.
1. Select **Go to Download Page**.
1. Next to the smaller (web) download, select **Download**. If prompted, select **No thanks, just start my download**. The mysql-installer-web-community-8.0.28.0.msi downloads.

## Install MySQL Workbench

1. Locate the mysql-installer-web-community-8.0.28.0.msi file and double-click it. The installer is started. 
1. If Windows warns you that the app is not verified, select **Install anyway**. If the User Account Control dialog appears, select **Yes**.
1. The MySQL Installer wizard starts and shows the **Choosing a Setup Type** page. Select **Custom** and then select **Next**:

    :::image type="content" source="../media/mysql-install-wizard-start.png" alt-text="Screenshot showing the first page of the MySQL setup wizard." lightbox="../media/mysql-install-wizard-start.png":::

1. In the **Select Products** page, use the green double arrow to remove all items from the **Products to be installed** list.
1. In the **Available products** list, expand **Applications > MySQL Workbench > MySQL Workbench 8.0**.
1. Select **MySQL Workbench 8.0.30** and then select the green right arrow. Select **Next**

    :::image type="content" source="../media/mysql-install-wizard-products.png" alt-text="Screenshot showing the product selection page of the MySQL setup wizard." lightbox="../media/mysql-install-wizard-products.png":::

1. On the **Download** page, select **Execute**. When the download is complete, select **Next**.
1. On the **Installation** page, select **Execute**.

    :::image type="content" source="../media/mysql-install-wizard-installation.png" alt-text="Screenshot showing the installation page of the MySQL setup wizard." lightbox="../media/mysql-install-wizard-installation.png":::

1. When the installation is complete, select **Next**.
1. On the **Installation Complete** page, select **Finish**. MySQL Workbench start.

## Connect to a server

1. Start **MySQL Workbench**, if it is not already open from the last exercise.
1. From the top menu, select **Database**, **Manage connections**.
1. At the bottom left, select **New**.
1. In **Connection Name**, enter **AzureMySQL**.
1. In **Hostname**, enter the fully qualified name of your Azure Database for MySQL flexible server that you created in Module 1. You can copy the name of the server from the Azure portal. Navigate to your Azure Database for MySQL flexible server, and from the **Overview** blade copy the server name. Paste this into the Hostname field.
1. In **Username**, enter **demo** (the username used when you created the server).
1. Select **Store in Vault**, and in **Password** enter **Pa$$w0rd** (the password you used when you created the server).
1. Select **Test Connection**. If the details are correct, an acknowledgment is displayed.
1. Select **OK**. If the connection details are correct, MySQL Workbench connects to Azure Database for MySQL and displays the navigator window, an empty query window and other user interface elements.
1. Leave MySQL Workbench open for the next exercise.

## Create a database

1. Select the **SQL+** icon to create a new query tab for executing queries.
1. From the menu, select **Database**, and then **Connect to Database**. The stored connection you made in the previous step is displayed.
1. Select **OK**. You are now connected to your Azure Database for MySQL Flexible server.
1. Open script **lab2_Zoodb.sql**.
1. From the menu, select **Query**, then **Execute (All or Selection)**.
1. In the Navigate pane, select the **Schemas** tab, and then select **Refresh** to view the database you have just created.
1. Using the expand and collapse icons, inspect the tables.

When you have completed this exercise, in the Azure portal return to the **Overview** page and then select **STOP** to stop the server. This will prevent charges being incurred while you are not using it. The server will be used in the next module.
