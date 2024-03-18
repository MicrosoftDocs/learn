Azure Functions enables developers to develop and run small pieces of code, or "functions," in the cloud. You can write just the code you need for the problem at hand, without worrying about a whole application or the infrastructure to run it. Functions can make development more productive, and you can use your development language of choice, such as C\#, Java, JavaScript, PowerShell, and Python.

## Stream processing support with Azure Functions

You can run Azure Functions from Azure Stream Analytics by configuring Functions as one of the outputs sinks to the Stream Analytics job. Functions provide an event-driven, compute-on-demand experience that lets you implement code that is triggered by events occurring in Azure or third-party services. This ability of Functions to respond to triggers makes it a natural output to Stream Analytics jobs.

### Triggers

Stream Analytics invokes Functions through HTTP triggers. The Functions output adapter allows users to connect Functions to Stream Analytics, such that the events can be triggered based on Stream Analytics queries.

> [!NOTE]
> The Azure Functions output can also be used to relay messages into unsupported databases, like Redis, or update tables in Azure SQL.

## Features of Azure Functions

Here are some key features of Azure Functions:

 -  Choice of language - Write functions using your choice of C\#, Java, JavaScript, Python, and other languages. See Supported languages for the complete list.
 -  Pay-per-use pricing model - Pay only for the time spent running your code. See the Consumption hosting plan option in the pricing section.
 -  Bring your own dependencies - Functions supports NuGet and npm, so you can use your favorite libraries.
 -  Integrated security - Protect HTTP-triggered functions with OAuth providers such as Microsoft Entra ID, Facebook, Google, Twitter, and Microsoft Account.
 -  Simplified integration - Easily apply Azure services and software-as-a-service (SaaS) offerings. See the integrations section for some examples.
 -  Flexible development - Code your functions right in the portal or set up continuous integration and deploy your code through GitHub, Azure DevOps Services, and other supported development tools.
 -  Open-source - The Functions runtime is open-source and available on GitHub.

## Additional resources

The following resources describe the use of Azure Functions within Azure IoT solutions:

 -  [Tutorial: Run Azure Functions from Azure Stream Analytics jobs](/azure/stream-analytics/stream-analytics-with-azure-functions)
 -  [Azure Functions output from Azure Stream Analytics](/azure/stream-analytics/azure-functions-output)
 -  [Azure IoT Hub bindings for Azure Functions](/azure/azure-functions/functions-bindings-event-iot)
 -  [Azure IoT Hub trigger for Azure Functions](/azure/azure-functions/functions-bindings-event-iot-trigger)
