::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=39006f09-f4f1-4cd7-a09b-10f31aca7050]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Shared definitions connect installation tasks to their required equipment. You now need to choose how to use that context: answer a question, trace a dependency, monitor a condition, or plan future work. The six items in the Fabric IQ workload serve different parts of that decision.

The six items in the IQ workload are:

- **Ontology items** define your business vocabulary and bind concepts to data sources
- **Data agents** answer natural language questions across multiple data sources
- **Graph** stores and queries connected data using relationships
- **Power BI semantic models** provide trusted calculations and a starting point for generating ontologies
- **Operations agents** monitor data and recommend or take configured actions
- **Planning** enables collaborative planning, forecasting, and reporting from a shared data foundation

## Ontology items: Define your business vocabulary

An **ontology item** is where you build your shared business vocabulary. You define the business concepts that matter to your organization, then bind them to actual data sources. For the offshore construction team, you bind Equipment to a prepared lakehouse equipment register and optionally add time-series bindings for equipment measurements in an eventhouse.

Your team defines Project, Vessel, Equipment, Foundation, InstallationTask, and MaintenanceOrder as entity types. Properties include `ProjectId`, `VesselName`, and `PlannedStart`. Relationships such as `Project hasTask InstallationTask` and `InstallationTask requiresEquipment Equipment` connect these concepts into a shared vocabulary for installation readiness.

The ontology supplies context for supported consumers, including agents and optional Graph in Microsoft Fabric execution. Its built-in ontology agent helps authors propose and review definitions and lets users ask questions about bound data. This authoring and exploration experience is distinct from a separately configured Fabric data agent.

## Data agents: Query data with natural language

A **Fabric data agent** is a conversational Q&A system powered by generative AI. You configure it with up to five data sources in any combination (lakehouses, warehouses, KQL databases, Power BI semantic models, or ontologies), and it uses Azure OpenAI Assistant APIs to process natural language questions.

When you ask a question, the data agent parses it, identifies the most relevant data source, and generates the appropriate query. For lakehouses and warehouses, it generates SQL. For Power BI semantic models, it generates DAX. For KQL databases, it generates KQL. For ontologies, it uses the defined business vocabulary to understand context.

A project manager asks, "Which installation tasks require crane E001, and which projects do they belong to?" When the selected source is an ontology, it supplies the meaning of Equipment, InstallationTask, and Project, along with their relationships. The data agent uses this business context to answer without requiring the project manager to write queries.

To answer the broader question, "Which installations are at risk tomorrow?", you also need explicit logic that checks maintenance status, whether an order blocks operation, and whether its blocking interval overlaps the task's planned interval. Validate the agent's answers against known examples such as task T001 and maintenance order M001.

You enhance data agent accuracy by providing **data agent instructions** (guidance on which data source to use for specific question types) and, where supported, **example queries** (sample question-query pairs that illustrate expected responses). Example question-query pairs aren't currently supported for Power BI semantic-model sources. This customization aligns the data agent with your organization's specific terminology and data access patterns.

Data agents enforce read-only access and use the requesting user's permissions. Sharing an agent doesn't grant access to its sources. You can publish data agents to Microsoft 365 Copilot or integrate them with Microsoft Copilot Studio to extend their reach beyond Fabric.

## Graph in Microsoft Fabric: Visualize and traverse relationships

**Graph in Microsoft Fabric** offers native graph storage and compute for connected data. Unlike relational databases that require complex joins to navigate relationships, it uses a **labeled property graph model** where nodes (entities) and edges (relationships) carry labels and properties that make connections explicit and easy to traverse.

An ontology doesn't automatically load entity instances into a graph. You opt in to **graph materialization**, selecting the eligible entity types and relationships needed for your question. Materialization loads that data into a queryable graph. Graph uses **GQL (Graph Query Language)**, an international standard for graph queries.

In a materialized instance graph for the offshore construction team, maintenance order M001 affects crane E001. Task T001 requires that crane, and project P001 has that task. Starting at the maintenance order, you follow `affects` to the equipment, then traverse `requiresEquipment` and `hasTask` in reverse to find the dependent task and its project. These connections explain a dependency; checking schedule overlap determines whether the task is at risk.

Choose Graph when the path itself explains the answer, such as a maintenance-to-equipment-to-task-to-project dependency. A simple equipment lookup or trusted aggregate can stay with its source query engine, avoiding unnecessary materialization and refresh work.

Graph projection has narrower support than ontology binding. Currently, it requires bound, keyed entities backed by Delta tables in lakehouses or mirrored databases. Entities bound to semantic models or multiple backing tables aren't eligible. Generating an ontology from a semantic model therefore doesn't automatically make those entities graph-ready. Source changes can also leave materialized graph data stale until refresh.

For details, see [Materialize a graph from an ontology](/fabric/iq/ontology/how-to-use-ontology-graph).

## Semantic models: Generate ontologies from existing data models

A **Power BI semantic model** provides a structured representation of your data with tables, columns, relationships, and business logic already defined. It remains the place for trusted metrics and interactive reporting, while also providing a starting point for an ontology.

When you generate an ontology from an existing semantic model, Fabric IQ automatically creates:

- **Entity types** matching your semantic model tables (like Project, Vessel, Equipment, and InstallationTask)
- **Properties** matching your table columns (like ProjectId, VesselName, and PlannedStart)
- **Relationship types** based on your semantic model relationships (like those linking projects to tasks and tasks to vessels)
- **Metrics** linked to DAX measures in the source semantic model

This approach reuses existing definitions rather than requiring you to create each element manually. A metric retains its source-owned DAX calculation, so an agent can use an established measure rather than invent a new formula. The generated structure is a starting point that needs review, not a guarantee of complete business meaning.

The offshore construction team generates an ontology from an existing semantic model with project, vessel, equipment, foundation, task, and maintenance tables. The team reviews the generated entity types, names the relationships to express business meaning, and verifies that task-equipment mappings represent `requiresEquipment`. They then extend Equipment with time-series measurements from an eventhouse.

After generating an ontology, you refine it by:
- Verifying entity type keys and adding missing keys where needed
- Confirming that data bindings map to the right source columns
- Adding additional data from other sources (like eventhouse tables)
- Enhancing relationships with binding information that links to actual data

This workflow reuses existing modeling work while adding cross-domain context. If you also need a materialized graph, check its source eligibility separately.

## Operations agents: Monitor data and trigger actions

An **operations agent** monitors data and recommends or takes configured business actions. Where data agents answer questions through read-only queries, operations agents evaluate monitoring conditions and respond through approved actions.

For the offshore construction team, consider a monitoring rule: "If a crane's hydraulic temperature exceeds the maintenance team's configured threshold, notify that team." This requires an explicit condition and a configured response in the monitoring solution. Defining `Vessel carries Equipment` alone doesn't create an alert, declare a crane unavailable, or authorize changes to an installation schedule.

An operations agent uses a selected source, such as an eventhouse or ontology, with instructions and configured actions. You review the generated playbook and the queries behind its rules before starting it. A natural-language rule saved in the ontology supplies business context; it doesn't run itself or create monitoring automatically. Operations agents also require a supported nontrial capacity and their own tenant settings.

## Planning: Collaborate on business planning

**Planning** is a no-code platform for collaborative planning, forecasting, and reporting from the same data foundation that powers your analytics and ontologies. Teams build planning sheets, forecasts, and actuals comparisons without switching tools or exporting data.

Planning connects directly to Power BI semantic models, so dimensions, measures, and hierarchies already defined in your semantic models flow into planning sheets automatically. This means business concepts like revenue targets, inventory thresholds, and budget allocations stay consistent across reports, ontologies, and planning experiences.

The project planning team uses Planning to forecast vessel utilization and installation costs for the coming weeks. The team connects to the Power BI semantic model used to generate its ontology. Shared project and vessel definitions help align forecasts with the task and equipment dependencies explored through the ontology. Each experience still depends on its own data refresh behavior; shared definitions don't guarantee a continuously live view of operational readiness.

The items serve different decisions, but each depends on clear business meaning. To make their answers consistent, you need to distinguish a reusable concept from a schema designed for one report.

::: zone-end
