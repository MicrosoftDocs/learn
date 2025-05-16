
SQL injection is a common method used for data breaches. The attack involves appending an SQL command to a form field in a web or application front end, usually through a website, with the intent of breaking the original SQL script and executing the injected SQL script. This often occurs when dynamically generated SQL is used within the client application. The primary cause of SQL injection attacks is poor coding practices in both the client application and database stored procedures. While many developers adopt better practices, SQL injection remains a significant problem due to the prevalence of legacy applications and newer applications built by developers who didn't prioritize SQL injection prevention.

As an example, assume that a front-end web application creates a dynamic SQL statement as follows:

```sql
SELECT * FROM Orders WHERE OrderId=25
```

This T-SQL is created when the user goes to the sales order history portion of the company’s website and enters 25 into the form field for the order ID number. However, suppose the user enters more than just an ID number, for example “25; DELETE FROM Orders;”

In that case, the query sent to your database would be as follows:

```sql
SELECT * FROM Orders WHERE OrderID=25; DELETE FROM Orders;
```

The way the query in the above example works is that the SQL database is told via the semicolon “;” that the statement has ended and that there's another statement that should be run. The database then processes the next statement as instructed, which would result in the deletion of all rows from the Orders table.

The initial `SELECT` query is run as normal without any errors being generated. However, when you look at the Orders table, you don't see any rows. The second query in the batch, which deletes all the rows, was also executed.

One technique used to prevent SQL injection attacks is to inspect the text of the parameters, or values entered into the form fields, looking for various keywords. However, this solution only provides minimum protection as there are many, many ways to force these attacks to work. Some of these injection techniques include passing in binary data, having the database engine convert the binary data back to a text string, and then executing the string. 

You can run the following T-SQL code to see an example of this scenario. 

```sql
DECLARE @v VARCHAR(255)

SELECT @v = cast(0x73705F68656C706462 AS VARCHAR(255))

EXEC (@v)
```

When accepting data from a user, whether a customer or an employee, it's crucial to validate that the input matches the expected data type to prevent SQL injection attacks. If a number is expected, the client application should verify that the input is indeed a number. If a text string is expected, ensure it is of the correct length and doesn't contain any binary data. The client application should validate all user input. Validation can be done by either informing the user of the issue and allowing them to correct it, or by gracefully handling the error to ensure no commands are sent to the database or file system.

While fixing your application code should always be the priority, there may be cases where it's not possible. In such cases, Advanced Threat Protection can offer an extra layer of security for your sensitive data.
