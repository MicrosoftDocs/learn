## Use psql to connect in Azure Cloud Shell

1. Go to Azure Cloud Shell
    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com)

2. Select **Bash**
3. Select the subscription you used in the previous exercise to deploy the Hyperscale sever group

![Select Subscription](../media/5a.png)

After a few seconds, a black cloud shell should appear

![Azure Cloud Shell](../media/5b.png)

Let's now use the psql command-line utility to connect to the Hyperscale server group.

4. Select the Copy button on the code block to copy the code, and replace the `{YOUR-PASSWORD-HERE}` with your password from the previous exercise.

   ```psql
   psql "host=payment-server-demo-c.postgres.database.azure.com port=5432 dbname=citus user=citus password={YOUR-PASSWORD-HERE} sslmode=require"
   ```

    > [!NOTE]
    > You can reset your in the Azure Portal. Select the `payment-server-demo` resource, then select`Reset password` 

5. Paste the code into the Cloud Shell session by selecting Ctrl+Shift+V on Windows and Linux or by selecting Cmd+Shift+V on macOS.
6. Select Enter to run the code to connect to your Hyperscale server group.

## Create tables in the database

Now that you know how to connect to your Hyperscale server group, we can start to fill out the database. We'll:

- Create two tables
- Tell Hyperscale to shard the two tables across the worker nodes
- Insert payment and user data into the tables

First, create the event and user tables.

8. In the Cloud Shell window, run the following query to create our payment_events and payment_users tables:

```SQL
CREATE TABLE payment_events
(
    event_id bigint,
    event_type text,
    merchant_id bigint,
    user_id bigint primary key,
    event_details jsonb,
    created_at timestamp
);

CREATE TABLE payment_users
(
    user_id bigint primary key references payment_events,
    url text,
    login text,
    avatar_url text
);
```

The tables are on the coordinator node. To distribute the tables to the worker nodes, we have to run a `create_distributed_table` query with what `table` to distribute, and what `key` to shard it on. The syntax looks like `create_distributed_table('table', 'key')`

In our case, we have the **user_id** to shard and we want to distribute both the tables we created. We'll shard the two tables from our previous step, `payment_events` and `payment_users`.

9. In the Cloud Shell window, run the following query to distribute our payment_events and payment_users tables to the worker nodes:
```sql
SELECT create_distributed_table('payment_events', 'user_id');
SELECT create_distributed_table('payment_users', 'user_id');
```

That's it. You've now got a distributed database. Next, we'll load in some data.

> [!IMPORTANT]
> Distributing tables is necessary to take advantage of Hyperscale worker nodes. If you don't distribute tables, the worker nodes can't help run queries involving those tables.

Now we're ready to load in our **user data** `users.csv`, and **payment event data** `events.csv`.

10. Run the following command to download the CSV files of our user and payment event data.

```
\! curl -O https://raw.githubusercontent.com/TomReidNZ/CSV-Hosting/main/users.csv
\! curl -O https://raw.githubusercontent.com/TomReidNZ/CSV-Hosting/main/events.csv
```

11. Next, load the data from the CSV files into the distributed tables, `payment_users` and `payment_events`.

```sql
SET CLIENT_ENCODING TO 'utf8';

\copy payment_users from 'users.csv' WITH CSV;
\copy payment_events from 'events.csv' WITH CSV;
```

## Run queries

Our data is now loaded and distributed. Let's run a couple queries.

12. Run the follow query in the cloud shell to see how many events we have stored.

```sql
SELECT count(*) from payment_events;
```
126,243 events. Let's look into the data further.

13. Run the following query to see how many transcactions we're having per hour.

```sql
SELECT date_trunc('hour', created_at) AS hour,
       count(*) AS transactions
FROM payment_events
WHERE event_type = 'SendFunds'
GROUP BY hour
ORDER BY hour;
```

14. And now, for some analytics, run the following query to see how many transactions are staying within our bank.

```sql
SELECT count(*)
  FROM payment_events events
  JOIN payment_users users
    ON events.user_id = users.user_id
 WHERE events.event_type = 'SendFunds';
```
