Azure Functions is an event-driven serverless compute platform that can also solve complex orchestration problems for many scenarios.

Getting the timing right of heading to the bus stop is a challenge that most can relate to. More often than not, you either end up waiting for the bus or running to catch the bus and missing it. Throughout this module and the associated learning path, you'll follow the scenario (and the development of a solution) of catching the bus. In the first module of the learning path, you built the foundation, which includes the database backend. Review the architecture below to see what the desired-state solution is.

:::image type="content" source="../media/1-catch-the-bus.svg" alt-text="Potential architecture for a solution to the catching the bus scenario.":::

In this module, you'll break down the scenario for an application and build a multi-service architecture, which is based on the microservices approach. In the language of your choice (Node.js, Python, or .NET), you'll use an Azure Function that adds real-time data to an Azure SQL Database and triggers an Azure Logic App for notifications when a bus enters a geofence. You'll also use GitHub Actions for CI/CD.

By the end of the module, you'll be able to deploy Azure Function Apps in any language and integrate them with Azure SQL Database and Azure Logic Apps. You'll learn how to build backend APIs with Azure Functions and how services like Azure SQL Database can help in easing development.
