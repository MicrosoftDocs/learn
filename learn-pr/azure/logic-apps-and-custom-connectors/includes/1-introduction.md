Azure Logic Apps includes many prebuilt connectors that integrate with Microsoft, Azure, Microsoft 365, and external services. But if you want to connect from your logic app workflow to a Web API that's not available as a connector, you can create a custom connector for that API.

Imagine you're the lead developer at a picture-frame company. You and other developers can access some of your company's picture-frame data, but only through an in-house, custom-built REST API. You plan to create many automated workflows in Azure Logic Apps and need access to this data. For example, you want to create a workflow that automatically quotes a price for a frame based on the dimensions.

You'll need to create a custom connector for the picture frame REST API so that you can access that API from Azure Logic Apps.

In this module, you'll learn about custom connectors and how they determine the schema for a Web API. Then, you'll create a custom connector, which you'll use to call the API from a logic app workflow.

By the end of this module, you'll have the ability to call any Web API from a logic app workflow.

## Learning objectives

In this module, you'll complete the following tasks:

- Create a custom Azure Logic Apps connector.
- Define the behavior of the container using an OpenAPI definition.
- Use the connector from a logic app workflow.

## Prerequisites

- Basic familiarity with the authoring and running workflows in Azure Logic Apps
- A basic understanding of APIs and REST
