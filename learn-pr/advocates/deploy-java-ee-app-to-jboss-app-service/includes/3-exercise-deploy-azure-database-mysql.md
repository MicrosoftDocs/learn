In this exercise, you'll create your Azure for MySQL Database instance and load it with sample data.

## Get the sample application and script

First, clone the sample application and shell script from the GitHub repository:

```bash
git clone https://github.com/MicrosoftDocs/mslearn-jakarta-ee-azure.git
```

After you clone the project, you'll see the following directories and files:

```text
├── Azure-MySQL-Setup-For-Sample-App.md
├── README.md
├── pom.xml
├── setup_mysql.sh
├── src
│   ├── main
│   │   ├── java
│   │   │   └── com
│   │   │       └── microsoft
│   │   │           └── azure
│   │   │               └── samples
│   │   │                   ├── JAXRSConfiguration.java
│   │   │                   ├── controllers
│   │   │                   │   ├── CityService.java
│   │   │                   │   └── CountryService.java
│   │   │                   ├── entities
│   │   │                   │   ├── City.java
│   │   │                   │   └── Country.java
│   │   │                   └── rest
│   │   │                       └── WorldServiceEndpoint.java
│   │   ├── resources
│   │   │   └── META-INF
│   │   │       └── persistence.xml
│   │   └── webapp
│   │       └── WEB-INF
│   │           ├── beans.xml
│   │           ├── createMySQLDataSource.sh
│   │           └── web.xml
│   └── test
│       └── java
│           └── com
│               └── microsoft
│                   └── azure
│                       └── samples
│                           └── SampleTest.java
└── world.sql
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
> We advise you to change to the same region for deploying your Java EE application.

## Create an Azure Database for MySQL instance

After you've signed in, use the project script `setup_mysql.sh` to create your Azure Database for MySQL instance. Make sure you're in the `mslearn-jakarta-ee-azure` directory.

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
[INFO] RESOURCE GROUP is MySQL-RG-20201208152233
[INFO] MySQL HOSTNAME is mysqlserver-wqcnzwhqvw.mysql.database.azure.com
[INFO] MySQL USERNAME is azureuser
[INFO] MySQL PASSWORD is **********
[INFO]
[INFO]
[INFO] 2. Please execute the following command.
[INFO]
[INFO] mysql -u azureuser -h mysqlserver-wqcnzwhqvw.mysql.database.azure.com -p [Enter Key]
[INFO] Enter password: ********** [COPY&PASTE]
[INFO] 
[INFO] 
[INFO] 3. Clean up Resource (Delete MySQL DB)
[INFO] az group delete -n MySQL-RG-20201208152233
[INFO] -------------------------------------------------------
```

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

After you get the MySQL database, you can access the database by using the `mysql` command and password that you recorded when you created your Flexible Server instance:

```bash
mysql -u azureuser -h mysqlserver-<your instance>.mysql.database.azure.com -p [Enter]
Enter password: [**********]
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 12
Server version: 5.7.29-log MySQL Community Server (GPL)

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

## Create a database and tables for your application

Run the following `mysql` command:

```mysql
mysql> source world.sql
Query OK, 0 rows affected (0.01 sec)
....
....
Query OK, 0 rows affected (0.01 sec)

mysql>
```

The `world` database and its tables are automatically created in your MySQL database. This action takes several minutes.

## Confirm the database and tables

1. Confirm that the databases are in your server:

   ```mysql
   mysql> show databases;
   +--------------------+
   | Database           |
   +--------------------+
   | information_schema |
   | mysql              |
   | performance_schema |
   | sys                |
   | world              |
   +--------------------+
   5 rows in set (0.02 sec)
   ```

1. Point to the data in the `world` database:

   ```mysql
   mysql> use world;
   Database changed
   ```

1. Confirm the tables in the `world` database:

   ```mysql
   mysql> show tables;
   +-----------------+
   | Tables_in_world |
   +-----------------+
   | city            |
   | country         |
   | countrylanguage |
   +-----------------+
   3 rows in set (0.04 sec)
   ```

## Query the sample database

Now you can view the contents of the `world` database.

1. Get all the continent information:

   ```mysql
   mysql> select distinct Continent from country ;
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
   mysql> select code,name from country where Continent='Asia';
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
   mysql> select * from city where CountryCode='JPN' AND Population > 1000000 ORDER BY Population DESC;
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

You've now completed the setup and preparation for your MySQL Server. In the next unit, you see the steps to deploy the Java EE (Jakarta EE) application to JBoss EAP on Azure App Service and configure it.
