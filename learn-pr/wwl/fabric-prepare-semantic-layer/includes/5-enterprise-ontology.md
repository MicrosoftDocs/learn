The semantic model you build doesn't exist in isolation. In organizations that adopt AI at scale, individual semantic models connect to a broader business context layer called an **ontology**. This unit introduces how your semantic model work feeds into this larger picture through Fabric IQ and the ontology workload.

## What is an ontology?

An ontology is an organization-wide, machine-understandable vocabulary of your business. It defines the **things** in your environment (represented as entity types like Customer, Product, or Store), the **facts** about those things (represented as properties like a customer's name or email), and the **connections** between them (represented as relationships like "Customer places Order").

Unlike a semantic model that serves a specific reporting domain, an ontology standardizes business concepts once and reuses them everywhere. When a term like "Customer" means the same thing across all teams, tools, and AI agents, the entire organization communicates more consistently.

In Microsoft Fabric, the ontology is part of the **IQ workload**. Ontology provides a shared context layer that downstream tools and AI agents consume for consistent reasoning and actions.

> [!NOTE]
> Ontology in Fabric is currently in preview. For the latest capabilities, see the [What is ontology?](/fabric/iq/ontology/overview) documentation.

## How semantic models connect to the intelligent data platform

Your semantic model work connects to three intelligence layers across the Microsoft ecosystem. Together, these layers form the intelligent data platform that enables AI across the organization.

| Layer | What it does | How your semantic model work connects |
|-------|-------------|--------------------------------------|
| **Fabric IQ** | Unifies business semantics within Fabric. Provides ontology, data agents, and operations agents. | Your semantic models, naming conventions, and business definitions feed the ontology. Data agents query your models using natural language (NL2DAX, NL2SQL, NL2KQL). |
| **Foundry IQ** | Powers AI apps and agents in Microsoft Foundry. Provides shared context and knowledge endpoints. | Well-structured Fabric data with clear semantics improves Foundry agent quality. Copilot Studio agents access your models through Foundry IQ. |
| **Work IQ** | Delivers intelligence into Microsoft 365 experiences (Copilot, Teams, Excel). | Curated semantic models flow into Microsoft 365 Copilot, enabling natural language insights in the productivity tools people use daily. |

Every skill practiced in this course, from curating gold layers to naming measures clearly, directly improves how AI performs across all three layers. The semantic model is the shared language between humans and AI.

## Generate an ontology from a semantic model

Fabric provides a direct path from semantic model to ontology through the **Generate Ontology** button on the semantic model ribbon. This workflow is the primary entry point for analytics professionals who want to connect their model to the broader enterprise context.

The generation process works as follows:

1. Open a published semantic model in Fabric.
1. Select **Generate Ontology** from the ribbon.
1. Choose the target workspace and enter a name for the ontology.
1. Select **Create**.

Ontology generation automatically creates the following artifacts:

- **Entity types** that match the tables in your semantic model.
- **Properties** on each entity type based on your columns, with data bindings that link to source data.
- **Relationship types** that follow the relationships defined in your semantic model.

This is where your upstream work pays off directly. Clear table names become clear entity type names. Well-defined relationships become well-defined relationship types. Descriptive column names become descriptive properties.

> [!IMPORTANT]
> For ontology generation to create data bindings, your semantic model must use Direct Lake mode with inbound public access enabled on the workspace. Import mode and DirectQuery mode support entity type and relationship generation but don't generate data bindings.

### Semantic model mode support

The following table summarizes which generation features each semantic model mode supports:

| Feature | Import mode | Direct Lake mode | DirectQuery mode |
|---------|------------|-----------------|-----------------|
| Entity type definitions | Supported | Supported | Supported |
| Property definitions | Supported | Supported | Supported |
| Relationship definitions | Supported | Supported | Supported |
| Data bindings to sources | Not supported | Supported (with inbound public access) | Not supported |
| Querying bound data | Not supported | Supported (without measures and calculated columns) | Not supported |

For most production scenarios, Direct Lake mode provides the fullest ontology generation experience.

## Verify and complete the generated ontology

Ontology generation provides a strong starting point, but you need to review and complete the results. After generation, verify these elements:

1. **Entity types.** Rename technical table names to business-friendly names. For example, rename `factsales` to `SaleEvent` or `dimstore` to `Store`.
1. **Properties.** Confirm that columns mapped correctly as properties on each entity type.
1. **Entity type keys.** Each entity type needs a unique identifier. Some keys might not import automatically and need to be added manually.
1. **Data bindings.** Confirm that entity types are bound to the correct source tables.
1. **Relationship types.** Name the relationships, bind them to source data columns, and configure source and target columns.

After the initial verification, some elements require manual configuration:

- **Time series data bindings.** Properties for time series data aren't created automatically during generation.
- **Multi-key scenarios.** Entity types with composite keys might need manual key configuration.
- **Relationship bindings.** While relationship types are created, their data bindings might need manual configuration.

The quality of your naming, documentation, and relationship design in the previous units directly reduces the verification work here. A well-designed semantic model generates a cleaner ontology that requires less manual adjustment.

## How ontology enables AI across the organization

Once your ontology is defined and bound to data, it becomes a shared context layer for AI tools across Fabric. The ontology provides:

- **A query surface for business questions.** You can query the ontology using entity types and properties instead of table and column names. The ontology converts natural language questions into structured queries and returns results based on your entity type definitions.
- **Grounding for data agents.** Data agents in Fabric can connect to your ontology as a data source. When a data agent answers a question, it uses the entity types, properties, and relationships you defined to understand business concepts and generate accurate responses.
- **A graph representation.** The ontology graph links related concepts in a visual, navigable structure. Graph enables traversal queries like "Find all sales events related to stores in the Western region" using graph-native query patterns.

These capabilities extend the value of your semantic model work far beyond reporting. The same clear naming and documentation that helps Copilot answer questions in Power BI also helps data agents reason across domains in broader enterprise scenarios.

## The analytics professional's role in ontology

Your role in ontology is primarily at the semantic model level. The work you do to prepare models for AI creates the foundation that ontology builds on.

**Your contributions to ontology:**

- **Define entities clearly.** Your tables become entity types in the ontology. Clear, entity-oriented table design translates directly to clear entity types.
- **Use consistent naming.** The ontology inherits your naming. Consistent naming across models means consistent terminology in the ontology.
- **Document business definitions.** Your descriptions ground agents in shared business semantics. When a data agent answers a question, it uses the context from your descriptions.
- **Maintain relationships.** Star schema relationships in your model map naturally to ontology relationship types. Dimensions become entity types. Fact tables become event entity types. Measures become the trusted metrics that agents and Copilot surface.

The ontology connects to data agents and operations agents, enabling natural language queries and real-time action recommendations across the organization.

> [!NOTE]
> For advanced ontology design, manual OneLake-based ontology creation, graph queries, and agent configuration, see the [Fabric IQ documentation](/fabric/iq/overview). Full ontology creation is covered in a separate module.
