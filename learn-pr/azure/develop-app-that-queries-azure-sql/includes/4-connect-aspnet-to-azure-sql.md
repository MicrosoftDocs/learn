You can connect to databases within the Azure SQL Database service from an application in a variety of ways. For .NET applications, you can use the `System.Data.SqlClient` library.

The web application for the university must fetch and display the data that you uploaded to Azure SQL Database. In this unit, you'll learn how to connect to a database from a web application, and process data using the `System.Data.SqlClient` library.

## Overview of the System.Data.SqlClient library

The `System.Data.SqlClient` library is a collection of types and methods that you can use to connect to a SQL Server database, running either on-premises or in the cloud on Azure SQL Database. The library provides a generalized interface for retrieving and maintaining data. Using the `System.Data.SqlClient` library, you can run SQL commands, perform transactional operations, and retrieve data. You can parameterize these operations to avoid problems associated with SQL injection attacks. If an operation fails, the `System.Data.SqlClient` library makes any error information available through specialized exception and error classes. You can handle these exceptions just like any other type of exception in a .NET application.

The `System.Data.SqlClient` library is available in the **System.Data.SqlClient** NuGet package.

## Connect to a single database

You create a database connection using a `SqlConnection` object. You provide a *connection string* that specifies the name and location of the database, the credentials to use, and other connection-related parameters. A typical connection string to a single database looks like this:

```Text
Server=tcp:myserver.database.windows.net,1433;Initial Catalog=mydatabase;Persist Security Info=False;User ID=myusername;Password=mypassword;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
```

You can find the connection string for your single database in the Azure portal, on the **Connection strings** page for your database.

The following code example shows how to create a `SqlConnection` object:

```C#
using System.Data.SqlClient;

...

string connectionString = "Server=tcp:myserver.database.windows.net,...";
SqlConnection con = new SqlConnection(connectionString);
```

The database connection isn't established until you open the connection. You typically open the connection immediately before running a SQL command or query.

```C#
con.Open();
```

Some databases only support a finite number of concurrent connections, so when you have finished running a command and retrieved any results, it's good practice to close the connection and release any resources held.

```C#
con.Close();
```

Another common approach is to create the connection in a `using` statement. This strategy automatically closes the connection when the `using` statement completes, although you can still explicitly call the `Close` method as well.

```C#
using (SqlConnection con = new SqlConnection(connectionString))
{
    // Open and Use the connection here
    con.Open();
    ...
}
// Connection is now closed
```

## Define a SQL command or query

Create a `SqlCommand` object to specify a SQL command or query to run. The following example shows a SQL **DELETE** statement that removes rows for a given customer from a table named **Orders**. You can parameterize commands; this example uses a parameter named **CustID** for the **CustomerID** value. Additionally, the line that sets the `CommandType` property of the `SqlCommand` object to `Text` indicates that the command is an SQL statement. You can run a stored procedure rather than an SQL statement, in which case you set the `CommandType` to `StoredProcedure`.

```C#
SqlCommand deleteOrdersForCustomer = new SqlCommand("DELETE FROM Orders WHERE CustomerID = @custID", con);
deleteOrdersForCustomer.CommandType = CommandType.Text;
string customerID = <prompt the user for a customer to delete>;
deleteOrdersForCustomer.Parameters.Add(new SqlParameter("custID", customerID));
```

The final parameter to the `SqlCommand` constructor shown in this example is the connection that will be used to run the command.

The next example shows a query that joins the **Customers** and **Orders** tables together to produce a list of customer names and their orders.

```C#
SqlCommand queryCmd = new SqlCommand(
                    @"SELECT c.FirstName, c.LastName, o.OrderID
                      FROM Customers c JOIN Orders o
                      ON c.CustomerID = o.CustomerID", con);
queryCmd.CommandType = CommandType.Text;
```

## Run a command

If your `SqlCommand` object references a SQL statement that doesn't return a result set, you run the command with the `ExecuteNonQuery` method. if the command is successful, it returns the number of rows affected by the operation. The next example shows how to run the **deleteOrdersForCustomer** command shown earlier.

```C#
int numDeleted = deleteOrdersForCustomer.ExecuteNonQuery();
```

If you expect the command to take some time to run, you can use the `ExecteNonQueryAsync` method to perform the operation asynchronously.

## Execute a query and fetch data

If your `SqlCommand` contains an SQL SELECT statement, you run it using the `ExecuteReader` method. This method returns an `SqlDataReader` object that you can use to iterate through the results and process each row in turn. You retrieve the data from a `SqlReader` object with the `Read` method. This method returns true if a row is found, and false if there are no more rows left to read. Having read the next row, the data for that row is available in the fields in the `SqlReader` object. Each field shares the same name as the corresponding column in the original SELECT statement. However, the data in each field is retrieved as an untyped `object`, so you must convert it to the appropriate type before you can use it. The code below shows how to run the **queryCmd** command illustrated earlier, and fetch the data a row at a time.

```C#
SqlDataReader rdr = queryCmd.ExecuteReader();

// Read the data a row at a time
while (rdr.Read())
{
    string firstName = rdr["FirstName"].ToString();
    string lastName = rdr["LastName"].ToString();
    int orderID = Convert.ToInt32(rdr["OrderID"]);

    // Process the data
    ...
}
```

## Handle exceptions and errors

Exceptions and errors can occur when using a database for any number of reasons. For example, you might attempt to access a table that no longer exists. You can catch SQL errors using the `SqlException` type.

An exception might have been triggered by a number of events or problems in the database. An `SqlException` object has a property named `Errors` that contains a collection of `SqlError` objects. These objects provide the details for each error. The example below shows how to catch a `SqlException`, and process the errors it contains.

```C#
...
using (SqlConnection con = new SqlConnection(connectionString))
{
    SqlCommand command = new SqlCommand("DELETE FROM ...", con);
    try
    {
        con.Open();
        command.ExecuteNonQuery();
    }
    catch (SqlException ex)
    {
        for (int i = 0; i < ex.Errors.Count; i++)
        {
            Console.WriteLine($"Index # {i} Error: {ex.Errors[i].ToString()}");
        }
    }
}
```
