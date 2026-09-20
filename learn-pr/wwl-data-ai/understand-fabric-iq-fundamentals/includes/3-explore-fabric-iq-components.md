Microsoft Fabric IQ brings together six items that work as an integrated ecosystem. Each item serves a specific role in how you define, query, analyze, visualize, plan, and automate actions on your business data. Understanding these items helps you choose the right tool for each task.

The six items in the IQ workload are:

- **Ontology items** define your business vocabulary and bind concepts to data sources
- **Data agents** answer natural language questions across multiple data sources
- **Graph** stores and queries connected data using relationships
- **Semantic models** provide a starting point for generating ontologies from existing Power BI models
- **Operations agents** monitor live data and trigger governed actions based on ontology rules
- **Planning** enables collaborative planning, forecasting, and reporting from a shared data foundation

## Ontology items: Define your business vocabulary

An **ontology item** is where you build your shared business vocabulary. You define the business concepts that matter to your organization, then bind them to actual data sources in OneLake. At Contoso Offshore, you bind Equipment to a prepared lakehouse equipment register and optionally add time-series bindings for equipment measurements in an eventhouse.

Your team defines Project, Vessel, Equipment, Foundation, InstallationTask, and MaintenanceOrder as entity types. Properties include `ProjectId`, `VesselName`, and `PlannedStart`. Relationships such as `Project hasTask InstallationTask` and `InstallationTask requiresEquipment Equipment` connect these concepts into a shared vocabulary for installation readiness.

The ontology defines your business concepts that can be used by Graph in Microsoft Fabric for visualization and traversal, and by data agents for answering natural language questions.

## Data agents: Query data with natural language

A **Fabric data agent** is a conversational Q&A system powered by generative AI. You configure it with up to five data sources in any combination (lakehouses, warehouses, KQL databases, Power BI semantic models, or ontologies), and it uses Azure OpenAI Assistant APIs to process natural language questions.

When you ask a question, the data agent parses it, identifies the most relevant data source, and generates the appropriate query. For lakehouses and warehouses, it generates SQL. For Power BI semantic models, it generates DAX. For KQL databases, it generates KQL. For ontologies, it uses the defined business vocabulary to understand context.

At Contoso Offshore, a project manager asks, "Which installation tasks require crane E001, and which projects do they belong to?" The ontology supplies the meaning of Equipment, InstallationTask, and Project, along with their relationships. The data agent uses this business context to answer without requiring the project manager to write queries.

To answer the broader question, "Which installations are at risk tomorrow?", you also need explicit logic that checks maintenance status, whether an order blocks operation, and whether its blocking interval overlaps the task's planned interval. Validate the agent's answers against known examples such as task T001 and maintenance order M001.

You enhance data agent accuracy by providing **data agent instructions** (guidance on which data source to use for specific question types) and **example queries** (sample question-query pairs that illustrate expected responses). This customization aligns the data agent with your organization's specific terminology and data access patterns.

Data agents enforce read-only access and apply security protocols to ensure users only see data they have permission to access. You can publish data agents to Microsoft 365 Copilot or integrate them with Microsoft Copilot Studio to extend their reach beyond Fabric.

## Graph in Microsoft Fabric: Visualize and traverse relationships

**Graph in Microsoft Fabric** offers native graph storage and compute for connected data. Unlike relational databases that require complex joins to navigate relationships, it uses a **labeled property graph model** where nodes (entities) and edges (relationships) carry labels and properties that make connections explicit and easy to traverse.

When you create an ontology item, a managed graph is automatically created from your ontology's entity types and relationships. You query it using **GQL (Graph Query Language)**, an international standard for graph queries. Graph supports relationship-heavy questions like "Which tasks in project P001 require crane E001?" or "Which foundations are scheduled for installation by vessel V001?"

In Contoso Offshore's instance graph, maintenance order M001 affects crane E001. Task T001 requires that crane, and project P001 has that task. Starting at the maintenance order, you follow `affects` to the equipment, then traverse `requiresEquipment` and `hasTask` in reverse to find the dependent task and its project. These connections explain a dependency; checking schedule overlap determines whether the task is at risk.

Graph in Microsoft Fabric operates directly on OneLake without requiring data duplication or ETL. Its scale-out architecture can handle large-scale graph structures with many relationships. You can explore graph data visually through the graph interface or write GQL queries for more complex analysis.

Ontology and Graph in Microsoft Fabric work together seamlessly. The ontology declares your business concepts and relationships, then automatically creates a graph structure. Graph in Microsoft Fabric stores and computes the traversals, enabling visual exploration and advanced queries over your connected data.

## Semantic models: Generate ontologies from existing data models

A **Power BI semantic model** provides a structured representation of your data with tables, columns, relationships, and business logic already defined. In the context of Fabric IQ, semantic models serve as an excellent starting point for creating ontologies.

When you generate an ontology from an existing semantic model, Fabric IQ automatically creates:

- **Entity types** matching your semantic model tables (like Project, Vessel, Equipment, and InstallationTask)
- **Properties** matching your table columns (like ProjectId, VesselName, and PlannedStart)
- **Relationship types** based on your semantic model relationships (like those linking projects to tasks and tasks to vessels)
- **Keys** identifying unique instances of each entity type

This approach is significantly faster than building an ontology from scratch. Instead of manually creating each entity type and defining every property and relationship, you start with a complete structure that reflects your existing data model.

Contoso Offshore's data team generates an ontology from an existing semantic model with project, vessel, equipment, foundation, task, and maintenance tables. The team reviews the generated entity types, names the relationships to express business meaning, and verifies that task-equipment mappings represent `requiresEquipment`. They then extend Equipment with time-series measurements from an eventhouse.

After generating an ontology, you refine it by:
- Verifying that entity type keys are correctly identified
- Confirming that data bindings map to the right source columns
- Adding additional entity types from other data sources (like eventhouse streams)
- Enhancing relationships with binding information that links to actual data

This workflow lets you leverage existing modeling work while extending it with Fabric IQ's cross-domain reasoning and graph capabilities.

## Operations agents: Monitor data and trigger actions

An **operations agent** is an AI agent that monitors real-time data and recommends or triggers business actions based on rules defined in your ontology. Where data agents answer questions, operations agents take action.

For Contoso Offshore, consider a monitoring rule: "If a crane's hydraulic temperature exceeds the maintenance team's configured threshold, notify that team." This requires an explicit condition and a configured response in the monitoring solution. Defining `Vessel carries Equipment` alone doesn't create an alert, declare a crane unavailable, or authorize changes to an installation schedule.

Operations agents reason across both live streaming data in Eventhouse and historical data in lakehouse, applying ontology-defined rules to detect anomalies and drive governed responses. This connection between ontology rules and real-time action is what makes Fabric IQ an operational intelligence layer, not just an analytical one.

## Planning: Collaborate on business planning

**Planning** is a no-code platform for collaborative planning, forecasting, and reporting from the same data foundation that powers your analytics and ontologies. Teams build planning sheets, forecasts, and actuals comparisons without switching tools or exporting data.

Planning connects directly to Power BI semantic models, so dimensions, measures, and hierarchies already defined in your semantic models flow into planning sheets automatically. This means business concepts like revenue targets, inventory thresholds, and budget allocations stay consistent across reports, ontologies, and planning experiences.

Contoso Offshore's project planning team uses Planning to forecast vessel utilization and installation costs for the coming weeks. The team connects to the Power BI semantic model used to generate its ontology. Shared project and vessel definitions help align forecasts with the task and equipment dependencies explored through the ontology. Each experience still depends on its own data refresh behavior; shared definitions don't guarantee a continuously live view of operational readiness.
