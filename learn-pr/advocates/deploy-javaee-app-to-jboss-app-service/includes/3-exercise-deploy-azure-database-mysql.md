## Get Sample Application and script

First, please get the sample application and shell script from the GitHub repository.

```bash
git clone https://*****
```

After you got the project, you will see like following directories and files.

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
│   │   │       ├── microprofile.properties
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

## Login to Azure

Before executing the following steps, at first you need login to Azure.

```azurecli
az login
```

## Create an Instance of Azure Database for MySQL

In order to create the MySQL DB intance, You can execute the Bash Shell Script as `setup_mysql.sh` in the direcotry. 
 
Please execute the following command.

```bash
 ./setup_mysql.sh flexible
```

Then you can see following result. The following information is important and we will use them to the following steps. So please copy the value to some places.

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

> [!NOTE]
> Please execute the above command on IPv4 environment, if your environment has IPv6 address, this command will fail because firewall configuration of azure cli command doesn't support the IPv6 address now.


## Get an Example Database from MySQL Official Site

In this module, you will use a Sample World DataBase from official site of MySQL.
You can get the original data from following URL.
`https://downloads.mysql.com/docs/world.sql.zip`

In order to get the Sample Database, please execute following command.

```bash
curl -o world.sql.zip https://downloads.mysql.com/docs/world.sql.zip
```

After donwload the file, please un-archive the file as follows.

```bash
unzip world.sql.zip
```

Then you will get the SQL file.

```bash
ls -l world.sql
-rw-r--r--  1 ******  wheel  398635  1  7 12:25 world.sql
```

## Login to the MySQL DB

After you created the MySQL DB, you can access to the MySQL DB using `mysql` client command.  
Please copy & paste the string in the previous result of `2`.

```bash
mysql -u azureuser -h mysqlserver-qtrfennwvy.mysql.database.azure.com -p [Enter]
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

## Create a Database and Tables for Application

Please execute the following mysql  command.

```mysql
mysql> source world.sql
Query OK, 0 rows affected (0.01 sec)
....
....
Query OK, 0 rows affected (0.01 sec)

mysql>
```

### Evaluate the created DB and TABLES

Then automatically, `world` database and some tables will be created on your MySQL.

In order to confirm the databases in your server, please execute the following mysql command.

```bash
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

In order to refer the data in the `world` DB , please execute the following command.

```mysql
mysql> use world;
Database changed
```

Then you can operate the `world` DB. In order to confirme the tables in the `world` DB, please execute the following command. Then you can see following result.

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

In the Sample Application, we would like to show the following data.

1. Get all of the Continent Informations
2. List the Name of Country and Country Code in Continent
3. Get Cities which has the population over 1 million

So we will show the above data using SQL query.

### Get All of the Continent Informations

In order to get the Continent Informations, please execute following command.  
Then you will see following result.

```bash
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

### List Country Name and Country Code in Continent

In order to get Country Name and  Country Code in Continent, please execute following command.  
Then you will see following result.

```bash
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

### Get the cites which has the population over 1 million

In order to get the cities which has the population over 1 million, please execute following command.  
Then you will see following result.

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

We created a MySQL database flexible server on Azure and created the databases and tables which will be used by the application in this. Then We stored the data in the created table.

We also executed some SQL queries with the mysql command to see if the data could be available and if the SQL statements written in the application could be executed.  

Now we completed the setup and preparation for MySQL Server which is required to deploy a Java EE (Jakarta EE) application in next Chapter.  
Next, we will deploy the Java EE(Jakarta EE) application to JBoss EAP on Azure App Service and configure it so that it can connect to the MySQL created here.