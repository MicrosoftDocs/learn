Woodgrove Bank requested that extra capabilities be added to their database. Azure Cosmos DB for PostgreSQL enables you to extend a database's functionality using many [popular PostgreSQL extensions](/azure/postgresql/hyperscale/reference-extensions).

## View supported and preinstalled extensions

Woodgrove Bank asked for extensions allowing geospatial data to be stored in the database and the ability to run scheduled rollup jobs. After researching the available PostgreSQL extensions, you've identified the [PostGIS](https://www.postgis.net/) and [`pg_cron`](https://github.com/citusdata/pg_cron) extensions as the best candidates for providing these capabilities.

> [!NOTE]
> [PostGIS](https://www.postgis.net/) is a spatial database extender for PostgreSQL object-relational databases, adding support for geographic objects that allow location queries to be run in SQL.
>
> [`pg_cron`](https://github.com/citusdata/pg_cron) is a cron-based job scheduler that allows you to schedule PostgreSQL commands directly from the database.

The next step you need to take is determining if the extensions you identified are supported in Azure Cosmos DB for PostgreSQL. There are two ways you can accomplish this step. The first is to review the list of [Extensions supported by Azure Cosmos DB for PostgreSQL](/azure/postgresql/hyperscale/reference-extensions#extensions-supported-by-azure-database-for-postgresql) in the Microsoft docs. The second and recommended approach is to execute the following query against your database:

```sql
SELECT * FROM pg_available_extensions;
```

The [`pg_available_extensions` view](https://www.postgresql.org/docs/current/view-pg-available-extensions.html) provides a list of supported extensions available to install. Reviewing the output reveals that both of the extensions you selected are supported.

Many popular PostgreSQL extensions are preinstalled on each Azure Cosmos DB for PostgreSQL instance. Before installing any new supported extensions, it's a good idea to view the complete list of preinstalled extensions in your database to avoid conflicts. You can view this list by running the following query:

```sql
SELECT * FROM pg_extension;
```

> [!NOTE]
> Alternatively, you could run `\dx` from the command line, a shortcut command that provides a list of installed extensions in your database.

For the extensions you want to use for Woodgrove Bank, the query output shows that `pg_cron` comes preinstalled, but the `PostGIS` extension doesn't. To provide the requested capabilities, you must load `PostGIS` into your database.

## Install extensions in Azure Cosmos DB for PostgreSQL

To use PostgreSQL extensions, you must first install them in your database. Use the [psql tool](https://www.postgresql.org/docs/current/app-psql.html) to load the packaged objects into your database.

To install the `PostGIS` extension in Woodgrove Bank's database, you should first attempt to use the [CREATE EXTENSION](https://www.postgresql.org/docs/current/static/sql-createextension.html) command. This command installs the specified extension into the current database.

Behind the scenes, executing `CREATE EXTENSION` runs the extension's script file. The script typically creates new SQL objects such as functions, data types, operators, and index support methods. Additionally, `CREATE EXTENSION` records the identities of all the created objects so that they can be dropped again if `DROP EXTENSION` is issued.

Run the `CREATE EXTENSION` command to install the `PostGIS` extension in your database.

```sql
CREATE EXTENSION IF NOT EXISTS postgis;
```

If you attempt to install an extension with the same name as one already loaded in the database, you'll receive an error that the extension already exists. Specifying the `IF NOT EXISTS` clause when running the `CREATE EXTENSION` command allows you to avoid this error.

Running this command against the Woodgrove Bank database results in error:

```sql
ERROR: permission denied to create extension "postgis"
HINT: Must be superuser to create this extension.
```

Loading an extension typically requires the same privileges needed to create its component objects. For many extensions, this requirement means superuser privileges are required. For these extensions, it's possible that `CREATE EXTENSION` will fail with a permission-denied error. Because Azure Cosmos DB for PostgreSQL is a managed PaaS service in Azure, only Microsoft can sign in with the `postgres` superuser role. However, if the extension is marked trusted in its control file, any user with the `CREATE` privilege on the current database can install it.

If you receive this error when installing an extension, try the `create_extension()` function instead. When you create an Azure Cosmos DB for PostgreSQL cluster, you provide a password for the `citus` server admin user. This account grants limited administrative access to the database and cluster. The `citus` user is a member of `azure_pg_admin`, which can install PostgreSQL extensions. The `create_extension()` function executes in the context of the `citus` user.

Let's try using the `create_extension()` function and see if this function allows the `PostGIS` extension to be created.

```sql
SELECT create_extension('postgis');
```

The command runs successfully, so let's run the following to verify:

```sql
\dx
```

The command's output reveals that `PostGIS` was successfully installed. It also provides the version, schema, and description of the extension.

The user who runs `CREATE EXTENSION` is assigned as the owner of the extension. Typically, that user is designated as the owner of all the objects created by the extension's script. Knowing the extension owner becomes vital if you need to [remove](https://www.postgresql.org/docs/current/sql-dropextension.html) or [alter](https://www.postgresql.org/docs/current/sql-alterextension.html) an extension, as both must be done in the context of that user.

## Add geospatial columns to Woodgrove Bank's events table

With the `PostGIS` extension now loaded, you're ready to begin working with geospatial data in the database. Woodgrove Bank's developers have updated the contactless payment application to capture the latitude and longitude of all transactions entering the system. To store this data, you need to alter the `payment_events` table to add a `geometry` column that accepts the `point` data type. These new data types are included in the `PostGIS` extension.

As a reminder, the `payment_events` table has the following structure:

```sql
/* Table structure provide here for reference.
CREATE TABLE payment_events
(
   event_id bigint,
   event_type text,
   user_id bigint,
   merchant_id bigint,
   event_details jsonb,
   created_at timestamp,
   PRIMARY KEY (event_id, user_id)
);
*/
```

To accommodate `point` data, you must add a new `geometry` column to the table that accepts `point` data:

```sql
ALTER TABLE payment_events
ADD COLUMN event_location geometry(point, 4326);
```

Next, test your changes by updating the first event record with geospatial data provided by the Woodgrove Bank development team.

```sql
UPDATE payment_events
SET event_location = ST_GeomFromText('POINT(-71.060316 48.432044)', 4326)
WHERE event_id = (SELECT event_id FROM payment_events ORDER BY event_id LIMIT 1);
```

With a record now updated, you can use the `ST_X(point)` and `ST_Y(point)` functions loaded by `PostGIS` to view the geospatial data that was inserted:

```sql
SELECT event_id, event_type, ST_X(event_location) AS longitude, ST_Y(event_location) AS latitude FROM payment_events WHERE event_location IS NOT null;
```

The Woodgrove Bank database is ready to accept geospatial data from the contactless-payments app. The development team has assigned location data to each of their merchants and will handle the bulk update of existing transactions.

## Set up scheduled jobs

Woodgrove Bank has asked you to use scheduled tasks in the database to compute hourly rollups of events per user for an analytical dashboard. Using `pg_cron`, you can schedule a job that calls a function to execute every hour.

> [!NOTE]
> The date range of the sample data is limited, so the times passed into the function below are fixed to represent how the job can be called and scheduled. In a real-world scenario, the begin and end times being passed into the function from the cron job would be for the most recent 60-minute window.

To get started, you need to create a rollup table to store the aggregate data:

```sql
-- Define the table
CREATE TABLE rollup_events (
   user_id bigint,
   event_type text,
   hour timestamptz,
   event_count bigint
);

-- Create a unique constraint on user_id, event_type, and hour
CREATE UNIQUE INDEX rollup_events_unique_idx ON rollup_events(user_id, event_type, hour);

-- Distribute the table, assigning the user_id as the distribution column
SELECT create_distributed_table('rollup_events', 'user_id');
```

For the rollup, you'll use an `INSERT ... SELECT` command, which will run in parallel across all the nodes in the cluster. This command loads the aggregated data into the rollup table. To simplify calling the query to perform the data aggregation, you can create a function to perform the rollup:

```sql
CREATE OR REPLACE FUNCTION compute_event_rollups(start_time timestamptz, end_time timestamptz)
RETURNS void LANGUAGE PLPGSQL AS $function$
BEGIN
   RAISE NOTICE 'Computing 60-minute rollups from % to % (excluded)', start_time, end_time;

RAISE NOTICE 'Aggregating event data into 60-minute rollup table';
INSERT INTO rollup_events
SELECT user_id,
   event_type,
   date_trunc('hour', created_at) as hour,
   count(*) AS event_count
FROM payment_events
WHERE created_at >= start_time AND created_at <= end_time
GROUP BY user_id, event_type, hour
ON CONFLICT (user_id, event_type, hour)
   DO UPDATE SET event_count = rollup_events.event_count + excluded.event_count;

END;
$function$;
```

Now, run the following query to trigger your function to roll up the last hour of data in the database:

```sql
SELECT compute_event_rollups(timestamp '2016-01-12 08:00:00',timestamp '2016-01-12 09:00:00');
```

The final step is to automate your rollups using the `pg_cron` extension. Execute the following query using the `cron.schedule()` function to schedule the job to run at the top of every hour of every day (`0 * * * *`).

```sql
SELECT cron.schedule('0 * * * *', $$SELECT compute_event_rollups(timestamp '2016-01-12 05:00:00',timestamp '2016-01-12 06:00:00');$$);
```

For Woodgrove Bank's dashboard, they requested a query that provides a list of the top 10 users with the most events over the last hour. You created the following query against the rollup table to generate this information:

```sql
SELECT user_id, sum(event_count) as total_events FROM rollup_events WHERE hour >=timestamp '2016-01-12 08:00:00' AND hour <=timestamp '2016-01-12 09:00:00' GROUP BY user_id ORDER BY total_events DESC LIMIT 10;
```

If you need to stop the job, query the `cron.job` table to retrieve the `jobid` of your job:

```sql
SELECT * FROM cron.job;
```

Then, unschedule the job using the following, replacing the `{job_id}` token when the `jobid` you retrieved from the previous query.

```sql
SELECT cron.unschedule({job_id});
```

Extending your database with the `pg_cron` extension allows you to schedule PostgreSQL commands directly from the database. You can use this powerful and simple extension for many tasks, including aggregating data in near-real time, database cleanup and administrative tasks, and much more.

## Extensions and pg_dump backups

Woodgrove Bank uses the [`pg_dump`](https://www.postgresql.org/docs/current/app-pgdump.html) utility to back up their database. Fortunately, when used with extensions, `pg_dump` knows that it shouldn't dump the individual member objects of the extension. Instead, it will include a `CREATE EXTENSION` command in dumps. This capability vastly simplifies migration to a new extension version that might contain more or different objects than the old version.
