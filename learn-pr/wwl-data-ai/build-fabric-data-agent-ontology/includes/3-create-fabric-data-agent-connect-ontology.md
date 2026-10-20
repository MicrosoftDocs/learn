To build the Lamna Healthcare agent, you start with an existing ontology and the underlying sources it describes. You then add that context to a data agent and configure guidance for the questions you expect.

## Check access and create the agent

Before you create the agent, check the [data agent prerequisites](/fabric/data-science/how-to-create-data-agent#prerequisites). They include a paid Fabric F2 or higher capacity, or a Power BI Premium P1 or higher capacity with Fabric enabled, and access to the data.

Ask your Fabric administrator to check the [required data agent tenant settings](/fabric/data-science/data-agent-tenant-settings). These include:

- **Users can use Copilot and other features powered by Azure OpenAI**
- **Capacities can be designated as Fabric Copilot capacities**
- **Data sent to Azure OpenAI can be processed outside your capacity's geographic region, compliance boundary, or national cloud instance**, when the capacity is outside the EU data boundary and the US
- **Data sent to Azure OpenAI can be stored outside your capacity's geographic region, compliance boundary, or national cloud instance**, when the capacity is outside the EU data boundary and the US

Tenant setting changes might take up to one hour to take effect. If your scenario also involves creating an ontology, check the separate [ontology creation settings](/fabric/iq/ontology/overview-tenant-settings).

In your Fabric workspace, select **+ New item**, search for **Fabric data agent**, and select the item. Enter a name such as `LamnaHealthcareAgent` to create it. These steps create the agent item, not an ontology or the underlying hospital data.

:::image type="content" source="../media/new-agent.png" alt-text="Screenshot showing how to create a new Fabric data agent.":::

## Add ontology context

Use the current ontology-specific source workflow:

1. Open the Fabric data agent.
1. In the **Sources** experience, select **Add sources**.
1. Select **Add an ontology**.
1. Choose the ontology for the scenario, such as `LamnaHealthcareOntology`.
1. Expand the ontology to review its entity types and associated **Ontology data sources**.

The agent loads a read-only representation of the ontology context. The associated underlying sources supply the schemas and data for queries. Check that the entities and sources match the intended scope before you test a question.

:::image type="content" source="../media/fabric-data-agent-add-ontology-context.png" alt-text="Screenshot of Fabric data agent showing an ontology and its entity types in the Sources pane, with the Setup tab available.":::

For example, a room-occupancy question needs context that maps the relevant room, department, and assignment concepts to actual source data. An equipment-readings question needs an appropriate binding to the readings source. Don't infer that a source is available solely because its business concept appears in an ontology.

> [!NOTE]
> Entity selection within an ontology isn't supported in the initial experience. The [ontology integration documentation](/fabric/data-science/data-agent-ontology-sources) recommends the preview runtime for the best experience. Runtime selection is separate from the sources you add. See [Fabric data agent runtime](/fabric/data-science/data-agent-runtime).

## Configure agent-level guidance

Open **Data agent instructions** to provide plain-language guidance. The instruction area supports up to 15,000 characters. Use that space to explain the agent's objective, when to use its sources, relevant terminology, and the expected response format.

For the learning scenario, an initial instruction might read:

```text
Help answer questions about Lamna Healthcare hospital operations.
Use the connected ontology context and its associated sources for questions
about departments, rooms, current patient assignments, and equipment.
Use the business definitions supplied by the ontology.
Present counts with a short explanation of what is counted.
Ask for clarification when the question leaves the department or time
period ambiguous.
Keep answers within the connected data's hospital-operations scope.
```

This text is a configuration example, not a guarantee that every response follows it. Test whether it produces the intended behavior. An instruction also doesn't grant access to data or supply a missing source binding.

Keep shared definitions in the ontology. If your organization defines a particular synonym for a department, update that shared context rather than relying on conflicting definitions in separate agents. Use agent instructions for behavior specific to this conversational experience, such as requesting a short summary before a table.

For the configuration options and instruction format, see [Configure your data agent](/fabric/data-science/data-agent-configurations).

:::image type="content" source="../media/fabric-data-agent-instructions.png" alt-text="Screenshot of Fabric data agent showing the agent-level instructions alongside the ontology context and its associated data sources.":::

## Supplement eligible underlying sources

Agent-level instructions aren't the only configuration option. To configure an eligible ontology data source, open the agent's **Setup** tab. In the **Ontology data sources** list, select the plus (+) icon next to the data source that you want to configure. From the available setup options, select **Data source instructions** or **Example queries**. You can also provide a data source description where that option is available.

:::image type="content" source="../media/fabric-data-agent-data-source-instructions.png" alt-text="Screenshot of Fabric data agent Setup tab showing ontology data sources with Data source instructions and Example queries configuration options.":::

The current ontology integration supports supplemental source configuration where the underlying source type allows it:

| Configuration | Purpose | Lamna scenario example |
| --- | --- | --- |
| Data source instructions | Explain how to query the source | Describe the join path for current room assignments |
| Data source description | Explain when the source is relevant | Identify the source containing equipment readings |
| Example queries | Pair a question with a verified source-native query | Demonstrate a distinct-room count by department |

Verify an example query against the actual schema and expected result before you add it. A query copied from a different hospital model might use the wrong keys or count a different business object.

These additions belong to the data agent's source configuration. They don't change the ontology. Correct shared definitions, relationships, mappings, and bindings in the ontology itself.

Configuration support varies. SQL and Eventhouse KQL sources support source instructions and example queries. Power BI semantic models don't support these supplemental data-agent-specific configurations. Use the [configuration support matrix](/fabric/data-science/data-agent-add-datasources#configure-your-data-source) to check the selected source rather than assuming that every source offers the same options.

With context and guidance configured, use representative questions to check source selection, query logic, and results. Adding more instructions isn't a substitute for that validation.
