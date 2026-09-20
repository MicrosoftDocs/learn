Fabric IQ is part of Microsoft IQ, a set of capabilities that form the enterprise intelligence layer of the Microsoft stack. Microsoft IQ works across four areas: Work IQ provides context on how employees work, Foundry IQ provides context on policies and documents, Web IQ provides context from the web, and Fabric IQ provides context on business entities and data.

Within Microsoft Fabric, IQ is a dedicated workload where you create **ontology items**—Fabric artifacts that contain your ontology definitions and data bindings.

## Define an ontology

An ontology is a shared vocabulary of your business. It's made up of the things in your environment (represented as entity types), their facts (represented as properties of entity types), and the ways they connect (represented as relationships), while offering constraints and rules that keep those representations consistent.

You can also think of an ontology like a business context layer, containing:

- A catalog of concepts (like Project, Vessel, and Equipment) with their properties and relationships
- Data bindings to your lakehouse tables, eventhouse streams, and Power BI semantic models
- A graphical representation that links related concepts for navigation and analysis
- A query surface that lets you ask questions about concepts (not just tables), supporting federated queries across sources

Instead of requiring data experts to translate business questions into SQL queries, you model data using business concepts that everyone understands.

The ontology provides a single definition of each concept that can be used by data agents and Graph in Microsoft Fabric for querying and visualization.

### Position ontologies alongside semantic models

Power BI semantic models and Fabric ontologies both provide business meaning over data and can ground AI agents. They serve different primary needs within Fabric.

Use the following guidance to decide where each item fits:

| Aspect | Power BI semantic model | Fabric ontology |
|---|---|---|
| Primary emphasis | Consistent calculations and interactive analysis | Shared business entities and their connections across domains |
| Modeling elements | Tables, columns, relationships, measures, and hierarchies | Entity types, properties, named directional relationships, and data bindings |
| Typical use | Analyze metrics by project, vessel, or time period | Explore dependencies among specific projects, tasks, equipment, and maintenance orders |

:::image type="content" source="../media/fabric-ontology-semantic-model.png" alt-text="Diagram showing how Fabric ontologies and Power BI semantic models compare for business context and analytics." lightbox="../media/fabric-ontology-semantic-model.png":::

**An ontology complements a semantic model rather than replacing it.** Use a semantic model for trusted metrics and reporting. Add an ontology when you need shared entity definitions and relationship exploration across business domains. Fabric can generate an initial ontology from an existing semantic model, so you can build on established definitions.

Later in this module, you examine how ontology modeling shifts the design process from report-specific schemas to reusable business concepts.

For more information, see [Power BI semantic models and reusable business metrics](/power-bi/connect-data/semantic-models-third-party#power-bi-semantic-models) and [how semantic models and ontologies work together in Fabric IQ](/fabric/iq/overview#layers-of-fabric-iq).

## Where Fabric IQ fits in the data platform

Fabric IQ delivers business context through three layers.

**Unified data (OneLake):** OneLake is the foundation. All analytical and operational data—lakehouse tables, eventhouse streams, and Power BI semantic models—lives in one governed data lake. Fabric IQ references this data in place without duplicating it.

**Business intelligence (Power BI semantic models):** Semantic models provide a curated analytics layer with measures, hierarchies, and relationships optimized for reporting. You can generate ontologies directly from semantic models already in production, keeping business language consistent across reports and agents.

**Operational intelligence (ontologies):** The ontology defines core business entities, relationships, properties, and rules. Both humans and AI agents use this shared language for cross-domain reasoning. You can query your ontology using natural language, and operations agents monitor live data and trigger governed actions based on ontology rules.

In the next unit, you explore the six items in the IQ workload and how they work together.

## Access Fabric IQ in your workspace

You create ontology items the same way you create other Fabric items:

1. Navigate to your Fabric workspace
2. Select **+ New item**
3. Search for and select **Ontology (preview)**
4. Enter a name for your ontology (use numbers, letters, and underscores—no spaces or dashes)
5. Select **Create**

:::image type="content" source="../media/new-ontology-item.png" alt-text="Screenshot showing the New item dialog with Ontology option selected." lightbox="../media/new-ontology-item.png":::

The ontology opens on the **Home configuration canvas**, where you begin defining or reviewing its model.

> [!IMPORTANT]
> Your Fabric administrator needs to enable certain tenant settings before you can create ontology items. For more information, see [Ontology (preview) required tenant settings](/fabric/iq/ontology/overview-tenant-settings?azure-portal=true).

## Explore the ontology interface

The **Home configuration canvas** displays the entity types and relationship types in your ontology. From this canvas, you add entity types, select relationships, and open configuration details.

:::image type="content" source="../media/ontology-blank.png" alt-text="Screenshot of an empty ontology Home configuration canvas with no entity types added." lightbox="../media/ontology-blank.png":::

Select an entity type, and then select **View Entity Type details** to open its details page. The **Configure** page shows the entity type's properties, key, data bindings, and relationships. Use this page to verify generated definitions or complete the configuration.

:::image type="content" source="../media/configure-entity.png" alt-text="Screenshot of the data bindings in the Configure page." lightbox="../media/configure-entity.png":::

After you bind source data, the entity type details also provide ways to inspect the resulting entity instances. The **Instances** tab lists instances and their static property values.

:::image type="content" source="../media/entity-type-instances.png" alt-text="Screenshot of the Instances tab listing entity type instances with property values." lightbox="../media/entity-type-instances.png":::

The **Overview** tab can display time-series data and a relationship graph. Expand the graph to explore connected entity types and use **Query builder** to filter entity instances and their connections.

## Understand the build-bind-query workflow

Creating an ontology in Fabric IQ follows three main steps:

**Build:** Define your business vocabulary by creating entity types, properties, and relationship types. For Contoso Offshore, you define an InstallationTask as a scheduled operation to install a foundation. Its properties include `TaskId`, `PlannedStart`, `PlannedEnd`, and `TaskStatus`. Its relationships identify the assigned vessel, the foundation to install, and the required equipment.

**Bind:** Connect your ontology definitions to prepared data sources. Lakehouse tables provide vessel records, task schedules, equipment registers, and maintenance orders. An optional eventhouse source provides timestamped equipment measurements. Data binding maps source columns to ontology properties, while a task-equipment mapping table links tasks to their required equipment. Reconcile identifiers across source systems before you bind the data.

**Query:** Once your ontology is bound to data, you can query it using business concepts instead of database tables. Use Graph in Microsoft Fabric to visualize relationships and traverse connections. Use **Query builder** to filter and explore entity instances without writing SQL. Or connect AI agents that can answer natural language questions using your business vocabulary.

This workflow separates business meaning from physical data structures.

## How Fabric IQ connects to OneLake

Fabric IQ doesn't move or duplicate your data. Instead, it creates a semantic layer that references existing data sources:

- **Lakehouse tables** contain static data (project records, vessel information, task schedules, and maintenance orders)
- **Eventhouse streams** contain time-series data (timestamped measurements from vessel equipment)
- **Power BI semantic models** contain curated analytics definitions—measures, hierarchies, and relationships—that ontologies can align with directly

When you query your ontology, Fabric IQ automatically sends your queries to the most efficient system to get results quickly. For graph traversals, it uses GQL for Graph in Microsoft Fabric. For time-series queries, it uses KQL for Eventhouse. This federated query capability means you can ask business-level questions that span multiple data sources without knowing the technical details of where data lives.

## Two paths to create an ontology

Fabric IQ offers two approaches for creating ontologies:

**Generate from Power BI semantic model:** If you already have a well-structured Power BI semantic model, you can automatically generate an initial ontology structure from it. Fabric IQ creates entity types matching your tables, properties matching your columns, and relationship types following your model relationships. You then refine this generated ontology by renaming entity types, verifying keys and bindings, and enhancing it with additional data sources like time-series eventhouse streams.

**Build from OneLake data:** If you don't have a semantic model, or want full control over ontology design, you can build directly from lakehouse and eventhouse data. You manually create entity types, define properties, and establish relationships. This approach gives you complete control over how you model your business vocabulary.

Both paths lead to the same result: a complete ontology that defines your business concepts.
