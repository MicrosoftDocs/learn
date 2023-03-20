In the previous module, we developed a vitals bot to collect basic health information from users. To store the information, we'll build a database.

Follow these steps to build a database:

1. In the [Azure portal](https://portal.azure.com/), sign in to your account.

1. Select **Create a resource**.

1. In the **Categories** menu, select **Databases**. Then select **SQL Database**.

   :::image type="content" source="../media/2-database-creation.png" alt-text="Screenshot showing how to provision a database. In the Categories list, Databases is selected." lightbox="../media/2-database-creation.png":::

1. Select **Create**.

   :::image type="content" source="../media/2-create-database.png" alt-text="Screenshot of the Create SQL Database page." lightbox="../media/2-create-database.png":::

1. Use the following information to configure the SQL Database:

    - **Subscription**: Select your subscription.
    - **Resource group**: Select **Create new** and enter a unique name for the resource group, such as *Healthbot*. Then select **OK**.
    - **Database name**: Name your database. We'll name our database *healthbot*.
    - **Server**: Select **Create new**, and then fill in the following:

       - **Server name**: Add a server name, such as *healthbot*.
       - **Server admin login**: Add a username, such as *learnbot*.
       - **Location**: Select a location close to you.
       - **Authentication method**: Select **Use SQL authentication**.
       - **Password**: Add a unique password for the server. We'll use *healthbot@123*.
       - **Confirm password**: Retype the password you provided in the **Password** field.
       - Select **OK**.

        :::image type="content" source="../media/2-health-bot-create-sql-server.png" alt-text="Screenshot showing how to create a server.":::

    - **Want to use SQL elastic pool?**: Select **No**.

    - **Compute + storage**: Select **Configure database**. Select **Service tier**.

      :::image type="content" source="../media/2-health-bot-database-size.png" alt-text="Screenshot that shows selecting the Basic compute plan.":::

    - Select the **Basic** option from the drop-down. Note its cost. Then select **Apply**.

    - **Backup storage redundancy**: Select **Geo-redundant backup storage**.

1. Select **Review + create**.

   :::image type="content" source="../media/2-database-review-create.png" alt-text="Screenshot showing the review of the database. The Review + create button is selected." lightbox="../media/2-database-review-create.png":::

1. On the summary page that appears, make sure you entered all details accurately. Then select **Create**.

1. After the deployment succeeds, select **Go to resource**.

1. Make a note of the server name that's listed under **Essentials**.

   :::image type="content" source="../media/2-query-editor.png" alt-text="Screenshot showing the database's query editor. The server name is listed on the right." lightbox="../media/2-query-editor.png":::

1. Return to the **Overview** page of the SQL database, and then select **Set server firewall**.

1. Under **Public network access**, select **Selected networks**.

1. Under **Exceptions**, select the checkbox for **Allow Azure services and resources to access this server**.

   :::image type="content" source="../media/2-health-bot-add-firewall-rule.png" alt-text="Screenshot showing how to add all I P addresses to the allowlist." lightbox="../media/2-health-bot-add-firewall-rule.png":::

1. Under **Firewall rules**, select **Add a firewall rule**, and then enter the following details in the three text boxes:

     - **Rule name**: *ALL*
     - **Start IP**: *0.0.0.0*
     - **End IP**: *255.255.255.255*

1. Select **Save**.

1. In the menu on the left, select **Query editor (preview)**. Then enter the credentials you created in the previous steps.

    - **Login ID**: *learnbot*
    - **Password**: *healthbot@123*

1. Select **Tables** to create a new table.

   :::image type="content" source="../media/2-sql-query.png" alt-text="Screenshot showing a SQL query in the editor." lightbox="../media/2-sql-query.png":::

   In the code section, paste the following code:

   ```sql
        CREATE TABLE Vitals (
               name varchar(255),
               Age int,
               Weight int,
               Height int,
               ColumnDateTime DATETIME DEFAULT CURRENT_TIMESTAMP
        );
   ```

1. Select **Run**.

1. To save this code for future use, select **Save query**.

## Allow other users to edit your database

We often work with multiple people on the same project and want to be able to share our current work with them. So we'll assign the other users as administrators for our database. They'll be able view and modify the database like we do.

Follow these steps to give access to another user:

1. In the Azure portal, select the SQL server you created.

    :::image type="content" source="../media/2-sql-server.png" alt-text="Screenshot showing the selected seequel server." lightbox="../media/2-sql-server.png":::
    
1. In the menu on the left side of the page, select **Azure Active Directory**.

   :::image type="content" source="../media/2-azure-active-directory.png" alt-text="Screenshot showing the Azure Active Directory selection. The Set admin tab is also selected." lightbox="../media/2-azure-active-directory.png":::

1. Select **Set admin** to open the **Azure Active Directory** pane.

1. Search for the user who needs access. Then choose **Select**.

   :::image type="content" source="../media/2-set-admin.png" alt-text="Screenshot showing the Azure Active Directory pane." lightbox="../media/2-set-admin.png":::

## Visualize the database as a table

Even though we know our database works, we can visualize the data that's logged into a table. To visualize it, we'll use Azure Data Studio.

1. On the Azure portal landing page, select the SQL database you created.

1. Select **Connect with** > **Azure Data Studio**.

   :::image type="content" source="../media/2-database-connect.png" alt-text="Screenshot showing how to connect a database for visualization." lightbox="../media/2-database-connect.png":::

1. Select **Download Azure Data Studio**. Follow the steps to download it. If Data Studio is already installed, select **Launch it now**.

   :::image type="content" source="../media/2-azure-data-studio.png" alt-text="Screenshot showing how to download or open Azure Data Studio." lightbox="../media/2-azure-data-studio.png":::

1. Select the **New connection** button next to the **Servers** list. The **Connection** pane opens on the right.

   :::image type="content" source="../media/2-azure-data-studio-connection.png" alt-text="Screenshot showing the New connection button and the Connection pane. The Connect button is selected." lightbox="../media/2-azure-data-studio-connection.png":::

1. Fill in information for the following fields:

    - **Connection type**: Select **Microsoft SQL Server**.
    - **Server**: Paste the server name you created in step 9.
    - **Authentication type**: Select **SQL login**.
    - **Username**: Use the username you used to log in to the query editor. We used *learnbot*.
    - **Password**: Use the password you used to log in to the query editor. We used *healthbot@123*.
    - **Database**: Select the name of the database you created on Azure.
    - **Server group**: Leave the selection as **Default**.

1. Select **Connect**.

1. In the **Servers** list, select **healthbotserver** > **Databases**.

1. Right-click **healthbot** and then select **New query**.

1. In the query, enter *SELECT * FROM Vitals*.

1. Select **Run** to see the table of the currently logged data.

   :::image type="content" source="../media/2-ads-run.png" alt-text="Screenshot showing how to run a query in Azure Data Studio. The Run button is selected." lightbox="../media/2-ads-run.png":::

> [!NOTE]
>
> - The query **SELECT * FROM Vitals** asks to select all the data from the table named *Vitals*.
> - The table name is case sensitive. The asterisk (\*) denotes **ALL**.
> - Follow steps 8 through 10 every time you want to visualize the table.
