In our previous module (Enhanced Healthcare Bot), we had developed a vitals bot to collects basic health information of the users. To store the data we collected, we are going to build a database.

Follow the steps to build a database:

1. Go to the [Azure Portal](https://portal.azure.com/) and sign into your account.

1. Select **Create a resource**.

   :::image type="content" source="../media/2-database-creation.png" alt-text="Provisioning a database":::

1. From the Categories menu, select **Databases** and select **SQL Database** from the listed options of databases.

1. Select **Create**.

   :::image type="content" source="../media/2-create-database.png" alt-text="Creating a database":::

1. The configurations for SQL database fields are mentioned below:

    - **Subscription:** Select your subscription.
    - **Resource group:** Select create new and enter a unique name for the resource group. In our case, we use the name as **Healthbot** and select **OK**.
    - **Database name:** Give a name for your database. We have used the name **healthbot**.

      :::image type="content" source="../media/2-create-sql-server.png" alt-text="Creating a server":::

    - **Server:** Click on 'Create New' and then fill in configurations for New Server cell as follows:

       - **Server Name:** Give a server name like **healthbot**.
       - **Server Admin Login:** Give a username for the server such as **learnbot**.
       - **Password:** Give a unique password for the server. We have used healthbot@123**.
       - **Confirm Password:** Carefully repeat the password you have given in the password field.
       - **Location:** Select **(US) West US** from the dropdown and select **OK**.

    :::image type="content" source="../media/2-database-compute.png" alt-text="Searching for a database compute option":::

   - Want to use SQL elastic pool: Select 'No'

   - Compute + Storage: Click on 'Configure database' and then click on 'Looking for basic, standard, premuim'

      :::image type="content" source="../media/2-compute-categories.png" alt-text="Categories of compute plans":::

   - Select the Basic option and note that it will cost 359.58 INR and click on 'Apply'

      :::image type="content" source="../media/2-database-review-create.png" alt-text="Review a database":::

   - Backup Storage Redundancy: Select 'Geo-redundant backup storage'

1. Select **Review + Create**, after which you will land on the summary page. Check if you have entered all the details accurately and select **Create**.

1. Once the deployment is successful, select the SQL database you have created.

1. Note down the Server name mentioned under the essentials.

   :::image type="content" source="../media/2-query-editor.png" alt-text="Query Editor of Database":::

1. Select **Query editor (preview)** from the menu bar on the left of the page and you will be able to see a login page. Enter the credentials which you created in the previous steps. (Login ID: learnbot and Password: healthbot@123)

   :::image type="content" source="../media/2-whitelist-ip.png" alt-text="Whitelisting a single IP address":::

1. It will give out an error saying **Cannot open server**.

    > [!NOTE]
    > To avoid this issue, follow the steps below before logging in:
    >
    > 1. In the Overview page of the SQL database, select **Set Server Firewall**.
    > 1. Select **Yes** for Allow azure Services and resources to access this server.
    >
    >    :::image type="content" source="../media/2i.png" alt-text="Searching for a database":::
    >
    > 1. Under Rule name enter the following details in the three textboxes:
    >
    >    - 1st textbox - ALL
    >    - 2nd textbox – 0.0.0.0
    >    - 3dr textbox – 255.255.255.255
    >
    > 1. Select **Save**.

1. To solve this issue, select the link with the IP address which is highlighted in the red box and select **ok**. With that you will get a **Succesfully updated server firewall rules** message.

1. Enter the credentials again and select Login.

   :::image type="content" source="../media/2-sql-query.png" alt-text="SQL query in Editor":::

1. After you login, select **Tables** to create a new table. In the code section, paste the following code:

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

1. To save this code to your PC for future purpose, select **Save Query**.

### Giving Access to other users to make changes to your database

We often work with multiple people on the same project and would like to share our timely updated work with them. We can do this by making the the other users admins for our database. This way the user can view and modify the database along with you.

Follow the steps to give access to another user:

:::image type="content" source="../media/2-sql-server.png" alt-text="Sql server":::

1. On the main Azure portal, select the SQL server you created.

   :::image type="content" source="../media/2-azure-active-directory.png" alt-text="Azure active directory":::

1. Select **Azure Active Directory** form the setting menu on the left side of the page.

1. Select **Set Admin** which will pop open an Azure Active Directory cell on your screen.

   :::image type="content" source="../media/2-set-admin.png" alt-text="Set azure active directory admin":::

1. Search for the user you'd like to give access to and choose **Select**.

### Visualizing the database in the form of a table

Even though we know our database is working successfully, to visualize the data getting logged into a table we can . For this we will require to download Azure Data Studio.

1. Return to the Azure portal landing page and select the SQL database you created.

   :::image type="content" source="../media/2-database-connect.png" alt-text="Connecting a database for visualisation":::

1. From the dropdown menu of **Connect with**, select **Azure Data Studio**.

   :::image type="content" source="../media/2-azure-data-studio.png" alt-text="Azure Data Studio":::

1. Select **Download Azure Data Studio** and follow the steps given to download it. If you already have it installed in your laptop, select **Launch it Now**.

1. Select the **New Connection** icon next to Servers dropdown, and you'll be able to see a cell named connection pop on your screen.

   :::image type="content" source="../media/2-azure-data-studio-connection.png" alt-text="Connecting to database from azure data studio":::

1. Fill in the following details in the Connection details fields:

    - **Connection type:** Select Microsoft SQL Server.
    - **Server:** Paste the server name which you noted in step 8 under **Building a Database**.
    - **Authentication type:** Select **SQL Login** from the dropdown.
    - **Username:** Use the same Username which you used for logging into the Query Editor. We used **learnbot**.
    - **Password:** Use the same Password which you used for logging into the Query Editor. We used **healthbot@123**.
    - **Database:** Select the name of your database which you created on Azure.
    - **Server Group:** Leave it as **Default**.

1. Select **Connect**

   :::image type="content" source="../media/2-ads-run.png" alt-text="Executing query in azure data studio":::

1. Expand the Servers dropdown, then expand the **healthbotserver** dropdown, and continue to expand the dropdown named **Databases**.

1. Right-click on **healthbot** under the Databases and select the **New Query** option.

1. Enter **SELECT - FROM Vitals** into the query.

1. Select **Run** to see the table with the data logged till now.

> [!NOTE]
>
> - The query **SELECT - FROM Vitals** asks to select all the data from the table named Vitals.
> - The name of table is case-sentive and the asterisk (\*) denotes **ALL**.
> - It is required for you to follow step 8, 9, and 10 everytime you want to visualize the table.
