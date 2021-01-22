In this exercise, we'll look at creating and our Azure for MySql Database and load it with sample data.

## Get Sample Application and script

First, let us clone the sample application and shell script from its GitHub repository:

```bash
git clone https://github.com/MicrosoftDocs/mslearn-jakarta-ee-azure.git
```

After you cloned the project, you'll see the following directories and files.

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

First, sign in to Azure

```azurecli
az login
```

## Setup default install location

You can specify the Azure Data-Centre Region for your Flexible Database. 

Currently the following Azure regions are available for MySQL Flexible severs: 
"eastus2, westus2, brazilsouth, southeastasia, northeurope, australiaeast, japaneast, koreacentral, uksouth, westeurope, canadacentral, centralus, eastus"

```azurecli
az configure --defaults location=japaneast
```

> [!NOTE]
> It's advisable to also change to the same region for deploying your Java EE application.

## Create an Instance of Azure Database for MySQL

After you've signed in, we'll create your MySQL DB instance, by using the Projects Script `setup_mysql.sh`.

Execute the following command:

```bash
 ./setup_mysql.sh flexible
```

> [!IMPORTANT]
> You'll need to record certain key values from the output of the MySQL instance creation. Those values will be used in later steps.

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

> [!IMPORTANT]
> Execute the above command on IPv4 environment.
If your environment has a IPv6 address, this command will fail because the firewall configuration Azure CLI command doesn't support IPv6 addresses yet.

## Get a sample database for MySQL

In this module, you'll use a sample `World` dataBase from the official MySQL website.
You can get the original data from following URL:
`https://downloads.mysql.com/docs/world.sql.zip`

Download the `world` sample database:

```bash
curl -o world.sql.zip https://downloads.mysql.com/docs/world.sql.zip
```

After downloading the file, unzip the file as follows:

```bash
unzip world.sql.zip
```

Then get the SQL file:

```bash
ls -l world.sql
-rw-r--r--  1 ******  wheel  398635  1  7 12:25 world.sql
```

## Sign in to the MySQL DB

After you created the MySQL database, you can access the database using the `mysql` command-line and password that was returned when you created your flexible server:

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

## Create a Database and Tables for your application

Execute the following mysql command:

```mysql
mysql> source world.sql
Query OK, 0 rows affected (0.01 sec)
....
....
Query OK, 0 rows affected (0.01 sec)

mysql>
```

### Evaluate the Database and Tables

The `world` database and its tables are automatically created in your MySQL database.

To confirm the databases in your server, execute the following mysql command:

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

To refer the data in the `world` DB, execute the following command:

```mysql
mysql> use world;
Database changed
```

Then you can query the `world` DB. To confirm the tables in the `world` DB, execute the following command:

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

## Query for Sample Database

Next we'll view the contents of the `world` database by using the three steps:

1. Get all continent information
2. List all the names of country and their country codes in each continent
3. Get cities, which have population greater than 1 million

### Get all the continent information

To get the continent information, execute following command:

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

### Get names of countries and country codes by continent

To get Country Name and  Country Code in Continent, execute following command:

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
| HKG  | Hong Kong            |
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

### Get all cities with population greater than million

To get the cities, which have the population over 1 million, execute following command:

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

## Finally

We've completed the setup and preparation for our MySQL Server.
In the next section, we'll deploy the Java EE(Jakarta EE) application to JBoss EAP on Azure App Service and configure it.
