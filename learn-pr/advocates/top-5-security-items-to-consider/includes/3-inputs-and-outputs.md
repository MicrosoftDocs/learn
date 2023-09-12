The most prevalent security weakness of current applications is a failure to correctly process data that is received from external sources, particularly _user input_. You should always take a close look at any input to make sure it has been validated before it is used. Failing to analyze user input for possible attacks can result in data loss or exposure, elevation of privilege, or even execution of malicious code on other users' computers.

The tragedy in this situation is that this scenario an easy problem to solve. In this unit we'll cover how to treat data when it's received, when it's displayed on the screen, and when it's stored for later use.

## Why do we need to validate our input?

Imagine that you're building an interface to allow a user to create an account on your website. Our profile data includes a name, email, and a nickname that we'll display to everyone who visits the site. What if a new user creates a profile and enters a nickname that includes some SQL commands? For example, what if a malicious user enters something like the following excerpt:

```sql
Eve'); DROP TABLE Users;--
```

If we blindly insert this value into a database, it could potentially alter the SQL statement to execute commands we absolutely don't want to run! This example is referred to as a "SQL Injection" attack, which is one of the _many_ types of exploits that can potentially be done when you don't properly handle user input. So, what can we do to fix this situation? This unit will teach you when to validate input, how to encode output, and how to create parameterized queries (which solves the above exploit). These techniques are the three main defense techniques against malicious input being entered into your applications.

## When do I need to validate input?

The answer is _always_. You must validate **every** input for your application. This includes parameters in the URL, input from the user, data from the database, data from an API, and anything that is passed in the clear that a user could potentially manipulate. Always use an _allowlist_ approach, which means you only accept "known good" input, instead of a _blocklist_ (where you specifically look for bad input) because it's impossible to think of a complete list of potentially dangerous input. Do this work on the server, not the client side (or in addition to the client side), to ensure that your defenses can't be circumvented. Treat **ALL** data as untrusted, and you'll protect yourself from most of the common web app vulnerabilities.

If you're using ASP.NET, the framework provides [great support for validating input](/aspnet/web-pages/overview/ui-layouts-and-themes/validating-user-input-in-aspnet-web-pages-sites) on both the client and server side.

If you're using another web framework, there are some great techniques for doing input validation available on the [OWASP Input Validation Cheatsheet](https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html).

## Always use parameterized queries

SQL databases are commonly used to store data; for example, your application could store user profile information in a database. You should never create inline SQL or other database queries in your code using raw user input and send it directly to the database; this behavior is a recipe for disaster, as we saw previously.

For example, **don't** create code like the following inline SQL example:

```csharp
string userName = Request.QueryString["username"]; // receive input from the user BEWARE!
...
string query = "SELECT *  FROM  [dbo].[users] WHERE userName = '" + userName + "'";
```

Here we concatenate text strings together to create the query, taking the input from the user and generating a dynamic SQL query to look up the user. Again, if a malicious user realized we were doing this, or just _tried_ different input styles to see if there was a vulnerability, we could end up with a major disaster. Instead, use parameterized SQL statements or stored procedures such as this:

```sql
-- Lookup a user
CREATE PROCEDURE sp_findUser
(
@UserName varchar(50)
)

SELECT *  FROM  [dbo].[users] WHERE userName = @UserName
```

With this method, you can invoke the procedure from your code safely, passing it the `userName` string without worrying about it being treated as part of the SQL statement.

## Always encode your output

Any output you present either visually or within a document should always be encoded and escaped. This can protect you in case something was missed in the sanitization pass or the code accidentally generates something that can be used maliciously. This design principle will make sure that everything is displayed as _output_ and not inadvertently interpreted as something that should be executed, which is another common attack technique that is referred to as "Cross-Site Scripting" (XSS).

Since XSS prevention is a common application requirement, this security technique is another area where ASP.NET will do the work for you. By default, all output is already encoded. If you're using another web framework, you can verify your options for output encoding on websites with the [OWASP XSS Prevention Cheatsheet](https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html).

## Summary

Sanitizing and validating your input is a necessary requirement to ensure your input is valid and safe to use and store. Most modern web frameworks offer built-in features that can automate some of this work. You can check your preferred framework's documentation and see what features it offers. While web applications are the most common place where this happens, keep in mind that other types of applications can be just as vulnerable. Don't think you're safe just because your new application is a desktop app. You'll still need to properly handle user input to ensure someone doesn't use your app to corrupt your data or damage your company's reputation.
