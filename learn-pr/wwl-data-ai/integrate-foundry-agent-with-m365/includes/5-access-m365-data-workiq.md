::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=757b6fae-8663-419e-a9e4-eb69ec034388]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

When you build agents for workplace tasks, you need access to the data, context, and tools that support those tasks. Microsoft Work IQ provides a workplace intelligence layer that helps your agents access and reason over organizational and business information.

## What is Work IQ?

Work IQ continuously builds a semantic understanding of information across Microsoft 365 and external systems. This understanding captures meaning and relationships across your workplace data, with built-in, permission-aware governance.

Work IQ combines chat, context, tools, and workspaces to support high-volume, multistep interactions. It works across frameworks and runtimes through standard protocols, providing a foundation for the agents, applications, and workflows you build.

With Work IQ, your agents can answer questions like:

- "What did my manager say about the project deadline?"
- "Find my recent documents about Q4 planning"
- "Summarize today's messages in the Engineering channel"
- "Who is working on Project Alpha?"

Work IQ accesses data across multiple Microsoft 365 services:

| Data type | Example capabilities |
|-----------|---------------------|
| **Emails** | Search messages, find communications from specific people |
| **Meetings** | Check calendar, retrieve meeting notes and decisions |
| **Documents** | Find files in SharePoint and OneDrive, search content |
| **Teams messages** | Summarize channel discussions, find specific conversations |
| **People** | Identify team members, find collaborators on projects |

## How your Foundry agent uses Work IQ

Your Foundry agent uses Work IQ as a tool when it needs workplace context. You don't need to build separate search logic for emails, meetings, and files.

For example, you ask, "What decisions from this week's project meetings should I include in the review?" Here's how your agent responds:

1. Your agent sends the task to Work IQ.
2. Work IQ finds and summarizes relevant information, respecting your Microsoft 365 permissions.
3. Your agent uses the summary to answer your question.

## Configure the connection and agent

First, check for an approved Work IQ connection in your Foundry project. If one exists, skip to adding the tool to your agent. Otherwise, setup involves three steps:

1. **Authorize the application in Microsoft Entra.** For a custom OAuth connection, an administrator provisions the Work IQ service principal and configures a single-tenant app under **Entra ID** > **App registrations**:
   - **API permissions**: Add the delegated `WorkIQAgent.Ask` permission and grant admin consent.
   - **Certificates & secrets**: Create a client secret for the Foundry connection.

   :::image type="content" source="../media/api-permissions.png" alt-text="Screenshot of the Entra API permissions picker showing Work IQ under APIs my organization uses." lightbox="../media/api-permissions.png":::

2. **Connect the tool in Foundry.** Open **Tools** > **Connect a Tool**, then select **Work IQ MCP** on the **Catalog** tab:

   :::image type="content" source="../media/select-work-iq.png" alt-text="Screenshot of the Foundry tool catalog with the Work IQ MCP remote tool selected." lightbox="../media/select-work-iq.png":::

   - Enter the app's client ID and secret, plus your tenant's authorization, token, and refresh URLs.
   - Save the tool connection, then copy the OAuth redirect URL supplied by Foundry.
   - Add that URL under **Authentication** in the Entra app registration as a **Web** redirect URI. This completes the sign-in return path.

   :::image type="content" source="../media/tool-config.png" alt-text="Screenshot of the Work IQ MCP connection form with client credentials and authentication URL fields." lightbox="../media/tool-config.png":::

3. **Add Work IQ to your agent.** In the agent's tool configuration, select your configured **Work IQ MCP** tool. Add instructions to the agent on when to use workplace context and how to handle missing information.

Keep these access and security requirements in mind:

- **Foundry roles**: Creating connections requires **Foundry Project Manager**. The developer, runtime identity, and users in OAuth flows need **Foundry User** on the project.
- **User permissions**: Work IQ acts on behalf of the signed-in user. Admin consent doesn't expand that user's Microsoft 365 access, and application-only authentication isn't supported.
- **Billing**: Enable **Copilot Credits** for Work IQ API usage. Connector-backed tools have separate licensing requirements.
- **Secrets**: Store client secrets in an approved secret store and rotate them before expiration. Don't include them in agent instructions or source code.

Review connection values before saving because you can't edit them after creation.

For more setup details, see [Connect a Microsoft Foundry project to Work IQ](/microsoft-365/copilot/extensibility/work-iq/mcp/quickstart/foundry).

## Validate user context and data boundaries

Before you share your agent, check that it uses Work IQ correctly:

1. **Ask about workplace information.** Use a question about a recent meeting or document you can access, and complete any sign-in prompt.
2. **Verify the tool call.** Confirm that the agent calls Work IQ and uses the result rather than guessing.
3. **Test permissions.** Try different user accounts, including one without access to the relevant content. Confirm that restricted information stays protected.

The following example shows an approved Work IQ tool call and the agent's project status response.

:::image type="content" source="../media/work-iq-output.png" alt-text="Screenshot of Foundry chat showing an approved Work IQ tool call and a Contoso product launch status response." lightbox="../media/work-iq-output.png":::

If a call fails, check sign-in, the redirect URI, admin consent for `WorkIQAgent.Ask`, Foundry roles, and billing before changing the agent's instructions.

> [!IMPORTANT]
> Work IQ respects Microsoft 365 permissions and policies, but processing might occur outside the Azure compliance boundary. Foundry can also process or store the response according to your configuration. Review service terms, data-handling policies, and regional requirements before deployment, even if you publish the agent to Teams or Microsoft 365 Copilot.

::: zone-end
