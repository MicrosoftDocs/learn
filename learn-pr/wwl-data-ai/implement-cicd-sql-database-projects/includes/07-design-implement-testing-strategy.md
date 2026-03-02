A SQL database project that builds successfully doesn't mean the stored procedures inside it return the right results. A procedure can compile with no errors and still calculate the wrong totals or skip a validation check. Testing catches these problems before they reach production.

## Understand database testing levels

Database testing works in layers, each catching a different class of problem:

- **Build validation** is the `dotnet build` step you already have. It catches syntax errors and broken object references. Fast, but it only proves the schema is structurally valid.
- **Unit tests** verify that individual stored procedures and functions produce the right results for a given set of inputs. They catch logic errors.
- **Integration tests** exercise end-to-end scenarios against a deployed database. They prove that objects work together correctly, but they require a running instance and take the most time.

Each layer is slower and more expensive than the one before it, but also catches problems the previous layer can't.

## Create SQL Server unit tests

SQL Server Data Tools (SSDT) in Visual Studio includes a built-in framework for database unit tests. Each test executes T-SQL against a live database and validates the results using test conditions.

### Structure of a unit test

Each test has three sections that follow a setup-execute-cleanup pattern:

- **Pre-test**: set up the data the test needs. Insert customer records, clear leftover data from previous runs.
- **Test**: execute the operation you're testing. Call the stored procedure and query the view.
- **Post-test**: clean up after the test so it doesn't contaminate the next run.

### Test conditions

After the test T-SQL runs, **test conditions** validate what came back. The most commonly used conditions are:

- **Row Count**: verifies that the result set contains the expected number of rows.
- **Scalar Value**: verifies that a specific cell in the result set contains the expected value.
- **Expected Schema**: verifies that the result set has the expected column names and data types.

Other built-in conditions include **Data Checksum**, **Empty ResultSet**, **Not Empty ResultSet**, and **Execution Time**.

### Create a unit test project

Setting up SQL Server unit tests in Visual Studio takes a few steps:

1. Open your SQL database project.
2. In **SQL Server Object Explorer**, find the stored procedure or function you want to test.
3. Right-click the object and select **Create Unit Tests**.
4. Choose or create a C# test project.
5. Set the test connection to your development database.
6. Select **Automatically deploy the database project before unit tests are run**. This option keeps the test database in sync with your latest project changes.

The designer opens with a T-SQL template where you write your test logic and attach test conditions.

### Write effective database unit tests

A good unit test answers a specific question: "Does this procedure do what it supposed to for a known input?" Here's an example that tests `uspPlaceNewOrder`, verifying that placing an order correctly updates the customer's year-to-date total:

```sql
-- Pre-test: Set up customer and clear previous data
DECLARE @CustomerID INT;
INSERT INTO [Sales].[Customer] (CustomerName) VALUES (N'Test Customer');
SET @CustomerID = SCOPE_IDENTITY();
DELETE FROM [Sales].[Orders] WHERE [CustomerID] = @CustomerID;

-- Test: Place an order and verify YTDOrders updated correctly
DECLARE @RC INT;
EXECUTE @RC = [Sales].[uspPlaceNewOrder] @CustomerID, 100, GETDATE(), 'O';

SELECT [YTDOrders]
FROM [Sales].[Customer]
WHERE [CustomerID] = @CustomerID;
```

&#128221; Pair this test T-SQL with a **Scalar Value** test condition that expects the `YTDOrders` value to be `100`.

### Negative tests

You also need to verify that stored procedures fail correctly when they receive invalid inputs. For example, canceling an order that was already shipped should raise an error, not succeed silently. A **negative test** confirms that the expected error occurs.

When you select **Create Unit Tests** in step 3 of the previous section, Visual Studio generates a C# test project in **Solution Explorer** with a `.cs` file containing a test for each stored procedure you selected. For example, if you created a test for `uspCancelOrder`, the generated file includes a section named `Sales_uspCancelOrder_Test`. To mark that test as a negative test, open the `.cs` file in **Solution Explorer** and add the `ExpectedSqlException` attribute directly above it and save the file:

```csharp
[TestMethod()]
[ExpectedSqlException(Severity = 16, MatchFirstError = false, State = 1)]
public void Sales_uspCancelOrder_FilledOrder_Test()
```

The test passes only when the stored procedure raises an error matching the specified severity and state. If the procedure succeeds silently, the test fails, which is exactly what you want.

## Design an integration testing approach

Unit tests isolate individual objects. Integration tests go further and test scenarios that span multiple operations. They answer questions like:

- Does a sequence of stored procedure calls leave the database in the expected state?
- Do triggers fire correctly when data arrives through the application layer?
- Do views return accurate results after a series of related table changes?

Integration tests need a dedicated database. Deploy the SQL database project to a test instance before each run using the **Automatically deploy the database project before unit tests are run** setting. This setting keeps the test schema current.

### Considerations for test databases

Both unit tests and integration tests run T-SQL against a live database, so the test environment needs careful setup to produce reliable results.

- **Isolate tests from production**. Use a separate instance or dedicated test database. Running tests against production is never recommended.
- **Reset to a known state** before each run. Post-deployment scripts or test cleanup scripts handle this issue.
- **Externalize connection strings** in configuration files so local development and CI pipelines each point to the right database without code changes.

## Integrate tests into CI/CD pipelines

Add a test step after build and deployment so tests run automatically on every commit. In Azure DevOps, use the `VSTest` task:

```yaml
- task: VSTest@2
  inputs:
    testAssembly: '**\*Tests.dll'
    searchFolder: '$(System.DefaultWorkingDirectory)'
```

In GitHub Actions, run the tests using `dotnet test`:

```yaml
- name: Run database unit tests
  run: dotnet test ./DatabaseTests/DatabaseTests.csproj
```

> [!TIP]
> Configure the test project to automatically deploy the database project before tests run. This setting ensures that the test database schema matches the project at the time of testing.

When a test fails, the pipeline stops and the change doesn't reach staging or production. This delay gives the team time to fix the issue before it affects any environment.

## Key takeaways

Database testing spans three levels: build validation for structural correctness, unit tests for logic verification, and integration tests for end-to-end workflows. SQL Server unit tests follow a three-phase structure of test preactions, test actions, and test post-actions. To verify stored procedure and function behavior, use test conditions like `Scalar Value`, `Row Count`, and `Expected Schema`. To test methods that should validate error handling paths, add the `ExpectedSqlException` attribute. Wire test projects into your CI/CD pipeline so a failing test blocks the deployment before changes reach staging or production. Together, these three layers form a safety net that lets your team deploy database changes with confidence instead of anxiety.
