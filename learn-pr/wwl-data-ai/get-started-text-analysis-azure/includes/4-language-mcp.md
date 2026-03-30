::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=899339c4-91f7-4ebd-baf1-9ccc2b7e4135]

> [!NOTE]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

An AI agent uses tools and models to perform tasks such as reasoning, planning, retrieval, and calling external services. While AI agents can use various generative AI models to perform language-related tasks, you can create an agent that uses Azure Language in Foundry Tools to ensure consistent and predictable text analysis functionality. 

The **Azure Language MCP server** in Foundry Tools is a managed service that exposes Azure Language capabilities through the **Model Context Protocol (MCP)** so that AI agents can use advanced language processing tools without custom integration work.

A **MCP server** gives an agent access to tools, data, or actions that the agent can't do on its own. The agent can make a request to the MCP server. The MCP server might respond by:  
- Providing *data* (for example: files, records, or analytics)
- Taking *action* (for example: sending an email) 

You can access the Azure Language MCP server and other Foundry Tools in the *new* Foundry portal. 

:::image type="content" source="../media/azure-language-mcp-details.png" alt-text="Screenshot of the Azure Language MCP server description page in the new Foundry portal." lightbox="../media/azure-language-mcp-details.png":::

## Use the Azure Language MCP Server in Foundry portal 

You can start out in the *new* Foundry portal by deploying a model and saving it in the Foundry playground as an agent. 

:::image type="content" source="../media/agent-playground.png" alt-text="Screenshot of the agent in the Foundry playground." lightbox="../media/agent-playground.png":::

> [!NOTE]
> A Foundry resource provides a unified environment that already includes access to Language tools. You do not need to create a separate Azure Language resource to access the Azure Language MCP server. 

You can add tools, such as **Azure Language in Foundry Tools**, to your agent in the Foundry playground.

:::image type="content" source="../media/add-tool-to-agent.png" alt-text="Screenshot of the tool browser open in the playground and the Azure Language in Foundry Tools selected." lightbox="../media/add-tool-to-agent.png":::

To connect to the Azure Language MCP server, you need to configure your connection with your *Foundry resource name*. Once you've connected the MCP server to an agent as a tool, you can use prompts to instruct the agent to use the tool to analyze text. The ability to use  Azure Language as a tool in an agent helps you build agentic solutions that make sense of text documents. 

:::image type="content" source="../media/language-agent-response.png" alt-text="Screenshot of Azure Language in Foundry Tools used in the Foundry playground." lightbox="../media/language-agent-response.png":::

Next, try out text analysis in Foundry yourself.

::: zone-end