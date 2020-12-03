We want to set up an ASP.NET app to connect and query our `paymentapp` postgres database.

Using the Azure Cloud Shell, we can deploy a ASP.NET app,

1. In the Azure Cloud Shell window on the right side of your screen, run the following command to download the data files and application code for the university system.

```bash
git clone https://github.com/TomReidNZ/payment-app.git payment-app
```

2. Run these commands to move the sample data to its own folder and list the files in the folder.

```bash
mv ~/payment-app/data ~/paymentdata
cd ~/paymentdata
ls
```

This folder contains one file: **users.csv**.

3. We're going to load more user data. The data is located in `payment-app/data`. Let's view the contents of the **users.csv** file.

```bash
cat users.csv
```

This file contains the following comma-separated data. It includes a user_id, user_name, user_age for each user that we're going to load into the database.

```text
user_id ,user_name, user_age
3,Charles,39
2,Dakota,90
3,Dylan,33
...
```

## Load the data

Let's connect to our database again, and load the CSV data in there.

4. Run the following command to connect to the `payment-server-demo` server.

```psql
psql --host=$SERVERNAME.postgres.database.azure.com --port=5432 --username=paymentadmin@$SERVERNAME.postgres.database.azure.com --dbname=postgres
```

Type in your password and select enter.

5. At the prompt, execute the following command to **connect directly** to the **paymentapp** database:

```sql
\c paymentapp
```

6. Next, load the data from the CSV files into the `users` table.

```sql
SELECT count(*) from users;
SET CLIENT_ENCODING TO 'utf8';

\copy users from 'users.csv' WITH CSV;
SELECT * from users;
```

7. Let's exit from the database and return to the Azure Cloud Shell

```sql
\q
```

## Deploy and connect an ASP.NET web app to your database

Now we have more data to query, we'll deploy our webapp, then connect it to our database.

8. In Cloud Shell, go to the **payment-app** folder.

```bash
cd ~/payment-app
```

9. Run the following commands to build and deploy the initial web app.

```bash
WEBAPPNAME=payment-app-$RANDOM
az webapp up \
    --resource-group "<rgn>Sandbox resource group name</rgn>" \
    --location centralus \
    --sku F1 \
    --name $WEBAPPNAME
```

When the web application has been deployed, the output will show an _App_url_ with the URL of the web site. **Open the URL in a new tab**.

> [!NOTE]
> If you select the URL directly from the Azure Cloud Shell, there may be an extra `"` on the end of the URL, causing the website to not connect. \*\*If you remove the `"` from the end of the URL, you will connect to the website.

## Add code to the web app to retrieve data

Now let's add to the application the code to retrieve course data from the database.

1. In Cloud Shell, go to the **payment-app/Models** folder.

```bash
cd ~/payment-app/Models
```

This folder contains two files, **Users.cs** and **DataAccessController.cs**.

2. Use the code editor to open the **DataAccessController.cs** file.

```bash
code DataAccessController.cs
```

This file contains an empty class that's named `DataAccessController`.

```C#
        using Microsoft.Extensions.Options;
        using System;
        using System.Collections.Generic;
        using System.Data;
        using Npgsql;
        using System.Linq;
        using System.Threading.Tasks;

        namespace PaymentUsersApp.Models
        {
            public class DataAccessController

    {
    // TODO: Add your connection string in the following statements
    private string connectionString = "<Azure Database for PostgreSQL Connection String>";

                    // Retrieve all details of courses and their modules
        public IEnumerable<Users> GetAllUsers()
                    {
            List<Users> userList = new List<Users>();

                        // TODO: Connect to the database
                        //using ()
                        {
                            // TODO: Specify the SQL query to run

                            // TODO: Execute the query

                            // TODO: Read the data a row at a time

                            // TODO: Close the database connection
                        }
                        return userList;
                    }
                }
            }
```

This class will contain the logic to:

- Connect the app to the database
- Retrieve user data
- Add each users data to a `User` object
- Populate a **list** with all of the `User` objects\*\*

The data for each user will be _userID_, _userName_, and _userAge_.

3. Leave the code editor open, and switch to the Azure portal.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

4. In the Azure portal menu, select **payment-server-demo**.

5. Under **Settings**, select **Connection strings**. Copy the **ADO.NET** connection string to the clipboard.

6. Return to the code editor. Replace the value of the **_connectionString_ variable on line 14** with the value from the clipboard. In the connection string, **replace the text `{your_password}` with the password for the database** and **replace the text {your_database} with `paymentapp`**. Leave the quotation marks around your connection string.

The payment string will read:

```C#
private string connectionString = "Server=payment-server-demo.postgres.database.azure.com;Database=paymentapp;Port=5432;User Id=paymentadmin@payment-server-demo;Password={your_password};Ssl Mode=Require;";
```

7. After the comment `//TODO: Connect to the database`, replace the commented-out `using` statement with the following code.

```C#
using (var conn = new NpgsqlConnection(connectionString))
```

This code creates a new `NpgsqlConnection` object that connects to the database, using your connection string.

8. Replace the comment `// TODO: Specify the SQL query to run` with the following statements.

```C#
conn.Open();
using (var command = new NpgsqlCommand("SELECT * FROM users", conn))
                {
```

The `NpgsqlCommand` object contains an SQL statement that retrieves the data for all users.

9. Replace the comment `// TODO: Execute the query` with the following code.

```C#
var reader = command.ExecuteReader();
```

These statements open the connection to the database and run the SQL statement. You can use the `SqlDataReader` object to fetch the results one row at a time.

10. Replace the comment `// TODO: Read the data a row at a time` with the following block of code.

```C#
while (reader.Read())
    {
        string userID = reader.GetInt32(0).ToString();
        string userName = reader.GetString(1);
        int moduleSequence = reader.GetInt32(2);
        Users user = new Users(userID, userName, moduleSequence);
        userList.Add(user);
    }
                }
```

This block iterates through the rows that are returned in the `SqlDataReader` object. The code extracts the data in the fields in each row and uses them to populate a new `Users` object. This object is then added to a list.

11. Replace the comment `// TODO: Close the database connection` with the following statement.

```C#
conn.Close();
```

This statement closes the connection to the database and releases any resources that were held.

12. The completed class should contain the following code, which includes the connection string for your database.

```C#
        using Microsoft.Extensions.Options;
        using System;
        using System.Collections.Generic;
        using System.Data;
        using Npgsql;
        using System.Linq;
        using System.Threading.Tasks;

        namespace PaymentUsersApp.Models

    {
    public class DataAccessController
    {
    // TODO: Add your connection string in the following statements
    string connectionString = "Server=payment-server-demo.postgres.database.azure.com;Database=paymentapp;Port=5432;User Id=paymentadmin@payment-server-demo;Password=<password>;Ssl Mode=Require;";

            // Retrieve all details of courses and their modules
            public IEnumerable<Users> GetAllUsers()
            {
                List<Users> userList = new List<Users>();

            // TODO: Connect to the database
            //using ()
                using (var conn = new NpgsqlConnection(connectionString))
                {
                    Console.Out.WriteLine("Opening connection");
                // TODO: Specify the SQL query to run
                    conn.Open();
                    using (var command = new NpgsqlCommand("SELECT * FROM users", conn))
                    {
                // TODO: Execute the query
                        var reader = command.ExecuteReader();

                // TODO: Read the data a row at a time
                        while (reader.Read())
                        {
                            string userID = reader.GetInt32(0).ToString();
                            string userName = reader.GetString(1);
                            int moduleSequence = reader.GetInt32(2);
                            Users user = new Users(userID, userName, moduleSequence);
                            userList.Add(user);
                        }
                    }
                // TODO: Close the database connection
                    conn.Close();
                }
                return userList;
            }
        }

}
```

Later, if your program doesn't properly query the user data, come back to this file and replace the entire contents with the code block above, and save.

Save the file, and close the **Code** editor.

## Add code to the web app to display the data

The application can now retrieve the course data. Now, update the app to display the data to the user.

1. In Cloud Shell, move to the **payment-app/Pages** folder.

```bash
cd ~/payment-app/Pages
```

This folder contains the .cshtml pages and code files that the web app uses to display information.

2. Use the code editor to open the incomplete file **Index.cshtml**.

```bash
code Index.cshtml
```

This file contains the display logic for the webpage page. Our data is delivered by the `CoursesAndModulesModel` - It will return a list, containing the user information.

Currently, the page just displays the table headings. The table body (`<tbody>`) is empty.

```cshtml
<h2>Woodward Payment App Users</h2>
<div>
    <table class="table">
        <thead>
            <tr>
                <th>
                    User ID
                </th>
                <th>
                    User Name
                </th>
                <th>
                    User Age
                </th>
            </tr>
        </thead>
        <tbody>
            <!-- TODO: Display the data from the Users collection -->
        </tbody>
    </table>
</div>
```

3. Replace the comment `<!-- TODO: Display the data from the Users collection --\>` with the following foreach loop.

```cshtml
@foreach (var user in Model.Users)
{
    <tr>
        <td>
            @Html.DisplayFor(userId => user.UserId)
        </td>
        <td>
            @Html.DisplayFor(userName => user.UserName)
        </td>
        <td>
            Html.DisplayFor(userAge => user.UserAge)
        </td>
    </tr>
}
```

This code iterates through the list of User objects, and outputs the data in each field.

4. The completed **Index.cshtml** file should contain the following code.

```cshtml
@page
@model UsersModel
@{
    ViewData["Title"] = "Home page";
}

<h2>Woodward Payment App Users</h2>
<div>
    <table class="table">
        <thead>
            <tr>
                <th>
                    User ID
                </th>
                <th>
                    User Name
                </th>
                <th>
                    User Age
                </th>
            </tr>
        </thead>
        <tbody>
            <!-- TODO: Display the data from the Users collection -->
            @foreach (var user in Model.Users)
            {
                <tr>
                    <td>
                        @Html.DisplayFor(userId => user.UserId)
                    </td>
                    <td>
                        @Html.DisplayFor(userName => user.UserName)
                    </td>
                    <td>
                        @Html.DisplayFor(userAge => user.UserAge)
                    </td>
                </tr>
            }
        </tbody>
    </table>
</div>
```

Save the file, and close the code editor.

## Deploy and test the updated web app

With the application fully configured to retrieve and display the course data to the user, you can deploy the updated version.

1. In Cloud Shell, return to the **payment-app** folder.

```bash
cd ~/payment-app
```

2. Run the following commands to build and deploy the updated web app.

```bash
az webapp up \
    --resource-group postgres \
    --name $WEBAPPNAME
```

3. After the new web app is deployed, select the link for the app. It should now display a list of users with the data that's stored in the database.
