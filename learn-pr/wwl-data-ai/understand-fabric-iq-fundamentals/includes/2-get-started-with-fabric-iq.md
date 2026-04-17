Fabric IQ is a workload in Microsoft Fabric for creating ontologies that define your business vocabulary. It sits alongside other Fabric workloads like Data Engineering, Data Factory, Data Science, Data Warehouse, Real-Time Intelligence, and Power BI. Within the IQ workload, you create **ontology items**—Fabric artifacts that contain your ontology definitions and data bindings.

An ontology is a shared vocabulary of your business. It's made up of the things in your environment (represented as entity types), their facts (represented as properties of entity types), and the ways they connect (represented as relationships).

You can also think of an ontology like a business context layer, containing:

- A catalog of concepts (like Hospital, Patient, Department) with their properties and relationships
- Data bindings to your lakehouse tables and eventhouse streams
- A graphical representation that links related concepts for navigation and analysis
- A query surface that lets you ask questions about concepts (not just tables), supporting federated queries across sources

Instead of requiring data experts to translate business questions into SQL queries, you model data using business concepts that everyone understands.

The ontology provides a single definition of each concept that can be used by data agents and Graph in Microsoft Fabric for querying and visualization.

## Where Fabric IQ fits in the data platform

Fabric IQ builds on Microsoft Fabric's unified data platform. Here's how it connects to other capabilities:

**Ingest and store:** Fabric IQ works with data you already have in lakehouse tables and eventhouse streams. It doesn't move or duplicate your data—it creates a semantic layer that references your existing data sources.

**Model and represent semantics:** The ontology item offers modeling capabilities by defining entity types, properties, and relationship types. You can generate an ontology structure from existing Power BI semantic models, or create your own from scratch. Then bind these definitions to your data and explore them in a navigable graph that builds automatically.

**Analyze and visualize:** The ontology item integrates with Graph in Microsoft Fabric to provide a visual graph and query experience based on your business concepts. You can use the ontology to ground data agents with business context.

## Access Fabric IQ in your workspace

You create ontology items the same way you create other Fabric items:

1. Navigate to your Fabric workspace
2. Select **+ New item**
3. Search for and select **Ontology (preview)**
4. Enter a name for your ontology (use numbers, letters, and underscores—no spaces or dashes)
5. Select **Create**

:::image type="content" source="../media/new-ontology-item.png" alt-text="Screenshot showing the New item dialog with Ontology option selected." lightbox="../media/new-ontology-item.png":::

The ontology opens when it's ready. You'll see two main areas: the configuration canvas where you define entity types and relationships, and the preview experience where you explore your data.

> [!IMPORTANT]
> Your Fabric administrator needs to enable certain tenant settings before you can create ontology items. For more information, see [Ontology (preview) required tenant settings](/fabric/iq/ontology/overview-tenant-settings?azure-portal=true).

## Explore the ontology interface

The ontology item has two primary views:

**Configuration canvas:** This is where you build your ontology. You create entity types (like Hospital, Department, Room, Patient), define properties on those entities (like FirstName, DateOfBirth, AdmissionDate), and establish relationship types between entities (like "contains" or "assigned to").

:::image type="content" source="../media/configuration-canvas.png" alt-text="Screenshot showing the ontology configuration canvas with entity types, properties, and relationships." lightbox="../media/configuration-canvas.png":::

**Preview experience:** This view shows your instantiated ontology. You can see entity instances (specific rooms, departments, and patients), explore relationships in a graph visualization, and query your data using business language instead of SQL. The preview experience integrates with Graph in Microsoft Fabric to provide rich visual exploration.

:::image type="content" source="../media/preview-ontology.png" alt-text="Screenshot showing the ontology preview experience with graph visualization and entity instances." lightbox="../media/preview-ontology.png":::

## Understand the build-bind-query workflow

Creating an ontology in Fabric IQ follows three main steps:

**Build:** Define your business vocabulary by creating entity types, properties, and relationship types. You're modeling the concepts that matter to your business. For example, in a healthcare scenario, this means defining what a Patient is, what properties describe a patient (like name, date of birth, admission date), and how patients relate to other entities (like rooms and departments).

**Bind:** Connect your ontology definitions to data sources. This includes lakehouse tables for static data (like patient records and room assignments) and eventhouse streams for time-series data (like vital signs monitoring). Data binding maps your source data columns to ontology properties.

**Query:** Once your ontology is bound to data, you can query it using business concepts instead of database tables. Use Graph in Microsoft Fabric to visualize relationships and traverse connections. Use Query Builder to filter and explore entity instances without writing SQL. Or connect AI agents that can answer natural language questions using your business vocabulary.

This workflow separates business meaning from physical data structures.

## How Fabric IQ connects to OneLake

Fabric IQ doesn't move or duplicate your data. Instead, it creates a semantic layer that references existing data sources:

- **Lakehouse tables** contain static data (patient records, hospital information, room assignments)
- **Eventhouse streams** contain time-series data (continuous vital signs from medical monitoring equipment)

When you query your ontology, Fabric IQ automatically sends your queries to the most efficient system to get results quickly. For graph traversals, it uses GQL for Graph in Microsoft Fabric. For time-series queries, it uses KQL for Eventhouse. This federated query capability means you can ask business-level questions that span multiple data sources without knowing the technical details of where data lives.

## Two paths to create an ontology

Fabric IQ offers two approaches for creating ontologies:

**Generate from Power BI semantic model:** If you already have a well-structured Power BI semantic model, you can automatically generate an initial ontology structure from it. Fabric IQ creates entity types matching your tables, properties matching your columns, and relationship types following your model relationships. You then refine this generated ontology by renaming entity types, verifying keys and bindings, and enhancing it with additional data sources like time-series eventhouse streams.

**Build from OneLake data:** If you don't have a semantic model, or want full control over ontology design, you can build directly from lakehouse and eventhouse data. You manually create entity types, define properties, and establish relationships. This approach gives you complete control over how you model your business vocabulary.

Both paths lead to the same result: a complete ontology that defines your business concepts.
