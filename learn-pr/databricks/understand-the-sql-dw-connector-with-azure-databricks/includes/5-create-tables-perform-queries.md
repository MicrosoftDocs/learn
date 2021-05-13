In this unit, you'll learn how to create distributed tables in Azure Synapse Analytics. After you create the tables, you'll use Azure Data Studio to run some queries against them.

## Create distributed tables

Azure Synapse Analytics divides your data into 60 databases. Each individual database is called a *distribution*. After you've loaded data into each table, Azure Synapse Analytics has to know how to divide the data across these 60 distributions.

The distribution method is defined at the table level. There are three choices:

- **Replicated**. The replicated table is fully copied to a distribution database on each Compute node. Replicating a table removes the need to transfer data among Compute nodes before a join or aggregation. Replicated tables are feasible only with small tables because of the extra storage required to store the full table on each Compute node.

- **Round robin**. Data is distributed evenly but randomly.

- **Hash distributed**. Data is distributed based on hashing values from a single column.

By default, when you don't define a data distribution method, your table will use the round robin distribution method. As you become more sophisticated in your implementation, you'll want to consider using hash distributed tables to minimize data movement, which will in turn optimize query performance.

### Create distributed tables that use the hash distributed method

1. Open Azure Data Studio.

1. Go to the **Servers** list in the menu on the left side of Azure Data Studio. Right-click the connection you made to the Azure Synapse Analytics database, and select **New Query**.

    ![Right-click the Azure Synapse Analytics connection and select New Query](../media/azure-data-studio-new-query-dw.png)

1. Run these statements in the new query window to create a hash distributed table.

    ```sql
    CREATE TABLE [dbo].[EmployeeBasic]
    (
      [EmployeeID] int NOT NULL,
      [EmployeeName] varchar(30) NOT NULL,
      [DOB] date NOT NULL,
      [Address] varchar(50) NOT NULL,
      [BloodGroup] nvarchar(2) NOT NULL
    )
    WITH
    (
      CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH([EmployeeID])
    );
    ```

    In this `CREATE TABLE` statement:

    - `[dbo]` is the schema name.
    - `[EmployeeBasic]` is the table name.
    - `[EmployeeID], [EmployeeName] ... [BloodGroup]` are column definitions.
    - The `WITH` clause defines one-to-many table options.
    - `CLUSTERED COLUMNSTORE INDEX` is a table structure option. It stores the table as a clustered columnstore index in which all data is compressed and stored by column. Clustered columnstore index is the default structure for Azure Synapse Analytics, and applies to all table data.
    - `DISTRIBUTION = HASH` ( *`distribution_column_name`* ) assigns each row to one distribution by hashing the value stored in `distribution_column_name`. The algorithm is deterministic, which means it always hashes the same value to the same distribution. The  distribution column should be defined as `NOT NULL` because all rows with `NULL` will be assigned to the same distribution.

### Create distributed tables that use the round robin method

Run this statement in a new query window to create a round robin distributed table:

   ```sql
    CREATE TABLE [dbo].[Sales]
    (
      [ProductKey] int NOT NULL,
      [OrderDateKey] int NOT NULL,
      [CustomerKey] int NOT NULL,
      [PromotionKey] int NOT NULL,
      [SalesOrderNumber] nvarchar(20) NOT NULL,
      [OrderQuantity] smallint NOT NULL,
      [UnitPrice] money NOT NULL,
      [SalesAmount] money NOT NULL
    )
    WITH
    (
      CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = ROUND_ROBIN
    );
   ```

`DISTRIBUTION = ROUND_ROBIN` distributes the rows evenly across all distributions in a round robin fashion. That is, there's no sorting done during the round robin process, which places your data. This is the default distribution for Azure Synapse Analytics.

### Create a replicated table

Run this statement in a new query window to create a replicated table. Make sure Azure Synapse Analytics is selected as target database in the query window.

  ```sql
    CREATE TABLE [dbo].[States]
    (
      [StateKey] int NOT NULL,
      [State] nvarchar(20) NOT NULL
    )
    WITH
    (
      CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = REPLICATE
    );
  ```

## Query Azure Synapse Analytics

Now we'll use Azure Data Studio to perform some queries against your data warehouse.

### Create a table that uses the hash distribution method

1. Create a table named **EmployeeBasic** that uses the hash distribution method, if you haven't created it in the previous section.

1. Create another table named **EmployeeRemuneration** that uses the hash distribution method.

    ```sql
    CREATE TABLE [dbo].[EmployeeRemuneration]
    (
      [EmployeeID] int NOT NULL,
      [EmployeeDesignation] varchar(30) NOT NULL,
      [Salary] money NOT NULL,
      [DepartmentID] int NOT NULL
    )
    WITH
    (
      CLUSTERED COLUMNSTORE INDEX,
      DISTRIBUTION = HASH([EmployeeID])
    );
    ```

    ![Create EmployeeRemuneration table](../media/azure-data-studio-create-table.png)

### Insert rows in both tables

1. Clear the query window, and run these INSERT statements to insert records in the **EmployeeBasic** table.

    ```sql
    INSERT INTO [dbo].[EmployeeBasic] VALUES
    (1,'Sam','01-06-1996','P-37, 5TH LANE, GLEN ALLEN,RICHMOND','O+');
    INSERT INTO [dbo].[EmployeeBasic] VALUES (2,'Mary','03-06-1997','44 Shirley Ave. West Chicago, IL 60185','B+');
    INSERT INTO [dbo].[EmployeeBasic] VALUES (3,'Nicole','12-01-1996','51 S.Magnolia St. Orlando, FL','B+');
    INSERT INTO [dbo].[EmployeeBasic] VALUES (4,'Sanjay','10-03-1996','70 Bowman St. South Windsor,CT','O-');
    INSERT INTO [dbo].[EmployeeBasic] VALUES (5,'Tania','08-06-1997','71 Pilgrim Avenue Chevy Chase,MD','A-');
    INSERT INTO [dbo].[EmployeeBasic] VALUES (6,'Ben','03-07-1998','840 S. Windfall Rd. Elmont, NY 11003','O+');
     ```

   You should see six messages that state `(1 row affected)`.

   ![Insert rows into the EmployeeBasic table](../media/azure-data-studio-insert-rows.png)

1. Insert a few rows into the EmployeeRemuneration table. Run these INSERT statements.

    ```sql
    INSERT INTO [dbo].[EmployeeRemuneration] VALUES (1,'Software Developer',4000,1);
    INSERT INTO [dbo].[EmployeeRemuneration] VALUES (2,'Sr.Software Developer',6000,1);
    INSERT INTO [dbo].[EmployeeRemuneration] VALUES (3,'Data Engineer',5000,2);
    INSERT INTO [dbo].[EmployeeRemuneration] VALUES (4,'Data Scientist',8000,2);
    INSERT INTO [dbo].[EmployeeRemuneration] VALUES (5,'Human Resource',4600,3);
    INSERT INTO [dbo].[EmployeeRemuneration] VALUES (6,'Sr.Software Developer',6000,1);
    ```

### Run some basic queries

1. Select all the rows of the **EmployeeBasic** table with all details.

    ```sql
    SELECT * FROM [dbo].[EmployeeBasic];
    ```

1. Select all the details of employees who were born in the year 1996.

    ```sql
    SELECT * FROM [dbo].[EmployeeBasic]
    WHERE YEAR(dob) = 1996;
    ```

1. Select all the rows of the **EmployeeRemuneration** table with all details.

    ```sql
    SELECT * FROM [dbo].[EmployeeRemuneration];
    ```

1. Sort all employees by name:

    ```sql
    SELECT EmployeeID, EmployeeName
    FROM [dbo].[EmployeeBasic]
    ORDER BY (EmployeeName);
    ```

1. Sort all employees in `[dbo].[EmployeeRemuneration]` by salary.

    ```sql
    SELECT EmployeeID, EmployeeDesignation, Salary, DepartmentID
    FROM [dbo].[EmployeeRemuneration]
    ORDER BY (Salary) DESC;
    ```

### Run some queries that use aggregation

1. Select the sum of all the salaries in each department.

    ```sql
    SELECT SUM(Salary) AS TOTALSUM, DepartmentID
    FROM [dbo].[EmployeeRemuneration] GROUP BY(DepartmentID);
    ```

1. Select the average of all the salaries in each department.

    ```sql
    SELECT AVG(Salary) AS AverageSalary, DepartmentID
    FROM [dbo].[EmployeeRemuneration] GROUP BY(DepartmentID);
    ```

1. Select the maximum of all the salaries in each department.

    ```sql
    SELECT MAX(Salary) AS MaximumSalary, DepartmentID
    FROM [dbo].[EmployeeRemuneration] GROUP BY(DepartmentID);
    ```

1. Select the minimum of all the salaries in each department.

    ```sql
    SELECT MIN(Salary) AS MinimumSalary, DepartmentID
    FROM [dbo].[EmployeeRemuneration] GROUP BY(DepartmentID);
    ```

1. Select the number of employees in each department.

    ```sql
    SELECT COUNT(EmployeeID) AS NumberOfEmployees, DepartmentID
    FROM [dbo].[EmployeeRemuneration] GROUP BY(DepartmentID);
    ```

### Run join queries

1. Join the tables **EmployeeBasic** and **EmployeeRemuneration** using the key **EmployeeID**, and select **EmployeeID**,
    **EmployeeName**, **EmployeeDesignation**, and **Salary**.

    ```sql
    SELECT
      ER.[EmployeeID],
      [EmployeeName],
      [EmployeeDesignation],
      [Salary]
    FROM [dbo].[EmployeeRemuneration] ER
    JOIN [dbo].[EmployeeBasic] EB ON ER.EmployeeID = EB.EmployeeID;
    ```

### Use aggregations with join operations

1. Get details about all employees who receive the maximum salary in their department.

    ```sql
    SELECT
      EB.EmployeeID, EmployeeName, EmployeeDesignation, Salary,DepartmentID
    FROM
      [dbo].[EmployeeBasic] EB, [dbo].[EmployeeRemuneration] ER1
    WHERE
      ER1.EmployeeID = EB.EmployeeID AND
      ER1.Salary = ( SELECT MAX(Salary)
        FROM [dbo].[EmployeeRemuneration] ER2
        WHERE ER2.DepartmentID = ER1.DepartmentID );
    ```

1. Select the second highest salary in each department. If there's only one employee in any department, return that employee's salary.

    ```sql
    SELECT
      MAX(Salary) as Salary, DepartmentID
    FROM
      [dbo].[EmployeeRemuneration] E1
    WHERE
      E1.Salary < (SELECT MAX(Salary) FROM
        [dbo].[EmployeeRemuneration] AS E2
        WHERE E2.DepartmentID = E1.DepartmentID)
    OR
      E1.Salary = (SELECT MAX(Salary) FROM
        [dbo].[EmployeeRemuneration] AS E2
        WHERE E2.DepartmentID = E1.DepartmentID
        HAVING COUNT(DISTINCT Salary) = 1)
    GROUP BY(DepartmentID);
    ```