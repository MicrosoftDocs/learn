Modern applications face new challenges that many traditional database platforms are ill-equipped to handle such as:

- Managing and syncing data distributed around the globe
- Delivering highly responsive, real-time personalization
- Processing and analyzing large, complex data
- Scaling both throughput and storage based on global demand
- Offering low-latency to global users
- Modernizing existing apps and data
- Offering high-availability to users

Suppose you work as the lead developer at a start-up gaming company. Your team is building their first game. The new game will be a persistent online experience playable across various devices. The team expects a spike in demand when the game is published to various subscription services.

As the lead developer, you have been tasked with identifying a database platform. The database platforms you consider should be able to service the data your team will generate and collect throughout the lifetime of the game. The selected database should also be able to handle a large variety of data, at high volumes and velocity. Your database solution needs to scale quickly and with little friction in order to handle this demand that is both growing and variable.

:::image type="complex" source="../media/1-gaming.svg" alt-text="Illustration of a game growing in usage connected to servers and a database" border="false":::

Architectural diagram for a gaming workload that includes:

1. A growing number of gamers playing a video game
1. A collection of compute resources handling requests from the game instances
1. A generic database storing game data

:::image-end:::

## Azure Cosmos DB

Azure Cosmos DB is a fully managed NoSQL database service for modern app development and provides low-latency, high-availability and elastic automatic scalability.

:::image type="icon" source="../media/1-icon.svg" border="false":::

Here, you'll see how Azure Cosmos DB and its SQL API can be used for this type of business problem. You'll also learn a bit about how the database works. At the end, this module will help you decide if Azure Cosmos DB's SQL API is a good choice for your solutions.

## Learning objectives

By the end of this module, you'll be able to:

- Describe Azure Cosmos DB
- Describe the Azure Cosmos DB SQL API

## Prerequisites

- Ability to navigate the Azure portal
