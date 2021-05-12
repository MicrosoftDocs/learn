Modern applications face new challenges that many traditional database platforms are ill-equipped to handle such as:

- The ability to provide high performance irrespective of the volume of data
- The ability to provide low latency experience irrespective of the number of requests
- Ensuring highest possible availability
- Enabling development and deployment agility through support for flexible schema
- Minimizing the need for management
- Providing local latency data access globally

Suppose you work as the lead developer at a retail company. Your team is building your online storefront. The new storefront will be designed to be accessible across various devices including mobile. The team expects a spike in demand when the storefront is published and various "grand opening" sales begin.

As the lead developer, you have been tasked with identifying a database platform. The database platforms you consider should be able to service the data your team will generate and collect over time. The selected database should also be able to handle a large variety of data, at high volumes and velocity. Your database solution needs to scale quickly and with little friction in order to handle this demand that is both growing and variable.

:::image type="complex" source="../media/1-gaming.svg" alt-text="Illustration of a game growing in usage connected to servers and a database" border="false":::

Architectural diagram for a gaming workload that includes:

1. A growing number of gamers playing a video game
1. A collection of compute resources handling requests from the game instances
1. A generic database storing game data

:::image-end:::

## Azure Cosmos DB

Azure Cosmos DB is a fully managed NoSQL database service for modern app development and provides low-latency, high-availability, and elastic scale-out.

:::image type="icon" source="../media/1-icon.svg" border="false":::

Here, you'll see how Azure Cosmos DB and its SQL API can be used for this type of business problem. You'll also learn a bit about how the database works. At the end, this module will help you decide if Azure Cosmos DB's SQL API is a good choice for your solutions.

## Learning objectives

By the end of this module, you'll be able to:

- Describe the Azure Cosmos DB SQL API

## Prerequisites

- Ability to navigate the Azure portal
