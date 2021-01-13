We need to set up our database and connect to it from an app. In this exercise, we'll:

* Configure the firewall so we can connect to the database service
* Connect to the database service using Azure Cloud Shell
* Create a database called `paymentapp`
* Create a `payment_users` table and load the names and age of two users
* Run an update query to update a users age

## Configure a server-level firewall rule

Azure has an automatic firewall for our server - preventing all external parties from connecting to the server. In the portal, we'll create a firewall rule to allow us to connect externally.

1. Go to the Azure portal. Select **All Resources** from the left-hand menu, and select your newly-created server. The **Overview** page for your server opens and provides options for further configuration.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)
    :::image type="content" source="../media/5a-firewall.png" alt-text="Azure Database for PostgreSQL - Search for server":::

1. In the left nav bar, under **Settings**, select **Connection security**.

1. Select **Add 0.0.0.0 - 255.255.255.255**, then select **Continue**.

    :::image type="content" source="../media/5b-firewall.png" alt-text="Azure Database for PostgreSQL - Create Firewall Rule":::

1. Select **Save**.

## Use psql to connect in Azure Cloud Shell

We’ll now use the psql command-line utility to connect to the Azure Database for PostgreSQL server. To start with, we'll save the name of the database server in the Cloud Shell on the right of your screen.

To run the code in this article in Azure Cloud Shell:

1. Start Cloud Shell.

1. Select **Copy** on the following code block to copy the code.

    ```bash
    SERVERNAME={server-name}
    ```

1. Paste the code into the Cloud Shell session by selecting Ctrl+Shift+V on Windows and Linux, or by selecting Cmd+Shift+V on macOS.

1. Replace `{server-name}` with the server name you chose in Unit 3.

1. Press <kbd>Enter</kbd> to run the code and set your server name.

### Connect to the server

To connect to the server, we'll use our sever name in a connection command, and the password from Exercise 3.

1. Copy the connection command for our Azure Database for PostgreSQL instance.

    ```psql
    psql --host=$SERVERNAME.postgres.database.azure.com --port=5432 --username=paymentadmin@$SERVERNAME.postgres.database.azure.com --dbname=postgres
    ```

1. Paste the code into the Cloud Shell session, and press <kbd>Enter</kbd>.

1. Enter your password, and press <kbd>Enter</kbd> to connect.

    > [!NOTE]
    > If you get stuck, you can disconnect from the database connection using `\q`. You can then reconnect using the previous connection command. If you're still stuck, try pressing <kbd>Escape</kbd>, and then press <kbd>Enter</kbd>, or alternatively `;`, then press <kbd>Enter</kbd>.

## Create the paymentapp database

1. After you're connected to the server, create a blank database at the prompt.

    ```sql
    CREATE DATABASE paymentapp;
    ```

1. At the prompt, execute the following command to **connect directly** to the newly created **paymentapp** database.

    ```sql
    \c paymentapp
    ```

## Create and query tables in the payment app database

Now that you know how to connect to Azure Database for PostgreSQL and create a database, we can complete some basic tasks. We'll:

* Create a table
* Insert some account data into it
* View the table
* Edit one of the values

First, create a table and load it with some account data.

### Create the users table

1. In the Cloud Shell window, run the following query to create a table called `payment_users`.

    ```sql
    CREATE TABLE payment_users (
    	user_id serial PRIMARY KEY,
    	user_name VARCHAR(50),
    	age_in_years INTEGER
    );
    ```

    The table is storing an id, name, and age.

1. You can see the newly created table in the list of tables now by entering:

    ```sql
    \dt
    ```

### Load data into the users table

Now that you have a table, insert some data into it.

In the Cloud Shell  window, run the following query to insert a couple rows of data.

```sql
INSERT INTO payment_users (user_id, user_name, age_in_years) VALUES (1, 'John', 45);
INSERT INTO payment_users (user_id, user_name, age_in_years) VALUES (2, 'Lauren', 32);
```

You have now two rows of sample data into the account table you created earlier.

### Query and update the data the users tables

1. Execute the following query to retrieve information from the account database table.

    ```sql
    SELECT * FROM payment_users;
    ```

1. You can also update the data in the table.

    ```sql
    UPDATE payment_users SET age_in_years = 31 WHERE user_id = 2;
    ```

1. You can see the updated values when you retrieve the data.

    ```sql
    SELECT * FROM payment_users;
    ```

Well done. Now you can create a PostgreSQL database in Azure Database for PostgreSQL, create tables, and query data.
