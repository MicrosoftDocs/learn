## Use psql to connect in Azure Cloud Shell

1. Select [Azure Cloud Shell](https://shell.azure.com)
2. Select **Bash**
3. Select the subscription you used in the previous exercise to deploy the Hyperscale sever group

*image goes here*

After a few seconds, a black cloud shell should appear

*image goes here*

Let's now use the psql command-line utility to connect to the Hyperscale server group.

4. Select the Copy button on the code block to copy the code, and replace the `{YOUR-PASSWORD-HERE}` with your password from the previous exercise.

   ```psql
   psql "host=payment-server-demo-c.postgres.database.azure.com port=5432 dbname=citus user=citus password={YOUR-PASSWORD-HERE} sslmode=require"
   ```

5. Paste the code into the Cloud Shell session by selecting Ctrl+Shift+V on Windows and Linux or by selecting Cmd+Shift+V on macOS.
6. Select Enter to run the code to connect to your Hyperscale server group.

## Create tables in the database

Now that you know how to connect to your Hyperscale server group, we can start to fill out the database. We'll:

- create two tables
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
    user_id bigint,
    event_details jsonb,
    created_at timestamp
);

CREATE TABLE payment_users
(
    user_id bigint,
    url text,
    login text,
    avatar_url text
);
```

The tables are on the coordinator node. To distribute the tables to the worker nodes, we have to run a `create_distributed_table` query with what `table` to distribute, and what `key` to shard it on.

In our case, we have the **user_id** to shard.

> [!IMPORTANT]
> Distributing tables is necessary to take advantage of Hyperscale worker nodes. If you don't distribute tables, the worker nodes can't help run queries involving those tables.

9. In the Cloud Shell window, run the following query to distribute our payment_events and payment_users tables to the worker nodes:
```sql
SELECT create_distributed_table('payment_events', 'user_id');
SELECT create_distributed_table('payment_users', 'user_id');
```

Now we're ready to load in our **user data** `users.csv`, and **payment event data** `events.csv`.

10. Run the follow command to download the CSV files of our user and payment event data.

\! curl -0 https://raw.githubusercontent.com/TomReidNZ/CSV-Hosting/main/users.csv -o users.csv
\! curl -0 https://raw.githubusercontent.com/TomReidNZ/CSV-Hosting/main/events.csv -o events.csv

11. Next, load the data from the CSV files into the distributed tables, `payment_users` and `payment_events`.

```sql
SET CLIENT_ENCODING TO 'utf8';

\copy payment_users from 'users.csv' WITH CSV
\copy payment_events from 'events.csv' WITH CSV


SELECT count(*) from payment_users;
SELECT count(*) from payment_events;
```

## Run queries

Our data is now loaded and distributed. Let's run a couple queries.

12. Run the follow query in the cloud shell to see how many events we have stored.

```sql
SELECT count(*) from payment_events;
```

13. Run the follow query to see how many transcactions we're having per hour

```sql
SELECT date_trunc('hour', created_at) AS hour,
       count(*) AS transactions
FROM payment_events
WHERE event_type = 'SendFunds'
GROUP BY hour
ORDER BY hour;
```

```sql

SELECT users.login, count(*)
  FROM payment_events events
  JOIN payment_users users
    ON events.user_id = users.user_id
 WHERE events.event_type = 'SendFunds'
 GROUP BY users.login
 ORDER BY count(*) DESC;


 SELECT events.user_id, count(*)
  FROM payment_events events
 WHERE events.event_type = 'SendFunds'
 GROUP BY events.user_id
 ORDER BY count(*) DESC;

 SELECT users.login, count(*)
 FROM payment_events events
 JOIN payment_users users
 ON events.user_id = users.user_id
 WHERE events.event_type = 'SendFunds'
 GROUP BY events.user_id
 ORDER BY count(*) DESC;
```