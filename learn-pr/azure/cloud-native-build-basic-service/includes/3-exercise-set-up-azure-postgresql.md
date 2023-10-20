This exercise takes you through the process of creating and configuring Azure Database for PostgreSQL. 

In this exercise, you'll:

* Create a single-server instance of Azure Database for PostgreSQL.
* Configure the Azure Database for PostgreSQL server.
* Connect to the Azure Database for PostgreSQL server.
* Create a sample database and table.

## Prerequisites

To perform this exercise, you need:

* An Azure subscription.
* A Microsoft account or a Microsoft Entra account with the Global Administrator role in the Microsoft Entra tenant that's associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription.

## Create a single server instance of Azure Database for PostgreSQL

1. On a web browser, navigate to the [Azure portal](https://portal.azure.com/?azure-portal=true) and sign in to access the Azure subscription that you'll be using in this module.
1. Use the **Search resources, services, and docs** text box at the beginning of the Azure portal page to search for **Azure Database for PostgreSQL**, and then in the list of results, in the **Marketplace** section, select **Azure Database for PostgreSQL**.
1. On the **Select Azure Database for PostgreSQL deployment option** blade, on the **Single server** tile, select **Create**.
1. On the **Basics** tab at the top of the **Single server** blade, configure the following settings and leave all other settings with their default values:

   | Setting | Configuration |
   | --- | --- |
   | Subscription | Select the name of the Azure subscription you'll be using in this module. |
   | Resource group | Create a new resource group named **postgresql-db-RG**. |
   | Server name | Enter a unique name that consists of lower-case letters, digits or dashes, and starts with a letter. |
   | Data source | Select **None**. |
   | Location | Select the Azure region closest to the location of your lab environment where you can create Azure Database for PostgreSQL instances. |
   | Version | Select **11**. |
   | Compute + storage | Select the **Configure server** link. On the **Configure** blade, select **Basic**, set the **vCore** value to **1** and **Storage** to **5 GB**, and then select **OK**. |
   | Admin username | Enter **Student**. |
   | Password | Enter **Pa55w0rd1234**. |

    :::image type="content" source="../media/3-azure-db-postgresql-create-basics.png" alt-text="Screenshot of the Basics tab of the Single server blade in the Azure portal.":::

1. Select **Review + create**.
1. On the **Review + create** tab of the **Single server** blade, select **Create**. Wait for the provisioning to complete. This might take about five minutes.

    > [!NOTE]
    > The provisioning process automatically creates a database named **postgres** within the target server.

## Configure the Azure Database for PostgreSQL server

1. Within the browser window displaying the Azure portal with the Azure Database for PostgreSQL single server provisioning status blade, select **Go to resource**.
1. On the Azure Database for PostgreSQL single server blade, in the vertical menu, in the **Settings** section, select **Connection security**.
1. On the **Connection security** blade, set **Allow access to Azure services** to **Yes**, select **+ Add client IP**, set **Enforce SSL connection** to **DISABLED**, and then select **Save**.

    > [!NOTE]
    >  These settings will allow connectivity to the database from your computer and from applications running in Azure.

    > [!NOTE]
    >  Disabling the SSL enforcement is meant strictly to simplify the subsequent exercises. In general, you should keep this setting enabled.

## Connect to the Azure Database for PostgreSQL server

1. Within the browser window displaying the Azure portal with the Azure Database for PostgreSQL single server blade, in the vertical menu, select **Overview**.
1. In the **Essentials** section, identify the entries next to the **Server name** and **Admin username** labels and record their values.

   You'll use these values to connect to the database from your computer and from applications running in Azure. Note that the username includes the **@** symbol followed by the server name you specified in the previous task.

1. In the Azure portal, open the **Cloud Shell** by selecting its icon in the toolbar next to the search text box.
1. If you're prompted to select either **Bash** or **PowerShell**, select **Bash**.

    > [!NOTE]
    > If this is the first time you're starting Azure Cloud Shell and you're presented with the **You have no storage mounted** message, select the subscription you're using in this lab, and then select **Create storage**.

1. Within the Bash session on the **Azure Cloud Shell** pane, run the following command to connect to the **postgres** database hosted on the newly deployed single server instance of Azure Database for PostgreSQL. Replace the `<server_name>` and `<user_name>` placeholders with the values you recorded previously in this task, and when prompted to provide the password, enter **Pa55w0rd1234**:

    ```azurecli
    psql --host=<server_name> --port=5432 --username=<user_name> --dbname=postgres
    ```

    > [!NOTE]
    > Once you successfully connect, you should be presented with the `postgres=>` prompt.

## Create a sample database and table

1. From the `postgres=>` prompt, run the following command to create a new database named **cnainventory** (make sure to include the semicolon at the end of the command):

    ```t-sql
    CREATE DATABASE cnainventory;
    ```

1. Run the following command to switch the connection to the newly created database:

    ```t-sql
    \c cnainventory
    ```

1. Run the following command to create an inventory table in the newly created database:

    ```t-sql
    CREATE TABLE inventory (
    id serial PRIMARY KEY, 
    name VARCHAR(50), 
    quantity INTEGER,
        date DATE NOT NULL DEFAULT NOW()::date
    );
    ```

    > [!NOTE]
    > The inclusion of the date column facilitates partitioning of the table based on date.

1. Run the following command to verify that the table has been created successfully:

    ```t-sql
    \dt
    ```

1. Run the following command to load sample data into the newly created table:

    ```t-sql
    INSERT INTO inventory (id, name, quantity) VALUES (1, 'yogurt', 200);
    INSERT INTO inventory (id, name, quantity) VALUES (2, 'milk', 100);
    ```

1. Run the following command to verify that the table contains the data you inserted (the output should display newly added inventory items):

    ```t-sql
    SELECT * FROM inventory;
    ```

1. Close the Cloud Shell pane displaying a Bash session.

## Results

Congratulations! You've completed the first exercise of this module. In this exercise, you created a single server instance of Azure Database for PostgreSQL, configured its connection security options, connected to it, and added a database and table with sample inventory data.
