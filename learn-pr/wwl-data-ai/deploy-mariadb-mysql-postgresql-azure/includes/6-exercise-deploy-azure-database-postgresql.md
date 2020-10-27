As a database administrator, you'll set up a new Azure Database for PostgreSQL for testing. You've been asked to evaluate how Azure Data Studio can be used in your company to support its existing PostreSQL estate.

## Deploy a PostgreSQL Database

1. When the VM lab environment opens use the password on the Resources tab for the Student account.

1. Select the Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/).

1. The username and password information to sign into the Azure Portal are in the  **Resources** tab above these instructions. If you select the **Username** the environment will type the text for you.

1. Repeat this for the password field.

1. From the Azure Portal, select on **+ Create a Resource** at the top of the left side navigation bar.

    :::image type="content" source="../media/dp-3300-module-22-lab-34.png" alt-text="Screenshot of selecting the create a resource link.":::

1. Search for "postgresql" in the search box at the top, then select **Azure Database for PostgreSQL** in the results.  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-35.png" alt-text="Screenshot of selecting Azure Database for PostgreSQL from the search results.":::

1. Select **Create**.

1. Select **Create** for the Single Server option.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-36.png" alt-text="Screenshot of select create under the Singer server option.":::

1. Complete the Single Server Basics screen with the following information:

    ‎:::image type="content" source="../media/dp-3300-module-22-lab-38.png" alt-text="Screenshot of single server options completed.":::

    - Subscription: Select the lab subscription
    - Resource Group: **DP-300-Lab02**
    - Server Name: **dp300-lab02-&lt;your initials&gt;** (add additional characters as a server name must be unique)
    - Data source: **None**
    - Location: Select the Region closest to you, which has been used throughout this lab.
    - Version: **10** or **11**
    - Select **Configure Server** link under **Compute + Storage**.

        :::image type="content" source="../media/dp-3300-module-22-lab-37.png" alt-text="Screenshot of ":::

        - Select **Basic** tab.
        - Slide the vCore slider all the way to the left to select **1 vCore**.
        - Select **OK**.

    - Admin username: **dp300admin**
    - Password: Enter a strong password
    - Confirm password: Enter the same strong password

1. Select **Review + Create**.

1. Review the settings and select **Create**.

1. When the deployment is complete, select **Go to resource**.

## Enable All Azure Services Access to PostgreSQL Database

1. Select on the **Connection security** button under Settings in the database's sidebar.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-39.png" alt-text="Screenshot of ":::

1. Slide the Allow access to Azure services setting to **Yes**.
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-40.png" alt-text="Screenshot of ":::

1. Select **+ Add client IP**.

1. Select **Save** at the top left.

1. On the left select **Overview**, then copy the **Server name** from the top right.

## Connect to the PostgreSQL Database with Azure Data Studio (ADS)

> [!NOTE]
> With the PostgreSQL extension installed to ADS, PostgreSQL can be queried. This extension is pre-installed on the lab VM.

1. In Azure Data Studio on the lab VM, ensure the Connections sidebar is expanded.
1. Select **Connections** button in the left nav bar, if not.

1. Select **New Connection** button  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-41.png" alt-text="Screenshot of ":::

1. In the Connection Details sidebar, enter the following information to connect to the previous Task's PostgreSQL database:

    - Connection Type: **PostgreSQL**

    - Server: Paste the name you copied form the Azure Portal.

    - Authentication Type: **Password**

    - User name: **dp300admin@[hostname]** (note that the user name must include the hostname. This is the first part up to the period in the server name.)

    - Password: The strong password you used to create the PostgreSQL in the portal.

    - Database name: **&lt;default&gt;**

    - Server group: **&lt;default&gt;**

    - Name (optional): You can add a friendly name for the database server if you like. It can be left blank.

1. Review the connection settings.  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-42.png" alt-text="Screenshot of ":::

1. Select **Connect**.

1. Azure Data Studio is now connected to your PostgreSQL database server.  
‎
    :::image type="content" source="../media/dp-3300-module-22-lab-43.png" alt-text="Screenshot of ":::

1. Double-click on the **postgres** database.

1. Select **New Notebook**.

1. Select **+ Code**.
1. In the Notebook cell, type this query:

    ```sql
    SELECT * FROM information_schema.sql_features
    ```

1. Select **Run Cells**.

    :::image type="content" source="../media/dp-3300-module-22-lab-44.png" alt-text="Screenshot of ":::

1. View the results form the query.