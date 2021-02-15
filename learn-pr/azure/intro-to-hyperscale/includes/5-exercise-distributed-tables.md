## Use psql to connect in Azure Cloud Shell

1. Go to Azure Cloud Shell.
    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com?azure-portal=true)

1. Select **Bash**.

1. Select the subscription you used in the previous exercise to deploy the Hyperscale server group.

    :::image type="content" source="../media/5a-subscription.png" alt-text="Select Subscription.":::

    After a few seconds, the Cloud Shell appears.

    :::image type="content" source="../media/5b-shell.png" alt-text="Azure Cloud Shell.":::

1. To make things easier, we'll save the name of the server group in the Cloud Shell. Copy the following code, and replace the `{SERVER-NAME}` with the name you set for the server in the previous exercise.

    ```bash
    SERVERNAME={SERVER-NAME}
    ```

    :::image type="content" source="../media/5-server-name.png" alt-text="Configure Hyperscale form.":::

    Let's now use the psql command-line utility to connect to the Hyperscale server group.

1. Select the Copy button on the code block to copy the code, and paste it into the Cloud Shell.

    ```psql
       psql "host=$SERVERNAME-c.postgres.database.azure.com port=5432 dbname=citus user=citus sslmode=require"
    ```

1. At the prompt, enter your password, and then press <kbd>Enter</kbd> to connect to your Hyperscale server group.

    > [!NOTE]
    > You can reset your password in the [Azure Portal](https://portal.azure.com?azure-portal=true). Select the server resource you created in the previous exercise (such as `payment-server-demo`), and then select `Reset password`.

## Create tables in the database

Now that you know how to connect to your Hyperscale server group, we can start to fill out the database. We'll:

- Create two tables.
- Inform Hyperscale to shard the two tables across the worker nodes.
- Insert payment and user data into the tables.

First, let's create the event and user tables.

1. In the Cloud Shell, run the following query to create our payment_events and payment_users tables.

    ```SQL
    CREATE TABLE payment_users
    (
        user_id bigint,
        url text,
        login text,
        avatar_url text,
        primary key(user_id)
    );
    
    CREATE TABLE payment_events
    (
        event_id bigint,
        event_type text,
        user_id bigint,
        merchant_id bigint,
        event_details jsonb,
        created_at timestamp,
        primary key(event_id)
    );
    ```
    
    The tables are on the coordinator node. To distribute the tables to the worker nodes, we have to run a `create_distributed_table` query with what `table` to distribute, and what `key` to shard it on. The syntax looks like `create_distributed_table('table', 'key')`
    
    In our case, we have the **user_id** to shard and we want to distribute both the tables we created. We'll shard the two tables from our previous step, `payment_events` and `payment_users`.
    
1. In the Cloud Shell, run the following query to distribute our payment_events and payment_users tables to the worker nodes.

    ```sql
    SELECT create_distributed_table('payment_events', 'event_id');
    SELECT create_distributed_table('payment_users', 'user_id');
    ```
    
    That's it. You've now got a distributed database.
    
    > [!IMPORTANT]
    > Distributing tables is necessary to take advantage of Hyperscale worker nodes. If you don't distribute tables, the worker nodes can't help run queries involving those tables.

## Load and query data

Now, we're ready to load in our **user data** `users.csv`, and **payment event data** `events.csv`.

1. Run the following command to download the CSV files of our user and payment event data.

    ```
    \! curl -O https://raw.githubusercontent.com/MicrosoftDocs/mslearn-create-connect-postgresHyperscale/main/users.csv
    \! curl -O https://raw.githubusercontent.com/MicrosoftDocs/mslearn-create-connect-postgresHyperscale/main/events.csv
    ```

1. Next, load the data from the CSV files into the distributed tables, `payment_users` and `payment_events`.

    ```sql
    SET CLIENT_ENCODING TO 'utf8';
    
    \copy payment_users from 'users.csv' WITH CSV;
    \copy payment_events from 'events.csv' WITH CSV;
    ```

    ### Run queries

    Our data is now loaded and distributed. Let's run a couple queries.

1. Run the following query in the Cloud Shell to see how many events we've stored.

    ```sql
    SELECT count(*) from payment_events;
    ```

    126,195 events. Let's look into the data further.

1. Run the following query in the Cloud Shell to see how many transactions we're having per hour.

    ```sql
    SELECT date_trunc('hour', created_at) AS hour,
           count(*) AS transactions
    FROM payment_events
    WHERE event_type = 'SendFunds'
    GROUP BY hour
    ORDER BY hour;
    ```

1. Now, let's take a look for high activity, and see if we can find anything interesting. Run the following query.

    ```sql
    SET citus.enable_repartition_joins TO ON;
    SELECT users.login, count(*) as purchases
    FROM payment_events events
    JOIN payment_users users
    ON events.user_id = users.user_id
    WHERE events.event_type = 'SendFunds'
    GROUP BY users.login
    ORDER BY purchases DESC LIMIT 20;
    ```

    We can see our most active user is `LombiqBot`, with 2232 transactions within the four-hour window. Interesting.

1. In the Cloud Shell, run the following command to disconnect from the Hyperscale instance.

    ```sql
    \q
    ```
    
    Keep the Cloud Shell open, and move onto Unit 6 - Scale up and scale out.
