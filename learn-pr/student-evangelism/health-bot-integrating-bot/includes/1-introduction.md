The healthcare bot so far has been receiving the inputs from users. We can notice that it isn't being stored anywhere. What if we were to retrieve the data on a website for the doctor to see his appointments? To achieve this the data has to be stored in a database. The Azure Health bot provides us a "Data Connection" Step to achieve this. The data connection step has the capability of connecting to a FHIR [Fast Healthcare Interoperability Resources](https://azure.microsoft.com/services/azure-api-for-fhir/) database and also any Normal databases like SQL.

In this tutorial we will be demonstrating the connection with a SQL database hosted on Microsoft Azure.

To achieve this connection, we will be following the architecture which has 3 main components:

- The Azure Health Bot platform

- Logic App

- SQL Server and SQL Database

The framework here will be the Node.js. Azure provides us various options. Since the Node.js has been a popular choice in the development community we will be going ahead with Node.js.

These can be diagrammatically represented as follows

## Architecture

:::image type="content" source="../media/1-architecture.png" alt-text="built bot":::

Let's now dive deep into each section and learn the steps involved in the database connection process. By the end of this module the bot will be able to store the data in the SQL database.

## Learning objectives

In this module, you will:

- Getting to know how to connect healthcare bot to database
- Building a database using Azure SQL Database  
- Integrating the bot with database using Logic Apps

## Prerequisite modules

- Introduction to the Health Bot
- Introduction and Basic Healthcare Bot
- Enhanced Healthcare Bot
- Familiarity with Logic App
- Basic Knowledge on SQL Database

**Produced in partnership with Meghana Chikkam and Shreyan J D Fernandes Microsoft Learn Student Ambassadors and Microsoft HealthBot Product Group**
