Azure Logic Apps includes many connectors to integrate with Microsoft and third-party services. If you want to connect a logic app workflow to a Web API that is not available already as a connector, you can create a custom connector for it.

You're the lead developer at a picture framing company. Some of your company’s picture frame data is only accessible through a custom-built, in-house REST API. You have plans to build many automated workflows in Azure Logic Apps that need access to this data. For example, you want a workflow that automatically quotes a price for a frame given its dimensions.

You’ll need to create a custom connector for the picture framing  REST API so that you can access it from Azure Logic Apps.

In this module, you will learn about custom connectors and how they determine the schema of a Web API. Then, you'll create a custom connector and use it to call the API from a logic app workflow.

By the end of this module, you will be able to call any Web API from a logic app workflow.

## Learning objectives

In this module, you will:

- Create a custom Azure Logic Apps connector
- Define the behavior of the container using an OpenAPI definition
- Use the connector from a logic app workflow

## Prerequisites

- Basic familiarity with the authoring and running of Azure Logic Apps
- A basic understanding of APIs and REST
