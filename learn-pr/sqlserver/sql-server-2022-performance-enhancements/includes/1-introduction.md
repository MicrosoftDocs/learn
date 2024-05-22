---
ms.custom:
  - build-2023
---
In this module, you learn about the Intelligent Query Processing (IQP) features that were enhanced in SQL Server 2022.

IQP is a family of capabilities built into the query processor in the database engine. They're designed to accelerate performance with no code changes. The next generation of Intelligent Query Processing is built on a foundation of capabilities found in SQL Server 2017 and 2019:

:::image type="content" source="../media/iqp-feature-family.svg" alt-text="Chart that shows the SQL Server Intelligent Query Processing feature family.":::

As you can see in this diagram, there are several IQP features that are part of SQL Server 2017 and SQL Server 2019. SQL Server 2022 adds several new capabilities for IQP. This module focuses on the following features:

- Memory grant feedback
- Parameter Sensitive Plan optimization
- Degree of Parallelism feedback

## Query Store for IQP

SQL Server 2022 provides built-in capabilities to reduce time for query tuning with the Query Store and next generation of IQP features to help you gain faster and consistent performance with no code changes.

The database engine uses two principles to make decisions for IQP:

- Avoid causing any query performance regressions by using a new method or automation.
- Provide a method at the database or query level to disable a specific IQP capability.

This approach allows you to choose which IQP feature you want enabled at the database or query level. Use the other IQP feature depending on your database compatibility level.

While the Query Store collects key performance information for queries, the query processor in SQL Server 2022 also uses the Query Store to persist information to accelerate query performance. This information includes supporting features such as:

- Optimized Plan Forcing
- Memory Grant feedback
- Cardinality Estimation (CE) Model feedback
- Degree of Parallelism (DOP) feedback.

## Example scenario

Imagine that you're a database administrator at the World Wide Importers Corporation. You oversee the adoption of SQL Server 2022. Some databases that you manage need to maintain their legacy compatibility mode of 140. Some can be upgraded to the current compatibility mode of 160. In each scenario, you need use the best practices when you apply the latest functionality available to optimize the performance of your systems.

To do this task, use the Intelligent Query Processing advancements in SQL Server 2022. Your goal is to implement these low-code to no-code changes.

## Learning objectives

At the end of this module, you can:

- Understand the key functionality behind Intelligent Query Processing and when to implement the feature
- Understand automatic performance healing with memory grant feedback persistence
- Know how to get consistent performance with Parameter Sensitive Plan optimization
- Gain parallel efficiency with DOP Feedback
