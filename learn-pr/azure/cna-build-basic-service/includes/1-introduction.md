Cloud-native applications are modular in nature, with loosely coupled, self-contained components. You can implement each of these components independently, using its own technology stack by using cloud services such as Azure Kubernetes Service (AKS) and Azure Database for PostgreSQL. These cloud services allow you to choose the open-source technologies that you're used to, but rely on Azure to perform most of the administration and deployment tasks for you. In addition, you can be more agile in your design and don't need to strive to predict future requirements.

## Scenario: Build a basic service

Suppose you work for Adatum Corporation, which is a manufacturer of smart appliances, including refrigerators and air-conditioning units. You lead a small development team, and you've been tasked with building a multiple-feature app for smart refrigerators.

The initial version of the app, in the form of an Express.js web service, exposes a basic set of refrigerator inventory functions, helping businesses identify the items they need to restock. A front-end Next.js web app provides management capabilities. You containerized both apps and deployed them to an AKS cluster. Now you want to provide both apps with a persistent data store by using Azure Database for PostgreSQL.

## Prerequisites

* Basic familiarity with Azure
* Basic understanding of cloud computing
* Basic familiarity with programming concepts

## Learning objectives

After completing this module, you'll be able to:

* Describe the concept of service in the context of cloud-native applications.
* Set up a basic service.
* Extend the services architecture.
* Implement Azure Database for PostgreSQL.
* Connect Node.js Express to Azure Database for PostgreSQL.
* Set up a Next.js management web app.
