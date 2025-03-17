In this exercise, you create your Azure Database for MySQL - Flexible Server instance and load it with sample data.

## Get the sample application and script

Clone the sample application and shell script from the GitHub repository by using the following command:

```bash
git clone https://github.com/MicrosoftDocs/mslearn-jakarta-ee-azure.git
```

Cloning the project produces the following file structure:

```
├── LICENSE
├── README.md
├── mvnw
├── mvnw.cmd
├── pom.xml
├── setup_mysql.sh
└── src
    ├── main
    │   ├── java
    │   │   └── com
    │   │       └── microsoft
    │   │           └── azure
    │   │               └── samples
    │   │                   ├── JAXRSConfiguration.java
    │   │                   ├── controllers
    │   │                   │   ├── CityService.java
    │   │                   │   └── CountryService.java
    │   │                   ├── entities
    │   │                   │   ├── City.java
    │   │                   │   └── Country.java
    │   │                   └── rest
    │   │                       └── WorldServiceEndpoint.java
    │   ├── resources
    │   │   └── META-INF
    │   │       └── persistence.xml
    │   └── webapp
    │       └── WEB-INF
    │           ├── beans.xml
    │           ├── createMySQLDataSource.sh
    │           └── web.xml
    └── test
        └── java
            └── com
                └── microsoft
                    └── azure
                        └── samples
                            └── SampleTest.java
```

## Sign in to Azure

If you haven't signed in to Azure, sign in by using the following command:

```azurecli
az login
```

## Set up a default installation location

The commands executed by the script used in this module expect a `--location` option. Specify a default value for this option by using the following command, replacing `<location>` with an appropriate region. You should use the same region you use for deploying your Jakarta EE application later in this module.

```azurecli
az configure --defaults location=<location>
```

## Create an Azure Database for MySQL - Flexible Server instance

Navigate to the **mslearn-jakarta-ee-azure** directory, and then use the following command to create your Azure Database for MySQL - Flexible Server instance:

> [!IMPORTANT]
> Use the following command in an IPv4 environment. If your environment has an IPv6 address, the command will fail because the firewall configuration for it doesn't support IPv6 addresses yet.
>
> If an error occurs during the execution of the script, the process stops in the middle of the execution. An error might occur while the script is granting permissions, as indicated by the output message `Granting the User.Read.All, GroupMember.Read.All, and Application.Read.All permissions to the user managed identity`. To fix this error, sign in to the Azure CLI again with a user that has `Azure AD administrator` privileges, and then re-run the script.

```bash
./setup_mysql.sh flexible
```

The typical output includes the following success, plus some important values that you use in the rest of this module:

```output
[INFO] -------------------------------------------------------
[INFO] Azure Database for MySQL Setup Completed SUCCESS
[INFO] -------------------------------------------------------
```

Save aside the key values that appear in the output because you use these values in later steps.

## Set up environment variables

Use the following commands to store the key values. Be sure to replace the `<...>` placeholders with the values output by the script in the previous section.

```bash
export RESOURCE_GROUP_NAME=<resource-group>
export MYSQL_SERVER_INSTANCE=<MySQL-host-name>
export MYSQL_USER=<MySQL-admin-user-name>
export MYSQL_PASSWORD=<MySQL-password>
```

## Get data from the sample database

In this module, you use a sample database called `world` from the official MySQL website. To get the data, use the following steps:

1. Download the database file by using the following command:

    ```bash
    curl -o world-db.zip https://downloads.mysql.com/docs/world-db.zip
    ```

1. Unzip the database file by using the following command:

    ```bash
    unzip world-db.zip
    ```

1. List the SQL file by using the following commands:

    ```bash
    cd world-db
    ls -l world.sql
    ```

    The following output is typical:

    ```output
    -rw-r--r--  1 ******  wheel  398635  1  7 12:25 world.sql
    ```

## Sign in to the database

### [Azure CLI](#tab/azure-cli)

Use the following command to connect to the database using only the username and password, instead of an access token:

```azurecli
az mysql flexible-server connect \
    --name $MYSQL_SERVER_INSTANCE \
    --user azureuser \
    --interactive
```

When the system prompts you, enter the MySQL password that you retrieved previously.

### [MySQL](#tab/mysql)

Use the following command to connect to the database using an access token instead of a password:

```azurecli
mysql \
    --host $MYSQL_SERVER_INSTANCE.mysql.database.azure.com \
    --user CURRENT_AZ_LOGIN_USER_NAME#EXT#@CURRENT_AZ_LOGIN_USER_NAME \
    --enable-cleartext-plugin \
    --password=$(az account get-access-token \
        --resource-type oss-rdbms \
        --output tsv \
        --query accessToken)
```

> [!NOTE]
> Using an access token is necessary when you authenticate using `mysql`. This requirement is because the default authentication plug-in is `caching_sha2_password` starting with MySQL version 8. If you use only the username and password, you encounter the following error: `ERROR 2059 (HY000): Authentication plugin 'mysql_native_password' cannot be loaded`.
>
> The **setup_mysql.sh** script that you ran previously in this unit enables the access-token authentication. The script adds an admin user who can connect to the database using the access token of the user currently signed in to the Azure CLI. The `mysql` command can then connect by using that access token. For more information, see the [`CreateUserManagedIdentity()`](https://github.com/MicrosoftDocs/mslearn-jakarta-ee-azure/blob/main/setup_mysql.sh#L145-L208) function in the [setup_mysql.sh](https://github.com/MicrosoftDocs/mslearn-jakarta-ee-azure/blob/main/setup_mysql.sh) script.

---

After you connect, you can use the following query at the SQL prompt to view the available usernames and plugins:

```sql
SELECT user, host, plugin FROM mysql.user;
```

The following output is typical:

```output
+----------------------------------+-----------+-----------------------+
| user                             | host      | plugin                |
+----------------------------------+-----------+-----------------------+
| azureuser                        | %         | mysql_native_password |
| $CURRENT_AZ_LOGIN_USER_NAME#EXT#@| %         | aad_auth              |
| azure_superuser                  | 127.0.0.1 | mysql_native_password |
| azure_superuser                  | localhost | mysql_native_password |
| mysql.infoschema                 | localhost | caching_sha2_password |
| mysql.session                    | localhost | caching_sha2_password |
| mysql.sys                        | localhost | caching_sha2_password |
+----------------------------------+-----------+-----------------------+
```

## Create a database and tables for your application

Use the following steps to create a database for your application from the **world.sql** script, and then verify its details:

1. Use the following command to create the database and tables:

    ```azurecli
    az mysql flexible-server execute \
        --name $MYSQL_SERVER_INSTANCE \
        --admin-password azureuser \
        --admin-password '$MYSQL_PASSWORD' \
        --file-path "./world-db/world.sql"
    ```

    > [!TIP]
    > You can also use `mysql` to create a database and tables from a script file, but that command takes a long time to complete.

1. Confirm that the databases and tables are in your server by using the following command:

    ```azurecli
    az mysql flexible-server connect \
        --name $MYSQL_SERVER_INSTANCE \
        --admin-user $MYSQL_USER \
        --database-name world \
        --interactive
    ```

1. When the system prompts you, enter the MySQL password that you retrieved previously.

    The following output is typical:

    ```output
    MySQL 8.0.39
    mycli 1.27.2
    Home: http://mycli.net
    Bug tracker: https://github.com/dbcli/mycli/issues
    Thanks to the contributor - Jakub Boukal
    ```

1. At the SQL prompt, use the following query to show the databases on the server:

    ```sql
    show databases;
    ```

    The following output is typical:

    ```output
    +--------------------+
    | Database           |
    +--------------------+
    | flexibleserverdb   |
    | information_schema |
    | mysql              |
    | newdatabase        |
    | performance_schema |
    | sys                |
    | world              |
    +--------------------+

    7 rows in set
    Time: 0.152s
    ```

1. Use the following query to list the tables in the `world` database:

    ```sql
    show tables;
    ```

    The following output is typical:

    ```output
    +-----------------+
    | Tables_in_world |
    +-----------------+
    | city            |
    | country         |
    | countrylanguage |
    +-----------------+

    3 rows in set
    Time: 0.145s
   ```

## Query the sample database

Use the following steps to view the contents of the `world` database:

1. List all of the continent information by using the following query:

    ```sql
    select distinct Continent from country ;
    ```

    The following output is typical:

    ```output
    +---------------+
    | Continent     |
    +---------------+
    | North America |
    | Asia          |
    | Africa        |
    | Europe        |
    | South America |
    | Oceania       |
    | Antarctica    |
    +---------------+
    ```

1. List country names and country codes by continent by using the following query:

    ```sql
    select code,name from country where Continent='Asia';
    ```

    The following output is typical:

    ```output
    +------+----------------------+
    | code | Name                 |
    +------+----------------------+
    | AFG  | Afghanistan          |
    | ARE  | United Arab Emirates |
    | ARM  | Armenia              |
    | AZE  | Azerbaijan           |
    | BGD  | Bangladesh           |
    | BHR  | Bahrain              |
    | BRN  | Brunei               |
    | BTN  | Bhutan               |
    | CHN  | China                |
    | CYP  | Cyprus               |
    | GEO  | Georgia              |
    | HKG  | Hong Kong SAR        |
    | IDN  | Indonesia            |
    | IND  | India                |
    | IRN  | Iran                 |
    | IRQ  | Iraq                 |
    | ISR  | Israel               |
    | JOR  | Jordan               |
    | JPN  | Japan                |
    .....
    | VNM  | Vietnam              |
    | YEM  | Yemen                |
    +------+----------------------+
    51 rows in set (0.02 sec)
    ```

1. List all cities that have a population greater than 1 million by using the following query:

    ```sql
    select * from city where CountryCode='JPN' AND Population > 1000000 ORDER BY Population DESC;
    ```

    The following output is typical:

    ```output
    +------+---------------------+-------------+-----------+------------+
    | ID   | Name                | CountryCode | District  | Population |
    +------+---------------------+-------------+-----------+------------+
    | 1532 | Tokyo               | JPN         | Tokyo-to  |    7980230 |
    | 1533 | Jokohama [Yokohama] | JPN         | Kanagawa  |    3339594 |
    | 1534 | Osaka               | JPN         | Osaka     |    2595674 |
    | 1535 | Nagoya              | JPN         | Aichi     |    2154376 |
    | 1536 | Sapporo             | JPN         | Hokkaido  |    1790886 |
    | 1537 | Kioto               | JPN         | Kyoto     |    1461974 |
    | 1538 | Kobe                | JPN         | Hyogo     |    1425139 |
    | 1539 | Fukuoka             | JPN         | Fukuoka   |    1308379 |
    | 1540 | Kawasaki            | JPN         | Kanagawa  |    1217359 |
    | 1541 | Hiroshima           | JPN         | Hiroshima |    1119117 |
    | 1542 | Kitakyushu          | JPN         | Fukuoka   |    1016264 |
    +------+---------------------+-------------+-----------+------------+
    11 rows in set (0.33 sec)
    ```

## Unit summary

You completed the setup and preparation for your Azure Database for MySQL - Flexible Server instance. The next unit introduces you to the process of deploying the Jakarta EE application to JBoss EAP on Azure App Service, along with various configuration options.
