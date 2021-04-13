Azure Functions provide an easy, scalable way to deploy serverless APIs.
<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
In the bus-catching scenario, several lightweight APIs will be required in order to get, process, and react to incoming real-time bus data.
<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
Here, you will learn about Azure Functions. You'll also learn how Azure Functions have easy integrations with other services, like Azure SQL Database and Azure Logic Apps, that will help in building out the final solution.

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. A visual like an image, table, or list

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

## Serverless APIs

Recall the bus-catching scenario, real-time data containing information about where buses are located is stored in a JSON file. In order to access this information, you could use an API to get the latest data. Once you have the latest data, it needs to be stored somewhere for processing. Processing the data involves checking for buses within the monitored routes as well as proximity to the monitored GeoFence(s). In this scenario, the GeoFence represents the area where you want to be notified that your bus is nearby. As the data is processed, any buses that are entering or exiting the GeoFence should result in a notification, e.g. an email, stating that the specified bus and route is coming soon or has left. Azure Functions contain the capability to complete this task easily and integrate with other services required.

## Azure Functions

Azure Functions accelerate and simplify application development. You can develop more efficiently with Azure Functions, which is an event-driven serverless compute platform that can also solve complex orchestration problems. There is great support for building and debugging locally in Visual Studio Code. You can also deploy and operate at scale in Azure, and integrate services using triggers and bindings.

Azure Functions supports using your preferred language as C#, Java, JavaScript, PowerShell, and Python are all supported. There are also custom handlers to enable you to use any other language as needed.

Azure Functions allow you to host a single method or function to respond to an event. An event could be an HTTP request, a new message on a queue, or a timer. Additionally, Azure Functions scale automatically and you are only charged when a function is triggered, so it is truly a serverless service. Azure Functions allow you to focus on the code that's running your service and not the underlying infrastructure. Since they can be granular, Azure Functions are often used to support microservices architectures. This also allows you to build reusable pieces for different applications.

### Integrating with Azure Logic Apps

Azure Logic Apps is a low-code/no-code development platform hosted as a serverless cloud service. Since Azure Logic Apps have a connector to be triggered when an HTTP POST request is made, calling them from Azure Functions is easy.

In this scenario, an Azure Function will be used to do the data collection and processing of real-time bus data. Once the Azure Function detects that there is a bug entering or exiting the GeoFence, the function calls an Azure Logic App to send notifications in the form of an email. More on this service and solution will be later in the module.

### Integrating with Azure SQL Database

Azure Functions support many languages as mentioned above and so does Azure SQL, including Azure SQL Database, Azure SQL Managed Instance, and SQL Server on Azure VM. This means that connecting and accessing Azure SQL Database from Azure Functions is as simple as obtaining the correct driver and formatting your connection strings accordingly.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
<!-- Do not add a unit summary or references/links -->