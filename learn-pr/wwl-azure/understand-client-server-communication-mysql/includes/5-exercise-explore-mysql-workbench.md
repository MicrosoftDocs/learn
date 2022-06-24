## Before you start
To complete these exercises, you must have:
•	Created a resource group (see Module 1, Unit 5)
•	Created an Azure Database for MySQL Flexible Server (see Module 1, Unit 5)
•	Downloaded and installed MySQL Workbench (see Module 2, Unit 5)
•	Downloaded the scripts for this exercise from [GitHub](https://github.com/MicrosoftLearning/mslearn-mysql/tree/main/labfiles).

## Download MySQL Workbench

1. Open a browser window and navigate to [MySql Community Downloads](https://dev.mysql.com/downloads/workbench/).
    :::image type="content" source="../media/mysql-community-downloads.png" alt-text="Screenshot showing the MySQL Community Downloads for MySQL Workbench page." lightbox="../media/mysql-community-downloads.png":::
1. Select your **Operating System** from the drop-down list.
1. Select **Go to Download Page**.
1. Next to the smaller (web) download, select **Download**. The mysql-installer-web-community-8.0.28.0.msi downloads.

## Install MySQL Workbench

1. Locate the mysql-installer-web-community-8.0.28.0.msi file and double-click. The installer is started and prompts you to enter administrator credentials.
1. The MySQL Workbench 8.0 CE setup Wizard starts. Select **Next**.
    :::image type="content" source="../media/workbench-wizard.png" alt-text="Screenshot showing the MySQL Workbench 8.0 CE setup wizard." lightbox="../media/workbench-wizard.png":::
1. Accept the default installation folder or select **Change** to specify a location.
1. The Setup type dialog box is displayed, select **Complete**, and then select **Next**.
1. The **Ready to Install the Program** dialog box is displayed. Check the installation settings, and then select **Install**. The program installs.
    
    :::image type="content" source="../media/mysql-workbench-ready-install.png" alt-text="Screenshot showing the MySQL Workbench ready to install program page." lightbox="../media/mysql-workbench-ready-install.png":::
1. When the wizard has completed the installation, ensure the **Launch MySQL Workbench now** is selected, and select **Finish**.
    
    :::image type="content" source="../media/mysql-workbench-wizard-finished.png" alt-text="Screenshot showing the MySQL Workbench wizard complete page." lightbox="../media/mysql-workbench-wizard-finished.png":::

## Connect to a server

1. Start **MySQL Workbench**, if it is not already open from the last exercise.
1. From the top menu, select **Database**, **Connect to Database**.
1. In Connection name, enter **MySQLFlex**.
1. In **Hostname**, enter the fully qualified name of your Azure Database for MySQL flexible server that you created in Module 1. You can copy the name of the server from the Azure portal. Navigate to your Azure Database for MySQL flexible server, and from the **Overview** blade copy the server name. Paste this into the Hostname field.
1. In **Username**, enter **demo** (the user name used when you created the server).
1. Select **Store in Vault**, and in **Password** enter **Pa$$w0rd** (the password you used when you created the server).
1. Select **Test Connection** to check that you can connect to the server. Leave MySQL Workbench open for the next exercise.

## Create a database

1. Select the **SQL+** icon to create a new query tab for executing queries.
1. From the menu, select **Database**, and then **Connect to Database**. The stored connection you made in the previous step is displayed.
1. Select **OK**. You are now connected to your Azure Database for MySQL Flexible server.
1. Open script **lab2_Zoodb.sql**.
1. From the menu, select **Query**, then **Execute (All or Selection)**.
1. In the Navigate pane, select **Refresh** to view the database you have just created.
1. Using the expand and collapse icons, inspect the tables.
