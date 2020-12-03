We need to set up our database and connect to it from an app. In this exercise we'll:

* Configure the firewall so we can connect to the database service
* Connect to the database service using Azure Cloud Shell
* Create a database called `paymentapp`
* Create a users table and load the names and age of two users
* Run an update query to update a users age

## Configure a server-level firewall rule

Azure has an automatic firewall for our server - preventing all external parties from connecting to the server. In the portal, we'll create a firewall rule to allow us to connect externally.

1. Go to the Azure portal. Select **All Resources** from the left-hand menu and select your newly created server. The **Overview** page for your server opens and provides options for further configuration.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)
    :::image type="content" source="../media/5a-firewall.png" alt-text="Azure Database for PostgreSQL - Search for server":::

1. In the server page, select **Connection security**

1. Select **Add 0.0.0.0 - 255.255.255.255**, then select **Continue**.

    :::image type="content" source="../media/5b-firewall.png" alt-text="Azure Database for PostgreSQL - Create Firewall Rule":::

1. Select **Save**

## Use psql to connect in Azure Cloud Shell

We'll now use the psql command-line utility to connect to the Azure Database for PostgreSQL server. To start with, we'll save the name of the database server in the Cloud Shell.

Copy the code below, and replace `{server-name}` with the server name you chose in exercise 3.

    ```bash
    SERVERNAME={server-name}
    ```

To run the code in this article in Azure Cloud Shell:

1. Start Cloud Shell.
1. Select the Copy button on the code block to copy the code.

    ```psql
    psql --host=$SERVERNAME.postgres.database.azure.com --port=5432 --username=paymentadmin@$SERVERNAME.postgres.database.azure.com --dbname=postgres
    ```

1. Paste the code into the Cloud Shell session by selecting Ctrl+Shift+V on Windows and Linux, or by selecting Cmd+Shift+V on macOS.
1. Select Enter to run the code to connect to your Azure Database for PostgreSQL database.
1. Type in your password and select enter.

## Create the paymentapp database

6. Once you're connected to the server, create a blank database at the prompt:

    ```sql
    CREATE DATABASE paymentapp;
    ```

7. At the prompt, execute the following command to **connect directly** to the newly created **paymentapp** database:

    ```sql
    \c paymentapp
    ```

## Create and query tables in the payment app database

Now that you know how to connect to the Azure Database for PostgreSQL, we can complete some basic tasks. We'll:

* Create a table
* Insert some account data into it
* View the table
* Edit one of the values

First, create a table and load it with some account data.

### Create the users table

8. In the Cloud Shell window, run the following query to create a table called `users`:

    ```sql
    CREATE TABLE users (
    	id serial PRIMARY KEY,
    	name VARCHAR(50),
    	age INTEGER
    );
    ```

The table is storing an id, name, and age.

9. You can see the newly created table in the list of tables now by typing:

    ```sql
    \dt
    ```

### Load data into the users table

Now that you have a table, insert some data into it.

10. In the Cloud Shell  window, run the following query to insert some rows of data.

    ```sql
    INSERT INTO users (id, name, age) VALUES (1, 'John', 45);
    INSERT INTO users (id, name, age) VALUES (2, 'Lauren', 32);
    ```

You have now two rows of sample data into the account table you created earlier.

## Query and update the data the users tables

11. Execute the following query to retrieve information from the account database table.

    ```sql
    SELECT * FROM users;
    ```

12. You can also update the data in the table.

    ```sql
    UPDATE users SET age = 31 WHERE id = 2;
    ```

13. You can see the updated values when you retrieve the data.

    ```sql
    SELECT * FROM users;
    ```

Well done. Now you can create a PostgreSQL database in Azure Database for PostgreSQL, create tables and query data.
