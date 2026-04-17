Now that you understand what a Fabric data agent is and how it uses an ontology as a data source, this unit covers how to set one up: creating the data agent item in a Fabric workspace, connecting an ontology as its data source, and configuring agent instructions — the primary way to improve accuracy when using an ontology.

## Create the data agent item

Creating a data agent in Microsoft Fabric follows the same pattern as creating any workspace item. You select the item type, provide a name, and Fabric generates the item with a default interface.

1. In a Fabric workspace, select **+ New item**.
1. In the search box, type `data agent` and select **Data agent** from the results.
1. Enter a name for the agent, such as `LamnaHealthcareAgent`, and select **Create**.

The agent interface opens immediately. The **Explorer** pane on the left appears empty until a data source is added. Without a data source, the agent has no knowledge base to query.

:::image type="content" source="../media/data-agent-empty.png" alt-text="Screenshot of the Fabric data agent interface showing No data added in the Explorer pane and Build your data agent options in the center.":::

## Add the ontology as a data source

The agent's intelligence comes from its connected data sources. Connecting the ontology item makes all its entity types and relationships available to the agent.

1. In the data agent interface, select **Add a data source**.
1. The OneLake catalog opens. Search for the ontology item by name, such as `LamnaHealthcareOntology`.
1. Select the ontology and select **Add**.

The ontology and its entity types appear in the **Explorer** pane: **Hospital**, **Department**, **Room**, **Patient**, and **VitalSignEquipment**. Each entity type appears as a distinct node that can be expanded to view its attributes and relationships.

:::image type="content" source="../media/data-agent-explorer.png" alt-text="Screenshot of the Explorer pane showing five entity types: Departments, Hospitals, Patients, Rooms, and VitalSignEquipment.":::

## Configure agent instructions

With the ontology connected, the next step is to write instructions. Instructions are plain-language guidance you write directly in the agent to explain your domain — the terminology your organization uses, what the agent should answer, and how to interpret common question patterns. For ontology sources, instructions are how you bridge the gap between how people ask questions and how concepts are defined in the ontology.

To configure instructions, select **Agent instructions** from the ribbon. The instructions pane opens with an empty text area that accepts up to 15,000 characters of plain-language guidance.

Effective instructions typically include four components:

1. **Domain description** — Explain what the ontology models and its purpose. Example: "This ontology models hospital operations at Lamna Healthcare, including facilities, departments, rooms, patients, and vital sign monitoring equipment."
1. **Terminology mappings** — Map common business terms to ontology concepts. Example: "ICU refers to the Intensive Care Unit department. Critical Care rooms are ICU patient rooms."
1. **Scope guidance** — Define what the agent should and shouldn't answer. Example: "Answer questions about patient room assignments, department occupancy, and vital sign equipment allocation. Do not answer questions about billing, insurance, or staffing."

Instructions apply automatically as you type — there's no save button. Changes take effect immediately for subsequent queries.

:::image type="content" source="../media/data-agent-instructions.png" alt-text="Screenshot of the Fabric data agent instructions pane showing the Lamna Healthcare example instructions with domain description, terminology mappings, and scope guidance.":::

With the data agent created, the ontology connected, and instructions configured, the agent is ready to test. In the next unit, you'll see how to test it with natural language questions, review the generated GQL queries, and publish it for colleagues to use.
