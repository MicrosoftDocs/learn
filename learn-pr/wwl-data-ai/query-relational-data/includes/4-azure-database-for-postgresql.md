PostgreSQL provides many tools you can use to connect to a PostgreSQL database and run queries. These tools include the **pgAdmin** graphical user interface, and the **psql** command-line utility. There are a large number of third-party utilities you can use as well. 

In this unit, you'll see how to connect to a PostgreSQL database running in Azure Database for PostgreSQL from the command line using **psql**. 

## Retrieve connection information for Azure Database for PostgreSQL

To connect to a PostgreSQL database, you require the name of the server, and the credentials for an account that has access rights to connect to the server. You can find the server name and the name of the default administrator account on the **Overview** page for the Azure Database for PostgreSQL instance in the Azure portal. Contact your administrator for the password.

> [!div class="mx-imgBorder"]
> ![The **Overview** page for an Azure Database for PostgreSQL instance in the Azure portal](../media/4-postgresql-azure.png)

As with Azure SQL Database, you must open the PostgreSQL firewall to enable client applications to connect to the service. For detailed information, see [Firewall rules in Azure Database for PostgreSQL - Single Server](/azure/postgresql/concepts-firewall-rules)

## Use psql to query a database

The **psql** utility is available in the Azure Cloud Shell. You can also run it from a command prompt on your desktop computer, but you must download and install the psql client. You can find the psql client on the [postgresql.org](http://postgresql.org) website.

To connect to Azure Database for PostgreSQL using **psql**, perform the following operations:

1. Run the following command. Make sure to replace the server name and admin name with the values from the Azure portal.

    ```bash
    psql --host=<server-name>.postgres.database.azure.com --username=<admin-user>@<server-name> --dbname=postgres
    ```

    Enter your password when prompted.

    > [!NOTE]
    > **postgres** is the default management database created with Azure Database for PostgreSQL. You can create additional databases using the **CREATE DATABASE** command from psql.

1. If your connection is successful, you'll see the prompt `postgres=>`.

1. You can create a new database with the following SQL command:

    ```sql
    CREATE DATABASE "Adventureworks";
    ```

    > [!NOTE]
    > You can enter commands across several lines. The semi-colon character acts as the command terminator.

1. Inside psql, you can run the command `\c Adventureworks` to connect to the database.

1. You can create tables and insert data using CREATE and INSERT commands, as shown in the following examples::

    ```sql
    CREATE TABLE PEOPLE(NAME TEXT NOT NULL, AGE INT NOT NULL);
    INSERT INTO PEOPLE(NAME, AGE) VALUES ('Bob', 35);
    INSERT INTO PEOPLE(NAME, AGE) VALUES ('Sarah', 28);
    CREATE TABLE LOCATIONS(CITY TEXT NOT NULL, STATE TEXT NOT NULL);
    INSERT INTO LOCATIONS(CITY, STATE) VALUES ('New York', 'NY');
    INSERT INTO LOCATIONS(CITY, STATE) VALUES ('Flint', 'MI');
    ```

1. You can retrieve the data you just added using the following SQL commands:

    ```sql
    SELECT * FROM PEOPLE;
    SELECT * FROM LOCATIONS;
    ```

1. Other psql commands include:
    - `\l` to list databases.
    - `\dt` to list the tables in the current database.

1. You can use the `\q` command to quit psql.

The following example adds a new table to the database and inserts four rows.

```SQL
-- Create a new table called 'customers'
CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR (50) NOT NULL,
    location VARCHAR (50) NOT NULL,
    email VARCHAR (50) NOT NULL
);

-- Insert rows into table 'customers'
INSERT INTO customers
    (customer_id, name, location, email)
VALUES
    ( 1, 'Orlando', 'Australia', ''),
    ( 2, 'Keith', 'India', 'keith0@adventure-works.com'),
    ( 3, 'Donna', 'Germany', 'donna0@adventure-works.com'),
    ( 4, 'Janet', 'United States','janet1@adventure-works.com');
```

To query the data, enter a SELECT statement:

```SQL
-- Select rows from table 'customers'
SELECT * FROM customers; 
```