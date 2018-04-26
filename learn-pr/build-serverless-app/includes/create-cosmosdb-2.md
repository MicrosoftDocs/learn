## Overview of Cosmos DB

Azure Cosmos DB is Microsoft's globally distributed, multi-model database. With the click of a button, Azure Cosmos DB enables you to elastically and independently scale throughput and storage across any number of Azure's geographic regions.

## Capability comparison

Azure Cosmos DB provides the best capabilities of traditional relational and non-relational databases.

| Capabilities | Relational databases	| Non-relational (NoSQL) databases | 	Azure Cosmos DB |
| --- | --- | --- | --- |
| Global distribution | No | No | Yes, turnkey distribution in 30+ regions, with multi-homing APIs|
| Horizontal scale | No | Yes | Yes, you can independently scale storage and throughput | 
| Latency guarantees | No | Yes | Yes, 99% of reads in <10 ms and writes in <15 ms | 
| High availability | No | Yes | Yes, Azure Cosmos DB is always on, has well-defined PACELC tradeoffs, and offers automatic and manual failover options|
| Data model + API | Relational + SQL | Multi-model + OSS API | Multi-model + SQL + OSS API (more coming soon) |
| SLAs | Yes | No | Yes, comprehensive SLAs for latency, throughput, consistency, availability |

In this tutorial, you'll use an Azure Cosmos DB instance to host your metadata about the images that are uploaded through your serverless web application.