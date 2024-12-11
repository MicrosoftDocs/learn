Azure Functions is serverless compute services that allow you to run event-driven code without having to manage infrastructure. This code is capable of performing various tasks, such as data transformation, validation, logging, and more.

Azure Functions supports multiple programming languages, making it versatile for developers with different skill set. They also integrate seamlessly with GitHub Actions, allowing for automatic data pushes to your application whenever there are changes. This ensures that your data is always up-to-date and your workflows remain efficient.

Azure Functions supports [input binding](/azure/azure-functions/functions-bindings-azure-sql-input?azure-portal=true), [output binding](/azure/azure-functions/functions-bindings-azure-sql-output?azure-portal=true), and a [function trigger](/azure/azure-functions/functions-bindings-azure-sql-trigger?azure-portal=true) for the Azure SQL and SQL Server products.

Depending on the binding mode you're using in your function app, there are extensions you need to install, see [Azure SQL bindings for Azure Functions overview](/azure/azure-functions/functions-bindings-azure-sql) to learn more.

## Understand Azure SQL bindings

There are two recommended modes for creating a C# function.

- The [isolated worker model](/azure/azure-functions/dotnet-isolated-process-guide?azure-portal=true), which is a compiled function that runs in a worker process isolated from the runtime. This model supports C# functions running on both LTS and non-LTS versions of .NET and the .NET Framework.
- A [C# script](/azure/azure-functions/functions-dotnet-class-library?azure-portal=true), which is primarily used when creating C# functions in the Azure portal.

> [!IMPORTANT]
> Editing .NET isolated Function Apps is not supported in the Azure portal. Use your local development environment to edit the Function App. 

## Create a function app

The first step is to create a Function App. In this example, we use the Azure portal, but you can also use other methods such as Visual Studio Code or Azure CLI.

1. In the Azure portal, select **Create a resource** and then **Function App**. Choose the plan type.
1. Fill in the required details like subscription, resource group, and function app name.
1. Select the runtime stack and the version you want to use.
1. Choose the region, and operating system for your Function App.

    :::image type="content" source="../media/3-azure-function.png" alt-text="Screenshot showing the Create Function App page on Azure portal.":::

1. Review your settings and select **Create** to deploy the Function App.

## Add connection string

You can add the Azure SQL Database connection string in the left-hand menu of your function app, under the **Settings** section. Select **Environment variables**. On the **Connection strings** tab, select **+ Add** to add a new connection string. Provide a name, enter the connection string value, and select the **SQLAzure** type.

:::image type="content" source="../media/3-connection-string.png" alt-text="Screenshot showing how to add a connection string for Azure SQL Database on the Azure Function.":::

## Read data operation (input binding)

The function operates in an [input binding mode](/azure/azure-functions/functions-bindings-azure-sql-input?azure-portal=true), which means that when the function runs, the Azure SQL input binding retrieves data from a database and passes it to the input parameter of the function.

### Read a single record from an Azure SQL database

In this example, we demonstrate how to create an Azure Function in C# that retrieves a single record from an Azure SQL database. This function is triggered by an HTTP request, making it a practical solution for scenarios where you need to fetch specific data based on user input or other parameters. 

The following code snippet shows a C# function that retrieves a single record from the `Employee` table. The function is triggered by an HTTP request that uses a query string to specify the `EmployeeId`. The query string parameter is case-sensitive.

```csharp
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;

namespace AzureSQLSamples
{
    public static class GetEmployee
    {
        [FunctionName("GetEmployee")]
        public static IActionResult Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "getemployee")]
            HttpRequest req,
            [Sql(commandText: "select [EmployeeId], [FirstName], [LastName], [Email], [Department] from dbo.Employee where EmployeeId = @EmployeeId",
                commandType: System.Data.CommandType.Text,
                parameters: "@EmployeeId={Query.EmployeeId}",
                connectionStringSetting: "SqlConnectionString")]
            IEnumerable employee)
        {
            return new OkObjectResult(employee.FirstOrDefault());
        }
    }
}
```

### Validate the function

To trigger and validate the `GetEmployee` function, you need to send an HTTP GET request to the function's endpoint with the `EmployeeId` specified in the query string. You can use many tools to send the HTTP GET request, such as a web browser, Postman, or cURL. To use a web browser, enter the URL in the address bar of your web browser.

```
https://<your-function-app>.azurewebsites.net/api/getemployee?EmployeeId=123
```

When the function `GetEmployee` is triggered by an HTTP GET request, the following sequence of events occurs.

- The Azure SQL input binding retrieves data from the `Employee` table in the database using the specified EmployeeId.
- The SQL command fetches the record from the Employee table that matches the specified `EmployeeId`.
- The retrieved record is passed to the function as an `IEnumerable` collection named *employee*.
- The function returns the first (and only) record from the employee collection as an `OkObjectResult`, which is an HTTP 200 response containing the employee data.

## Write data operation (output binding)

The Azure SQL output binding for Azure Functions allows you to write data to an Azure SQL database. 

When you use the Azure SQL output binding, you define the SQL command that you want to execute, such as an `INSERT`, `UPDATE`, or `DELETE` statement. The binding takes care of executing the SQL command with the provided parameters.

### Write a single record to an Azure SQL database

This following code example defines an Azure Function named `AddEmployee` that inserts a new employee record into the `Employee` table. 

The function is triggered by an HTTP POST request and uses the Azure SQL output binding to insert the data into the database. The `Employee` class represents the structure of the employee data, and the `OutputType` class is used to pass the employee data and the HTTP response back to the caller.

```csharp
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using Microsoft.Azure.Functions.Worker.Extensions.Sql;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace AzureSQL.Employee
{
    public static class AddEmployee
    {
        // create a new Employee from body object
        // uses output binding to insert new item into Employee table
        [FunctionName("AddEmployee")]
        public static async Task Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = "AddEmployee")] HttpRequestData req,
                FunctionContext executionContext)
        {
            var logger = executionContext.GetLogger("AddEmployee");
            logger.LogInformation("C# HTTP trigger function processed a request.");

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            Employee employee = JsonConvert.DeserializeObject<Employee>(requestBody);

            // generate a new id for the employee
            employee.EmployeeId = Guid.NewGuid();

            return new OutputType()
            {
                Employee = employee,
                HttpResponse = req.CreateResponse(System.Net.HttpStatusCode.Created)
            };
        }
    }

    public class OutputType
    {
        [SqlOutput("dbo.Employee", connectionStringSetting: "SqlConnectionString")]
        public Employee Employee { get; set; }

        public HttpResponseData HttpResponse { get; set; }
    }

    public class Employee
    {
        public Guid EmployeeId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Department { get; set; }
    }
}
```

### Validate the function

To trigger and validate the `AddEmployee` function, you need to send an HTTP POST request to the function's endpoint with the employee data in the request body. You can use tools like Postman or cURL to send the HTTP POST request. Here's an example using Postman.

1. Set the request type to **POST**.
2. Enter the URL in the address bar:
   ```
   https://<your-function-app-name>.azurewebsites.net/api/addemployee
   ```
3. In the **Body** tab, select **raw** and set the format to **JSON**.
4. Enter the employee data in JSON format, for example:
   ```json
   {
       "FirstName": "John",
       "LastName": "Doe",
       "Email": "john.doe@example.com",
       "Department": "HR"
   }
   ```

## Configure an Azure SQL trigger

An [Azure SQL trigger](/azure/azure-functions/functions-bindings-azure-sql-trigger?azure-portal=true) is a feature used in Azure Functions that triggers a function when a change is detected on a SQL table. 

The trigger uses [SQL change tracking](/sql/relational-databases/track-changes/work-with-change-tracking-sql-server?azure-portal=true) to detect changes in the table by monitoring and responding to `INSERT`, `UPDATE`, and `DELETE` events efficiently.

It operates on a polling loop that periodically checks for changes and triggers the function accordingly. If multiple changes are made during one polling interval, these changes are applied by the trigger in the order that the changes were originally made.

You can configure the `Sql_Trigger_MaxBatchSize` setting to control the number of changes processed at a time, and the `Sql_Trigger_PollingIntervalMs` setting to set the delay between polling intervals.

#### Enable change tracking

Run the following example command to enable change tracking on the database and table.

```sql
ALTER DATABASE [AdventureWorksLT]
SET CHANGE_TRACKING = ON
(CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON);

ALTER TABLE [dbo].[Employee]
ENABLE CHANGE_TRACKING;
```

#### Create a class

Now, let's defines a C# class named `Employee` within the `AzureSQL.Employee` namespace. The `Employee` class represents the structure of an employee record.

```csharp
namespace AzureSQL.Employee
{
    public class Employee
    {
        public Guid EmployeeId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Department { get; set; }
    }
}
```

#### Create the function trigger

In your Azure Function, set up the trigger to respond to changes detected by the change tracking.

```csharp
using System;
using System.Collections.Generic;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Extensions.Sql;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace AzureSQL.Employee
{
    public static class EmployeeTrigger
    {
        [Function("EmployeeTrigger")]
        public static void Run(
            [SqlTrigger("[dbo].[Employee]", "SqlConnectionString")]
            IReadOnlyList<SqlChange<Employee>> changes,
            FunctionContext context)
        {
            var logger = context.GetLogger("EmployeeTrigger");
            foreach (SqlChange<Employee> change in changes)
            {
                Employee employee = change.Item;
                logger.LogInformation($"Change operation: {change.Operation}");
                logger.LogInformation($"EmployeeId: {employee.EmployeeId}, FirstName: {employee.FirstName}, LastName: {employee.LastName}, Email: {employee.Email}, Department: {employee.Department}");
            }
        }
    }
}
```

This setup allows your function to react to data changes in near real-time, making it useful for scenarios like data synchronization, auditing, and more.

> [!NOTE] 
> To learn more about how SQL change tracking works, see [Work with change tracking](/sql/relational-databases/track-changes/work-with-change-tracking-sql-server?azure-portal=true).

## Monitor function execution

Enable [Azure Application Insights](/azure/azure-functions/functions-monitoring?azure-portal=true) integration to keep track of your function's performance and any potential issues. Application Insights collects log, performance, and error data.
