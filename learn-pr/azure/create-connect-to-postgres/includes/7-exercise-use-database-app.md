We want to set up an ASP.NET app to connect and query our `paymentapp` PostgreSQL database. We'll run our queries using low-level code, to understand the process well. PostgreSQL can also be connected to objects that support higher-level logic, such as the .NET Entity Framework.

In this exercise, we’ll:

* Preview our user data
* Connect to our `paymentapp` database
* Load user data into our `payment_users` table
* Deploy an ASP.NET webapp to Azure
* Configure the webapp to connect and query our database
* Redeploy the webapp with the updated code

## Download the data and webapp

If your Shell is still connected to the database, you can exit with `\q`

1. In the Azure Cloud Shell window on the right side of your screen, run the following command to download the data files and application code.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-create-connect-postgresql.git payment-app
    ```

2. Run these commands to move the sample data to its own folder and list the files in the folder.

    ```bash
    mv ~/payment-app/data ~/paymentdata
    cd ~/paymentdata
    ls
    ```

    This folder contains one file: **users.csv**.

3. We're going to load more user data. Let's view the contents of the **users.csv** file.

    ```bash
    cat users.csv
    ```

    This file contains the following comma-separated data. It includes a user_id, user_name, age_in_years for each user that we're going to load into the database.

## Load the CSV data into the payment_users table

Let's connect to our database again, and load the CSV data into the database.

1. Run the following command to connect to the `payment-server-demo` server.

    ```psql
    psql --host=$SERVERNAME.postgres.database.azure.com --port=5432 --username=paymentadmin@$SERVERNAME.postgres.database.azure.com --dbname=postgres
    ```

    Enter your password, and press <kbd>Enter</kbd>.

2. At the prompt, we'll connect directly to the **paymentapp** database by executing the `\c` command:

    ```sql
    \c paymentapp
    ```

3. Next, load the data from the CSV files into the `payment_users` table.

    ```sql
    SELECT count(*) from payment_users;
    SET CLIENT_ENCODING TO 'utf8';

    \copy payment_users from 'users.csv' WITH CSV;
    SELECT * from payment_users;
    ```

4. Exit from the database and return to the Azure Cloud Shell.

    ```sql
    \q
    ```

## Deploy and connect an ASP.NET web app to your database

Now we have more data to query, we'll deploy our webapp, then connect it to our database.

1. In Cloud Shell, go to the **payment-app** folder.

    ```bash
    cd ~/payment-app
    ```

2. Run the following commands to build and deploy the initial web app.

    ```bash
    WEBAPPNAME=payment-app-$RANDOM
    az webapp up \
        --resource-group "<rgn>[Sandbox resource group name]</rgn>" \
        --location centralus \
        --sku F1 \
        --name $WEBAPPNAME
    ```

    When the webapp has been deployed, the output will show an *App_url* with the URL of the web site. Open the URL in a new tab.

    > [!NOTE]
    > If you select the URL directly from the Azure Cloud Shell, there may be an extra `"` on the end of the URL, causing the website to not connect. If you remove the `"` from the end of the URL, you will connect to the website.

## Add code to the web app to query the paymentapp database

Now let's add to the application the code to retrieve user data from the database.

1. In Cloud Shell, go to the **payment-app/Models** folder.

    ```bash
    cd ~/payment-app/Models
    ```

    This folder contains two files, **Users.cs** and **DataAccessController.cs**.

2. Use the code editor to open the **DataAccessController.cs** file.

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

                            // TODO: Execute the query

                            // TODO: Read the data a row at a time

                        }
                        return userList;
                    }
                }
            }
    ```

    This class will contain the logic to:

    * Connect the app to the database
    * Retrieve user data
    * Add each users data to a `User` object
    * Populate a **list** with all of the `User` objects

    The data for each user will be _userID_, _userName_, and _userAge_.

3. Leave the code editor open, and switch to the Azure portal in a new tab.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

4. In the Azure portal menu, select **payment-server-demo**.

5. Under **Settings**, select **Connection strings**. Copy the **ADO.NET** connection string to the clipboard.

6. Return to the code editor.

    * **On line 14**, Replace the value of the string **_connectionString_** with the value from the clipboard.
        * Make sure you leave the quotation marks around your connection string.
    * In the connection string, **replace the text**:
        * **`{your_password}` with the password for the database**
        * **`{your_database}` with `paymentapp`**.

    The payment string will read:

    ```C#
    private string connectionString = "Server=payment-server-demo.postgres.database.azure.com;Database=paymentapp;Port=5432;User Id=paymentadmin@payment-server-demo;Password={your_password};Ssl Mode=Require;";
    ```

    > [!NOTE]
    > We are including the connection string in the source code to make this exercise easy and understandable. Best practice, however, is to keep your connection string in a configuration file.

7. After the comment `//TODO: Connect to the database`, replace the commented-out `//using ()` statement on line 22 with the following code.

    ```C#
    using (var conn = new NpgsqlConnection(connectionString))
    ```

    This code creates a new `NpgsqlConnection` object that connects to the database, using your connection string.

8. Replace the comment `// TODO: Specify the SQL query to run` on line 26 with the following statements.

    ```C#
    conn.Open();
    using (var command = new NpgsqlCommand("SELECT * FROM payment_users", conn))
                    {
    ```

    The `NpgsqlCommand` object contains an SQL statement that retrieves the data for all users.

9. Replace the comment `// TODO: Execute the query` with the following code.

    ```C#
    var reader = command.ExecuteReader();
    ```

    These statements open the connection to the database and run the SQL statement. You can use the `SqlDataReader` object to fetch the results one row at a time.

10. Replace the comment `// TODO: Read the data a row at a time` on line 24 with the following block of code.

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

11. The completed class should contain the following code, which includes the connection string for your database.

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
                    // TODO: Execute the query
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

    Later, if your program doesn't properly query the user data, come back to this file and replace the entire contents with the code block above, with your connection string and password, and save.

    Save the file, and close the **Code Editor**.

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

    This file contains the display logic for the webpage. Our data is delivered by the `UsersModel`. It will return a list, containing the user information.

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
                @Html.DisplayFor(userAge => user.UserAge)
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

    Save the file, and close the **Code Editor**.

## Deploy and test the updated web app

With the application fully configured to retrieve and display the course data to the user, you can deploy the updated version.

1. In Cloud Shell, return to the **payment-app** folder.

    ```bash
    cd ~/payment-app
    ```

2. Run the following commands to build and deploy the updated web app.

    ```bash
    az webapp up \
        --resource-group "<rgn>[Sandbox resource group name]</rgn>" \
        --name $WEBAPPNAME
    ```

3. After the new web app is deployed, select the link for the app. It should now display a list of users with the data that's stored in the database.
