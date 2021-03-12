You have been hired as a Senior Database Administrator to help with performance issues currently happening when users query the AdventureWorks2017 database. Your job is to identify issues in query performance and remedy them using techniques learned in this module.

You'll evaluate a database design for problems with normalization, data type selection and index design.

## Examine the query and identify the problem

1. When the VM lab environment opens, use the password on the **Resources** tab above for the Student account to sign in to Windows.

1. From the lab virtual machine, start **SQL Server Management Studio (SSMS)**.

1. You will be prompted to connect to your SQL Server. ‎Ensure that **Windows Authentication** is selected, and then select **Connect**.

    :::image type="content" source="../media/connect-to-server.png" alt-text="Connect to Server":::

1. Start a new query by selecting the **New Query** button in Management Studio.

    :::image type="content" source="../media/new-query.png" alt-text="New Query":::

    > [!NOTE]
    > If you'd like to copy and paste the code you can find the code in the **D:\LabFiles\Query Performance\exercise_steps.sql** file.

1. Copy and paste the code below into your query window.

    ```sql
    USE AdventureWorks2017;
    SELECT BusinessEntityID, NationalIDNumber, LoginID, HireDate, JobTitle
    FROM HumanResources.Employee
    WHERE NationalIDNumber = 14417807;
    ```

1. Select **Include Actual Execution Plan** icon as shown below before running the query or type CTRL+M. This will cause the execution plan to be displayed when you execute the query.

    :::image type="content" source="../media/actual-execution-plan.png" alt-text="Include Actual Execution Plan":::

1. Select the execute button to execute this query.

1. Navigate to the execution plan, by selecting the **Execution plan** tab in the results panel in SSMS. In the execution plan, mouse over the SELECT operator. You will note a warning message identified by an exclamation point in a yellow triangle as shown below. Identify what the Warning Message tells you.

    :::image type="content" source="../media/execution-plan-warning.png" alt-text="Warning Message":::

## Identify two ways to fix the warning issue

The structure for the table is shown in the follow data definition language (DDL) statement. Review the fields that are used in the previous SQL query against this DDL, paying attention to their types.

```sql
CREATE TABLE [HumanResources].[Employee](
 [BusinessEntityID] [int] NOT NULL,
 [NationalIDNumber] [nvarchar](15) NOT NULL,
 [LoginID] [nvarchar](256) NOT NULL,
 [OrganizationNode] [hierarchyid] NULL,
 [OrganizationLevel] AS ([OrganizationNode].[GetLevel]()),
 [JobTitle] [nvarchar](50) NOT NULL,
 [BirthDate] [date] NOT NULL,
 [MaritalStatus] [nchar](1) NOT NULL,
 [Gender] [nchar](1) NOT NULL,
 [HireDate] [date] NOT NULL,
 [SalariedFlag] [dbo].[Flag] NOT NULL,
 [VacationHours] [smallint] NOT NULL,
 [SickLeaveHours] [smallint] NOT NULL,
 [CurrentFlag] [dbo].[Flag] NOT NULL,
 [rowguid] [uniqueidentifier] ROWGUIDCOL NOT NULL,
 [ModifiedDate] [datetime] NOT NULL
) ON [PRIMARY]
```

1. Fix the query using code as a solution.

    Identify what field is causing the implicit conversion and why. If you review the query:

    ```sql
    USE AdventureWorks2017;
    SELECT BusinessEntityID, NationalIDNumber, LoginID, HireDate, JobTitle
    FROM HumanResources.Employee
    WHERE NationalIDNumber = 14417807;
    ```

    You'll note the value compared to the NationalIDNumber column in the WHERE clause is compared as a number, since **14417807** isn't in a quoted string. After examining the table structure you will find the **NationalIDNumber** column is using the nvarchar(15) data type and not an integer data type. This inconsistency causes the SQL server optimizer to implicitly convert the number to a nvarchar causing additional overhead to the query performance by creating a suboptimal plan.

1. Change the code to resolve the implicit conversion and rerun the query.

    Remember to turn on the **Include Actual Execution Plan** (Cntl+M) if it is not already on from the steps above. Note the warning is now gone, and the query plan has improved. Changing the **WHERE** clause so that the value compared to the **NationalIDNumber** column matches the column's data type in the table, the optimizer can get rid of the implicit conversion. In this scenario just adding a single quote on each side of the value changes it from a number to a character format. Keep the query window open for this query.

    Run the updated SQL query:

    ```sql
    SELECT BusinessEntityID, NationalIDNumber, LoginID, HireDate, JobTitle
    FROM HumanResources.Employee
    WHERE NationalIDNumber = '14417807';
    ```

    :::image type="content" source="../media/execution-plan.png" alt-text="Warning now gone":::

1. Fix the query using database design changes.

    To attempt to fix the index, copy and paste the query below into a new query window, to change the column's data type. Attempt to execute the query, by selecting **Execute** or pressing <kbd>F5</kbd>.

    ```sql
    ALTER TABLE [HumanResources].[Employee] ALTER COLUMN [NationalIDNumber] INT NOT NULL;
    ```

    The changes to the table would solve the conversion issue. However, this change introduces another issue that as a database administrator you need to resolve. Since this column is part of an already existing nonclustered index, the index has to be rebuilt/recreated in order to change the data type. This could lead to extended downtime in production, which highlights the importance of choosing the right data types in your design.

    ```console
    Msg 5074, Level 16, State 1, Line 1The index 'AK_Employee_NationalIDNumber' is dependent on column 'NationalIDNumber'.

    Msg 4922, Level 16, State 9, Line 1

    ALTER TABLE ALTER COLUMN NationalIDNumber failed because one or more objects access this column.
    ```

1. In order to resolve this issue, copy and paste the code below into your query window and execute it by selecting **Execute**.

    ```sql
    USE AdventureWorks2017
    GO

    DROP INDEX [AK_Employee_NationalIDNumber] ON [HumanResources].[Employee]
    GO

    ALTER TABLE [HumanResources].[Employee] ALTER COLUMN [NationalIDNumber] INT NOT NULL;
    GO

    CREATE UNIQUE NONCLUSTERED INDEX [AK_Employee_NationalIDNumber] ON [HumanResources].[Employee]( [NationalIDNumber] ASC );
    GO
    ```

1. Rerun the original query without the quotes.

    ```sql
    USE AdventureWorks2017;
    SELECT BusinessEntityID, NationalIDNumber, LoginID, HireDate, JobTitle
    FROM HumanResources.Employee
    WHERE NationalIDNumber = 14417807;
    ```

Examine the query plan and note that you can now use a number for the **NationalIDNumber**. The SQL query optimizer can now generate and execute the most optimal plan.

To finish this exercise select **Done** below.
