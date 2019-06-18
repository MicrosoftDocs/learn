You can use the types defined in the `System.Data.SqlClient` library to connect to Azure SQL Database from an application. This library provides methods for running queries and retrieving the results.

In this lab, you'll create a web application that the academic advisors for the educational institution can use to discuss courses and plans of study with students. The application will use the `System.Data.SqlClient` library to retrieve and display the details of courses, and the modules that a student must pass to complete a course.

To save time, you'll work with a pre-existing web application. You'll add the code that connects this application to your database.

## Deploy and run the pre-existing web application

[!include[](../../../includes/azure-sandbox-activate.md)]

1. If you haven't already done so, in the Cloud Shell window, run the following command to download the data files and application code for the educational institute system:

    <!-- TODO: Replace <location of repository> with the name of the repository containing the sample code in GitHub. The source code is currently supplied in the code folder for this module -->

    ```bash
    git clone http://github.com/<location of repository> education
    ```

2. Move to the **education** folder:

    ```bash
    cd ~/education
    ```

3. Run the following command to build and deploy the initial web app. Ignore any warnings that are displayed:

    ```bash
    bash setup.sh
    ```

4. When the web application has been deployed, the script finishes with the message **Web app deployed to https://educationapp\<*nnn*\>.azurewebsites.net/**. Click this link to display the web app in your browser:

    ![Screenshot of the education web app running. Currently, no data appears](../media/5-web-app-no-data.png)

    The intention is that the web application will display a list of courses and the modules that make up this course. Currently, the application doesn't retrieve or display this data.

## Add code to the web application to retrieve data

1. In the Cloud Shell, go to the **education/Models** folder:

    ```bash
    cd ~/education/Models
    ```

    This folder contains two files, **CoursesAndModules.cs** and **DataAccessController.cs**.

2. Open the **CoursesAndModules.cs** file using the **Code** editor:

    ```bash
    code CoursesAndModules.cs
    ```

    This file contains an empty class named **CoursesAndModules**:

    ```C#
    namespace CoursesWebApp.Models
    {
        public class CoursesAndModules
        {
            // TODO: Define the CourseName, ModuleTitle, and Sequence read-only properties

            // TODO: Create a constructor that initializes the fields behind the properties
        }
    }
    ```

3. Replace the comment **// TODO: Define the CourseName, ModuleTitle, and Sequence read-only properties** with the following code:

    ```C#
    public string CourseName { get; }
    public string ModuleTitle { get; }
    public int Sequence { get; }
    ```

    This code defines a set of read-only fields that will contain the data for each row displayed by the web application.

4. Replace the comment **// TODO: Create a constructor that initializes the fields behind the properties** with the following constructor:

    ```C#
    public CoursesAndModules(string courseName, string moduleTitle, int sequence)
    {
        this.CourseName = courseName;
        this.ModuleTitle = moduleTitle;
        this.Sequence = sequence;
    }
    ```

    This constructor populates the fields with the data to be displayed. The complete file should look like this:

    ```C#
    namespace CoursesWebApp.Models
    {
        public class CoursesAndModules
        {
            public string CourseName { get; }
            public string ModuleTitle { get; }
            public int Sequence { get; }

            public CoursesAndModules(string courseName, string moduleTitle, int sequence)
            {
                this.CourseName = courseName;
                this.ModuleTitle = moduleTitle;
                this.Sequence = sequence;
            }
        }
    }
    ```

5. Save the file, and close the **Code** editor.

6. Open the **DataAccessController.cs** file using the **Code** editor:

    ```bash
    code DataAccessController.cs
    ```

    This file contains a class named **DataAccessController**:

    ```C#
    using Microsoft.Extensions.Options;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;
    using System.Linq;
    using System.Threading.Tasks;

    namespace CoursesWebApp.Models
    {
        public class DataAccessController
        {
            // TODO: Add your connection string in the following statements
            private string connectionString = "<Azure SQL Database Connection String>";

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

    This class will contain the data access logic for connecting to the database and retrieving the course and module data. It will populate a list of **CoursesAndModules** objects with this data.

7. Leave the **Code** editor open, and switch to the Azure portal. In the left-hand pane, click **SQL databases**, and select your database. 

8. Under **Settings**, click **Connection strings**. Copy the ADO.NET connection string to the clipboard:

    ![Screenshot of the connection string pane in the Azure portal.](../media/5-connection-string-annotated.png)

9. Return to the code editor, and replace the value of the connectionString variable with the value from the clipboard. In the connection string, replace the text `{your_username}` with the value `azuresql`, and replace the text `{your_password}` with the password for this account.

    ```C#
    private string connectionString = "Server=tcp:courseservernnn.database.windows.net,1433;Initial Catalog=coursedatabasennn;Persist Security Info=False;User ID=azuresql;Password=<password>;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";
    ```

10. After the comment **//TDO: Connect to the database**, replace the commented out **using** statement with the following code:

    ```C#
    using (SqlConnection con = new SqlConnection(connectionString))
    ```

    This code creates a new **SqlConnection** object that connects to the database using your connection string.

11. Replace the comment **// TODO: Specify the SQL query to run** with the following statements:

    ```C#
    SqlCommand cmd = new SqlCommand(
        @"SELECT c.CourseName, m.ModuleTitle, s.ModuleSequence
        FROM dbo.Courses c JOIN dbo.StudyPlans s
        ON c.CourseID = s.CourseID
        JOIN dbo.Modules m
        ON m.ModuleCode = s.ModuleCode
        ORDER BY c.CourseName, s.ModuleSequence", con);
    cmd.CommandType = CommandType.Text;
    ```

    The **SqlCommand** object contains an SQL statement that retrieves the data for all courses and modules, joining them using the information in the **StudyPlan** table.

12. Replace the comment **// TODO: Execute the query** with the following code:

    ```C#
    con.Open();
    SqlDataReader rdr = cmd.ExecuteReader();
    ```

    These statements open the connection to the database and run the SQL statement. You can use the **SqlDataReader** object to fetch the results a row at a time.

13. Replace the comment **// TODO: Read the data a row at a time** with the following block of code:

    ```C#
    while (rdr.Read())
    {
        string courseName = rdr["CourseName"].ToString();
        string moduleTitle = rdr["ModuleTitle"].ToString();
        int moduleSequence = Convert.ToInt32(rdr["ModuleSequence"]);
        CoursesAndModules course = new CoursesAndModules(courseName, moduleTitle, moduleSequence);
        courseList.Add(course);
    }
    ```

    This block iterates through the rows returned in the **SqlDataReader** object. The code extracts the data in the fields in each row and uses them to populate a new **CoursesAndModules** object. This object is then added to a list.

14. Replace the comment **// TODO: Close the database connection** with the following statement:

    ```C#
    con.Close();
    ```

    This statement closes the connection to the database and releases and resources held.

15. The completed class should look like this:

    ```C#
    using Microsoft.Extensions.Options;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;
    using System.Linq;
    using System.Threading.Tasks;

    namespace CoursesWebApp.Models
    {
        public class DataAccessController
        {
            // Add your connection string in the following statements
            private string connectionString = "Server=tcp:courseserver101.database.windows.net,1433;Initial Catalog=coursedatabase101;Persist Security Info=False;User ID=azuresql;Password=Pa55w.rd;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";

            // Retrieve all details of courses and their modules    
            public IEnumerable<CoursesAndModules> GetAllCoursesAndModules()
            {
                List<CoursesAndModules> courseList = new List<CoursesAndModules>();

                // Connect to the database
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    // Specify the SQL query to run
                    SqlCommand cmd = new SqlCommand(
                        @"SELECT c.CourseName, m.ModuleTitle, s.ModuleSequence
                        FROM dbo.Courses c JOIN dbo.StudyPlans s
                        ON c.CourseID = s.CourseID
                        JOIN dbo.Modules m
                        ON m.ModuleCode = s.ModuleCode
                        ORDER BY c.CourseName, s.ModuleSequence", con);
                    cmd.CommandType = CommandType.Text;

                    // Execute the query
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();

                    // Read the data a row at a time
                    while (rdr.Read())
                    {
                        string courseName = rdr["CourseName"].ToString();
                        string moduleTitle = rdr["ModuleTitle"].ToString();
                        int moduleSequence = Convert.ToInt32(rdr["ModuleSequence"]);
                        CoursesAndModules course = new CoursesAndModules(courseName, moduleTitle, moduleSequence);
                        courseList.Add(course);
                    }

                    // Close the database connection
                    con.Close();
                }
                return courseList;
            }
        }
    }
    ```

    Save the file, and close the **Code** editor.

## Add code to the web application to display the data

1. In the Cloud Shell, move to the **education/Pages** folder:

    ```bash
    cd ~/education/Pages**
    ```

    This folder contains the .cshtml pages and code files that the web application uses to display information.

2. Using the **Code** editor, open the **Index.cshtml.cs** file. It should look like this:

    ```C#
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using CoursesWebApp.Models;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.RazorPages;

    namespace CoursesWebApp.Pages
    {
        public class CoursesAndModulesModel : PageModel
        {
            // TODO: Create a DataAccessController object

            // TODO: Create a collection for holding CoursesAndModules object

            public void OnGet()
            {
                // TODO: Retrieve the data using the DataAccessController object and populate the CoursesAndModules object
            }
        }
    }
    ```

    This file contains code that the **Index** page runs when it's displayed. The code defines a class named **CoursesAndModulesModel**. The **Index** page will display the details of courses and modules using this model. In this file, you need to add the code that uses a **DataAccessController** object to fetch this data.

3. Replace the comment **// TODO: Create a DataAccessController object** with the following statement:

    ```C#
    DataAccessController dac = new DataAccessController();
    ```

    This statement creates a new **DataAccessController** object.

4. Replace the comment **// TODO: Create a collection for holding CoursesAndModules object** with the following statement:

    ```C#
    public List<CoursesAndModules> CoursesAndModules;
    ```

5. In the **OnGet** method, replace the comment **// TODO: Retrieve the data using the DataAccessController object and populate the CoursesAndModules object** with the following statement:

    ```C#
    CoursesAndModules = dac.GetAllCoursesAndModules().ToList();
    ```

    This statement uses the **DataAcessController** object to populate the list with the data from the database.

6. The completed file should look like this:

    ```C#
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using CoursesWebApp.Models;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.RazorPages;

    namespace CoursesWebApp.Pages
    {
        public class CoursesAndModulesModel : PageModel
        {
            // Create a DataAccessController object
            DataAccessController dac = new DataAccessController();

            // Create a collection for holding CoursesAndModules object
            public List<CoursesAndModules> CoursesAndModules;

            public void OnGet()
            {
                // Retrieve the data using the DataAccessController object and populate the CoursesAndModules object
                CoursesAndModules = dac.GetAllCoursesAndModules().ToList();
            }
        }
    }
    ```

    Save the file and close the **Code** editor**

7. Open the file **Index.cshtml** using the **Code** editor:

    ```bash
    code Index.cshtml
    ```

    This file contains the display logic for the Index page. It specifies **CoursesAndModulesModel** as the data source. The code you've added creates and populates this model.

    The page uses an HTML data to display the data from the model. Currently, the page just displays the table headings, but the table body is empty:

    ```cshtml
    <h2>Courses and Modules</h2>
    <div>
        <table class="table">
            <thead>
                <tr>
                    <th>
                        Course Name
                    </th>
                    <th>
                        Modules
                    </th>
                    <th>
                        Sequence
                    </th>
                </tr>
            </thead>
            <tbody>
                <!-- TODO: Display the data from the CoursesAndModules collection -->
            </tbody>
        </table>
    </div>
    ```

8. Replace the comment **\<!-- TODO: Display the data from the CoursesAndModules collection --\>** with the following markup:

    ```cshtml
    @foreach(var courseAndModule in Model.CoursesAndModules)
    {
    <tr>
        <td>
            @Html.DisplayFor(courseName => courseAndModule.CourseName)
        </td>
        <td>
            @Html.DisplayFor(moduleTitle => courseAndModule.ModuleTitle)
        </td>
        <td>
            @Html.DisplayFor(sequence => courseAndModule.Sequence)
        </td>
    </tr>
    }
    ```

    This code iterates through the rows in the model, and outputs the data in each field.

9. The completed file should look like this:

    ```cshtml
    @page
    @model CoursesAndModulesModel
    @{
        ViewData["Title"] = "Home page";
    }

    <h2>Courses and Modules</h2>
    <div>
        <table class="table">
            <thead>
                <tr>
                    <th>
                        Course Name
                    </th>
                    <th>
                        Modules
                    </th>
                    <th>
                        Sequence
                    </th>
                </tr>
            </thead>
            <tbody>
                @foreach(var courseAndModule in Model.CoursesAndModules)
                {
                <tr>
                    <td>
                        @Html.DisplayFor(courseName => courseAndModule.CourseName)
                    </td>
                    <td>
                        @Html.DisplayFor(moduleTitle => courseAndModule.ModuleTitle)
                    </td>
                    <td>
                        @Html.DisplayFor(sequence => courseAndModule.Sequence)
                    </td>
                </tr>
                }
            </tbody>
        </table>
    </div>
    ```

    Save the file and close the **Code** editor.

## Deploy and test the updated web application

1. In the Cloud Shell, return to the **education** folder:

    ```bash
    cd ~/education
    ```

2. Run the following commands to commit your changes, and build and deploy the updated web application. Note that the script creates a new web application, leaving the existing web application in place for comparison purposes:

    ```bash
    git commit -m "Added SQL Server Code" -a
    bash setup.sh
    ```

3. When the web application has been deployed, click the link for the new web app. The web application should now display a list of courses and modules using the data stored in the database:

    ![Screenshot of the education web app running, showing the data](../media/5-web-app-with-data.png)
