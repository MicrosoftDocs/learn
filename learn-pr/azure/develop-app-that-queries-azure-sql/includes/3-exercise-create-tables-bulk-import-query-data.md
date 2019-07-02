The university currently stores their data in a series of comma-delimited files. You must migrate this data to Azure SQL Database.

In this exercise, you'll create a database server and a single database using the Azure SQL Database service. Next, you'll create tables and import data into the database. Finally, you'll query the data using the Query Editor and the **sqlcmd** utility.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Examine the existing comma-delimited data

1. In the Cloud Shell window on the right, run the following command to download the data files and application code for the university system.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-develop-app-that-queries-azure-sql education
    ```

1. Run these commands to change directory to the **education/data** folder and list the files in the folder.

    ```bash
    mv ~/education/data ~/educationdata
    cd ~/educationdata
    ls
    ```

    This folder contains three files; **courses.csv**, **modules.csv**, and **studyplans.csv**.

1. View the contents of the **courses.csv** file.

    ```bash
    cat courses.csv
    ```

    The file contains the following comma-separated data. The data comprises a course name and an ID for each course the university offers.

    ```text
    ID,Course
    1,Computer Science
    2,Maths with Computing
    3,Maths with Physics
    4,Computer Science with Physics
    5,Maths with Chemistry
    6,Physics with Chemistry
    7,Maths
    8,Physics
    9,Chemistry
    ```

1. View the contents of the **modules.csv** file.

    ```bash
    cat modules.csv
    ```

    This file lists the various modules that students can take to fulfill the requirements of the courses. Each module has an identifying code and a name.

    ```text
    Module Code,Title
    CS101,Introduction to Computer Science
    CS102,Java Programming
    CS103,Distributed Applications
    CS104,Cloud-based systems
    MA101,Foundations of Applied Maths
    MA102,Advanced Calculus
    MA103,Number Theory
    MA104,String Theory
    PH101,Foundations of Physics
    PH102,Basic Experimental Phyics
    PH103,Basic Theoretical Physics
    PH104,Subatomic Physics
    CH101,Elements of Chemistry
    CH102,Basic Inorganic Chemistry
    CH103,Basic Organic Chemistry
    CH104,Chemical Engineering
    ```

1. View the contents of the **studyplans.csv** file.

    ```bash
    cat studyplans.csv
    ```

    This file contains the data that specifies which modules a student must pass to complete a course successfully. The **Sequence** column specifies the order in which the student should take each module. For example, for course 1 (Computer Science) the student should take module CS101 before taking module MA101. Part of the data is shown below.

    ```text
    Course ID,Module Code,Sequence
    1,CS101,1
    1,MA101,2
    1,CS102,3
    1,CS103,4
    1,CS104,5
    2,MA101,1
    2,MA102,2
    2,CS101,3
    2,CS102,4
    2,CS103,5
    3,MA101,1
    3,MA102,2
    3,PH101,3
    3,PH102,4
    3,PH103,5
    ...
    ```

## Create a database server and database with the Azure SQL Database service

Let's create the database and server to store the data for the application.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the account you activated sandbox with.

1. In the left pane, click **+ Create a resource**, select **Databases**, and then click **SQL Database**.

    ![Screenshot of the New page in the Azure portal showing the Databases options available in the Azure Marketplace](../media/3-new-database-annotated.png)

1. On the **Create SQL Database** page, specify the values in the following table for the properties of the database.

    | Property  | Value  |
    |---|---|
    | Subscription | Concierge Subscription  |
    | Resource Group | <rgn>[Sandbox resource group]</rgn> |
    | Database name | The database must have a unique name. We suggest using something like **coursedatabase*nnn*** where *nnn* is a random number. |
    | Server | Click **Create new**, and enter the details shown in the table below |
    | Want to use SQL elastic pool? | No |
    | Compute + storage | General Purpose |

    For the server, specify the following details in the **New server** pane, and then click **Select**.

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

    | Property  | Value  |
    |---|---|
    | Server name | **courseserver*nnn***  (use the same number that you selected for the database) |
    | Server admin login | azuresql |
    | Password | Enter a password that meets the requirements |
    | Confirm password | Confirm your password |
    | Location | Accept the default location |
    | Allow Azure services to access server | Checked |

1. Click **Review + create**.

1. Click **Create**, and wait for the server and database to be created before continuing.

## Create the tables

With the database created, you can now create the tables that will store the data from the csv files.

1. In the left-hand pane of the Azure portal, click **SQL databases**.

1. On the **SQL databases** page, select **coursedatabase*nnn***.

1. On the **coursedatabase*nnn*** page, select **Query editor**.

    ![Screenshot of the database page in the Azure portal highlighting the Query editor option](../media/3-query-editor-annotated.png)

1. On the **coursedatabase*nnn* - Query editor** page, enter the following details, and then click **OK** to connect to database service.

    | Property  | Value  |
    |---|---|
    | Authorization type | SQL server authentication |
    | Login | azuresql |
    | Password | Specify the password you used when you created this user  |

1. In the **Query 1** pane, enter the following SQL statement, and then click **Run**. This statement creates a new table for holding course information. Verify that the statement runs without any errors.

    ```SQL
    CREATE TABLE Courses
    (
        CourseID INT NOT NULL PRIMARY KEY,
        CourseName VARCHAR(50) NOT NULL
    )
    ```

    ![Screenshot of the Query editor window in the Azure portal. The user has entered a statement to create the Courses table](../media/3-create-table-courses-annotated.png)

1. Overwrite the existing statement with the following statement that creates a table for holding modules. Click **Run** and verify that the statement runs without any errors.

    ```SQL
    CREATE TABLE Modules
    (
        ModuleCode VARCHAR(5) NOT NULL PRIMARY KEY,
        ModuleTitle VARCHAR(50) NOT NULL
    )
    ```

1. Change the statement to create another table named **StudyPlans**, and then click **Run**.

    ```SQL
    CREATE TABLE StudyPlans
    (
        CourseID INT NOT NULL,
        ModuleCode VARCHAR(5) NOT NULL,
        ModuleSequence INT NOT NULL,
        PRIMARY KEY(CourseID, ModuleCode)
    )
    ```

1. In the database window, click the **Refresh** button in the toolbar. Then expand **Tables**, and expand each table in turn. You should see the three tables, **dbo.Courses**, **dbo.Modules**, and **dbo.StudyPlans**, together with the columns and primary key for each table.

    > [!NOTE]
    > *dbo* stands for *database owner*, and is the default schema in the database. All three tables were created in this schema.

    ![Screenshot of the database window in the Azure portal, showing the tables and columns](../media/3-tables-and-columns-annotated.png)

## Import the data

1. Return to the Cloud Shell window and make sure you are in the **education/data** folder.

    ```bash
    cd ~/education/data
    ```

1. Run the **bcp** utility to create a format file from the schema of the **courses** table in the database. The format file specifies that the data will be in character format (`-c`), and separated by commas (`-t,`). Replace `<nnn>` with the number that you used for your database and server, and use the password you specified for the **azuresql** user.

    ```bash
    bcp "coursedatabase<nnn>.dbo.courses" format nul -c -f courses.fmt -t, -S "courseserver<nnn>.database.windows.net" -U azuresql -P <password>
    ```

1. Open the format file, **courses.fmt** that was generated by the previous command, with the Code editor.

    ```bash
    code courses.fmt
    ```

    The file should look like this:

    ```text
    14.0
    2
    1       SQLCHAR             0       12      ","    1     CourseID                                     ""
    2       SQLCHAR             0       50      "\n"   2     CourseName                                   SQL_Latin1_General_CP1_CI_AS
    ```

1. Review the file. Note that the data in the first column in the comma-separated file will go into the CourseID column in the Courses table, and the second field will go into the CourseName column. The second column is character based, and has a collation associated with it. Additionally, the fields separator between the fields in the file is expected to be a comma, and the row terminator (after the second field) should be a new line character. In a real-world scenario, your data might not be organized as neatly as this, with different field separators and the fields in a different order from the columns. In this situation, you can edit the format file to change these items on a field by field basis. Close the editor by pressing `Ctrl-q`.

1. Run the following command to import the data in the **courses.csv** file using format specified in the amended **courses.fmt** file. The `-F 2` flag causes the bcp to start importing data from line 2 in the data file; the first line contains headers. Replace `<password>` with the password for the **azuresql** user.

    ```bash
    bcp "coursedatabase<nnn>.dbo.courses" in courses.csv -f courses.fmt -S "courseserver<nnn>.database.windows.net" -U azuresql -P <password> -F 2
    ```

    Verify that bcp imports nine rows, and doesn't report any errors.

1. Perform the following sequence of operations to import the data for the **dbo.Modules** table from the **modules.csv** file. Replace `<password>` with the password for the **azuresql** user.

    1. Generate a format file.

        ```bash
        bcp "coursedatabase<nnn>.dbo.modules" format nul -c -f modules.fmt -t, -S "courseserver<nnn>.database.windows.net" -U azuresql -P <password>
        ```

    1. Import the data from the **modules.csv** file into the **Modules** table in the database. Replace `<password>` with the password for the **azuresql** user.

        ```bash
        bcp "coursedatabase<nnn>.dbo.modules" in modules.csv -f modules.fmt -S "courseserver<nnn>.database.windows.net" -U azuresql -P <password> -F 2
        ```

        Verify that this command imports 16 rows.

1. Perform the following sequence of operations to import the data for the **dbo.StudyPlans** table from the **studyplans.csv** file. Replace `<password>` with the password for the **azuresql** user.

    1. Generate a format file.

        ```bash
        bcp "coursedatabase<nnn>.dbo.studyplans" format nul -c -f studyplans.fmt -t, -S "courseserver<nnn>.database.windows.net" -U azuresql -P <password>
        ```

    1. Import the data from the **studyplans.csv** file into the **StudyPlans** table in the database. Replace `<password>` with the password for the **azuresql** user.

        ```bash
        bcp "coursedatabase<nnn>.dbo.studyplans" in studyplans.csv -f studyplans.fmt -S "courseserver<nnn>.database.windows.net" -U azuresql -P <password> -F 2
        ```

        Verify that this command imports 45 rows.

## Query the data in the database

1. Return to the Azure portal.

1. In the left-hand pane of the Azure portal, click **SQL databases**.

1. On the **SQL databases** page, click **coursedatabase*nnn***.

1. On the **coursedatabase*nnn*** page, under **Overview**, click **Query editor**.

1. On the **coursedatabase*nnn* - Query editor** page, enter the following details, and then click **OK** to connect to database service.

    | Property  | Value  |
    |---|---|
    | Authorization type | SQL server authentication |
    | Login | azuresql |
    | Password | Enter the password for this user |

1. In the **Query 1** pane, enter the following SQL statement, and then click **Run**.

    ```SQL
    SELECT * FROM dbo.Courses
    ```

    This statement retrieves the data from the **Courses** table. The results window should display nine rows.

    ![Screenshot of the Query Editor in the Azure portal, showing the data retrieved from the Courses table](../media/3-query-results-annotated.png)

1. Change the query as follows, and then click **Run**.

    ```SQL
    SELECT * FROM dbo.Modules
    ```

    This time you should see the modules in the **Results** window; there are 16 rows.

1. Switch back to the Cloud Shell, and run the following command to connect to the database. Replace `<nnn>` with your database number and `<password>` with the password for the **azuresql** user.

    ```bash
    sqlcmd -S "courseserver<nnn>.database.windows.net" -d "coursedatabase<nnn>" -U azuresql -P <password>
    ```

1. At the `1>` prompt, enter the following SQL command to fetch the data in the **StudyPlans** table.

    ```SQL
    SELECT * FROM StudyPlans;  
    GO
    ```

    This query should return 45 rows.

1. At the `1>` prompt, type `exit` to close the **sqlcmd** utility.

You have now created a single database using Azure SQL Database. You created tables by using the Query Editor in the Azure portal. You used the **bcp** utility to upload data from a series of comma-delimited data files. Finally, you ran queries against the tables in the database from the Query Editor in the Azure portal, and from the **sqlcmd** utility in the Cloud Shell.
