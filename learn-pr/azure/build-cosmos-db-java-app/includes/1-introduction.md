Imagine you're managing storage for an online retailer. You need tools to create, update, and delete your user and product data. You also need the ability to query your data in order to make business or operations decisions.

In this module, you'll build a Java console application to create, update, and delete user records and query your data by using Java. This module will provide two sets of code samples - one for using Azure Cosmos DB Java SDK directly, and another using the Spring Data programming model for Java.

We'll use the Maven package manager to structure our project and pull in dependencies.

## Why Azure Cosmos DB?

A hypothetical company that manages its global retail operations in the cloud might benefit from Azure Cosmos DB. The company's engineers need to guarantee that point-of-sale (POS) devices can persist data to a cloud database with short response time to each request. The company maintains a database of inventory stock. It wants to ensure that this database is highly available (to avoid customer dissatisfaction) and globally distributed (to ensure that customers globally see a responsive webpage). 

Furthermore, the load on the company's global retail system varies throughout the year. The company knows that the load on its database will peak in the weeks around retail holidays. It's looking for a pricing model where it pays for what it consumes rather than paying for peak consumption.

Azure Cosmos DB is a NoSQL cloud database that offers performance service-level agreements (SLAs) on latency and availability. It also offers turnkey global distribution that lets users interact with geographically local copies of a database. These features might satisfy the retail company's global high-availability/low-latency requirements. By manually scaling database throughput in code or using autoscale throughput, the company can expect to pay only for the service throughput that it consumes in a particular hour. 

Azure Cosmos DB, a sharded and replicated NoSQL database, can elastically spin up enough physical machines to handle your application's peak database throughput, and then release that compute when you don't need it. This process of handling load by scaling the number of machines is called *scale-out* or *horizontal scaling*.

To help users get started with Azure Cosmos DB, this lab guides you through developing a basic Java-language client.

## Learning objectives

In this module, you will:  

- Learn how to send requests to Azure Cosmos DB from a Java application
- Create an application to store and query data in Azure Cosmos DB

## Prerequisites

- Knowledge of the Java programming language
- Optional: familiarity with the Spring Data programming model
- Experience creating and managing resources in Azure Cosmos DB, including creation and configuration of Cosmos DB accounts, databases, and containers
- Beginner-level familiarity with and local installations of the following tools: [Apache Maven](https://maven.apache.org/), [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), Java JDK 8 or later, and a Java IDE or text editor
