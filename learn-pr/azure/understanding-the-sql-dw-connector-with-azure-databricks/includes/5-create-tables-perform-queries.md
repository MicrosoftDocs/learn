In this unit, you'll learn how to create distributed tables in SQL Data Warehouse. After the tables are created, you'll perform several queries against them, using Azure Data Studio.

## Create Distributed tables

SQL Data Warehouse divides your data into 60 databases. Each individual database is referred to as a **distribution**. When data is loaded into each table, SQL Data Warehouse has to know how to divide your data across these 60 distributions.

The distribution method is defined at the table level and there are three choices:

- **Replicated** The replicated table is fully copied to a distribution database on each Compute node. Replicating a table removes the need to transfer data among Compute nodes before a join or aggregation. Replicated tables are only feasible with small tables because of the extra storage required to store the full table on each compute node.

- **Round robin**, which distributes data evenly but randomly.

- **Hash Distributed**, which distributes data based on hashing values from a single column

By default, when you do not define a data distribution method, your table will be distributed using the round robin distribution method. However, as you become more sophisticated in your implementation, you'll want to consider using hash distributed tables to minimize data movement, which will in turn optimize query performance.

### Create Distributed tables using the Hash Distribution method

1. Open Azure Data Studio.

1. Navigate to the Servers list on the left-hand menu in Azure Data Studio. Right-click on the SQL Data Warehouse connection you made to the SQL Data Warehouse database, then select **New Query** from the context menu.

    ![Right-click on the SQL Data Warehouse connection then click New Query.](../media/azure-data-studio-new-query-dw.png)

1. Execute following statements in new query window to create **HASH** distributed table:

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

    In the above CREATE TABLE statement

    - `[dbo]` is the schema name
    - `[EmployeeBasic]` is the table name
    - `[EmployeeID], [EmployeeName],....,[BloodGroup]` are column definitions
    - **WITH** clause defines one to many table options
    - **CLUSTERED COLUMNSTORE INDEX** is a table structure option, stores the table as a clustered columnstore index in which all of the data is compressed and stored by column. The clustered columnstore index is the default for SQL Data Warehouse and applies to all of the table data.
    - **DISTRIBUTION** = **HASH** ( `distribution_column_name` ) assigns each row to one distribution by hashing the value stored in distribution_column_name. The algorithm is deterministic, which means it always hashes the same value to the same distribution. The  distribution column should be defined as NOT NULL since all rows that have NULL will be assigned to the same distribution.

### Create Distributed tables using the Round Robin Distribution method

Execute the following statement in a new query window to create a **Round Robin** distributed table:

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

    - **DISTRIBUTION = ROUND_ROBIN**

  Distributes the rows evenly across all the distributions in a round-robin fashion. That is, there's no sorting done during the round robin process, which places your data. This is the default for SQL Data Warehouse.

### Create Replicated Table

Execute the following statement in a new query window to create a **REPLICATE** table. Ensure SQL Data Warehouse is selected as target database in the query window:

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

## Query SQL Data Warehouse

Continue using Azure Data Studio to perform the following queries against your data warehouse.

### Create a Table using the Hash Distribution method

1. Create a table named **EmployeeBasic** using the **Hash Distribution** method, if it hasn't been created in the previous section.

1.  Create another table named **EmployeeRemuneration** using the **Hash Distribution** method:

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

    ![Create EmployeeRemuneration table.](../media/azure-data-studio-create-table.png)

### Insert rows in both of the tables

1. Clear the query window and execute following `INSERT` statements to insert records in EmployeeBasic table:

    ```sql
    INSERT INTO [dbo].[EmployeeBasic] VALUES
    (1,'Sam','01-06-1996','P-37, 5TH LANE, GLEN ALLEN,RICHMOND','O+');
    INSERT INTO [dbo].[EmployeeBasic] VALUES (2,'Mary','03-06-1997','44 Shirley Ave. West Chicago, IL 60185','B+');
    INSERT INTO [dbo].[EmployeeBasic] VALUES (3,'Nicole','12-01-1996','51 S.Magnolia St. Orlando, FL','B+');
    INSERT INTO [dbo].[EmployeeBasic] VALUES (4,'Sanjay','10-03-1996','70 Bowman St. South Windsor,CT','O-');
    INSERT INTO [dbo].[EmployeeBasic] VALUES (5,'Tania','08-06-1997','71 Pilgrim Avenue Chevy Chase,MD','A-');
    INSERT INTO [dbo].[EmployeeBasic] VALUES (6,'Ben','03-07-1998','840 S. Windfall Rd. Elmont, NY 11003','O+');
     ```

You should see 6 messages stating `(1 row affected)`.

    ![Insert rows into the EmployeeBasic table.](../media/azure-data-studio-insert-rows.png)

1. Insert a few rows into the **EmployeeRemuneration** table. Execute the following `INSERT` statements:

    ```sql
    INSERT INTO [dbo].[EmployeeRemuneration] VALUES (1,'Software Developer',4000,1);
    INSERT INTO [dbo].[EmployeeRemuneration] VALUES (2,'Sr.Software Developer',6000,1);
    INSERT INTO [dbo].[EmployeeRemuneration] VALUES (3,'Data Engineer',5000,2);
    INSERT INTO [dbo].[EmployeeRemuneration] VALUES (4,'Data Scientist',8000,2);
    INSERT INTO [dbo].[EmployeeRemuneration] VALUES (5,'Human Resource',4600,3);
    INSERT INTO [dbo].[EmployeeRemuneration] VALUES (6,'Sr.Software Developer',6000,1);
    ```

### Perform some basic queries

1. Select all the rows with all details of the **EmployeeBasic** table.

    ```sql
    SELECT * FROM [dbo].[EmployeeBasic];
    ```

1. Select all the details of the employees who were born in the year 1996.

    ```sql
    SELECT * FROM [dbo].[EmployeeBasic]
    WHERE YEAR(dob) = 1996;
    ```

1. Select all the rows with all details of **EmployeeRemuneration**
    table.

    ```sql
    SELECT * FROM [dbo].[EmployeeRemuneration];
    ```

1. Sort all the employees by their names.

    ```sql
    SELECT EmployeeID, EmployeeName
    FROM [dbo].[EmployeeBasic]
    ORDER BY (EmployeeName);
    ```

1. Sort all the employees from [dbo].[EmployeeRemuneration] with
    respect to their salary.

    ```sql
    SELECT EmployeeID, EmployeeDesignation, Salary, DepartmentID
    FROM [dbo].[EmployeeRemuneration]
    ORDER BY (Salary) DESC;
    ```

### Perform some queries using aggregation

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

### Perform Join queries

1. Join the tables **EmployeeBasic** and **EmployeeRemuneration** using the key **EmployeeID**, and select **EmployeeID**,
    **EmployeeName**, **EmployeeDesignation**, and **Salary.**

    ```sql
    SELECT
      ER.[EmployeeID],
      [EmployeeName],
      [EmployeeDesignation],
      [Salary]
    FROM [dbo].[EmployeeRemuneration] ER
    JOIN [dbo].[EmployeeBasic] EB ON ER.EmployeeID = EB.EmployeeID;
    ```

### Use of aggregations with Join operations

1. Find the details of all employees who receive the maximum salary in their department.

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

1. Select the second maximum salary from each department, if there's only one employee in any department then it will display their salary.

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