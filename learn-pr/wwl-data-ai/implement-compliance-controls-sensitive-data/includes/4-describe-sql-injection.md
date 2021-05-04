SQL injection is one of the most common methods used for data breaches. The core of the attack is that an SQL command is appended to the back end of a form field in the web or application front end (usually through a website), with the intent of breaking the original SQL Script and then executing the SQL script that was injected into the form field. This SQL injection most often happens when you have dynamically generated SQL within your client application. The core reason behind an SQL Injection attack comes down to poor coding practices both within the client application and within the database stored procedures. Many developers have learned better development practices, but SQL injection is still a significant problem due to both the number of legacy applications still being used and newer applications built by developers who didn’t take SQL injection seriously while building the application.

As an example, assume that the front-end web application creates a dynamic SQL statement as shown below:

```sql
SELECT * FROM Orders WHERE OrderId=25
```

This T-SQL is created when the user goes to the sales order history portion of the company’s website and enters 25 into the form field for the order ID number. However, suppose the user enters more than just an ID number, for example “25; DELETE FROM Orders;”

In that case, the query sent to your database would be as shown below:

```sql
SELECT * FROM Orders WHERE OrderID=25; DELETE FROM Orders;
```

The way the query in the above example works is that the SQL database is told via the semicolon “;” that the statement has ended and that there is another statement that should be run. The database then processes the next statement as instructed, which would result in the deletion of all rows from the Orders table.

The initial SELECT query is run as normal without any errors being generated. However, when you look at the Orders table, you won’t see any rows. The second query in the batch, which deletes all the rows, was also executed.

One technique used to prevent SQL injection attacks is to inspect the text of the parameters, or values entered into the form fields, looking for various keywords. However, this solution only provides minimum protection as there are many, many ways to force these attacks to work. Some of these injection techniques include passing in binary data, having the database engine convert the binary data back to a text string, and then executing the string. You can see a simple example of this problem by running the T-SQL code below. 

```sql
DECLARE @v varchar(255)

SELECT @v = cast(0x73705F68656C706462 as varchar(255))

EXEC (@v)
```

When data is being accepted from a user, either a customer or an employee, one good way to ensure that the value won’t be used for an SQL injection attack is to validate that the data that was entered is of the expected data type. If a number is expected, the client application should ensure that there is in fact a number being returned. If a text string is expected, then ensure that the text string is of the correct length, and it does not contain any binary data within it. The client application should be able to validate all data being passed in from the user. Validation can be done either by informing the user of the problem and allowing the user to correct the issue, or by crashing gracefully in such a way that an error is returned and no commands are sent to the database or the file system.

While fixing your application code should always be the priority, in some cases that may not be possible, so having Advanced Threat Protection can provide an additional layer of protection for your sensitive data.
