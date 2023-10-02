In this exercise, you create tables and seed the data for the sensors database. This single-node database has the following characteristics:

- The `device_types` table has two fields: `device_type_id` and `name`.

   The `device_types` table primary key is `device_type_id`.

- The `devices` table has three fields: `device_id`, `device_type_id`, and `name`.

   The `devices` table primary key is `device_id`.

   A foreign key relationship on the `device_type_id` field references the `device_type_id` field on the `device_types` table.
- The `events` has four fields: `event_id`, `device_id`, `payload`, and `created_at`.

   The `events` table primary key is `event_id`.
  
   A foreign key relationship on the `device_id` field references the `device_id` field on the `devices` table.

:::image type="content" source="../media/normalized-database-erd.png" border="false" alt-text="Diagram that shows the relationships between three tables, and the columns and primary keys in each table.":::

## Create an Azure Cosmos DB for PostgreSQL account

> [!IMPORTANT]
>
> Planning for future growth when you initially select the size of your single-node cluster can help avoid downtime when the need to scale arises.
>
> Horizontally scaling to a multi-node cluster can be accomplished with zero downtime, but this capability depends on the configuration of the coordinator node. The minimum compute and storage sizes for the coordinator node in a multi-node cluster are four vCores with 16 GiB of RAM and 512 GiB of storage. 
>
> You can create a single-node database that has compute and storage settings smaller than this minimum requirement. Scaling a single-node cluster when the coordinator node compute size is less than four vCores with 16 GiB of RAM and less than 512 GiB of storage requires the coordinator node compute and storage to be scaled. After you scale the coordinator node compute and storage, you must restart the server, so there's a short period of downtime.
>

In this unit, you complete the process to have minimal downtime. There are notes on what to expect if Wide World Importers started with minimal resources.

To begin, you create an Azure Cosmos DB for PostgreSQL database that has the following specifications:

- One node that has four vCores, 16 GiB of RAM, and 512 GiB of storage

To create the database:

1. Open a web browser and go to the [Azure portal](https://portal.azure.com/).

1. Select **Create a resource** > **Databases** > **Azure Cosmos DB**. You can also use the search box to find the resource.

   In the **Azure Cosmos DB** tile, select **Create**.

   :::image type="content" source="../media/cosmos-db-for-postgresql-create.png" alt-text="Screenshot that shows the steps to create an Azure Cosmos DB for PostgreSQL resource in the Azure portal.":::

1. Under **Which API best suits your workload?**, on the **Azure Cosmos DB for PostgreSQL** tile, select **Create**.

   :::image type="content" source="../media/cosmos-db-select-api-option.png" alt-text="Screenshot of the Azure Cosmos DB API options. The PostgreSQL option is highlighted.":::

   The portal displays an Azure Cosmos DB for PostgreSQL configuration pane.

1. On the **Basics** tab, enter the following information. (Note the server name and password for later use.)

    | Parameter       | Value |
    | --------------- | ----- |
    | **Project details** |       |
    | Subscription    | Select your subscription.  |
    | Resource group  | Select **Create new** and name your resource group `learn-cosmosdb-postgresql`. |
    | **Cluster details** |       |
    | Cluster name    | _Enter a globally unique name_, such as `cosmos-sensors-data`. |
    | Location        | Leave the default, or use a region that is close to you. |
    | Scale           | You'll set this value in the next step. |
    | PostgreSQL version | Leave the default version (14) selected. |
    | **Administrator account** | |
    | Admin username  | This value is set to `citus` and can't be edited. |
    | Password        | Enter and confirm a strong password. |

1. On the **Basics** tab, for **Scale**, select **Configure**. Set the **Scale** settings to the following values, and then select **Save**:

    - Node count: **Single node**
    - Node compute: **4 vCores, 16 GiB RAM**
    - Node storage: **512 GiB**
    - No high availability

   :::image type="content" source="../media/cosmos-db-for-postgresql-basics-tab.png" alt-text="Screenshot that shows Basics tab options to use when you create an Azure Cosmos DB for PostgreSQL in the Azure portal.":::

    Select the **Review + create** button.
1. On the review screen, select **Create** to provision your Azure Cosmos DB for PostgreSQL cluster. If the **Configure IP address in firewall rules** dialog appears, select **Create cluster without firewall rules**.

    :::image type="content" source="../media/configure-ip-rules-warning.png" alt-text="Screenshot that shows options to choose in the Configure IP address in firewall rules dialog.":::

## Enable network access

After the Azure Cosmos DB for PostgreSQL account is created, you need to enable the resource to be accessible to other resources so that you can access the server by using the psql command-line tool in Azure Cloud Shell.

1. In the Azure portal, after the account is created, select **Go to resource** to go to your Azure Cosmos DB for PostgreSQL account.
1. In the left menu under **Settings**, select **Networking**.
1. On the **Networking** pane, select the **Allow public access from Azure services and resources within Azure to this cluster** checkbox.

    :::image type="content" source="../media/cosmos-db-for-postgresql-networking-tab.png" alt-text="Screenshot that shows the option to allow public access selected on the Azure Cosmos DB for PostgreSQL networking pane.":::

1. On the command bar, select **Save**.

## Connect to the database by using psql in the Azure Cloud Shell

After the Azure Cosmos DB for PostgreSQL cluster is created and the network access rules are saved, you can connect to the cluster by using Azure Cloud Shell.

1. On the left menu under **Settings**, select **Connection String**. Copy the connection string labeled **psql**.

    :::image type="content" source="../media/psql-connection-string.png" alt-text="Screenshot that shows the Connection String pane of the Azure Cosmos DB Cluster resource and the psql connection string highlighted.":::

1. Open [Azure Cloud Shell](https://shell.azure.com/) by using the global controls at the top of the portal.

    :::image type="content" source="../media/azure-portal-top-bar.png" alt-text="Screenshot of the bar that appears at the top of the Microsoft Azure portal. The Azure Cloud Shell button with the command icon is highlighted.":::

1. If you're prompted to select a shell environment, select **Bash**.

    :::image type="content" source="../media/azure-cloud-shell-welcome.png" alt-text="Screenshot that shows the Azure Cloud Shell welcome dialog, with a prompt to choose a shell environment, Bash or PowerShell. Bash is selected.":::

1. If you're prompted to create storage, select the subscription you use for your Azure Cosmos DB for PostgreSQL account. Then select **Create storage**.

    :::image type="content" source="../media/azure-cloud-shell-mount-storage.png" alt-text="Screenshot that shows the Azure Cloud Shell welcome wizard and no storage mounted. The current subscription appears in the Subscription dropdown.":::

1. To use the psql command-line utility to connect to Azure Cosmos DB for PostgreSQL, copy the psql connection string from step 1. Paste it in Cloud Shell. Update the `password` part of the connection string to use the password that you entered when you created the Azure Cosmos DB for PostgreSQL cluster. Then run the command.

## Create tables

After the account is created, you can add tables. Use psql in Cloud Shell to interact with the database.

The following code creates the `device_types`, `devices`, and `events` tables with their traditional primary key relationships:

```sql
CREATE TABLE device_types 
(
    device_type_id serial,
    device_type text,
    PRIMARY KEY(device_type_id)    
);

CREATE TABLE devices
(
    device_id serial,
    device_type_id int,
    name text,
    PRIMARY KEY (device_id),
    FOREIGN KEY (device_type_id) REFERENCES device_types (device_type_id)
);

CREATE TABLE events
(
    event_id bigserial,
    device_id int,
    payload jsonb,
    created_at timestamp,
    PRIMARY KEY(event_id),
    FOREIGN KEY (device_id) REFERENCES devices(device_id)    
);
```

Confirm that the tables were created by running the following command:

```sql
\dt
```

The output looks like this example:

```text
           List of relations
 Schema |     Name     | Type  | Owner 
--------+--------------+-------+-------
 public | device_types | table | citus
 public | devices      | table | citus
 public | events       | table | citus
(3 rows)
```

### Create a GIN index for the JSONB

You can create a Generalized Inverted Index (GIN index) to query JSON Binary (JSONB) by using fine-grained queries. This level of detail can help the query performance when you query the sensor values on the `events` table. Use the following query to create a GIN index on the `payload` field:

```sql
CREATE INDEX events_payload_idx ON events USING GIN (payload);
```

Confirm that the index appears in the **Indexes** list:

```sql
\d events
```

You should see an entry like the following example in the **Indexes** section:

```text
"events_payload_idx" gin (payload)
```

### Confirm that the tables aren't yet distributed

The `citus_tables` view shows any tables that are distributed. To ensure that these newly created tables aren't yet distributed, run the following query:

```sql
SELECT * FROM citus_tables;
```

The results should show zero rows. None of these tables are distributed.

## Load the data

You're creating a demo environment to show the Wide World Importers tech leads how to handle the migration of their data. You set up your environment by using simulated data. Keep in mind that the chilly chocolates are best kept at between 55 degrees and 60 degrees Fahrenheit, and with 60 percent to 70 percent humidity.

Because of foreign key relationships, the tables are loaded in the following order:

1. `device_types`
1. `devices`
1. `events`

Next, create functions that create simulated data.

1. There are two device types. Use the following command to populate the `device_types` table:

    ```sql
    INSERT INTO device_types (device_type_id,device_type) VALUES (1,'delivery truck'),(2,'warehouse');
    ```

1. Create a stored procedure to generate fake device data. Use the following SQL statements:

    ```sql
    CREATE OR REPLACE PROCEDURE create_devices(batch_size int)    
    LANGUAGE plpgsql
    AS
    $$
    DECLARE        
        selected_device_type_id int;
        selected_name text;        
    BEGIN
        FOR j IN 1..batch_size LOOP            
            -- between 1 and 2
            selected_device_type_id := (SELECT ceil(random()+.5));
            
            INSERT INTO devices (device_type_id,name)
                SELECT selected_device_type_id,
                    CONCAT('device-', substr(md5(random()::text), 0, 6));
        END LOOP;
    END;
    $$;
    ```

1. Generate some devices and force device 42 to be a delivery truck sensor by using the following commands:

    ```sql
    CALL create_devices(1000);
    UPDATE devices SET device_type_id = 1 WHERE device_id = 42;
    ```

1. Run the following commands to create a stored procedure that inserts a sensor reading that uses generated simulated readings:

    ```sql
    CREATE OR REPLACE PROCEDURE generate_reading(selected_device_id int)
    LANGUAGE plpgsql
    AS
    $$
    DECLARE
        selected_device_type_id int;
        selected_payload jsonb;
        random_temp decimal;
        random_humidity decimal;
        min_temp decimal;
        max_temp decimal;
        min_humidity int;
        max_humidity int;
    BEGIN
        min_temp:= 55.00;
        max_temp:= 60.00;
        min_humidity:= 60;
        max_humidity:= 70;

        selected_device_type_id := (SELECT device_type_id FROM devices WHERE device_id = selected_device_id);
        -- 1 = delivery truck; 2 = warehouse
        IF selected_device_type_id = 1 THEN
            random_temp := (random() * (max_temp - min_temp +1)+min_temp);
            IF selected_device_id = 42 THEN
                random_humidity := (random() * (90 - 65 +1) + 65);
            ELSE
                random_humidity := (random() * (max_humidity - min_humidity +1) + min_humidity);
            END IF;
            selected_payload := (json_build_object('temperature',random_temp,'humidity',random_humidity))::jsonb;
        ELSE
            random_temp := (random() * (max_temp - min_temp +1)+min_temp);
            selected_payload := (json_build_object('temperature',random_temp))::jsonb;
        END IF;
        
        INSERT INTO events (device_id,payload,created_at)
            SELECT selected_device_id,
                selected_payload, NOW()::timestamp;
    END;
    $$;
    ```

1. Run the following command to create a stored procedure that generates sensor data:

    ```sql
    CREATE OR REPLACE PROCEDURE create_events(batch_size int)
    LANGUAGE plpgsql
    AS
    $$
    DECLARE
        selected_device_id int;        
    BEGIN        
        -- Generates a batch of readings with random device ids
        FOR j IN 1..batch_size LOOP
            -- Retrieve a random device, skewing to device_id 42
            IF j % 3 = 0 THEN
                selected_device_id := 42;
            ELSE                
                selected_device_id := (SELECT * FROM
                (SELECT device_id FROM devices TABLESAMPLE BERNOULLI(1)) AS s
                ORDER BY RANDOM() LIMIT 1);
            END IF;
            CALL generate_reading(selected_device_id);
        END LOOP;
    END;
    $$;
    ```

1. Generate sensor data by running the following command:

    ```sql
    CALL create_events(10000);
    ```

1. Execute the following commands to verify that data was loaded into the `device_types`, `devices`, and `payment_events` tables:

    ```sql
    SELECT COUNT(*) FROM device_types;
    SELECT COUNT(*) FROM devices;
    SELECT COUNT(*) FROM events;
    ```

    The output looks like this example:

    ```text
     count 
    -------
         2
    (1 row)
    
     count 
    -------
      1000
    (1 row)
    
     count 
    -------
     10000
    (1 row)
    ```

## Query the data

You want to look at the events for the devices to make sure that they're keeping chilly chocolates at the right temperature and humidity values. The ideal environment for the chilly chocolates is between 55 degrees and 60 degrees Fahrenheit, with humidity in the range of 60 percent to 70 percent. Run the following query to look for problems:

```sql
SELECT * FROM events 
WHERE (payload ->> 'humidity')::decimal NOT BETWEEN 60 AND 70
OR (payload ->> 'temperature')::decimal NOT BETWEEN 55 AND 60;
```

This query returns records in a paginated form. You can use the Spacebar or Down arrow to move forward a page. You can use Enter to move forward a row. After you understand how the data is structured, press `q` to exit the paginated results and return to the Citus prompt.

Your query results show that some devices are running out of acceptable ranges. Are there any devices that are more problematic than others? Try this query:

```sql
SELECT COUNT(event_id), device_id FROM events 
WHERE (payload ->> 'humidity')::decimal NOT BETWEEN 60 AND 70
OR (payload ->> 'temperature')::decimal NOT BETWEEN 55 AND 60
GROUP BY device_id
ORDER BY COUNT(event_id) DESC;
```

The results show many devices in the single digits. However, `device_id` 42 has issues in the thousands. It's running out of the required ranges. Are these problems specific to temperature or humidity?

Use the following query to get more insight:

```sql
SELECT COUNT((CASE WHEN (payload ->> 'humidity')::decimal < 60 THEN 1 ELSE NULL END)) AS LowHumidity,  
COUNT((CASE WHEN (payload ->> 'humidity')::decimal > 70 THEN 1 ELSE NULL END)) AS HighHumidity,
COUNT((CASE WHEN (payload ->> 'temperature')::decimal < 55 THEN 1 ELSE NULL END)) AS LowTemperature,
COUNT((CASE WHEN (payload ->> 'temperature')::decimal > 60 THEN 1 ELSE NULL END)) AS HighTemperature,
COUNT((CASE WHEN (payload ->> 'humidity')::decimal BETWEEN 60 AND 70 THEN 1 ELSE NULL END)) AS RegularHumidity,  
COUNT((CASE WHEN (payload ->> 'temperature')::decimal BETWEEN 55 AND 60 THEN 1 ELSE NULL END)) AS RegularTemperature
FROM events 
WHERE device_id=42;
```

In the generated sample, the results look like this example output:

```text
 lowhumidity | highhumidity | lowtemperature | hightemperature | regularhumidity | regulartemperature 
-------------+--------------+----------------+-----------------+-----------------+--------------------
           0 |         2739 |              0 |             601 |             599 |               2737
```

The output looks like the chilly chocolates near device 42 are on their way to becoming melted chocolates. Wide World Importers needs to correct the problems in the device 42 environment.

Suppose that there was a growth in the number of sensors. Add another 50,000 records by using the following command:

```sql
CALL create_events(50000);
```

Now rerun the query to inspect device 42's problems. What do the results look like?

They might look like this example:

```text
 lowhumidity | highhumidity | lowtemperature | hightemperature | regularhumidity | regulartemperature 
-------------+--------------+----------------+-----------------+-----------------+--------------------
           0 |        16242 |              0 |            3419 |            3796 |              16619
(1 row)
```

You can continue to use `create_events()` to generate more sample sensor data as needed.

For this exercise, when you're finished with psql, exit by using the following command:

```sql
\q
```

Now that you have a single node of an Azure Cosmos DB for PostgreSQL cluster loaded with data, you can develop a plan to help Wide World Importers scale from a single-node database to a multi-node cluster.
