Azure Logic Apps includes many connectors to integrate with Microsoft and third-party services. If you want to connect a Logic App to a Web API that is not available already as a connector, you can create a custom connector for it.

You're the lead developer at a picture framing company. Some of your company’s picture frame data is only accessible through a custom-built, in-house REST API. You have plans to build many automated workflows in Azure Logic Apps that need access to this data. For example, you want a workflow that automatically quotes a price for a frame given its dimensions.

You’ll need to create a custom connector for the picture framing  REST API so that you can access it in Logic Apps.

In this module, you will learn about custom connectors and how they determine the schema of a Web API. Then, you'll create a custom connector and use it to call the API from a Logic App.

By the end of this module, you will be able to call any Web API from a Logic App.

## Learning objectives

In this module, you will:

- Create a custom Logic Apps connector
- Define the behavior of the container using an OpenAPI definition
- Use the connector from a Logic App

## Prerequisites

- Basic familiarity with the authoring and running of Logic Apps
- A basic understanding of APIs and REST