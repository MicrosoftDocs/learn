Knowing how Azure Cosmos DB for NoSQL works is one thing. Deciding if it's right for Contoso is another. This unit covers how to make that call, including for AI workloads, so you can weigh any workload's requirements against what the service offers.

## Signals that the service fits

Certain workload characteristics point toward Azure Cosmos DB for NoSQL. Look for these fit signals:

- **Rapidly evolving**: Your data arrives in varied shapes, or its structure changes over time, and a fixed relational schema would slow development or cause downtime for index updates.
- **Variable request volumes**: Traffic rises and falls, sometimes sharply, and you want throughput to follow demand rather than sit at peak capacity.
- **Predictable latency**: Your application is latency sensitive, and requires fast, consistent response times regardless of request volume or database size.
- **Mission critical**: Your application has strict uptime or resiliency requirements (RTO) with predictable data preservation (RPO).

The more of these signals a workload shows, the stronger the case for the service. The Contoso application, which is globally distributed and expects variable demand, matches several of them.

:::image type="content" source="../media/evaluate-fit-decision-tree.png" alt-text="Diagram with two columns showing five Azure Cosmos DB for NoSQL fit signals and three cases when another option fits better." lightbox="../media/evaluate-fit-decision-tree.png":::

## Modern and AI use cases

Azure Cosmos DB for NoSQL suits a broad range of applications (retail catalogs and shopping carts, web and mobile back ends, IoT telemetry, and gaming) because each benefits from flexible schema, elastic scale, and low latency.

AI applications add a further dimension. Because the NoSQL API stores vectors alongside operational data in the same documents, it serves several roles in an AI application:

- **Operational store**: The database of record for application data such as users, orders, and content.
- **Retrieval and grounding data**: A source of relevant, up-to-date content that an AI application retrieves to ground its responses.
- **Agent memory**: A durable place to store the state and history that an AI agent needs across interactions.

Keeping vectors and their source data together simplifies the architecture, because you manage one store rather than synchronizing a separate vector database with your operational data. For the Contoso team, this colocation is why the service remains a strong fit even as the application adds AI features in a later phase.

> [!NOTE]
> This module positions AI use cases so you can factor them into an adoption decision. You learn to implement vector search, retrieval, and agent memory in later modules.

## When Azure Cosmos DB might not add enough value

Workload size alone doesn't determine whether Azure Cosmos DB for NoSQL is a good fit. Instead, consider whether its capabilities solve requirements that your current platform can't address.

Consider another approach when:

- **An existing database already meets the requirements**: If the current platform satisfies the application's latency, availability, scale, schema, integration, and roadmap needs, migrating might add cost and complexity without delivering a measurable benefit. This consideration is especially relevant for packaged or integrated applications that depend on features of an existing relational engine.
- **Correctness depends on relational behavior across many entities**: Azure Cosmos DB supports transactions with atomicity, consistency, isolation, and durability (ACID). But a workload that frequently requires enforced foreign-key relationships, or joins across independently managed records might be simpler to implement with a relational model.
- **The primary workload is analytical**: Repeated full-dataset scans, complex aggregations, broad joins, and ad hoc historical reporting aren't the primary design target of the transactional store. An analytical platform might be a better primary store, or it can complement Azure Cosmos DB when the application also needs an operational database.
- **The access patterns don't support an effective partitioning strategy**: If common operations can't target a partition key and storage or requests can't be distributed evenly, the design might produce persistent cross-partition queries or hot partitions. Reconsider the data model or database choice if those problems can't be resolved through modeling.

Evaluate fit by asking which capabilities the application genuinely needs and which tradeoffs its access patterns impose. A workload doesn't need to be large or globally distributed to benefit from Azure Cosmos DB, but adopting it should solve a concrete application or operational requirement.

> [!TIP]
> Take a workload you know and list its requirements for scale, geographic reach, schema flexibility, consistency, and any planned AI features. Weigh those requirements against the fit signals and the cases for choosing another option. 

With a way to evaluate the service in hand, you're ready to move from decision to practice. Next, you explore the resources and basic operations you use to work with an account.
