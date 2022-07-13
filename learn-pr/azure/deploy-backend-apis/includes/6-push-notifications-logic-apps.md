Azure Logic Apps is a low-code/no-code development platform hosted as a serverless cloud service, which makes orchestrating connections between services and organizations simple.

Recall in the bus-catching scenario, once the Azure Function detects that there's a bus entering or exiting the geofence, it would be ideal for the final solution to push a notification to the application user. One option in Azure to accomplish this is to use Azure Logic Apps. Azure Logic Apps has a large number of connectors so you can integrate with other services. For example, you can use Azure Logic Apps to send an SMS message or send an email from your Outlook or Gmail account. Before implementing the bus-catching solution, you need to learn about Azure Logic Apps.

## Automate tasks and workflows with no coding using Azure Logic Apps

Azure Logic Apps allows you to automate and orchestrate tasks and workflows when you want to integrate apps, data, systems, and services across organizations. Azure Logic Apps is designed in a web-based designer and can execute logic without writing any code.

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4qhug]

When we compare Azure Logic Apps and Azure Functions, besides Azure Logic Apps being low-code/no-code and Azure Functions being code-based, the primary difference is intent. Azure Functions is a serverless compute service, and Azure Logic Apps is intended to be a serverless orchestration service. You can call Azure Functions from Azure Logic Apps, and vice versa.

## Connect to other services with Azure Logic Apps

Azure Logic Apps supports hundreds of connectors with services like Salesforce, SQL Server and Azure SQL, Outlook, and file shares. You can even create and build your own custom connectors as needed.

### Manipulate and retrieve data with Azure SQL and SQL Server connectors for Azure Logic Apps

Azure Logic Apps supports rich capabilities to integrate with SQL Server and Azure SQL. Since the connection is made similar to how you would make with tools including SQL Server Management Studio (SSMS) and Azure Data Studio (ADS), the connectors work for on-premises installations of SQL Server as well as all deployment options of Azure SQL (SQL Database, SQL Managed Instance, and SQL Server in Azure VM). Azure Logic Apps has connectors for **Triggers**, which means that when something happens in SQL Server/Azure SQL it could trigger the Logic App. The list of triggers includes:

* When an item is created
* When an item is modified

Azure Logic Apps also has connectors for **Actions**, which means that once a Logic App is triggered, a certain action on SQL Server/Azure SQL could be taken. The list of actions includes:

* Delete row
* Execute a SQL query
* Execute stored procedure
* Get row
* Get rows
* Get tables
* Insert row
* Transform data using Power Query
* Update row

> [!TIP]
> While Azure Functions is used for this solution, you might be wondering if Azure Logic Apps could be used instead. It is possible, and we challenge you to try it out if you want to work more with Azure Logic Apps and low-code/no-code environments.

### Send emails using the Outlook connector for Azure Logic Apps

Azure Logic Apps also supports various connectors for Outlook around sending and receiving as well as tasks. In the bus-catching scenario, the Outlook connector will be used to create a connection to an email account and be able to send email notifications when a bus enters or exits a geofence. In the exercise, you'll get to see how this connection is created, configured, and triggered.
