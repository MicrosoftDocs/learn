In the previous module, Enhanced healthcare bots, we developed a vitals bot to collect basic health information from users. To store the data we collected, we'll build a database.

Follow these steps to build a database:

1. In the [Azure portal](https://portal.azure.com/), sign in to your account.

1. Select **Create a resource**.

   :::image type="content" source="../media/2-database-creation.png" alt-text="Screenshot showing how to provision a database." lightbox="../media/2-database-creation.png":::

1. On the **Categories** menu, select **Databases**. On the database list, select **SQL Database**.

1. Select **Create**.

   :::image type="content" source="../media/2-create-database.png" alt-text="Screenshot showing how to create a database." lightbox="../media/2-create-database.png":::

1. Use the following information to configure the SQL database fields:

    - **Subscription**: Select your subscription.
    - **Resource group**: Select **Create new** and enter a unique name for the resource group. We'll name our resource group *Healthbot*. Then select **OK**.
    - **Database name**: Name your database. We'll name our database *healthbot*.

      :::image type="content" source="../media/2-create-sql-server.png" alt-text="Screenshot showing how to create a server." lightbox="../media/2-create-sql-server.png":::

    - **Server**: Select **Create new**. Then fill in the fields:

       - **Server name**: Add a server name such as *healthbot*.
       - **Server admin login**: Add a username for the server, such as *learnbot*.
       - **Password**: Add a unique password for the server. We used *healthbot@123*.
       - **Confirm password**: Carefully retype the password you provided in the **Password** field.
       - **Location**: Select **(US) West US**
       - Select **OK**.

    :::image type="content" source="../media/2-database-compute.png" alt-text="Screenshot showing how to search for a database compute option." lightbox="../media/2-database-compute.png":::

   - **Want to use SQL elastic pool?**: Select **No**.

   - **Compute + storage**: Select **Configure database**. Then select **Looking for basic, standard, premium**.

      :::image type="content" source="../media/2-compute-categories.png" alt-text="Screenshot showing categories of compute plans." lightbox="../media/2-compute-categories.png":::

   - Select the **Basic** option. Note its cost. Then select **Apply**.

      :::image type="content" source="../media/2-database-review-create.png" alt-text="Screenshot showing a database review." lightbox="../media/2-database-review-create.png":::

   - **Backup storage redundancy**: Select **Geo-redundant backup storage**.

1. Select **Review + Create**. 

1. On the summary page that appears, make sure you entered all details accurately. Then select **Create**.

1. After the deployment succeeds, select the SQL database you created.

1. Note down the Server name that's listed under **Essentials**.

   :::image type="content" source="../media/2-query-editor.png" alt-text="Screenshot showing the database's query editor." lightbox="../media/2-query-editor.png":::

1. In the menu on the left, select **Query editor (preview)**. In the page that appears, enter the credentials you created in the previous steps. (**Login ID**: *learnbot*, **Password**: *healthbot@123*)

   :::image type="content" source="../media/2-whitelist-ip.png" alt-text="Screenshot showing how to add a single IP address to an allowlist." lightbox="../media/2-whitelist-ip.png":::

   An error states, **Cannot open server**.

   > [!NOTE]
   > To avoid this error, follow these steps before you log in:
   >
   > 1. On the **Overview** page of the SQL database, select **Set server firewall**.
   > 1. For **Allow Azure services and resources to access this server**, select **Yes**.
   >
   >    :::image type="content" source="../media/2-firewall-settings.png" alt-text="Screenshot showing how to add all IP addresses to the allowlist." lightbox="../media/2-firewall-settings.png":::
   >
   > 1. Enter the following details in the three text boxes:
   >
   >    - **Rule name**: *ALL*
   >    - **Start IP**: *0.0.0.0*
   >    - **End IP**: *255.255.255.255*
   >
   > 1. Select **Save**.

1. To resolve the error, select the link that includes the IP address. Then select **OK**. You'll see this message: **Successfully updated server firewall rules**.

1. Enter the credentials again and then select **Login**.

   :::image type="content" source="../media/2-sql-query.png" alt-text="Screenshot showing a SQL query in the editor." lightbox="../media/2-sql-query.png":::

1. Select **Tables** to create a new table. In the code section, paste the following code:

   ```
        CREATE TABLE Persons (
        PersonID int,
        LastName varchar(255),
        FirstName varchar(255),
        Address varchar(255),
        City varchar(255)
        );
   ```

1. Select **Run**.

1. To save this code to your PC for future use, select **Save query**.

### Allow other users to edit your database

We often work with multiple people on the same project and want to share our current work with them. So we'll assign the the other users as admins for our database. They'll be able view and modify the database like we do.

Follow these steps to give access to another user:

:::image type="content" source="../media/2-sql-server.png" alt-text="Screenshot showing the SQL server." lightbox="../media/2-sql-server.png":::

1. In the Azure portal, select the SQL server you created.

   :::image type="content" source="../media/2-azure-active-directory.png" alt-text="Azure active directory" lightbox="../media/2-azure-active-directory.png":::

1. Select **Azure Active Directory** form the setting menu on the left side of the page.

1. Select **Set Admin** which will pop open an Azure Active Directory cell on your screen.

   :::image type="content" source="../media/2-set-admin.png" alt-text="Set Azure active directory admin" lightbox="../media/2-set-admin.png":::

1. Search for the user you'd like to give access to and choose **Select**.

### Visualizing the database in the form of a table

Even though we know our database is working successfully, to visualize the data getting logged into a table we can download and use Azure Data Studio.

1. Return to the Azure portal landing page and select the SQL database you created.

   :::image type="content" source="../media/2-database-connect.png" alt-text="Connecting a database for visualization" lightbox="../media/2-database-connect.png":::

1. From the dropdown menu of **Connect with**, select **Azure Data Studio**.

   :::image type="content" source="../media/2-azure-data-studio.png" alt-text="Azure Data Studio" lightbox="../media/2-azure-data-studio.png":::

1. Select **Download Azure Data Studio** and follow the steps given to download it. If you already have it installed in your laptop, select **Launch it Now**.

1. Select the **New Connection** icon next to Servers dropdown, and you'll be able to see a cell named connection pop on your screen.

   :::image type="content" source="../media/2-azure-data-studio-connection.png" alt-text="Connecting to database from Azure data studio" lightbox="../media/2-azure-data-studio-connection.png":::

1. Fill in the following details in the Connection details fields:

    - **Connection type**: Select Microsoft SQL Server.
    - **Server**: Paste the server name which you noted in step 8 under **Building a Database**.
    - **Authentication type**: Select **SQL Login** from the dropdown.
    - **Username**: Use the same Username which you used for logging into the Query Editor. We used **learnbot**.
    - **Password**: Use the same Password which you used for logging into the Query Editor. We used **healthbot@123**.
    - **Database**: Select the name of your database which you created on Azure.
    - **Server Group**: Leave it as **Default**.

1. Select **Connect**

   :::image type="content" source="../media/2-ads-run.png" alt-text="Executing query in Azure data studio" lightbox="../media/2-ads-run.png":::

1. Expand the Servers dropdown, then expand the **healthbotserver** dropdown, and continue to expand the dropdown named **Databases**.

1. Right-click on **healthbot** under the Databases and select the **New Query** option.

1. Enter **SELECT - FROM Vitals** into the query.

1. Select **Run** to see the table with the data logged till now.

> [!NOTE]
>
> - The query **SELECT - FROM Vitals** asks to select all the data from the table named Vitals.
> - The name of table is case-sensitive and the asterisk (\*) denotes **ALL**.
> - It is required for you to follow step 8, 9, and 10 every time you want to visualize the table.
