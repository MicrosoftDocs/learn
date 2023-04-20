# Exercise using ledger
For this exercise we have created a database called ContosoHR, and created an updatable ledger table called Employees. The table contains a list of employees and their salary. In this exercise, we're going make updates to the data, verify if the data can be fully trusted and query the history table and ledger views to see the tracking that is taking place and the relationship between the tables.

## Scenario
The HR department of Contoso is using a simple web application to manage the employee's salaries. In this exercise you will use 2 different types of users:

- Alice, who is an auditor.
- Jay, the DBA of the company. He thinks he should earn more money for the type of work he's doing :)
Jay wants to maliciously increase his salary. Because he's the DBA of the Contoso database, he thinks he can perform updates in the Employees table without anyone noticing. Unfortunately for Jay, the Employees table is an updatable ledger table, which means his change, along with his identity and the timestamp, have been persisted in a tamper-evident ledger data structures.

1. Open SSMS and connect to your SQL server.
1. Open a New Query for the ContosoHR database.
1. Execute the query below, which shows the content of the Employees table. The web application uses this table as a data store.

```sql
    SELECT [EmployeeID]
        ,[SSN]
        ,[FirstName]
        ,[LastName]
        ,[Salary]
    FROM [dbo].[Employees];
```

4. Pretending you are Jay, execute the query below to add $50000 to his salary. Unfortunately for Jay, the Employees table is an updatable ledger table, which means his change, along with his identity and the timestamp, have been persisted in a tamper-evident ledger data structures.

```sql
UPDATE [dbo].[Employees] SET [Salary] = [Salary] + 50000
WHERE [FirstName] = N'Jay' AND [LastName] = N'Adams'
```

5. Let's assume, a few weeks later, Alice, who is an auditor, performs a routine review of changes in the HR database. As her first step, Alice runs the ledger verification to make sure she can trust the data, she’s going to examine. Execute the query below to run the ledger verification. The result should be "Success".

```sql
    SET NOCOUNT ON
	DECLARE @digest_locations NVARCHAR(MAX) = (SELECT path, last_digest_block_id, is_current FROM sys.database_ledger_digest_locations FOR JSON AUTO, INCLUDE_NULL_VALUES);
	BEGIN TRY
       EXEC sys.sp_verify_database_ledger_from_digest_storage @digest_locations;
       INSERT INTO [dbo].[LedgerVerifications] ([DigestLocations], [Result]) VALUES (@digest_locations, N'Success')
	END TRY
	BEGIN CATCH
       INSERT INTO [dbo].[LedgerVerifications] ([DigestLocations], [Result]) VALUES (@digest_locations, N'Failure')
	END CATCH
```

6. Alice can browse the content of the ledger view for the Employees table. She notices a suspicious update operation performed by Jay, who will not be able to effectively deny he has updated his salary, because the data in the ledger table has been cryptographically verified as genuine and it clearly shows Jay updated his salary. To verify this run the query below.

```sql
    SET NOCOUNT ON
	SELECT
	t.[commit_time] AS [CommitTime]
	, t.[principal_name] AS [UserName]
	, l.EmployeeId
	, l.[SSN]
	, l.[FirstName]
	, l.[LastName]
	, l.[Salary]
	, l.[ledger_operation_type_desc] AS Operation
	FROM [dbo].[Employees_Ledger] l
	JOIN sys.database_ledger_transactions t
	ON t.transaction_id = l.ledger_transaction_id
	WHERE t.[commit_time] > DATEADD(MINUTE, -10, SYSDATETIMEOFFSET())
	ORDER BY t.commit_time DESC;
```


