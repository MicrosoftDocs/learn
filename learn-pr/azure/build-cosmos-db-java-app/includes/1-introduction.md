Imagine you're managing storage for an online retailer. You need tools to create, update, and delete your user and product data.

In this module, you will build a Java console application to create, update, and delete user records and query your data using Java.

We will use the Maven package manager to structure our project and pull in dependencies.

## Why Azure Cosmos DB?

A hypothetical company managing its global retail operations in the cloud may benefit from Azure Cosmos DB. The company's engineers may need to guarantee that point-of-sale (POS) devices can persist data to a cloud database with short response time to each request. If the company maintains a database of inventory stock, they may want to insure that this database is highly available (to avoid customer dissatisfaction) and globally distributed (to ensure customers globally see a responsive web page.) Furthermore, the load on the company's global retail system may vary dramatically throughout the year and especially aligned with retail holidays. The company knows that the load on its database will peak only in the weeks around retail holidays, and they are looking for a pricing model where they pay for what they consume rather than paying for peak consumption.

Azure Cosmos DB is Azure's NoSQL cloud database, offering performance SLAs on latency and availability, as well as turnkey global distribution which lets your users interact with geographically local copies of your database. These features may satisfy the retail company's global high-availability/low-latency requirements. By manually scaling database throughput in code or using autoscale throughput, the company can expect to pay only for the service throughput it consumes in a given hour.

To help users get started with Azure Cosmos DB, this lab guides you through developing a basic Java-language client.

## Learning objectives

In this module, you will:  

- Learn how to send requests to Azure Cosmos DB from a Java application
- Create an application to store and query data in Azure Cosmos DB

## Prerequisites

- Experience creating and managing Azure Cosmos DB resources such as an **account**, a **database** and a **container**.
- Local installations of [Apache Maven](https://maven.apache.org/), [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), and [Java JDK 8 or later versions](https://www.microsoft.com/net/download), and beginner-level familiarity with all three.
