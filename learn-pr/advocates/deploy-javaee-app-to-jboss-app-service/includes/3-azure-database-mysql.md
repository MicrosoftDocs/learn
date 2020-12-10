## Excersize of Azure Database for MySQL

`Azure Database for MySQL` is a relational database service in the Microsoft cloud based on MySQL Community Edition database engine. We will create sample DB for Java Web Applications.

## Get Sample Application and script

First, please get the sample application and script from the GitHub repository.

```bash
git clone https://*****
```

After you got the project, you will see like following files and directories.

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
│   │           ├── mysql-ds.xml
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

We will create an instance of `Azure  Database for MySQL`. In order to create the MySQL DB intance, I created the Bash shell script as `setup_mysql.sh` in the project.  
Please execute the following command.

```bash
 ./setup_mysql.sh flexible
```

Then you can see following result. The following information is important and we will use the following value to the following steps. So please copy the value to some places.

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

## Login to the MySQL DB

After you created the MySQL DB, you can access to the MySQL DB like below.  
Please copy & paste the string in the previous step.

```bash
mysql -u azureuser -h mysqlserver-qtrfennwvy.mysql.database.azure.com -p [Enter]
Enter password: [!Bzepiihx28028]
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

In this time, we will use a Sample World DB from MySQL from official site.
You can get the official data from  following.
`https://downloads.mysql.com/docs/world.sql.zip`

In this project, I already get and unarchive the download ata.
So you can see the `world.sql` file in the project. Please execute the following mysql  command.

```mysql
mysql> source world.sql
Query OK, 0 rows affected (0.01 sec)
....
....
Query OK, 0 rows affected (0.01 sec)

mysql>
```

### Evaluate the created DB and TABLES

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

```mysql
mysql> use world;
Database changed
```

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

```mysql
mysql> DESC `city`;
+-------------+----------+------+-----+---------+----------------+
| Field       | Type     | Null | Key | Default | Extra          |
+-------------+----------+------+-----+---------+----------------+
| ID          | int(11)  | NO   | PRI | NULL    | auto_increment |
| Name        | char(35) | NO   |     |         |                |
| CountryCode | char(3)  | NO   | MUL |         |                |
| District    | char(20) | NO   |     |         |                |
| Population  | int(11)  | NO   |     | 0       |                |
+-------------+----------+------+-----+---------+----------------+
5 rows in set (0.01 sec)
```

```mysql
mysql> DESC `country`;
+----------------+---------------------------------------------------------------------------------------+------+-----+---------+-------+
| Field          | Type                                                                                  | Null | Key | Default | Extra |
+----------------+---------------------------------------------------------------------------------------+------+-----+---------+-------+
| Code           | char(3)                                                                               | NO   | PRI |         |       |
| Name           | char(52)                                                                              | NO   |     |         |       |
| Continent      | enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') | NO   |     | Asia    |       |
| Region         | char(26)                                                                              | NO   |     |         |       |
| SurfaceArea    | decimal(10,2)                                                                         | NO   |     | 0.00    |       |
| IndepYear      | smallint(6)                                                                           | YES  |     | NULL    |       |
| Population     | int(11)                                                                               | NO   |     | 0       |       |
| LifeExpectancy | decimal(3,1)                                                                          | YES  |     | NULL    |       |
| GNP            | decimal(10,2)                                                                         | YES  |     | NULL    |       |
| GNPOld         | decimal(10,2)                                                                         | YES  |     | NULL    |       |
| LocalName      | char(45)                                                                              | NO   |     |         |       |
| GovernmentForm | char(45)                                                                              | NO   |     |         |       |
| HeadOfState    | char(60)                                                                              | YES  |     | NULL    |       |
| Capital        | int(11)                                                                               | YES  |     | NULL    |       |
| Code2          | char(2)                                                                               | NO   |     |         |       |
+----------------+---------------------------------------------------------------------------------------+------+-----+---------+-------+
15 rows in set (0.02 sec)
```

```bash
mysql> DESC `countrylanguage`;
+-------------+---------------+------+-----+---------+-------+
| Field       | Type          | Null | Key | Default | Extra |
+-------------+---------------+------+-----+---------+-------+
| CountryCode | char(3)       | NO   | PRI |         |       |
| Language    | char(30)      | NO   | PRI |         |       |
| IsOfficial  | enum('T','F') | NO   |     | F       |       |
| Percentage  | decimal(4,1)  | NO   |     | 0.0     |       |
+-------------+---------------+------+-----+---------+-------+
4 rows in set (0.02 sec)
```

## Query for Sample Database


### Get Area Informations

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

### Get Country Code in one Continent

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
| KAZ  | Kazakstan            |
| KGZ  | Kyrgyzstan           |
| KHM  | Cambodia             |
| KOR  | South Korea          |
| KWT  | Kuwait               |
| LAO  | Laos                 |
| LBN  | Lebanon              |
| LKA  | Sri Lanka            |
| MAC  | Macao                |
| MDV  | Maldives             |
| MMR  | Myanmar              |
| MNG  | Mongolia             |
| MYS  | Malaysia             |
| NPL  | Nepal                |
| OMN  | Oman                 |
| PAK  | Pakistan             |
| PHL  | Philippines          |
| PRK  | North Korea          |
| PSE  | Palestine            |
| QAT  | Qatar                |
| SAU  | Saudi Arabia         |
| SGP  | Singapore            |
| SYR  | Syria                |
| THA  | Thailand             |
| TJK  | Tajikistan           |
| TKM  | Turkmenistan         |
| TMP  | East Timor           |
| TUR  | Turkey               |
| TWN  | Taiwan               |
| UZB  | Uzbekistan           |
| VNM  | Vietnam              |
| YEM  | Yemen                |
+------+----------------------+
51 rows in set (0.02 sec)
```

### Get the city which the population over 1,000,000

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


