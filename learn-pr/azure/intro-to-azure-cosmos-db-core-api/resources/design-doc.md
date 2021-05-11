# Introduction to Azure Cosmos DB SQL API

## Role(s)

- [Developer][developer]

## Level

- [Intermediate][intermediate]

## Product(s)

- [Cosmos DB][azure-cosmos-db]

## Prerequisites

- Ability to navigate the Azure portal

## Summary

Implement geo-replication either during the creation of an Azure Cosmos DB account or anytime after. Create an account, configure geo-replication, and then add extra regions later.

## Learning objectives

1. Describe Azure Cosmos DB
1. Describe the Azure Cosmos DB SQL API

## Sub tasks

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Describe Azure Cosmos DB | Identify database platform | Knowledge check | 1 | Yes |
| Describe Azure Cosmos DB SQL API | Identify database platform | Knowledge check | 2 | Yes |

## Outline

1. **Introduction**
    - Suppose you work as the lead developer at a start-up gaming company. Your team is building their first game. The new game will be a persistent online experience playable across various devices. The team expects a spike in demand when the game is published to various subscription services.
    - As the lead developer, you have been tasked with identifying a database platform. The database platforms you consider should be able to service the data your team will generate and collect throughout the lifetime of the game. The selected database should also be able to handle a large variety of data, at high volumes and velocity. Your database solution needs to scale quickly and with little friction in order to handle this demand that is both growing and variable.
1. **What is Azure Cosmos DB?**
    - Azure Cosmos DB overview
    - SQL API overview
1. **How does Azure Cosmos DB work?**
    - Resource model
      - SQL API model
    - Partitioning (Video)
        - Partition Keys
1. **When should you use Azure Cosmos DB?**
    - Common scenarios
      - IoT/telemetry
      - Retail/marketing
      - Web/mobile
    - Module scenario
      - Gaming
1. **Knowledge check**
    - Select correct API (choose list)
    - Partitioning fact (choose list)
    - Partition key required (true/false)
    - Select correct resource (choose list)
1. **Summary**
    - Azure Cosmos DB and its various APIs
    - Accounts, databases, and containers

## Timing

| Unit | Minutes |
| --- | --- |
| What is Azure Cosmos DB? | 5 |
| How does Azure Cosmos DB work? | 8 |
| When should you use Azure Cosmos DB? | 7 |
| Knowledge check | 5 |
| Summary | 2 |
| **TOTAL** | **30** |

## Notes

This module is intended to be part of a learning path for Azure Cosmos DB developers

[azure-cosmos-db]: https://review.docs.microsoft.com/new-hope/information-architecture/metadata/taxonomies#product
[developer]: https://review.docs.microsoft.com/new-hope/information-architecture/metadata/taxonomies#role
[intermediate]: https://review.docs.microsoft.com/new-hope/information-architecture/metadata/taxonomies#level
