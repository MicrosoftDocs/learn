In this exercise you will download and install Azure Data studio, and then connect to the Azure Database for PostgreSQL server you created in Module 1. If you already have Azure Data Studio installed on your machine you can jump ahead to Connect to Azure Database for PostrgreSQL flexible server.

> [!IMPORTANT]
> You need your own Azure subscription to complete this exercise. If you do not have an Azure subscription, you can create an [Azure free trial](https://azure.microsoft.com/free).

## Install Azure Data Studio

To install Azure Data Studio for use with Azure Database for PostgreSQL:

1. In a browser, navigate to [Download and install Azure Data Studio](/sql/azure-data-studio/download-azure-data-studio) and under the Windows platform, select **User installer (recommended)**. The executable file is downloaded to your Downloads folder.
1. Select **Open file**.
1. The License agreement is displayed. Read and **accept the agreement**, then select **Next**.
1. In **Select additional Tasks**, select **Add to PATH**, and any other additions you require. Select **Next**.
1. The **Ready to Install** dialog box is displayed. Review your settings. Select **Back** to make changes or select **Install**.
1. The **Completing the Azure Data Studio Setup Wizard** dialog box is displayed. Select **Finish**. Azure Data Studio starts.

## Install the PostgreSQL extension

1. Open Azure Data Studio if it is not already open.
1. From the left menu, select **Extensions** to display the Extensions panel.
1. In the search bar, enter **PostgreSQL**. The PostgreSQL extension for Azure Data Studio icon is displayed.
1. Select **Install**. The extension installs.

## Connect to Azure Database for PostgreSQL flexible server

1. Open Azure Data Studio if it is not already open.
1. From the left menu, select **Connections**.
1. Select **New Connection**.
1. Under **Connection Details**, in **Connection type** select **PostgreSQL** from the drop-down list.
1. In **Server name**, enter the full server name as it appears on the Azure portal.
1. In **Authentication type**, leave Password.
1. In User name and Password, enter the user name **demo** and password **Pa$$w0rd1** or the credentials you used when you created the server in Module 1.
1. Select [ x ] Remember password.
1. The remaining fields are optional.
1. Select **Connect**. You are connected to the Azure Database for PostgreSQL server.
1. A list of the server databases is displayed. This includes system databases, and user databases.

## Create the zoo database

1. Download the all scripts from [PostgreSQL Labs](https://github.com/MicrosoftLearning/mslearn-postgres).
1. Open Azure Data Studio if it is not already open.
1. Select **File**, **Open file** and navigate to the folder where you saved the script. Select **Lab2_ZooDb.sql** and **Open**. If a trust warning is displayed select **Open**.
1. Run the script. The zoodb database is created.
1. At the top of the screen, use the drop-down arrow to display the databases on the server, including zoodb and system databases.
1. Scroll down to the end of the script to re-run some of the select statements
