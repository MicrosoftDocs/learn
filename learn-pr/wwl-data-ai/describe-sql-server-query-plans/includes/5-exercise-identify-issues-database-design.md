You have been hired as a Senior Database Administrator to help with performance issues currently happening when users query the AdventureWorks2017 database. Your job is to identify issues in query performance and remedy them using techniques learned in this module.

You'll evaluate a database design for problems with normalization, data type selection and index design.

## Examine the query and identify the problem

1. From the lab virtual machine, start **SQL Server Management Studio (SSMS)**. Start a new query by selecting the **New Query** button in Management Studio.

    :::image type="content" source="../media/dp-3300-module-55-lab-01.png" alt-text="New Query":::

1. You will be prompted to connect to your SQL Server. ‎Enter the server name localhost, and ensure that Windows Authentication is selected, and then select connect.

    :::image type="content" source="../media/dp-3300-module-55-lab-02.png" alt-text="Connect to Server":::

1. Start a new query by selecting the **New Query** button in SQL Server Management Studio. Copy and paste the code below into your query window.

    ```sql
    USE AdventureWorks2017;
    SELECT BusinessEntityID, NationalIDNumber, LoginID, HireDate, JobTitle
    FROM HumanResources.Employee
    WHERE NationalIDNumber = 14417807;
    ```

1. Select **Include Actual Execution Plan** icon as shown below before running the query or type CTRL+M. This will cause the execution plan to be displayed when you execute the query.

    :::image type="content" source="../media/dp-3300-module-55-lab-03.png" alt-text="Include Actual Execution Plan":::

1. Select the execute button to execute this query.

1. Navigate to the execution plan, by selecting the **Execution plan** tab in the results panel in SSMS. In the execution plan, mouse over the SELECT operator. You will note a warning message identified by an exclamation point in a yellow triangle as shown below. Identify what the Warning Message tells you.

    :::image type="content" source="../media/dp-3300-module-55-lab-04.png" alt-text="Warning Message":::

## Identify two ways to fix the warning issue

The structure for the table is shown in the follow data definition language (DDL) statement.

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

    Identify what field is causing the implicit conversion and why. If you review the query from Task1, you will note the value compared to the NationalIDNumber column in the WHERE clause is passed in as a number, since it is not in a quoted string. After examining the table structure you will find this column in the table is using the nvarchar(15) datatype and not the int or integer data type. This data type inconsistency causes the optimizer to implicitly convert the constant to a nvarchar upon execution causing additional overhead to the query performance with a suboptimal plan.

1. Change the code to resolve the implicit conversion and rerun the query.

    Remember to turn on the **Include Actual Execution Plan** (Cntl+M) if it is not already on from the exercise above. Note the warning is now gone. Changing the WHERE clause so that the value compared to the NationalIDNumber column matches the column’s data type in the table, you can get rid of the implicit conversion. In this scenario just adding a single quote on each side of the value changes it from a number to a character format. Keep the query window open for this query.

    :::image type="content" source="../media/dp-3300-module-55-lab-05.png" alt-text="Warning now gone":::

    ```sql
    SELECT BusinessEntityID, NationalIDNumber, LoginID, HireDate, JobTitle
    FROM HumanResources.Employee
    WHERE NationalIDNumber = '14417807'
    ```

1. Fix the query using database design changes.

    To attempt to fix the index, in a new query window, copy and paste the query below to change the column’s data type. Attempt to execute the query, by selecting **Execute** or pressing F5.

    ```sql
    ALTER TABLE [HumanResources].[Employee] ALTER COLUMN [NationalIDNumber] INT NOT NULL;
    ```

    The changes to the table would solve the conversion issue. However this change introduces another issue that as a database administrator you need to resolve. Since this column is part of an already existing nonclustered index, the index has to be rebuilt/recreated in order to execute the data type change. This could lead to extended downtime in production, which highlights the importance of choosing the right data types in your design.

    Msg 5074, Level 16, State 1, Line 1The index 'AK_Employee_NationalIDNumber' is dependent on column 'NationalIDNumber'.

    Msg 4922, Level 16, State 9, Line 1

    ALTER TABLE ALTER COLUMN NationalIDNumber failed because one or more objects access this column.

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
