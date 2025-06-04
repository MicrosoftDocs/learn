Copilot in Power BI enables users to ask natural language questions and receive relevant answers from their available Fabric resources. With Copilot, you can interact with data across Power BI semantic models, reports, and Fabric Data Agents, all within a single conversational interface. This integration helps you focus on extracting insights without switching between different items.

> [!NOTE]
> This feature is currently in preview.

## Prerequisites

- Access to Copilot in Power BI
- Required permissions for the relevant Fabric Data Agents and Power BI items

## Ways to Use Fabric Data Agents in Copilot

### 1. Use Copilot search to find and invoke a Fabric Data Agent

When you ask a question in Copilot, it automatically scans all items you have access to, such as Power BI semantic models, Power BI reports, and Fabric Data Agents. Based on your query, Copilot ranks and suggests the most relevant items. You can then choose from these suggestions to receive the most appropriate answer.

### 2. Directly add a Fabric Data Agent

If you already know which data agent you want to use, you can manually add it to your Copilot session. Start by selecting **Add items for better results**, then choose **Data agents** to open the OneLake catalog. 

From there, select the desired data agent from the list. Once added, the data agent is attached to your question, and Copilot will use it for relevant follow-up questions. 

If your question falls outside the scope of the attached data agent, you may need to indicate a topic change so Copilot can search across all available resources again.

## Interaction flow with a Fabric Data Agent

When you interact with a Fabric Data Agent through Copilot in Power BI, the following steps occur:

1. **Rephrase the question:** Copilot may rephrase your question for clarity or context.

2. **Send the query:** The question is sent to the selected Fabric Data Agent.

3. **Answer retrieval:** The data agent identifies the most relevant data source (such as a lakehouse, warehouse, semantic model, or KQL database) and queries it. Data security protocols like Row-Level Security (RLS) and Column-Level Security (CLS) are enforced based on your permissions.

4. **Response delivery:** The Fabric Data Agent sends the answer back to Copilot.

5. **User presentation:** Copilot presents the answer directly in the conversation interface.
