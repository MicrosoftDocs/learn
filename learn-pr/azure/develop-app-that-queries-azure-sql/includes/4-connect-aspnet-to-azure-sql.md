There are various ways to connect to databases within the Azure SQL Database service from an application. For .NET apps, you can use the `System.Data.SqlClient` library.

The web app for the university must fetch and display the data that you uploaded to your SQL database. In this unit, you learn how to connect to a database from a web app and use the `System.Data.SqlClient` library to process data.

## System.Data.SqlClient library overview

The `System.Data.SqlClient` library is a collection of types and methods that you can use to connect to a SQL Server database that's running on-premises or in the cloud on SQL Database. The library provides a generalized interface for retrieving and maintaining data. You can use the `System.Data.SqlClient` library to run Transact-SQL (T-SQL) commands and transactional operations and to retrieve data. You can parameterize these operations to avoid problems that are associated with SQL-injection attacks. If an operation fails, the `System.Data.SqlClient` library provides error information through specialized exception and error classes. You handle these exceptions just like any other type of exception in a .NET application.

The `System.Data.SqlClient` library is available in the *System.Data.SqlClient* NuGet package.

## Connect to a single database

You use an `SqlConnection` object to create a database connection. You provide a *connection string* that specifies the name and location of the database, the credentials to use, and other connection-related parameters. A typical connection string to a single database looks like this:

```Text
Server=tcp:myserver.database.windows.net,1433;Initial Catalog=mydatabase;Persist Security Info=False;User ID=myusername;Password=mypassword;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
```

You can find the connection string for your single database on the **Connection strings** page for your database in the Azure portal.

The following code example shows how to create an `SqlConnection` object:

```C#
using System.Data.SqlClient;

...

string connectionString = "Server=tcp:myserver.database.windows.net,...";
SqlConnection con = new SqlConnection(connectionString);
```

The database connection isn't established until you open the connection. You typically open the connection immediately before you run a T-SQL command or query.

```C#
con.Open();
```

Some databases only support a finite number of concurrent connections. So, after you finish running a command and retrieving any results, it's good practice to close the connection and release any resources that were held.

```C#
con.Close();
```

Another common approach is to create the connection in a `using` statement. This strategy automatically closes the connection when the `using` statement completes. But you can also explicitly call the `Close` method.

```C#
using (SqlConnection con = new SqlConnection(connectionString))
{
    // Open and Use the connection here
    con.Open();
    ...
}
// Connection is now closed
```

## Define a T-SQL command or query

Create an `SqlCommand` object to specify a T-SQL command or query to run. The following example shows a T-SQL `DELETE` statement that removes rows for a given customer from the `dbo.Orders` table. You can parameterize commands. This example uses a parameter that's named *CustID* for the `CustomerID` value. The line that sets the `CommandType` property of the `SqlCommand` object to `Text` indicates that the command is a T-SQL statement. You can also run a stored procedure rather than a T-SQL statement. In that case, you set the `CommandType` to `StoredProcedure`.

```C#
SqlCommand deleteOrdersForCustomer = new SqlCommand("DELETE FROM Orders WHERE CustomerID = @custID", con);
deleteOrdersForCustomer.CommandType = CommandType.Text;
string customerID = <prompt the user for a customer to delete>;
deleteOrdersForCustomer.Parameters.Add(new SqlParameter("custID", customerID));
```

The final parameter to the `SqlCommand` constructor in this example is the connection that's used to run the command.

The next example shows a query that joins the `dbo.Customers` and `dbo.Orders` tables together to produce a list of customer names and their orders.

```C#
SqlCommand queryCmd = new SqlCommand(
                    @"SELECT c.FirstName, c.LastName, o.OrderID
                      FROM Customers c JOIN Orders o
                      ON c.CustomerID = o.CustomerID", con);
queryCmd.CommandType = CommandType.Text;
```

## Run a command

If your `SqlCommand` object references a T-SQL statement that doesn't return a result set, run the command by using the `ExecuteNonQuery` method. If the command succeeds, it returns the number of rows affected by the operation. The next example shows how to run the `deleteOrdersForCustomer` command that was shown earlier.

```C#
int numDeleted = deleteOrdersForCustomer.ExecuteNonQuery();
```

If you expect the command to take a while to run, you can use the `ExecuteNonQueryAsync` method to perform the operation asynchronously.

## Execute a query and fetch data

If your `SqlCommand` contains a T-SQL SELECT statement, you run it by using the `ExecuteReader` method. This method returns an `SqlDataReader` object that you can use to iterate through the results and process each row in turn. You retrieve the data from an `SqlReader` object by using the `Read` method. This method returns *true* if a row is found and *false* if there are no more rows left to read. After a row is read, the data for that row is available in the fields in the `SqlReader` object. Each field has the same name as the corresponding column in the original SELECT statement. However, the data in each field is retrieved as an untyped `object`, so you must convert it to the appropriate type before you can use it. The following code shows how to run the `queryCmd` command that we illustrated earlier to fetch the data one row at a time.

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

Exceptions and errors can occur for various reasons when you're using a database. For example, you might try to access a table that no longer exists. You can catch T-SQL errors by using the `SqlException` type.

Various events or problems in the database might trigger an exception. An `SqlException` object has a property `Errors` that contains a collection of `SqlError` objects. These objects provide the details for each error. The following example shows how to catch an `SqlException` and process the errors that it contains.

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
