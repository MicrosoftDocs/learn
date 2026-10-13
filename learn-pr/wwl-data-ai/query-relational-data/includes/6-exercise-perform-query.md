Contoso has provisioned the SQL database and has imported all the inventory data into the data store. As lead developer, you've been asked to run some queries over the data.

In this exercise, you query the database to find how many products are in the database, and the number of items in stock for a particular product.

## Setup

To save time, you create the database server and an empty database by running commands in the Cloud Shell. The commands perform the following operations:

- Creates an Azure SQL Database server.
- Creates an Azure SQL database named *Inventory* attached to the server.
- Creates a server firewall rule that allows Azure services to connect to the server.

1. Run the following commands in the Cloud Shell to create the Azure SQL server and database. The commands use the first resource group in your subscription or sandbox.

    ```bash
    resource=$(az group list --query '[0].name' --output tsv)
    location=$(az group list --query '[0].location' --output tsv)
    server=contoso-server-$(openssl rand -hex 5)
    database=Inventory
    login=sampleLogin
    password="Pw1-$(openssl rand -hex 8)"

    az sql server create --name $server --resource-group $resource --location "$location" --admin-user $login --admin-password "$password"
    az sql server firewall-rule create --resource-group $resource --server $server --name AllowYourIp --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0
    az sql db create --resource-group $resource --server $server --name $database --edition Basic

    echo "Server: $server.database.windows.net"
    echo "User: $login"
    echo "Password: $password"
    ```

    The commands take a few minutes to run. When they finish, the Cloud Shell displays the connection details for the database. Write down the username and password.

## Connect to the query editor

You use the built-in query editor in the Azure portal to connect to the database and query the data.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. In the portal, on the home page select **SQL databases**, and then select *Inventory* database located on the server you have just created.

    > [!div class="mx-imgBorder"]
    >![Screenshot of the SQL Databases menu option on the home screen.](../media/6-select-sql-datbases.png)

1. On the **Overview** page for your database, select **Set server firewall**.

    > [!div class="mx-imgBorder"]
    >![Screenshot of the Overview page for the SQL Database instance. The user has selected Set server firewall.](../media/6-server-firewall.png)

1. On the **Networking** page, select **Add your client IP**, and then select **Save**.

    > [!div class="mx-imgBorder"]
    >![Screenshot of the firewall settings for the SQL Database instance. The user has selected the option to add the client IP.](../media/6-set-client-ip.png)

1. Close the **Networking** page, and return to the **Overview** page for your database.

1. On the **Overview** page, select **Query editor** in the left menu.

1. Under **SQL server authentication**, enter the username and password you recorded earlier when the setup commands ran, and then select **OK**.

    > [!div class="mx-imgBorder"]
    >![Screenshot of the SQL Database sign-in page in the Azure portal.](../media/6-query-editor-login.png)

    The query editor opens, similar to this example:

    > [!div class="mx-imgBorder"]
    >![Screenshot of the SQL Database Query Editor.](../media/6-simple-ui-query.png)

> [!TIP]
> Adding your client IP in this step doesn't account for any existing VPN connections. If you can't connect to the query editor, disable any VPN connections or add the additional IP address manually from any errors displayed.

## Create the tables and sample data

1. Copy the following SQL script into the editor, and then select **Run**. The script creates the *Inventory* and *CustomerOrder* tables and inserts sample rows:

    ```sql
    CREATE TABLE Inventory (
        Id int PRIMARY KEY,
        Name VARCHAR(50),
        Stock INTEGER
    );

    CREATE TABLE CustomerOrder (
        Id int PRIMARY KEY,
        CustomerName VARCHAR(50),
        Quantity int,
        Created DATETIME,
        InventoryId int FOREIGN KEY REFERENCES Inventory(Id)
    );

    INSERT INTO Inventory (Id, Name, Stock) VALUES (1, 'banana', 150);
    INSERT INTO Inventory (Id, Name, Stock) VALUES (2, 'orange', 154);
    INSERT INTO Inventory (Id, Name, Stock) VALUES (3, 'apple', 23);
    INSERT INTO Inventory (Id, Name, Stock) VALUES (4, 'lemon', 254);

    INSERT INTO CustomerOrder (Id, CustomerName, InventoryId, Quantity, Created) VALUES (1, 'John Smith', 2, 5, GETDATE());
    INSERT INTO CustomerOrder (Id, CustomerName, InventoryId, Quantity, Created) VALUES (2, 'Jane Brown', 2, 8, GETDATE());
    INSERT INTO CustomerOrder (Id, CustomerName, InventoryId, Quantity, Created) VALUES (3, 'Stephen Stone', 3, 3, GETDATE());
    INSERT INTO CustomerOrder (Id, CustomerName, InventoryId, Quantity, Created) VALUES (4, 'Claire Smith', 1, 1, GETDATE());
    INSERT INTO CustomerOrder (Id, CustomerName, InventoryId, Quantity, Created) VALUES (5, 'Sarah Fedun', 4, 3, GETDATE());
    INSERT INTO CustomerOrder (Id, CustomerName, InventoryId, Quantity, Created) VALUES (6, 'Graham Hinson', 3, 9, GETDATE());
    ```

## Run queries against the database

1. Replace the SQL script with the following statement. Select **Run**, to check everything is working. You should see a list of four inventory items.

    ```SQL
    SELECT * 
    FROM Inventory
    ```

    > [!div class="mx-imgBorder"]
    >![Screenshot showing how to run a basic query in SQL Database Query Editor.](../media/6-run-basic-query.png)

1. Replace the current SQL statement with the following statement to only show the number of bananas in stock:

    ```sql
    SELECT * 
    FROM Inventory 
    WHERE Name = 'banana'
    ```

    There should be 150 bananas.
    
    > [!div class="mx-imgBorder"]
    >![Screenshot showing how to run a WHERE query in SQL Database Query Editor.](../media/6-select-where-sql-databases.png)

1. Replace the SQL statement with the following statement to retrieve the inventory items in order of the quantity in stock:

    ```sql
    SELECT * 
    FROM Inventory 
    ORDER BY Stock
    ```
    
    > [!div class="mx-imgBorder"]
    >![Screenshot showing how to run an ORDER query in SQL Database Query Editor.](../media/6-select-order-sql-databases.png)

1. Replace the SQL statement with the statement shown below. This statement is a query that uses the  **JOIN** operator to combine data from the *CustomerOrder* table and the *Inventory* table. It lists the details of orders placed by customers together with the inventory information for each item ordered:
    
    ```sql
    SELECT * 
    FROM Inventory 
    JOIN CustomerOrder ON Inventory.Id = CustomerOrder.InventoryId
    ```
    
    > [!div class="mx-imgBorder"]
    >![Screenshot showing how to run a JOIN query in SQL Database Query Editor.](../media/6-select-join-sql-databases.png)

1. Change the query to find the names of all customers who have ordered oranges.

    ```sql
    SELECT CustomerOrder.CustomerName 
    FROM CustomerOrder
    JOIN Inventory ON CustomerOrder.InventoryId = Inventory.ID
    AND Inventory.Name = 'orange'
    ```

    This query should return two customers: John Smith and Jane Brown 

1. Find out how many customers have ordered lemons. This query uses the **COUNT(*)** function, which returns the number of rows that match the query criteria.

    ```sql
    SELECT COUNT(*) 
    FROM CustomerOrder
    JOIN Inventory ON CustomerOrder.InventoryId = Inventory.ID
    AND Inventory.Name = 'lemon'
    ```

    The results of this query should indicate that only one customer has ordered lemons.

1. Which fruits has John Smith ordered?

    ```sql
    SELECT Inventory.Name 
    FROM CustomerOrder
    JOIN Inventory ON CustomerOrder.InventoryId = Inventory.ID
    AND CustomerOrder.CustomerName = 'John Smith'
    ```

    The results of this query should show that John Smith has only ordered oranges.

1. What is the total quantity of items ordered by all customers? The *Quantity* column in the *CustomerOrder* table contains the quantity for each order. This query uses the **SUM** aggregate function to add the quantities together to product a grand total:

    ```sql
    SELECT SUM(CustomerOrder.Quantity) 
    FROM CustomerOrder
    ```

    The answer should be 29.

You've now run SQL queries against a SQL database. If you have time, try to add some more rows into both tables using **INSERT** statements, modify the rows using **UPDATE** statements, and remove rows using **DELETE** statements.

