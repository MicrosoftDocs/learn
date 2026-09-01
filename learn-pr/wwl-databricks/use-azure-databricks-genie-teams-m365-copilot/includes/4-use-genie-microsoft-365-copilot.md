If Microsoft 365 Copilot is your primary daily work tool, you can access Genie without switching to Teams or opening Azure Databricks. This unit explains the two ways to invoke Genie from Microsoft 365 Copilot, how the experience differs from the Teams app, and what to expect from each approach.

> [!NOTE]
> Genie on Microsoft 365 Copilot is in Public Preview. Verify current availability with your Microsoft 365 administrator or at [Azure Databricks integrations with Microsoft 365 Copilot](/azure/databricks/integrations/msft-m365-copilot).

## Find Genie in Microsoft 365 Copilot

Your organization determines how Genie appears in Microsoft 365 Copilot. Look for a connection named **Databricks Genie** or a custom name chosen by your organization. If you aren't sure which connection to use, ask your IT team or check your organization's internal guidance.

Regardless of its name, you use the connection in one of two ways: open a focused conversation through **More agents**, or mention Genie in a new chat for a one-off question.

## Open a Genie connection for an ongoing conversation

For a focused data conversation that persists across multiple exchanges, use the **More agents** option in Microsoft 365 Copilot:

1. Open Microsoft 365 Copilot.
2. In the Copilot Chat sidebar, select **More agents**.
3. Find and select **Databricks Genie** (or your organization's named connection).
4. Ask your data question.

:::image type="content" source="../media/copilot-databricks-genie.png" alt-text="Screenshot showing Microsoft Copilot with Databricks Genie Agent.":::

This opens a persistent agent conversation scoped to Genie. All follow-up questions in this conversation draw on the same context, similar to a thread in Teams.

## Mention Genie in a new chat

For a quick, one-off data question within a broader Copilot conversation, use the `@` mention approach:

1. Open a **New chat** in Microsoft 365 Copilot.
2. Type `@Databricks` and select **Databricks Genie** from the suggestion list.
3. Type your question.

This is a one-off mention. Genie answers within the current chat, and other Copilot capabilities remain available. Use this approach when you want to combine a data question with other tasks in one conversation.

## How the Microsoft 365 Copilot experience compares to Teams

The two surfaces use the same data permissions and have the same feature limitations. The main differences are in how you start a conversation and where the response appears.

| Feature | Teams app | Microsoft 365 Copilot |
|---|---|---|
| Natural-language data questions | Yes | Yes |
| Multi-turn follow-up questions | Yes—within a thread | Yes—within the agent conversation or chat |
| Source citations | Yes | Yes |
| Suggested follow-up prompts | Yes | Yes |
| Thumbs up/down feedback | Yes | Yes |
| Charts or visualizations | No | No |
| Persistent agent conversation | Yes—DM thread | Yes—via More agents |
| One-off question in a broader conversation | Yes—channel mention | Yes—@mention in new chat |

Both surfaces are subject to the same important limitation: Genie in Teams and Microsoft 365 Copilot doesn't display charts or visualizations. If you need to see a chart, open the Genie Agent directly in Azure Databricks or in Genie One, where visualization is supported.
