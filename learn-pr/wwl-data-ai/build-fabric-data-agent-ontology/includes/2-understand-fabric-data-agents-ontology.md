A Fabric data agent is a conversational interface to your data. It connects to data sources in your Fabric environment — people ask questions in natural language and get data-backed answers without writing queries or building reports. In this module, the focus is on using an ontology as the data source.

## What is a Fabric data agent?

When you ask a question, the agent identifies the relevant data source, generates a query in the appropriate language (SQL, DAX, KQL, or GQL depending on the source type), executes the query, and returns the result.

Each agent can connect to up to five data sources in any combination:

- **Lakehouses** — query Delta tables using SQL
- **Warehouses** — query structured data using SQL
- **KQL databases** — query event streams and time-series data using KQL
- **Power BI semantic models** — query business metrics using DAX
- **Ontologies** — query graph-structured domain models using GQL
- **Microsoft Graph** — query organizational data (people, calendars, files) using Microsoft Graph APIs

> [!NOTE]
> The agent runs under the querying user's Entra ID identity — it can only reach data that user is authorized to view, and it's strictly read-only. For more information, see [Fabric data agent sharing and permission management](/fabric/data-science/data-agent-sharing#sharing-permission-models-and-required-source-access).

## What is an ontology?

An **ontology** is a structured model that describes your business domain — the entity types, their properties, and how they relate to each other. Instead of raw column names like `rm_id` or `adm_flag` that you might find in a database schema, an ontology uses business terms like `Room`, `Patient`, and `admittedTo`.

The Lamna Healthcare ontology defines entity types like **Hospital**, **Department**, **Room**, **Patient**, and **VitalSignEquipment**. Each entity type has properties that describe its characteristics: a Room has properties like `roomNumber`, `capacity`, and `isOccupied`. Relationships connect entities in meaningful ways: a Patient is `admittedTo` a Room, and a Room is `inDepartment` a Department.

**Connecting to the ontology** gives the agent a structured vocabulary so it maps natural language questions to defined entity types, properties, and relationship labels rather than guessing from raw column names. The Lamna ontology is bound to lakehouse tables and an eventhouse — when the agent queries through the ontology layer, it accesses real data while using the conceptual structure the ontology provides.

This combination of meaningful vocabulary and real data bindings makes the ontology a bridge between how clinical staff ask questions and how data is stored.

## How the agent uses the ontology

When you use an ontology as the data source, the Fabric data agent generates **GQL (Graph Query Language)**. GQL is designed to traverse the graph structure of the ontology, following relationships between entities.

Here's how it works. When a nurse manager asks "Which departments have patients without vital sign equipment assigned?", the agent matches "departments" to the `Department` entity type, traverses the `inDepartment` relationship to find rooms, follows `admittedTo` to reach patients, and checks whether a `VitalSignEquipment` entity is linked to each patient's room. This semantic understanding guides the agent to generate GQL that retrieves the answer.

The process relies on the ontology's structure. The agent interprets "ICU" as a department filter, "beds" as rooms, and "occupied" as the `isOccupied` property or the presence of an `admittedTo` relationship. This mapping happens because the ontology defines these concepts explicitly. But terms like "ICU" or "beds" aren't always exact matches to entity type names or property values. That's where **instructions** come in — natural language guidance you write when configuring the agent to explain how domain-specific vocabulary maps to ontology concepts.

The agent's ability to generate accurate GQL depends entirely on how well the ontology models your domain and how clearly your instructions explain common question patterns.

## What the ontology layer provides

The agent inherits the ontology's governance layer. Entity definitions, relationships, and data bindings all flow through the ontology — you manage these in one place rather than configuring them separately for each agent. When the clinical team adds a new entity type like `MedicalDevice`, the agent immediately understands questions about devices without reconfiguration.

This centralized structure also means every user who asks the same question gets the same interpretation. The ontology defines how domain vocabulary maps to data, so results are consistent and repeatable.
