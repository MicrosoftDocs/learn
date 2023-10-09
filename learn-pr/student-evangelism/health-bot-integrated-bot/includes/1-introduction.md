The healthcare bot has been receiving inputs from users. But the data isn't stored anywhere. What if we retrieve the data on a website so the doctor can see appointments? To do that, we have to store the data in a database. We can use the data connection step in Azure Health Bot. In this step, we can connect to a [Fast Healthcare Interoperability Resources (FHIR)](https://azure.microsoft.com/services/azure-api-for-fhir/) database and also any normal databases, such as SQL.

In this tutorial, we demonstrate the connection by using a SQL database hosted on Azure.

## Architecture

To make the connection, follow the architecture. The architecture has three main components:

- The Azure Health Bot platform

- A logic app

- SQL Server and Azure SQL Database

Although Azure provides various framework options, we use Node.js. It's a popular choice in the development community.

The following diagram illustrates the architecture options:

:::image type="content" source="../media/1-architecture.png" alt-text="Diagram that shows the architecture of a health bot data connection.":::

Let's now learn the steps to connect the database. By the end of this module, the bot is going to store the data in the SQL database.

## Learning objectives

In this module, you'll:

- Learn how to connect the healthcare bot to a database.
- Build a database by using Azure SQL Database.  
- Integrate the bot with the database by using Azure Logic Apps.

## Prerequisites

### Modules

- Introduction to Azure Health Bot
- Basic Azure Health Bot
- Enhanced Azure Health Bot

### Knowledge

- Familiarity with Azure Logic Apps
- Basic knowledge about SQL Database

**This module was produced in partnership with Meghana Chikkam and Shreyan J D Fernandes, Microsoft Learn Student Ambassadors, and members of the Azure Health Bot product group.**
