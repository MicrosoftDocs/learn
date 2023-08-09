Set up the database and connect to it from an app. In this exercise:

* Configure the firewall so you can connect to the database service
* Connect to the database service using Azure [Cloud Shell](https://shell.azure.com/)
* Create a database called `paymentapp`
* Create a `payment_users` table and load the names and age of two users
* Run an update query to update a users age

## Configure a server-level firewall rule

Azure has an automatic firewall for the server. It prevents all external parties from connecting to the server. In the Azure portal, create a firewall rule to allow us to connect externally.

1. Go to the [Azure portal](https://portal.azure.com)..

1. Select **All Resources** from the left-hand menu, and select your newly created server. The **Overview** page for your server opens and provides options for further configuration.

    :::image type="content" source="../media/5a-firewall.png" alt-text="Screenshot with All resources selected from the Azure portal menu.":::

1. In the navigation bar, under **Settings**, select **Connection security**.

1. Select **Add 0.0.0.0 - 255.255.255.255**, then select **Continue**.

    :::image type="content" source="../media/5b-firewall.png" alt-text="Screenshot shows the Connection security page with the Firewall rules.":::

1. Select **Save**.

## Use psql to connect in Azure Cloud Shell

Use the psql command-line utility to connect to the Azure Database for PostgreSQL server. To start with, save the name of the database server in  [Azure Cloud Shell](https://shell.azure.com/).

Run the code in this article in [Azure Cloud Shell](https://shell.azure.com/):

1. In the Azure portal, start [Cloud Shell](https://shell.azure.com/). For this example, be sure that **Bash** is selected as the shell type, not **PowerShell**.

1. Select **Copy** on the following code block to copy the code.

    ```bash
    SERVERNAME={server-name}
    ```

1. Paste the code into the [Cloud Shell](https://shell.azure.com/) session by selecting **Ctrl** + **Shift** + **V** on Windows and Linux, or by selecting **Cmd** + **Shift** + **V** on macOS.

1. Replace `{server-name}` with the server name you chose in unit 3.

1. Press **Enter** to run the code and set your server name.

### Connect to the server

To connect to the server, use the server name in a connection command, and the password from unit 3 of this module.

1. Copy the connection command for the Azure Database for PostgreSQL instance.

    ```psql
    psql --host=$SERVERNAME.postgres.database.azure.com --port=5432 --username=paymentadmin@$SERVERNAME.postgres.database.azure.com --dbname=postgres
    ```

1. Paste the code into the [Cloud Shell](https://shell.azure.com/) session, and press **Enter**.

1. Enter your password, and press **Enter** to connect.

    > [!NOTE]
    > If you get stuck, you can disconnect from the database connection using the `\q` command. You can then reconnect using the previous connection command. If you're still stuck, try pressing **Escape** and then press **Enter**, or alternatively `;`, then press **Enter**.

## Create the paymentapp database

1. After you're connected to the server, create a blank database at the prompt.

    ```sql
    CREATE DATABASE paymentapp;
    ```

1. At the prompt, run the following command to connect directly to the newly created `paymentapp` database.

    ```sql
    \c paymentapp
    ```

## Create and query tables in the payment app database

Now that you know how to connect to Azure Database for PostgreSQL and create a database, you can complete some basic tasks.

* Create a table
* Insert some account data into it
* View the table
* Edit one of the values

First, create a table and load it with some account data.

### Create the users table

1. In the [Cloud Shell](https://shell.azure.com/) window, run the following query to create a table called `payment_users`.

    ```sql
    CREATE TABLE payment_users (
       user_id serial PRIMARY KEY,
       user_name VARCHAR(50),
       age_in_years INTEGER
    );
    ```

    The table is storing an ID, name, and age.

1. You can see the newly created table in the list of tables now by entering:

    ```sql
    \dt
    ```

### Load data into the users table

Now that you have a table, insert some data into it.

In the [Cloud Shell](https://shell.azure.com/) window, run the following query to insert a couple rows of data.

```sql
INSERT INTO payment_users (user_id, user_name, age_in_years) VALUES (1, 'John', 45);
INSERT INTO payment_users (user_id, user_name, age_in_years) VALUES (2, 'Lauren', 32);
```

You have now two rows of sample data into the account table you created earlier.

### Query and update the data the users tables

1. Run the following query to retrieve information from the account database table.

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
