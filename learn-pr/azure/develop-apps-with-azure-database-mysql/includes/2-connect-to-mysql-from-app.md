Azure Database for MySQL - Flexible Server provides you the flexibility to develop applications using your favorite tools, languages, and frameworks. You can continue to use powerful development tools like Visual Studio Code and Github and develop using any programming language like PHP, Java, Python, Node.js, C#, Ruby, etc. You can also integrate MySQL - Flexible Server with popular Content Management Systems (CMS) like WordPress or Drupal, Learning Management Systems (LMS) like Moodle, e-commerce platforms like Magento, and so on.

:::image type="content" source="../media/supported-tools-and-languages.png" alt-text="Screenshot showing supported development tools, programming languages and frameworks.":::

Let us begin by taking a look at how to connect to and query MySQL - Flexible Server from applications developed in programming languages of your choice. This unit contains code snippets for PHP, Python and Java only. To understand how to connect using other languages like C#, Ruby, Node.js, etc., refer to [Azure Database for MySQL documentation](https://aka.ms/mysqldocs).

> [!NOTE] This unit assumes that you have already created an Azure Database for MySQL - Flexible Server instance with a database named *demodb*. If you created your flexible server with private access connectivity method (VNet Integration), you will need to connect to your server from a resource within the same VNet as your server. You can create a virtual machine and add it to the VNet created with your flexible server. If you created your flexible server with public access connectivity method (allowed IP addresses), you can add your local IP address to the list of firewall rules on your server.

## Get connection information

First, obtain the connection information you need to connect to Azure Database for MySQL Flexible Server from the Azure portal. You'll need the server name, database name, and sign in credentials.

1. Sign in to the Azure portal.
1. From the left-hand menu in Azure portal, select **All resources**, search for and select the Azure Database for MySQL flexible server you created, such as *mydemoserver*.
1. From the server's Overview page, make a note of the **Server name** and **Server admin login name**. If you forget your password, you can also reset the password from this page.

## Obtain SSL certificate

It is  recommended to secure data in motion by ensuring that your application connects to MySQL flexible server using Secure Sockets Layer (SSL).
Download the public SSL certificate which is also available in Azure portal Networking blade as shown in the screenshot below.

:::image type="content" source="../media/download-ssl.png" alt-text="Screenshot showing Azure Database for MySQL Networking blade on Azure portal":::

Save the certificate file to your preferred location.

::: zone pivot="php"

## Install PHP

Download and install the latest version of PHP on your server.

- [Installation on macOS](https://www.php.net/manual/en/install.macosx.php)
- [Installation on Linux](https://www.php.net/manual/en/install.unix.php)
- [Installation on Windows](https://www.php.net/manual/en/install.windows.php)

In the php.ini file, enable [mysqli](https://www.php.net/manual/book.mysqli.php) and [openssl](https://www.php.net/manual/book.openssl.php) extensions by uncommenting the lines extension=mysqli and extension=openssl.

## Run the code snippets

Follow the below steps to run the code snippets to create table, insert, query, update and delete data:

1. Paste the PHP code snippets into new files in a project folder, and save with file extension *.php* such as *CreateTable.php*.
1. Replace the `host`, `username`, `password`, and `db_name` parameters with your own values.
1. In the `mysqli_ssl_set()` method, adjust the certificate path by pointing it to the downloaded SSL certificate.
1. Open the command prompt or bash shell, and then change directory into your project folder.
1. To run the application, enter the php command followed by the file name, such as `php CreateTable.php`.

### Connect to database and create a table

Use the following code snippet to connect and create a table by using **CREATE TABLE** SQL statement. The code uses the **MySQL Improved extension** (mysqli) class included in PHP. The code calls methods [mysqli_init](https://secure.php.net/manual/mysqli.init.php) and [mysqli_real_connect](https://secure.php.net/manual/mysqli.real-connect.php) to connect to MySQL. Then it calls the method [mysqli_query](https://secure.php.net/manual/mysqli.query.php) to run the query, and the method [mysqli_close](https://secure.php.net/manual/mysqli.close.php) to close the connection.

```php
<?php
$host = '<your_server_name>.mysql.database.azure.com';
$username = '<your_admin_username';
$password = '<your_password>';
$db_name = '<your_database_name>';

//Establish the connection
$conn = mysqli_init();
mysqli_ssl_set($conn,NULL,NULL,"<your_path_to_SSL_cert>",NULL,NULL);
mysqli_real_connect($conn, $host, $username, $password, $db_name, 3306, MYSQLI_CLIENT_SSL);
if (mysqli_connect_errno($conn)) {
    die('Failed to connect to MySQL: '.mysqli_connect_error());
}
printf("Connection Established.\n");

// Run the create table query
if (mysqli_query($conn, '
CREATE TABLE Products (
`Id` INT NOT NULL AUTO_INCREMENT ,
`ProductName` VARCHAR(200) NOT NULL ,
`Color` VARCHAR(50) NOT NULL ,
`Price` DOUBLE NOT NULL ,
PRIMARY KEY (`Id`)
);
')) {
    printf("Table Created.\n");
}

//Close the connection
mysqli_close($conn);
?>
```

### Insert data

Use the following code snippet to connect and insert data by using an **INSERT** SQL statement. The code uses method [mysqli_prepare](https://secure.php.net/manual/mysqli.prepare.php) to create a prepared insert statement, then binds the parameters for each inserted column value using method [mysqli_stmt_bind_param](https://secure.php.net/manual/mysqli-stmt.bind-param.php). The code runs the statement by using method [mysqli_stmt_execute](https://secure.php.net/manual/mysqli-stmt.execute.php) and finally closes the statement by using method [mysqli_stmt_close](https://secure.php.net/manual/mysqli-stmt.close.php).

```php
<?php
$host = '<your_server_name>.mysql.database.azure.com';
$username = '<your_admin_username';
$password = '<your_password>';
$db_name = '<your_database_name>';

//Establish the connection
$conn = mysqli_init();
mysqli_ssl_set($conn,NULL,NULL, "<your_path_to_SSL_cert>", NULL, NULL);
mysqli_real_connect($conn, $host, $username, $password, $db_name, 3306, MYSQLI_CLIENT_SSL);
if (mysqli_connect_errno($conn)) {
    die('Failed to connect to MySQL: '.mysqli_connect_error());
}
printf("Connection Established.\n");

//Create an Insert prepared statement and run it
$product_name = 'BrandNewProduct';
$product_color = 'Blue';
$product_price = 15.5;
if ($stmt = mysqli_prepare($conn, "INSERT INTO Products (ProductName, Color, Price) VALUES (?, ?, ?)")) {
    mysqli_stmt_bind_param($stmt, 'ssd', $product_name, $product_color, $product_price);
    mysqli_stmt_execute($stmt);
    printf("Insert: Affected %d rows\n", mysqli_stmt_affected_rows($stmt));
    mysqli_stmt_close($stmt);
}

// Close the connection
mysqli_close($conn);
?>
```

### Read data

Use the following code snippet to connect and read the data by using a **SELECT** SQL statement.  The code uses the **MySQL Improved extension** (mysqli) class included in PHP. The code uses method [mysqli_query](https://secure.php.net/manual/mysqli.query.php) perform the sql query and method [mysqli_fetch_assoc](https://secure.php.net/manual/mysqli-result.fetch-assoc.php) to fetch the resulting rows.

```php
<?php
$host = '<your_server_name>.mysql.database.azure.com';
$username = '<your_admin_username';
$password = '<your_password>';
$db_name = '<your_database_name>';

//Establish the connection
$conn = mysqli_init();
mysqli_ssl_set($conn,NULL,NULL, "<your_path_to_SSL_cert>", NULL, NULL);
mysqli_real_connect($conn, $host, $username, $password, $db_name, 3306, MYSQLI_CLIENT_SSL);
if (mysqli_connect_errno($conn)) {
die('Failed to connect to MySQL: '.mysqli_connect_error());
}
printf("Connection Established.\n");

//Run the Select query
printf("Reading data from table: \n");
$res = mysqli_query($conn, 'SELECT * FROM Products');
while ($row = mysqli_fetch_assoc($res)) {
    var_dump($row);
}

//Close the connection
mysqli_close($conn);
?>
```

### Update data

Use the following code snippet to connect and update the data by using an **UPDATE** SQL statement.

Similar to inserting data, this code again uses a prepared statement with bound parameters.

```php
<?php
$host = '<your_server_name>.mysql.database.azure.com';
$username = '<your_admin_username';
$password = '<your_password>';
$db_name = '<your_database_name>';

//Establishes the connection
$conn = mysqli_init();
mysqli_ssl_set($conn,NULL,NULL, "<your_path_to_SSL_cert>", NULL, NULL);
mysqli_real_connect($conn, $host, $username, $password, $db_name, 3306, MYSQLI_CLIENT_SSL);
if (mysqli_connect_errno($conn)) {
    die('Failed to connect to MySQL: '.mysqli_connect_error());
}
printf("Connection Established.\n");

//Run the Update statement
$product_name = 'BrandNewProduct';
$new_product_price = 15.1;
if ($stmt = mysqli_prepare($conn, "UPDATE Products SET Price = ? WHERE ProductName = ?")) {
    mysqli_stmt_bind_param($stmt, 'ds', $new_product_price, $product_name);
    mysqli_stmt_execute($stmt);
    printf("Update: Affected %d rows\n", mysqli_stmt_affected_rows($stmt));
    mysqli_stmt_close($stmt);
}

//Close the connection
mysqli_close($conn);
?>
```

### Delete data

Use the following code snippet to connect and delete the data by using a **DELETE** SQL statement.

Similar to inserting data, this code again uses a prepared statement with bound parameters.

```php
<?php
$host = '<your_server_name>.mysql.database.azure.com';
$username = '<your_admin_username';
$password = '<your_password>';
$db_name = '<your_database_name>';

//Establishes the connection
$conn = mysqli_init();
mysqli_ssl_set($conn,NULL,NULL, "<your_path_to_SSL_cert>", NULL, NULL);
mysqli_real_connect($conn, $host, $username, $password, $db_name, 3306, MYSQLI_CLIENT_SSL);
if (mysqli_connect_errno($conn)) {
    die('Failed to connect to MySQL: '.mysqli_connect_error());
}
printf("Connection Established.\n");

//Run the Delete statement
$product_name = 'BrandNewProduct';
if ($stmt = mysqli_prepare($conn, "DELETE FROM Products WHERE ProductName = ?")) {
    mysqli_stmt_bind_param($stmt, 's', $product_name);
    mysqli_stmt_execute($stmt);
    printf("Delete: Affected %d rows\n", mysqli_stmt_affected_rows($stmt));
    mysqli_stmt_close($stmt);
}

//Close the connection
mysqli_close($conn);
?>
```

::: zone-end

::: zone pivot="python"

## Install Python and the MySQL connector

Install Python and the MySQL connector for Python on your computer by using the following steps:

1. Download and install the [latest version of Python](https://www.python.org/downloads/) for your OS. Make sure to add Python to your `PATH`, because the MySQL connector requires that.
1. Open a command prompt or `bash` shell, and check your Python version by running `python -V` with the uppercase V switch.
1. The `pip` package installer is included in the latest versions of Python. Update `pip` to the latest version by running `pip install -U pip`.
1. Use `pip` to install the MySQL connector for Python and its dependencies: `pip install mysql-connector-python`

## Run the code snippets

Follow the below steps to run the code snippets to create table, insert, query, update and delete data:

1. Paste the Python code snippets into new files in a project folder, and save with file extension *.py* such as *CreateTable.py*.
1. Replace the `host`, `user`, `password`, and `database` parameters with your own values.
1. Provide the path to downloaded SSL certificate under `ssl_ca` option.
1. Open the command prompt or bash shell, and then change directory into your project folder.
1. To run the application, enter the python command followed by the file name, such as `python CreateTable.py`.

### Create a table and insert data

Use the following code snippet to connect to the server and database, create a table, and load data by using an **INSERT** SQL statement. 

The code imports the mysql.connector library, and uses the [connect()](https://dev.mysql.com/doc/connector-python/en/connector-python-api-mysql-connector-connect.html) function to connect to flexible server. The code uses a cursor on the connection, and the [cursor.execute()](https://dev.mysql.com/doc/connector-python/en/connector-python-api-mysqlcursor-execute.html) method executes the SQL query against the MySQL database.

```python
import mysql.connector
from mysql.connector import errorcode

# Obtain connection string information from the portal
config = {
  'host':'<your_server_name>.mysql.database.azure.com',
  'user':'<your_admin_username>',
  'password':'<your_password>',
  'database':'<your_database_name>',
  'client_flags': [mysql.connector.ClientFlag.SSL],
  'ssl_ca': '<your_path_to_SSL_cert>'
}

# Construct connection string
try:
    conn = mysql.connector.connect(**config)
    print("Connection established")
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("Something is wrong with the user name or password")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Database does not exist")
    else:
        print(err)
else:
    cursor = conn.cursor()

    # Drop previous table of same name if one exists
    cursor.execute("DROP TABLE IF EXISTS inventory;")
    print("Finished dropping table (if existed).")

    # Create table
    cursor.execute("CREATE TABLE inventory (id serial PRIMARY KEY, name VARCHAR(50), quantity INTEGER);")
    print("Finished creating table.")

    # Insert some data into table
    cursor.execute("INSERT INTO inventory (name, quantity) VALUES (%s, %s);", ("banana", 150))
    print("Inserted",cursor.rowcount,"row(s) of data.")
    cursor.execute("INSERT INTO inventory (name, quantity) VALUES (%s, %s);", ("orange", 154))
    print("Inserted",cursor.rowcount,"row(s) of data.")
    cursor.execute("INSERT INTO inventory (name, quantity) VALUES (%s, %s);", ("apple", 100))
    print("Inserted",cursor.rowcount,"row(s) of data.")

    # Cleanup
    conn.commit()
    cursor.close()
    conn.close()
    print("Done.")
```

### Read data

Use the following code snippet to connect and read the data by using a **SELECT** SQL statement.

The code reads the data rows using the [fetchall()](https://dev.mysql.com/doc/connector-python/en/connector-python-api-mysqlcursor-fetchall.html) method, keeps the result set in a collection row, and uses a `for` iterator to loop over the rows.

```python
import mysql.connector
from mysql.connector import errorcode

# Obtain connection string information from the portal
config = {
  'host':'<your_server_name>.mysql.database.azure.com',
  'user':'<your_admin_username>',
  'password':'<your_password>',
  'database':'<your_database_name>',
  'client_flags': [mysql.connector.ClientFlag.SSL],
  'ssl_ca': '<your_path_to_SSL_cert>'
}

# Construct connection string
try:
  conn = mysql.connector.connect(**config)
  print("Connection established")
except mysql.connector.Error as err:
  if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
    print("Something is wrong with the user name or password")
  elif err.errno == errorcode.ER_BAD_DB_ERROR:
    print("Database does not exist")
  else:
    print(err)
else:
  cursor = conn.cursor()

  # Read data 
  cursor.execute("SELECT * FROM inventory;")
  rows = cursor.fetchall()
  print("Read",cursor.rowcount,"row(s) of data.")

  # Print all rows
  for row in rows:
  	print("Data row = (%s, %s, %s)" %(str(row[0]), str(row[1]), str(row[2])))

  # Cleanup
  conn.commit()
  cursor.close()
  conn.close()
  print("Done.")
```

### Update data

Use the following code snippet to connect and update the data by using an **UPDATE** SQL statement.

```python
import mysql.connector
from mysql.connector import errorcode

# Obtain connection string information from the portal
config = {
  'host':'<your_server_name>.mysql.database.azure.com',
  'user':'<your_admin_username>',
  'password':'<your_password>',
  'database':'<your_database_name>',
  'client_flags': [mysql.connector.ClientFlag.SSL],
  'ssl_ca': '<your_path_to_SSL_cert>'
}

# Construct connection string
try:
  conn = mysql.connector.connect(**config)
  print("Connection established")
except mysql.connector.Error as err:
  if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
    print("Something is wrong with the user name or password")
  elif err.errno == errorcode.ER_BAD_DB_ERROR:
    print("Database does not exist")
  else:
    print(err)
else:
  cursor = conn.cursor()

  # Update a data row in the table
  cursor.execute("UPDATE inventory SET quantity = %s WHERE name = %s;", (200, "banana"))
  print("Updated",cursor.rowcount,"row(s) of data.")

  # Cleanup
  conn.commit()
  cursor.close()
  conn.close()
  print("Done.")
```

### Delete data

Use the following code snippet to connect and remove data by using a **DELETE** SQL statement.

```python
import mysql.connector
from mysql.connector import errorcode

# Obtain connection string information from the portal
config = {
  'host':'<your_server_name>.mysql.database.azure.com',
  'user':'<your_admin_username>',
  'password':'<your_password>',
  'database':'<your_database_name>',
  'client_flags': [mysql.connector.ClientFlag.SSL],
  'ssl_ca': '<your_path_to_SSL_cert>'
}

# Construct connection string
try:
  conn = mysql.connector.connect(**config)
  print("Connection established")
except mysql.connector.Error as err:
  if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
    print("Something is wrong with the user name or password")
  elif err.errno == errorcode.ER_BAD_DB_ERROR:
    print("Database does not exist")
  else:
    print(err)
else:
  cursor = conn.cursor()

  # Delete a data row in the table
  cursor.execute("DELETE FROM inventory WHERE name=%(param1)s;", {'param1':"orange"})
  print("Deleted",cursor.rowcount,"row(s) of data.")

  # Cleanup
  conn.commit()
  cursor.close()
  conn.close()
  print("Done.")
```

::: zone-end

::: zone pivot="java"

## Install Java and Apache Maven

Installed a supported [Java Development Kit, version 8](https://docs.microsoft.com/azure/developer/java/fundamentals/java-support-on-azure) and the [Apache Maven build tool](https://maven.apache.org/).

## Code the application

Follow the below steps to code a Java application to connect and query Azure Database for MySQL - Flexible Server using JDBC.

### Create a Java project

Using your favorite IDE, create a new Java project folder, and add a `pom.xml` file in its root directory. This file is used by Apache Maven to configure your project.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>demo</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>demo</name>

    <properties>
        <java.version>1.8</java.version>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
    </properties>

    <dependencies>
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>8.0.20</version>
        </dependency>
    </dependencies>
</project>
```

### Prepare a configuration file to connect to Azure Database for MySQL

Create a *src/main/resources/application.properties* file, and add:

```properties
url=jdbc:mysql://<your_server_name>.mysql.database.azure.com:3306/<your_database_name>?serverTimezone=UTC
user=<your_admin_username>
password=<your_password>
```

### Create an SQL file to generate the database schema

We will use a *src/main/resources/`schema.sql`* file in order to create a database schema. Create that file, with the following content:

```sql
DROP TABLE IF EXISTS todo;
CREATE TABLE todo (id SERIAL PRIMARY KEY, description VARCHAR(255), details VARCHAR(4096), done BOOLEAN);
```

### Create a domain class

To insert or query records from the *todo* table in database schema, let us first create a domain class *ToDo* mapped to it. Create a *src/main/java/com/example/ToDo.java* file that contains:

```java
package com.example;

public class Todo {

    private Long id;
    private String description;
    private String details;
    private boolean done;

    public Todo() {
    }

    public Todo(Long id, String description, String details, boolean done) {
        this.id = id;
        this.description = description;
        this.details = details;
        this.done = done;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public boolean isDone() {
        return done;
    }

    public void setDone(boolean done) {
        this.done = done;
    }

    @Override
    public String toString() {
        return "Todo{" +
                "id=" + id +
                ", description='" + description + '\'' +
                ", details='" + details + '\'' +
                ", done=" + done +
                '}';
    }
}
```

### Connect to and query the database

Next, add the Java code that uses JDBC to connect to your flexible server, create a table, store, retrieve and update data. 
Create a *src/main/java/com/example/DemoApplication.java* file, that contains:

```java
package com.example;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

import java.sql.*;
import java.util.*;
import java.util.logging.Logger;

public class DemoApplication {

    private static final Logger log;

    static {
        System.setProperty("java.util.logging.SimpleFormatter.format", "[%4$-7s] %5$s %n");
        log =Logger.getLogger(DemoApplication.class.getName());
    }

    public static void main(String[] args) throws Exception {
        
        //Establish connection

        log.info("Loading application properties");
        Properties properties = new Properties();
        properties.load(DemoApplication.class.getClassLoader().getResourceAsStream("application.properties"));

        log.info("Connecting to the database");
        Connection connection = DriverManager.getConnection(properties.getProperty("url"), properties);
        log.info("Database connection test: " + connection.getCatalog());

        //Create table 

        log.info("Create database schema");
        Scanner scanner = new Scanner(DemoApplication.class.getClassLoader().getResourceAsStream("schema.sql"));
        Statement statement = connection.createStatement();
        while (scanner.hasNextLine()) {
            statement.execute(scanner.nextLine());
        }

        //Create a ToDo object
        Todo todo = new Todo(1L, "Configuration", "JDBC set up successfully.", true);
        
        //Call method to insert data
        insertData(todo, connection);

        //Call method to read and print data
        todo = readData(connection);

        //Call method to update a record
        todo.setDetails("Updated Data");
        updateData(todo, connection);

        //Call method to delete a record
        deleteData(todo, connection);

        //Close database connection
        log.info("Closing database connection");
        connection.close();
        AbandonedConnectionCleanupThread.uncheckedShutdown();
    }

    private static void insertData(Todo todo, Connection connection) throws SQLException {
        //Method to insert data
        
        log.info("Insert data");
        PreparedStatement insertStatement = connection
                .prepareStatement("INSERT INTO todo (id, description, details, done) VALUES (?, ?, ?, ?);");

        insertStatement.setLong(1, todo.getId());
        insertStatement.setString(2, todo.getDescription());
        insertStatement.setString(3, todo.getDetails());
        insertStatement.setBoolean(4, todo.isDone());
        insertStatement.executeUpdate();
    }

    private static Todo readData(Connection connection) throws SQLException {
        //Method to read and print data

        log.info("Read data");
        PreparedStatement readStatement = connection.prepareStatement("SELECT * FROM todo;");
        ResultSet resultSet = readStatement.executeQuery();
        if (!resultSet.next()) {
            log.info("There is no data in the database!");
            return null;
        }
        Todo todo = new Todo();
        todo.setId(resultSet.getLong("id"));
        todo.setDescription(resultSet.getString("description"));
        todo.setDetails(resultSet.getString("details"));
        todo.setDone(resultSet.getBoolean("done"));
        log.info("Data read from the database: " + todo.toString());
        return todo;
    }

    private static void updateData(Todo todo, Connection connection) throws SQLException {
        //Method to update data
        
        log.info("Update data");
        PreparedStatement updateStatement = connection
                .prepareStatement("UPDATE todo SET description = ?, details = ?, done = ? WHERE id = ?;");

        updateStatement.setString(1, todo.getDescription());
        updateStatement.setString(2, todo.getDetails());
        updateStatement.setBoolean(3, todo.isDone());
        updateStatement.setLong(4, todo.getId());
        updateStatement.executeUpdate();
        readData(connection);
    }

    private static void deleteData(Todo todo, Connection connection) throws SQLException {
        //Method to delete data

        log.info("Delete data");
        PreparedStatement deleteStatement = connection.prepareStatement("DELETE FROM todo WHERE id = ?;");
        deleteStatement.setLong(1, todo.getId());
        deleteStatement.executeUpdate();
        readData(connection);
    }
}
```

## Run the Java application

1. Open the command prompt or bash shell, and then change directory into your project folder.
1. Compile the project using `mvn compile`.
1. Run the application using the command `mvn exec:java -Dexec.mainClass="com.example.DemoApplication"`

::: zone-end

## Clean up resources

To avoid incurring unwanted charges, delete the MySQL flexible server (or the entire resource group itself) using either Azure portal or Azure CLI.
