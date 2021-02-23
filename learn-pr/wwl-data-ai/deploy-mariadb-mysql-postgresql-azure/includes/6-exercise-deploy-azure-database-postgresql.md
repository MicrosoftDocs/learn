As a database administrator, you'll set up a new Azure Database for PostgreSQL for testing. You've been asked to evaluate how Azure Data Studio can be used in your company to support its existing PostgreSQL estate.

## Connect to the lab environment

1. When the VM lab environment opens, use the password on the **Resources** tab above for the **Student** account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/). This should be the home page of the browser.

1. The username and password information to sign into the Azure portal are in the  **Resources** tab above these instructions. If you select the **Username** it will be filled in for you.

1. Select **Next**.

1. Select the **Password** text in the **Resources** tab to have that filled in for you, then select **Sign in**.

1. Select **Yes**.

1. On the **Welcome to Azure** popup, select **Maybe later**.

## Deploy a PostgreSQL Database

1. From the Azure portal, select **+ Create a Resource**.

1. Search for **postgresql** in the search box at the top, then select **Azure Database for PostgreSQL** in the results.  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-35.png" alt-text="Screenshot of selecting Azure Database for PostgreSQL from the search results.":::

1. Select **Create**.

1. Select **Create** for the Single Server option.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-36.png" alt-text="Screenshot of select create under the Singer server option.":::

1. Complete the Single Server Basics screen with the following information:

    ‎:::image type="content" source="../media/dp-3300-module-22-lab-38.png" alt-text="Screenshot of single server options completed.":::

    - Resource Group: **DeploySQLAzure**
    - Server Name: **postgresql-azure-\<your initials\>** (add additional characters as a server name must be unique)
    - Data source: **None**
    - Location: Select the Region closest to you, which has been used throughout this lab.
    - Version: **10**
    - Select **Configure Server** link under **Compute + Storage**.

        :::image type="content" source="../media/dp-3300-module-22-lab-37.png" alt-text="Screenshot of the Single Server Basics screen.":::

        - Select **Basic** tab.
        - Slide the vCore slider all the way to the left to select **1 vCore**.
        - Select **OK**.

    - Admin username: **labadmin**
    - Password: **Azur3Pa$$2020**
    - Confirm password: **Azur3Pa$$2020**

1. Select **Review + Create**.

1. Review the settings and select **Create**.

1. When the deployment is complete, select **Go to resource**.

## Enable All Azure Services Access to a PostgreSQL Database

1. Select **Connection security** under Settings on the left navigation.

1. Select **Allow access to Azure services** setting to **Yes**.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-40.png" alt-text="Screenshot of adding a client address IP and allowing Azure to access services.":::

1. Select **+ Add client IP**.

1. Select **Save** at the top left.

1. On the left select **Overview**, then copy the **Server name** from the top right.

    :::image type="content" source="../media/dp-3300-module-22-lab-45.png" alt-text="Screenshot of selecting the server name.":::

## Connect to the PostgreSQL Database with Azure Data Studio (ADS)

> [!NOTE]
> With the PostgreSQL extension installed to ADS, PostgreSQL can be queried. This extension is pre-installed on the lab VM.

1. In Azure Data Studio, ensure the Connections sidebar is expanded.

1. Select the **Connections** button in the left nav bar, if not.

1. Select **Add Connection**.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-41.png" alt-text="Screenshot of selecting Add connection.":::

1. In the Connection Details sidebar, enter the following information to connect to the previous Task's PostgreSQL database:

    :::image type="content" source="../media/dp-3300-module-22-lab-42.png" alt-text="Screenshot of adding connection details.":::

    - Connection Type: **PostgreSQL**

    - Server: Paste the name you copied form the Azure portal.

    - Authentication Type: **Password**

    - User name: <strong>labadmin@postgresql-azure-<your initials\></strong> (note that the user name must include the hostname. This is the first part up to the period in the server name.)

    - Password: **Azur3Pa$$2020**

    - Database name: **\<default\>**

    - Server group: **\<default\>**

    - Name (optional): You can add a friendly name for the database server if you like. It can be left blank.

1. Select **Connect**.

1. Azure Data Studio is now connected to your PostgreSQL database server.  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-43.png" alt-text="Screenshot of being connected to the database.":::

1. Select **Databases**. Double-click on the **postgres** database.

    :::image type="content" source="../media/dp-3300-module-22-lab-46.png" alt-text="Screenshot of selecting a New Notebook.":::

1. Select **New Notebook**.

1. Select **+ Code**.
1. In the Notebook cell, type this query:

    ```sql
    SELECT * FROM information_schema.sql_features
    ```

1. Select **Run Cells**.

    :::image type="content" source="../media/dp-3300-module-22-lab-44.png" alt-text="Screenshot of results from SQL query.":::

1. View the results from the query.

You've now seen how easy it is to create a hosted version of PostgreSQL on Azure.

To finish this exercise select **Done** below.
