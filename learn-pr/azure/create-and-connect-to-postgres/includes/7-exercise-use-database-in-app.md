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
   cat payment-app/data/users.csv
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
   psql --host=payment-server-demo.postgres.database.azure.com --port=5432 --username=paymentadmin@payment-server-demo.postgres.database.azure.com --dbname=postgres
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

\copy users from 'payment-app/data/users.csv' WITH CSV;
SELECT count(*) from users;

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
       --resource-group postgres \
       --location centralus \
       --sku F1 \
       --name $WEBAPPNAME
   ```

When the web application has been deployed, the output will show an _App_url_ with the URL of the web site. **Open the URL in a new tab**.

> [!NOTE]
> If you select the URL directly from the Azure Cloud Shell, there may be an extra `"` on the end of the URL, causing the website to not connect. \*\*If you remove the `"` from the end of the URL, you will connect to the website.

## Add code to the web app to retrieve data

Now let's add to the application the code to retrieve course data from the database.

8.  In Cloud Shell, go to the **payment-app/Models** folder.

    ```bash
    cd ~/payment-app/Models
    ```

    This folder contains two files, **Users.cs** and **DataAccessController.cs**.

9.  Use the code editor to open the **DataAccessController.cs** file.

        ```bash
        code DataAccessController.cs
        ```

        This file contains an empty class that's named `DataAccessController`.

        ```C#
        using Microsoft.Extensions.Options;
        using System;
        using System.Collections.Generic;
        using System.Data;
        using System.Data.SqlClient;
        using System.Linq;
        using System.Threading.Tasks;

        namespace PaymentWebApp.Models
        {
            public class DataAccessController
            {
                // TODO: Add your connection string in the following statements
                private string connectionString = "<Azure Database for PostgreSQL Connection String>";

                // Retrieve all details of courses and their modules
                public IEnumerable<CoursesAndModules> GetAllCoursesAndModules()
                {
                    List<CoursesAndModules> courseList = new List<CoursesAndModules>();

                    // TODO: Connect to the database
                    //using ()
                    {
                        // TODO: Specify the SQL query to run

                        // TODO: Execute the query

                        // TODO: Read the data a row at a time

                        // TODO: Close the database connection
                    }
                    return courseList;
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

10. Leave the code editor open, and switch to the Azure portal.

    > [!div class="nextstepaction"] > [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

11. In the Azure portal menu, select **payment-server-demo**.

12. Under **Settings**, select **Connection strings**. Copy the **ADO.NET** connection string to the clipboard.

    ![The connection string pane in the Azure portal.](../media/5-connection-string-annotated.png)

13. Return to the code editor. Replace the value of the _connectionString_ variable with the value from the clipboard. In the connection string, replace the text `{your_password}` with the password for the database.

The payment string read:

    ```C#
    private string connectionString = "Server=payment-server-demo.postgres.database.azure.com;Database=paymentapp;Port=5432;User Id=paymentadmin@payment-server-demo;Password={your_password};Ssl Mode=Require;";
    ```

14. After the comment `//TODO: Connect to the database`, replace the commented-out `using` statement with the following code.

    ```C#
            using (var conn = new NpgsqlConnection(connectionString))
    ```

    This code creates a new `NpgsqlConnection` object that connects to the database, using your connection string.

15. Replace the comment `// TODO: Specify the SQL query to run` with the following statements.

    ```C#
                Console.Out.WriteLine("Opening connection");
                conn.Open();
                using (var command = new NpgsqlCommand("SELECT * FROM users", conn))
    ```

    The `SqlCommand` object contains an SQL statement that retrieves the data for all courses and modules. It joins them by using the information in the **StudyPlan** table.

16. Replace the comment `// TODO: Execute the query` with the following code.

    ```C#
    con.Open();
                    var reader = command.ExecuteReader();
    ```

    These statements open the connection to the database and run the SQL statement. You can use the `SqlDataReader` object to fetch the results one row at a time.

17. Replace the comment `// TODO: Read the data a row at a time` with the following block of code.

    ```C#
    while (rdr.Read())
                    while (reader.Read())
                    {
                        string userID = reader.GetInt32(0).ToString();
                        string userName = reader.GetString(1);
                        int moduleSequence = reader.GetInt32(2);
                        Users user = new Users(userID, userName, moduleSequence);
                        userList.Add(user);
                    }
    ```

    This block iterates through the rows that are returned in the `SqlDataReader` object. The code extracts the data in the fields in each row and uses them to populate a new `Users` object. This object is then added to a list.

18. Replace the comment `// TODO: Close the database connection` with the following statement.

    ```C#
    conn.Close();
    ```

    This statement closes the connection to the database and releases any resources that were held.

19. The completed class should contain the following code, which includes the connection string for your database.

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
// Add your connection string in the following statements
string connectionString = "Server=payment-server-demo.postgres.database.azure.com;Database=paymentapp;Port=5432;User Id=paymentadmin@payment-server-demo;Password=<password>;Ssl Mode=Require;";

        // Retrieve all details of courses and their modules
        public IEnumerable<Users> GetAllUsers()
        {
            List<Users> userList = new List<Users>();

            // Connect to the database
            using (var conn = new NpgsqlConnection(connectionString))

            {
                Console.Out.WriteLine("Opening connection");
                conn.Open();
                using (var command = new NpgsqlCommand("SELECT * FROM users", conn))
                {
                    var reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        string userID = reader.GetInt32(0).ToString();
                        string userName = reader.GetString(1);
                        int moduleSequence = reader.GetInt32(2);
                        Users user = new Users(userID, userName, moduleSequence);
                        userList.Add(user);
                    }
                }
                conn.Close();
            }
            return userList;
        }
    }

}

````

    Save the file, and close the **Code** editor.

## Add code to the web app to display the data

The application can now retrieve the course data. Now, update the app to display the data to the user.

1. In Cloud Shell, move to the **payment-app/Pages** folder.

   ```bash
   cd ~/payment-app/Pages
````

This folder contains the .cshtml pages and code files that the web app uses to display information.

1. Use the code editor to open the incomplete file **Index.cshtml**.

   ```bash
   code Index.cshtml
   ```

   This file contains the display logic for the webpage page. Our data is delivered by the `CoursesAndModulesModel` - It will return a list, containing the User information.

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
               <!-- TODO: Display the data from the CoursesAndModules collection -->
           </tbody>
       </table>
   </div>
   ```

1. Replace the comment `<!-- TODO: Display the data from the CoursesAndModules collection --\>` with the following foreach loop.

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

   This code iterates through the list of User object, and outputs the data in each field.

1. The completed **Index.cshtml** file should contain the following code.

   ```cshtml
   @page
   @model UsersModel
   @{
    ViewData["Title"] = "Home page";
   }
   ```

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

3. After the new web app is deployed, select the link for the app. It should now display a list of courses and modules with the data that's stored in the database.

   :::image type="content" source="../media/5-web-app-with-data.png" alt-text="Screenshot of the education web app running, showing the data." loc-scope="other":::

---

There are various ways to connect to databases within the Azure SQL Database service from an application. For .NET apps, you can use the System.Data.SqlClient library.

The web app for the university must fetch and display the data that you uploaded to your SQL database. In this unit, you will learn how to connect to a database from a web app and use the System.Data.SqlClient library to process data.

Using the Azure portal, you can deploy an Python [Django](https://www.djangoproject.com/) web app to [Azure App Service](/azure/app-service/overview#app-service-on-linux) and connect it to an [Azure Database for PostgreSQL](/azure/postgresql/) database. You can start with a free pricing tier that can be scaled up at any later time.

The web app code in this case comes from a GitHub repository, and you configure the web app for continuous deployment from GitHub. Once configured, you can do further development on your local computer and commit changes to the repository. The web app on Azure then deploys those changes automatically.

## Fork the sample repository

1. In a browser, navigate to [https://github.com/Azure-Samples/djangoapp](https://github.com/Azure-Samples/djangoapp) and fork the repository into your own GitHub account.

You create a fork of this repository so you can make changes and redeploy the code in a later step.

- Production settings are in the _azuresite/production.py_ file. Development details are in _azuresite/settings.py_.

## Provision the web app in Azure

2. Open the portal

   > [!div class="nextstepaction"] > [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

3. Select **Create a resource**, which opens the **New** page.

4. Search for and select **Web App**.

5. On the **Create Web App** page, enter the following information:

   | Field          | Value                                                                                                                                                                                                                                                                          |
   | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
   | Subscription   | Select the subscription you want to use if different from the default.                                                                                                                                                                                                         |
   | Resource group | Select **Create new** and enter "DjangoPostgres-Tutorial-rg".                                                                                                                                                                                                                  |
   | App name       | A name for your web app that's unique across all Azure (the app's URL is `https://<app-name>.azurewebsites.net`). Allowed characters are `A`-`Z`, `0`-`9`, and `-`. A good pattern is to use a combination of your company name and an app identifier.                         |
   | Publish        | Select **Code**.                                                                                                                                                                                                                                                               |
   | Runtime stack  | Select **Python 3.8** from the drop-down list.                                                                                                                                                                                                                                 |
   | Region         | Select a location near you.                                                                                                                                                                                                                                                    |
   | Linux Plan     | The portal will populate this field with an App Service Plan name based on your resource group. If you want to change the name, select **Create new**.                                                                                                                         |
   | Sku and size   | For best performance, use the default plan, although it incurs charges in your subscription. To avoid charges, select **Change size**, then select **Dev/Test**, select **B1** (free for 30 days), then select **Apply**. You can scale the plan later for better performance. |

6. Select **Review + Create**, then select **Create**. Azure takes a few minutes to provision the web app.

7. After provisioning is complete, select **Go to resource** to open the overview page for the web app. Keep this browser window or tab open for later steps.

## Create the pollsdb database on the PostgreSQL server

In this section, you connect to the database server in the Azure Cloud Shell and use a PostgreSQL command to create a "pollsdb" database on the server. This database is expected by the sample app code.

1. From the overview page for the PostgreSQL server, select select **Connection security** (under **Settings** on the left side).

   ![Portal connection security page for firewall rules](../media/server-firewall-rules.png)

1. Select the button labeled **Add 0.0.0.0 - 255.255.255.255**, then select **Continue** in the pop up message that appears, followed by **Save** at the top of the page. These actions add a rule that allows you to connect to the database server from the Cloud Shell as well as SSH (as you do in a later section to run Django data model migrations).

1. Open the Azure Cloud Shell from the Azure portal by selecting the Cloud Shell icon at the top of the window:

   ![Cloud Shell button on the Azure portal toolbar](..media/portal-launch-icon.png)

1. In the Cloud Shell, run the following command:

   ```psql
   psql --host=payment-server-demo.postgres.database.azure.com --port=5432 --username=paymentadmin@payment-server-demo.postgres.database.azure.com --dbname=postgres
   ```

   Enter your administrator password when prompted.

1. When the shell connects successfully, you should see the prompt `postgres=>`. This prompt indicates that you're connected to the default administrative database named "postgres". (The "postgres" database isn't intended for app usage.)

## Connect the database

In this section, you create settings for the web app that it needs to connect to the `pollsdb` database. These settings appear to the app code as environment variables.

1. Switch back to the browser tab or window for the web app you created in a previous section.

1. Select **Configuration** (under **Settings** on the left side), then select **Application settings** at the top of the page.

   ![Portal settings configuration for web apps](../media/web-app-settings.png)

1. Use the **New application setting** button to create settings for each of the following values (which are expected by the djangoapp sample):

   | Setting name | Value                                                                                                                                                                                                                                            |
   | ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
   | DBHOST       | The name of the database server from the previous section; that is, the `<server-name>` portion of the server's URL that precedes `.postgres.database.azure.com`. (The code in _azuresite/production.py_ constructs the full URL automatically.) |
   | DBNAME       | `pollsdb`                                                                                                                                                                                                                                        |
   | DBUSER       | The administrator user name used when you provisioned the database. (The sample code automatically adds the `@<server-name>` portion; see _azuresite/production.py_.)                                                                            |
   | DBPASS       | The administrator password you created earlier.                                                                                                                                                                                                  |

   As noted earlier, you should not use the `$` character in the username or password because that character is escaped within environment variables on the Linux container that hosts Python apps.

1. Select **Save** and then **Continue** to apply the settings.

   > [!IMPORTANT]
   > Selecting **Save** after making changes to settings is essential. Any settings you create with the **New application setting** button aren't applied until you use **Save**.

## Deploy app code to the web app from a repository

With the database and connection settings in place, you can now configure the web app to deploy code directly from a GitHub repository.

1. In the browser window or tab for the web app, select **Deployment Center** (under **Deployment** on the left side).

1. In the **Source Control** step, select **GitHub** and then **Authorize** (if necessary). Then follow the sign-in prompts or select **Continue** to use your current GitHub login.

1. In the **Build Provider** step, select **App Service build service**, then select **Continue**.

1. In the **Configure** step, select the following values:

   | Field        | Value                                                         |
   | ------------ | ------------------------------------------------------------- |
   | Organization | The GitHub account to which you forked the sample repository. |
   | Repository   | djangoapp                                                     |
   | Branch       | master                                                        |

1. Select **Continue** to select the repository, then select **Finish**. Azure should deploy the code within a few seconds and start the app.

## Run Django database migrations

With the code deployed and the database in place, the app is almost ready to use. The only piece that remains is to establish the necessary schema in the database itself. You do this by "migrating" the data models in the Django app to the database.

1. In the browser window or tab for the web app, select **SSH** (under **Development Tools** on the left side), and then **Go** to open an SSH console on the web app server. It may take a minute to connect for the first time as the web app container needs to start.

1. In the console, change into the web app's folder:

   ```bash
   cd site/wwwroot
   ```

1. Activate the container's virtual environment:

   ```bash
   source /antenv/bin/activate
   ```

1. Install Python packages:

   ```bash
   pip install -r requirements.txt
   ```

1. Run database migrations:

   ```bash
   python manage.py migrate
   ```

1. Create an administrator login for the app:

   ```bash
   python manage.py createsuperuser
   ```

   The `createsuperuser` command prompts you for Django superuser (or admin) credentials, which are used within the web app. For the purposes of this tutorial, use the default username `root`, press **Enter** for the email address to leave it blank, and enter `Pollsdb1` for the password.

### Create a poll question in the app

You're now ready to run a quick test of the app to demonstrate that it is working with the PostgreSQL database.

1. In the browser window or tab for the web app, return to the **Overview** page, then select the **URL** for the web app (of the form `http://<app-name>.azurewebsites.net`).

1. The app should display the message "No polls are available" because there are no specific polls yet in the database.

1. Browse to `http://<app-name>.azurewebsites.net/admin` (the "Django Administration" page) and sign in using the superuser credentials from the previous section (`root` and `Pollsdb1`).

1. Under **Polls**, select **Add** next to **Questions** and create a poll question with some choices.

1. Browse again to `http://<app-name>.azurewebsites.net/` to confirm that the questions are now presented to the user. Answer questions however you like to generate some data in the database.

**Congratulations!** You're running a Python Django web app in Azure App Service for Linux, with an active PostgreSQL database.

## Update the app and redeploy

As described earlier in this tutorial, Azure redeploys your app code whenever you commit changes to the GitHub repository.

If you change the Django app's data models, however, you must migrate those changes to the database:

1. Connect to the web app again via SSH as described under [Run Django database migrations](#run-django-database-migrations).

1. Change into the app folder with `cd site/wwwroot`.

1. Activate the virtual environment with `source /antenv/bin/activate`.

1. Run the migrations again with `python manage.py migrate`.

## View diagnostic logs

You can access the console logs generated from inside the container that hosts the app on Azure.

On the web app's page in the Azure portal, select **Log stream** (under **Monitoring** on the left side). The logs appear as console output.

You can also inspect the log files from the browser at `https://<app-name>.scm.azurewebsites.net/api/logs/docker`.
