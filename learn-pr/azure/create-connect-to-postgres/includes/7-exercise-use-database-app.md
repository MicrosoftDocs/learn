Set up an ASP.NET app to connect and query the `paymentapp` PostgreSQL database. Run queries using low-level code to understand the process well. PostgreSQL can also be connected to objects that support higher-level logic, such as the .NET Entity Framework.

In this exercise:

* Preview the user data
* Connect to the `paymentapp` database
* Load user data into the `payment_users` table
* Deploy an ASP.NET webapp to Azure
* Configure the webapp to connect and query the database
* Redeploy the webapp with the updated code

## Download the data and webapp

1. If your [Azure Cloud Shell](https://shell.azure.com/) is still connected to the database, exit with `\q`.

1. In the [Cloud Shell](https://shell.azure.com/) window, run the following command to download the data files and application code.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-create-connect-postgresql.git payment-app
    ```

1. Run these commands to move the sample data to its own folder and list the files in the folder.

    ```bash
    mv ~/payment-app/data ~/paymentdata
    cd ~/paymentdata
    ls
    ```

    This folder contains one file: *users.csv*.

1. View the contents of the *users.csv* file.

    ```bash
    cat users.csv
    ```

    This file contains the following comma-separated data. It includes a `user_id`, `user_name`, and `age_in_years` for each user.

## Load the CSV data into the payment_users table

Connect to the database again, and load the CSV data into the database.

1. Run the following command to connect to the `payment-server-demo` server.

    ```psql
    psql --host=$SERVERNAME.postgres.database.azure.com --port=5432 --username=paymentadmin@$SERVERNAME.postgres.database.azure.com --dbname=postgres
    ```

1. Enter your password, and press **Enter**.

1. At the prompt, connect directly to the `paymentapp` database by using the `\c` command:

    ```sql
    \c paymentapp
    ```

1. Next, load the data from the CSV files into the `payment_users` table.

    ```sql
    SELECT count(*) from payment_users;
    SET CLIENT_ENCODING TO 'utf8';

    \copy payment_users from 'users.csv' WITH CSV;
    SELECT * from payment_users;
    ```


    ```sql
    \q
    ```

## Deploy and connect an ASP.NET web app to your database

Now that you have more data to query, deploy the webapp, then connect it to the database.

1. In [Cloud Shell](https://shell.azure.com/), go to the **payment-app** folder.

    ```bash
    cd ~/payment-app
    ```

1. Run the following commands to build and deploy the initial web app.

    ```bash
    WEBAPPNAME=payment-app-$RANDOM
    az webapp up \
        --resource-group "<rgn>[your resource group name]</rgn>" \
        --location centralus \
        --sku F1 \
        --name $WEBAPPNAME
        --os-type Linux
    ```

    For more information, see [az webapp up](/cli/azure/webapp#az-webapp-up).

1. When the webapp has been deployed, the output shows an *App_url* with the URL of the web site. Open the URL in a new tab.

    > [!NOTE]
    > If you select the URL directly from the [Azure Cloud Shell](https://shell.azure.com/), there might be an extra `"` on the end of the URL, causing the website to not connect. If necessary, remove the `"` from the end of the URL.

## Add code to the web app to query the paymentapp database

Now add to the application the code to retrieve user data from the database.

1. In [Cloud Shell](https://shell.azure.com/), go to the *payment-app/Models* folder.

    ```bash
    cd ~/payment-app/Models
    ```

   This folder contains two files: *Users.cs* and *DataAccessController.cs*.

1. Use the code editor to open the *DataAccessController.cs* file.

    ```bash
    code DataAccessController.cs
    ```

    This file contains an empty class that's named `DataAccessController`, with the following code.

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

                            // TODO: Run the query

                            // TODO: Read the data a row at a time

                        }
                        return userList;
                    }
                }
            }
    ```

    This class contains the logic to:

    * Connect the app to the database
    * Retrieve user data
    * Add each user's data to a `User` object
    * Populate a `list` with all of the `User` objects

    The data for each user is _userID_, _userName_, and _userAge_.

1. Leave the code editor open, and switch to the [Azure portal](https://portal.azure.com) in a new tab.

1. In the Azure portal menu, select your server, **payment-server-demo**.

1. Under **Settings**, select **Connection strings**. Copy the **ADO.NET** connection string to the clipboard.

1. Return to the code editor.

    * On line 14, replace the value of the string `connectionString` with the value from the clipboard.

    > [!NOTE]
    > Make sure you leave the quotation marks around your connection string.

    * In the connection string, replace the text:
        * `{your_password}` with the password for the database
        * `{your_database}` with `paymentapp`

    The payment string reads:

    ```C#
    private string connectionString = "Server=payment-server-demo.postgres.database.azure.com;Database=paymentapp;Port=5432;User Id=paymentadmin@payment-server-demo;Password={your_password};Ssl Mode=Require;";
    ```

    > [!NOTE]
    > This example includes the connection string in the source code to make this exercise easy and understandable. Best practice, however, is to keep your connection string in a configuration file.

1. After the comment `//TODO: Connect to the database`, replace the commented-out `//using ()` statement on line 22 with the following code.

    ```C#
    using (var conn = new NpgsqlConnection(connectionString))
    ```

    This code creates a new `NpgsqlConnection` object that connects to the database, using your connection string.

1. Replace the comment `// TODO: Specify the SQL query to run` on line 26 with the following statements.

    ```C#
    conn.Open();
    using (var command = new NpgsqlCommand("SELECT * FROM payment_users", conn))
                    {
    ```

    The `NpgsqlCommand` object contains an SQL statement that retrieves the data for all users.

1. Replace the comment `// TODO: Run the query` with the following code.

    ```C#
    var reader = command.ExecuteReader();
    ```

    These statements open the connection to the database and run the SQL statement. You can use the `SqlDataReader` object to fetch the results one row at a time.

1. Replace the comment `// TODO: Read the data a row at a time` on line 24 with the following block of code.

    ```C#
    while (reader.Read())
        {
            string userID = reader.GetInt32(0).ToString();
            string userName = reader.GetString(1);
            int userAge = reader.GetInt32(2);
            Users user = new Users(userID, userName, userAge);
            userList.Add(user);
        }
                    }
    ```

    This block iterates through the rows that are returned in the `SqlDataReader` object. The code extracts the data in the fields in each row and uses them to populate a new `Users` object. This object is then added to a list.

1. Save the file, and close the code editor.

The completed class should contain the following code, which includes the connection string for your database.

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
                    using (var command = new NpgsqlCommand("SELECT * FROM payment_users", conn))
                    {
                // TODO: Run the query
                        var reader = command.ExecuteReader();

                // TODO: Read the data a row at a time
                    while (reader.Read())
                        {
                            string userID = reader.GetInt32(0).ToString();
                            string userName = reader.GetString(1);
                            int userAge = reader.GetInt32(2);
                            Users user = new Users(userID, userName, userAge);
                            userList.Add(user);
                        }
                    }
                }
                return userList;
            }
        }

}
```

If your program doesn't properly query the user data, come back to this file and replace the entire contents with this code block. Use your connection string and password.

## Add code to the web app to display the data

The application can now retrieve the course data. Now, update the app to display the data to the user.

1. In [Cloud Shell](https://shell.azure.com/), move to the *payment-app/Pages* folder.

    ```bash
    cd ~/payment-app/Pages
    ```

    This folder contains the *.cshtml* pages and code files that the web app uses to display information.

1. Use the code editor to open the incomplete file *Index.cshtml*.

    ```bash
    code Index.cshtml
    ```

    This file contains the display logic for the webpage. The `UsersModel` delivers the data. It returns a list that contains the user information.

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

1. Replace the comment `<!-- TODO: Display the data from the Users collection --\>` with the following foreach loop.

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
                @Html.DisplayFor(userAge => user.UserAge)
            </td>
        </tr>
    }
    ```

    This code iterates through the list of User objects, and outputs the data in each field.

1. Save the file, and close the code editor.

The completed *Index.cshtml* file should contain the following code.

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

## Deploy and test the updated web app

With the application fully configured to retrieve and display the course data to the user, you can deploy the updated version.

1. In [Cloud Shell](https://shell.azure.com/), return to the *payment-app* folder.

    ```bash
    cd ~/payment-app
    ```

1. Run the following commands to build and deploy the updated web app.

    ```bash
    az webapp up \
        --resource-group "<rgn>[your resource group name]</rgn>" \
        --name $WEBAPPNAME
    ```

1. After the new web app is deployed, select the link for the app. It should now display a list of users with the data that's stored in the database.

[!INCLUDE [azure-exercise-subscription-cleanup](../../../includes/azure-exercise-subscription-cleanup.md)]

To delete a resource group, use [az group delete](/azure/azure-resource-manager/management/manage-resource-groups-cli).
