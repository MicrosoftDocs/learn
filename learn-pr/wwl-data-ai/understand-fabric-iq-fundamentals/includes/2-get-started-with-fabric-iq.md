::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=e955fa25-cfcd-4633-8cc7-5ac9a4d195c0]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

The installation-readiness question needs shared definitions of tasks, equipment, and maintenance. Fabric IQ supplies this business context as part of Microsoft IQ, the enterprise intelligence layer of the Microsoft stack. - Within Microsoft Fabric, IQ is a dedicated workload where you create **ontology items**.

## Define an ontology

An **ontology** is a shared definition of business concepts and how they connect. These concepts are represented as **entity types**, their facts as **properties**, and their connections as **relationships**. Rules express business logic, while metrics preserve trusted calculations from source semantic models.

You can also think of an ontology like a business context layer, containing:

- A catalog of concepts (like Project, Vessel, and Equipment) with their properties and relationships
- Data bindings that map concepts to sources such as lakehouse tables, eventhouse tables, and Power BI semantic models
- Business rules linked to the concepts they describe
- Context that agents and other consumers use to query the appropriate sources, with optional graph execution for relationship analysis

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

**An ontology complements a semantic model rather than replacing it.** 

- Use a semantic model for trusted metrics and reporting.
- Add an ontology when you need shared entity definitions and relationship exploration across business domains.

Fabric can generate an initial ontology from an existing semantic model, so you can build on established definitions.

## Where Fabric IQ fits in the data platform

Microsoft IQ works across four areas:

- Work IQ provides context on how employees work.
- Foundry IQ provides context on policies and authoritative documents.
- Web IQ provides context from the web.
- Fabric IQ provides context on business entities and data. 

For the readiness question, the missing context is how business records connect, rather than employee activity or web information.

Fabric IQ delivers business context through three layers.

**Unified data (OneLake):** OneLake is the foundation for accessing governed business data. Fabric IQ uses bindings to connect business definitions to source data. Defining those bindings doesn't copy source data into the ontology.

**Business intelligence (Power BI semantic models):** Semantic models provide a curated analytics layer with measures, hierarchies, and relationships optimized for reporting. You can generate ontologies directly from semantic models already in production, keeping business language consistent across reports and agents.

**Operational intelligence (ontologies):** The ontology defines core business entities, relationships, properties, and rules. Humans and AI agents use this shared language for cross-domain reasoning. Natural-language rules provide context, not executable monitoring. An operations agent needs its own configured and reviewed monitoring logic and actions.

These layers establish shared meaning. The remaining choice is which consuming experience fits the question: a trusted metric, a dependency path, or a monitored condition.

## Explore the ontology interface

After a definition is published, the **Explorer** and canvas show the entity types and relationships. From this view, you inspect concepts and open their configuration details.

The built-in **Ontology agent** helps you draft definitions and bindings or ask questions about bound data. In **Plan mode**, you review proposals without changing the ontology. **Act mode** permits the agent to apply changes after you review them. Applying definitions requires Contributor or higher workspace permissions; read-only users can explain and query an existing ontology.

The **Configure** page shows an entity type's properties, identifiers, data bindings, and relationships. Use this page to verify generated definitions or complete the configuration.

You still own the business meaning. For example, inspect whether the proposed `requiresEquipment` relationship uses task requirements rather than every item carried on a vessel. A structurally valid draft can still represent the wrong dependency.

For more information, see [Use the ontology agent](/fabric/iq/ontology/how-to-use-ontology-agent).

## Understand the build-bind-query workflow

Creating an ontology in Fabric IQ follows three main steps:

**Build:** Define your business vocabulary by creating entity types, properties, and relationship types. For the offshore construction team, you define an InstallationTask as a scheduled operation to install a foundation. Its properties include `TaskId`, `PlannedStart`, `PlannedEnd`, and `TaskStatus`. Its relationships identify the assigned vessel, the foundation to install, and the required equipment.

**Bind:** Connect your ontology definitions to prepared data sources. Lakehouse tables provide vessel records, task schedules, equipment registers, and maintenance orders. An optional eventhouse source provides timestamped equipment measurements. Data binding maps source columns to ontology properties, while a task-equipment mapping table links tasks to their required equipment. Reconcile identifiers across source systems before you bind the data.

**Query:** Once your ontology is bound to data, consuming experiences use business concepts to answer questions. The ontology agent can query lakehouse data with SQL, eventhouse data with KQL, and semantic-model data with DAX. When a dependency path is central to the question, you can opt in to graph materialization for eligible entities and relationships, then explore those connections with Graph in Microsoft Fabric.

This workflow separates business meaning from physical data structures.

## How Fabric IQ connects to OneLake

Ontology bindings create a semantic reference layer over existing sources:

- **Lakehouse tables** contain static data (project records, vessel information, task schedules, and maintenance orders)
- **Eventhouse tables** contain time-series data (timestamped measurements from vessel equipment)
- **Power BI semantic models** contain curated analytics definitions, including measures, hierarchies, and relationships, that ontologies can build on

These mappings let consumers use business terminology while the source retains its data and calculation logic. Optional graph materialization is different: it loads selected source data into a queryable graph. Choose that extra execution layer for relationship-heavy questions, not as a required step for every ontology. Source support and refresh behavior differ between direct source queries and graph queries.

## Two paths to create an ontology

Fabric IQ offers two approaches for creating ontologies:

**Generate from a Power BI semantic model:** If you already have a well-structured Power BI semantic model, generate an initial ontology from it. Fabric IQ creates entity types matching your tables, properties matching your columns, relationship types following your semantic model relationships, and metrics linked to its DAX measures. You need Read and Build permissions on the source semantic model. You then verify keys and bindings, complete relationship bindings, and add other data such as time-series measurements.

**Build from prepared sources:** If you don't have a suitable semantic model, define the business concepts and bind them to prepared data. You can configure them manually or use the ontology agent to propose definitions from supported sources such as lakehouses and eventhouses. Review either approach against the business question before accepting the result.

Both paths establish the same foundation: shared business concepts mapped to data. You now need to distinguish which workload items use that foundation to answer, explore, monitor, or plan.

> [!IMPORTANT]
> Your Fabric administrator must enable **Users can create Fabric items** and **Users can create ontology (preview) items**. Agent experiences have additional tenant settings, including regional AI processing requirements. For more information, see [Ontology (preview) required tenant settings](/fabric/iq/ontology/overview-tenant-settings).

::: zone-end
