In this exercise, you'll create your Azure for MySQL Database instance and load it with sample data.

## Get the sample application and script

First, clone the sample application and shell script from the GitHub repository:

```bash
git clone https://github.com/MicrosoftDocs/mslearn-jakarta-ee-azure.git
```

After you clone the project, you'll see the following directories and files:

```text
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
21 directories, 17 files
```

## Sign in to Azure

If you haven't already done so, sign in to Azure:

```azurecli
az login
```

## Set up a default installation location

The commands executed by the script used in this module expect a `--location` option. You can specify a default value for this option with the following command.

```azurecli
az configure --defaults location=<desired location>
```

> [!NOTE]
> We advise you to change to the same region for deploying your Jakarta EE application.

## Create an Azure Database for MySQL instance

After you've signed in, use the project script `setup_mysql.sh` to create your Azure Database for MySQL flexible server instance. Make sure you're in the `mslearn-jakarta-ee-azure` directory.

> [!IMPORTANT]
> Run the following command in an IPv4 environment. If your environment has a IPv6 address, this command will fail because the firewall configuration for it doesn't support IPv6 addresses yet.

```bash
./setup_mysql.sh flexible
```

Note the key values that appear in the output of the command. You'll use those values in later steps.

```text
[INFO] -------------------------------------------------------
[INFO] Azure Database for MySQL Setup Completed SUCCESS
[INFO] -------------------------------------------------------
[INFO] 1. Please copy the following value into your temporal file
[INFO]
[INFO] RESOURCE GROUP is $RESOURCE_GROUP_NAME
[INFO] MySQL HOSTNAME is $MYSQL_SERVER_INSTANCE.mysql.database.azure.com
[INFO] MySQL ADMIN_USERNAME is $CURRENT_AZ_LOGIN_USER_NAME#EXT#$CURRENT_AZ_LOGIN_USER_NAME
[INFO]
[INFO]
[INFO] 2. Please execute the following command to connect to the Server.
[INFO]
[INFO] mysql -h $MYSQL_SERVER_INSTANCE.mysql.database.azure.com --user $CURRENT_AZ_LOGIN_USER_NAME#EXT#$CURRENT_AZ_LOGIN_USER_NAME --enable-cleartext-plugin --password=$(az account get-access-token --resource-type oss-rdbms --output tsv --query accessToken)
[INFO]
[INFO] Or you can use the following Azure CLI command
[INFO]
[INFO] az mysql flexible-server connect -g $RESOURCE_GROUP_NAME -n $MYSQL_SERVER_INSTANCE -u azureuser -p '!yhYrNhwQ27640' --interactive
[INFO] Password: [!yhYrNhwQ27640]
[INFO] 
[INFO] 
[INFO] 3. Clean up Resource (Delete MySQL DB)
[INFO] az group delete -n $RESOURCE_GROUP_NAME
[INFO] -------------------------------------------------------
```

> [!NOTE]
> If an error occurs during the execution of the script, the process will stop midway. If an error occurs while 'Granting the User.Read.All, GroupMember.Read.All, and Application.Read.All permissions to the user managed identity', please log in to Azure CLI again with a user that has Azure AD administrator privileges and then re-run the script.

## Get data from the sample database

In this module, you'll use a sample database called `world` from the official MySQL website. To get the data:

1. Download the database file:

   ```bash
   curl -o world-db.zip https://downloads.mysql.com/docs/world-db.zip
   ```

1. Unzip the database file:

   ```bash
   unzip world-db.zip
   ```

1. Access the SQL file:

   ```bash
   cd world-db
   ls -l world.sql
   ```
 
   ``` output
   -rw-r--r--  1 ******  wheel  398635  1  7 12:25 world.sql
   ```

## Sign in to the MySQL database

To connect to the MySQL flexible server, you can use one of the two methods described in the below when the MySQL flexible server was set up:

1. Connect to the MySQL flexible server using the mysql command:

   Obtain the access token for the currently logged-in user and connect to the MySQL flexible server

   ```bash
    mysql -h $MYSQL_SERVER_INSTANCE.mysql.database.azure.com --user CURRENT_AZ_LOGIN_USER_NAME#EXT#@CURRENT_AZ_LOGIN_USER_NAME --enable-cleartext-plugin --password=$(az account get-access-token --resource-type oss-rdbms --output tsv --query accessToken)
   ```

   > [!NOTE]
   > Starting from MySQL version 8, the default authentication plugin has been changed to caching_sha2_password. Therefore, when you try to authenticate using only the username and password with the mysql command, you will encounter the following error:
   > `ERROR 2059 (HY000): Authentication plugin 'mysql_native_password' cannot be loaded:`
   > To address this, we create an administrative user who can access to the MySQL database by `az mysql flexible-server ad-admin create` command with the user logged in to Azure CLI when creating the MySQL DB

2. Connect to the MySQL flexible server by Azure CLI:

   If you prefer to connect using only the username and password instead of an access token, you can do so using Azure CLI as shown below.

   ```bash
   az mysql flexible-server connect -n $MYSQL_SERVER_INSTANCE -u azureuser -p $PASSWORD --interactive
   Password: [$PASSWORD]
   ```

3. Confirm the available usernames and the plugins

   After connecting to MySQL, you can check the available usernames and the plugins in use with the following command.

   ```mysql
   mysql> SELECT user, host, plugin FROM mysql.user;
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

Run the following `Azure CLI` command to create a database and tables for your application from the script file `world.sql`:

```azurecli
az mysql flexible-server execute -n $MYSQL_SERVER_NAME  -u azureuser -p '$MYSQL_PASSWORD' -f "./world-db/world.sql"
```

> [!TIP]
> You can also use the `mysql` command to create a database and tables from script file. However it will take a long time to finish the command. Therefore, we recommend using the `az mysql flexible-server execute` command in this time.

## Confirm the database and tables

1. Confirm that the databases and tables are in your server:

   ```azurecli
    az mysql flexible-server connect -n' $MYSQL_SERVER_NAME '-u' $MYSQL_USER '-p' $MYSQL_PASSWORD '-d world --interactive
    Password: [Enter the same password as $MYSQL_PASSWORD]
    MySQL 8.0.39
    mycli 1.27.2
    Home: http://mycli.net
    Bug tracker: https://github.com/dbcli/mycli/issues
    Thanks to the contributor - Jakub Boukal
    azureuser@MYSQL_SERVER_NAME.mysql.database.azure.com
    (MySQL):world>show databases;
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
    azureuser@MYSQL_SERVER_NAME.mysql.database.azure.com
    (MySQL):world>show tables;
    +-----------------+
    | Tables_in_world |
    +-----------------+
    | city            |
    | country         |
    | countrylanguage |
    +-----------------+
    
    3 rows in set
    Time: 0.145s
    azureuser@MYSQL_SERVER_NAME.mysql.database.azure.com
    (MySQL):world>
   ```

## Query the sample database

Now you can view the contents of the `world` database.

1. Get all the continent information:

   ```mysql
   (MySQL):world> select distinct Continent from country ;
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

1. Get country names and country codes by continent:

   ```mysql
   (MySQL):world> select code,name from country where Continent='Asia';
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

1. Get all cities that have a population greater than 1 million:

   ```mysql
   (MySQL):world> select * from city where CountryCode='JPN' AND Population > 1000000 ORDER BY Population DESC;
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

You've now completed the setup and preparation for your MySQL Server. In the next unit, you see the steps to deploy the Jakarta EE application to JBoss EAP on Azure App Service and configure it.
