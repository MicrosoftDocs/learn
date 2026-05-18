This guided project focuses on building a simple HTTP endpoint using Azure Functions.

Azure Functions is a serverless compute service that lets you run code in response to events without managing infrastructure. You write a function, deploy it, and Azure handles the scaling and hosting. With an HTTP trigger, your function gets its own URL that anyone can call from a browser.

## Scenario

Your team needs a lightweight endpoint for a contact page without maintaining servers. You create a Function App, deploy an HTTP-triggered function using Cloud Shell, and then test, secure, and monitor the endpoint—all in one session.

- Exercise 1 - Create a Function App with the serverless Flex Consumption plan.
- Exercise 2 - Deploy an HTTP-trigger function from Cloud Shell.
- Exercise 3 - Test the endpoint, add security, and review logs.

:::image type="content" source="../media/overview-architecture.png" alt-text="Diagram of a serverless HTTP endpoint using Azure Functions with an HTTP trigger, function key, and Application Insights." border="false":::

By the end of this project, you have a live HTTP endpoint that responds to requests, requires an access key for security, and logs every invocation to Application Insights.

> [!NOTE]
> This is a guided project module where you complete a project by following step-by-step instructions.

## Skilling areas

In this project, you practice skills in the following areas:

**Create and configure a Function App**
+ Create a resource group and a Function App.
+ Select the Flex Consumption hosting plan.
+ Verify deployment status in the portal.

**Deploy a function using Cloud Shell**
+ Open Cloud Shell and initialize a function project.
+ Create an HTTP-triggered function.
+ Deploy the function to Azure from the command line.

**Test, secure, and monitor a function**
+ Call the HTTP endpoint from a browser.
+ Enable Application Insights for monitoring.
+ Change the authorization level to require a function key.
+ Review invocation logs and execution details.

> [!IMPORTANT]
> This project uses the Azure portal for every step. No prior Azure experience is required.
