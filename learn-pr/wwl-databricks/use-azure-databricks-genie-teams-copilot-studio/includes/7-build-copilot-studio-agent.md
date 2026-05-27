Before you start, confirm the prerequisites are in place:

- Managed MCP Servers preview enabled in the Databricks workspace (workspace admin setting).
- Power Apps connection to Azure Databricks created for your tenant.
- A premium Power Apps license.
- Access to an Azure Databricks SQL warehouse.
- A Copilot Studio license with access to an environment.

If Power Platform and Azure Databricks are in different Microsoft Entra tenants, use a service principal-based Azure Databricks connection.

> [!IMPORTANT]
> Connecting Genie Spaces to Copilot Studio via MCP is in **Public Preview** as of the time this content was written. Confirm current availability before deploying to production.

## Create and configure the agent

**Step 1: Create the agent.**

Open Copilot Studio. From the sidebar, select **Agents**, then select **+ New agent**. Choose a blank agent to start from scratch.

**Step 2: Set the model.**

In the agent settings, select your agent model. Databricks currently recommends Sonnet 4.5 for Genie integrations.

**Step 3: Write the agent instructions.**

Under **Instructions**, describe what the agent does and how it should behave. Include the following **polling instruction**:

> Always continue polling the Genie Space until you receive a complete response. Do not stop after a few seconds.

Without this instruction, the agent may return a "still processing" message when a query takes more than a few seconds to compute—because the agent stops waiting before Genie has finished. The polling instruction tells the agent to **keep waiting for a full answer** before replying to the user.

**Step 4: Add the Genie Space as a tool.**

Under **Tools**, select **+ Add a tool**. Search for "Azure Databricks" or browse to **Model Context Protocol**. Select **Azure Databricks Genie**, choose your Power Apps connection to Azure Databricks, and select **Add and configure**.

**Step 5: Configure the tool.**

In the tool configuration panel:

- **Name the tool** descriptively. A clear, specific name helps the agent's orchestration layer decide when to invoke this tool versus others.
- **Enter the Genie Space ID** under Inputs, or select the Genie Space from the dropdown list.
- **Configure credentials.** Under **Additional details**, choose:
  - **End user credentials** for OBO flow (each user's Unity Catalog grants apply).
  - **Maker-provided credentials** for a single shared identity (review governance implications with your data engineering team before choosing this option).

If you choose **End user credentials**, confirm that connection parameter sharing is enabled in your environment, or that users have an existing Power Apps connection to Azure Databricks.

Without one of these prerequisites for end user credentials, users can't authenticate and the agent returns no results.

If you choose **Maker-provided credentials**, no per-user Power Apps connection is required. Before publishing, verify that the maker's Unity Catalog grants cover only the data the agent should expose.

**Step 6: Enable generative orchestration.**

Select **Settings** in the upper-right corner. Under **Orchestration**, set the toggle to **Yes** to enable **generative AI orchestration**. MCP tools require this setting to function. Without it, the Genie tool is **registered but never invoked**.

**Step 7: Test the agent.**

Use the built-in test pane in Copilot Studio. Ask a question that should route to the Genie Space and verify:

- The answer arrives (not just "still processing").
- The answer includes the data you expected.
- The response cites the Genie Space as its source.

If the agent returns only "still processing" responses, check that the polling instruction is in your agent instructions and that generative orchestration is enabled.

**Step 8: Publish.**

Select **Publish** in the upper-right corner. To add the agent to Microsoft Teams, follow the [Copilot Studio documentation for publishing to Microsoft Teams](/microsoft-copilot-studio/publication-add-bot-to-microsoft-teams).

## What the agent can and can't do

Once published, your agent can **combine Genie data with other tools and knowledge sources** in a single conversation. A user asking about sales trends can receive a Genie-sourced data table alongside a summary of relevant SharePoint documents, all in one response. This combined experience is the **main reason to choose the Copilot Studio path** over the Databricks app.

The agent can't submit feedback to the Genie Space on behalf of users. If users notice an inaccurate answer, they need to open the Genie Space in Azure Databricks directly and use the feedback controls there.

Power Platform DLP policies in your tenant may restrict the Azure Databricks connector. If your agent returns connection errors or no results, check with your Power Platform admin to confirm the connector is allowed in your environment's DLP configuration.
