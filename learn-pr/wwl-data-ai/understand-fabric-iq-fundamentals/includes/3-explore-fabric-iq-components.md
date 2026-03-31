Microsoft Fabric IQ brings together several components that work as an integrated ecosystem. Each component serves a specific role in how you define, query, analyze, and visualize your business data. Understanding these components helps you choose the right tool for each task and leverage their combined strengths.

Fabric IQ includes four core components:

- **Ontology items** define your business vocabulary and bind concepts to data sources
- **Data agents** answer natural language questions across multiple data sources
- **Graph** stores and queries connected data using relationships
- **Semantic models** provide a starting point for generating ontologies from existing Power BI models

## Ontology items: Define your business vocabulary

An **ontology item** is where you build your shared business vocabulary. You define the business concepts that matter to your organization, then bind them to actual data sources in OneLake. If you were working with healthcare data, for example, you might bind a Patient concept to a lakehouse table containing patient records, and a VitalSign concept to an eventhouse stream capturing real-time monitoring data.

Consider a scenario where a healthcare data team defines Hospital, Department, Room, Patient, and VitalSign as entity types with properties like hospital ID, department name, and room number. Relationships like "Department contains Room" and "Patient occupies Room" connect these concepts into a coherent business vocabulary.

The ontology defines your business concepts that can be used by Graph in Microsoft Fabric for visualization and traversal, and by data agents for answering natural language questions.

## Data agents: Query data with natural language

A **Fabric data agent** is a conversational Q&A system powered by generative AI. You configure it with up to five data sources in any combination (lakehouses, warehouses, KQL databases, Power BI semantic models, or ontologies), and it uses Azure OpenAI Assistant APIs to process natural language questions.

When you ask a question, the data agent parses it, identifies the most relevant data source, and generates the appropriate query. For lakehouses and warehouses, it generates SQL. For Power BI semantic models, it generates DAX. For KQL databases, it generates KQL. For ontologies, it uses the defined business vocabulary to understand context.

Consider a scenario where a nurse asks "Which patients in cardiology have elevated heart rates right now?" The data agent understands "cardiology" from the ontology, queries the lakehouse for patient assignments, and queries the eventhouse for current vital sign readings—all without the nurse writing SQL or KQL.

You enhance data agent accuracy by providing **data agent instructions** (guidance on which data source to use for specific question types) and **example queries** (sample question-query pairs that illustrate expected responses). This customization aligns the data agent with your organization's specific terminology and data access patterns.

Data agents enforce read-only access and apply security protocols to ensure users only see data they have permission to access. You can publish data agents to Microsoft 365 Copilot or integrate them with Microsoft Copilot Studio to extend their reach beyond Fabric.

:::image type="content" source="../media/data-agent-interface.png" alt-text="Screenshot showing the data agent chat interface with a question and answer.":::

## Graph in Microsoft Fabric: Visualize and traverse relationships

**Graph in Microsoft Fabric** offers native graph storage and compute for connected data. Unlike relational databases that require complex joins to navigate relationships, it uses a **labeled property graph model** where nodes (entities) and edges (relationships) carry labels and properties that make connections explicit and easy to traverse.

When you create an ontology item, a managed graph is automatically created from your ontology's entity types and relationships. You query it using **GQL (Graph Query Language)**, an international standard for graph queries. Graph excels at answering relationship-heavy questions like "Which patients are assigned to surgical floor rooms?" or "Show me the department hierarchy for a specific hospital."

Consider a scenario where the ontology automatically creates a graph with nodes for hospitals, departments, rooms, and patients, connected by edges representing their relationships. To investigate patient flow patterns, you can traverse from a hospital → its departments → rooms → currently assigned patients.

Graph in Microsoft Fabric operates directly on OneLake without requiring data duplication or ETL. Its scale-out architecture can handle large-scale graph structures with many relationships. You can explore graph data visually through the graph interface or write GQL queries for more complex analysis.

Ontology and Graph in Microsoft Fabric work together seamlessly. The ontology declares your business concepts and relationships, then automatically creates a graph structure. Graph in Microsoft Fabric stores and computes the traversals, enabling visual exploration and advanced queries over your connected data.

:::image type="content" source="../media/graph-interface.png" alt-text="Screenshot showing the graph interface for exploring relationships visually.":::

## Semantic models: Generate ontologies from existing data models

A **Power BI semantic model** provides a structured representation of your data with tables, columns, relationships, and business logic already defined. In the context of Fabric IQ, semantic models serve as an excellent starting point for creating ontologies.

When you generate an ontology from an existing semantic model, Fabric IQ automatically creates:

- **Entity types** matching your semantic model tables (like Hospital, Department, Room, Patient)
- **Properties** matching your table columns (like HospitalId, DepartmentName, Floor)
- **Relationship types** based on your semantic model relationships (like Hospital contains Department, Room assigned to Patient)
- **Keys** identifying unique instances of each entity type

This approach is significantly faster than building an ontology from scratch. Instead of manually creating each entity type and defining every property and relationship, you start with a complete structure that reflects your existing data model.

Consider a scenario where a data team generates an ontology from their existing semantic model with tables for hospitals, departments, rooms, and patients. This automatically creates the entity types and relationships, which they could then enhance by adding time-series vital sign data from eventhouse.

After generating an ontology, you refine it by:
- Verifying that entity type keys are correctly identified
- Confirming that data bindings map to the right source columns
- Adding additional entity types from other data sources (like eventhouse streams)
- Enhancing relationships with binding information that links to actual data

This workflow lets you leverage existing modeling work while extending it with Fabric IQ's cross-domain reasoning and graph capabilities.
