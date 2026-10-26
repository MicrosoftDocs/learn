If Microsoft 365 Copilot is your primary daily work tool, you can access Genie without switching to Teams or opening Azure Databricks. This unit explains the two ways to invoke Genie from Microsoft 365 Copilot, how the experience differs from the Teams app, and what to expect from each approach.

> [!NOTE]
> The recommended connection uses the Databricks Genie app in Microsoft Teams, which is in Public Preview. Your organization can alternatively configure a Genie Agent connection through Power Platform and Copilot Studio. Verify your connection with your Microsoft 365 administrator or at [Azure Databricks integrations with Microsoft 365 Copilot](/azure/databricks/integrations/msft-m365-copilot).

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

This invokes Genie from the current chat without first opening a dedicated agent conversation. It doesn't mean the exchange is temporary or excluded from conversation history.

## How the Microsoft 365 Copilot experience compares to Teams

When you connect through the Databricks Genie Teams app, both surfaces use your existing data permissions and share the documented integration limitations. Conversation-specific features still differ. If your organization uses a custom Copilot Studio connection, check its configuration with your IT team.

| Feature | Teams app | Microsoft 365 Copilot |
|---|---|---|
| Natural-language data questions | Yes | Yes |
| Multi-turn follow-up questions | Yes—within a thread | Yes—within the agent conversation or chat |
| Source citations | Yes | Yes |
| Suggested follow-up prompts | Yes | Yes |
| Thumbs up/down feedback | Yes | Yes |
| Charts or visualizations | Chart images when included; not shown in private-visibility replies | Check the Teams integration's visualization and visibility limitations |
| File uploads | Direct messages only, with the upload preview enabled and OneDrive for Business | Not supported |
| Persistent agent conversation | Yes—DM thread | Yes—via More agents |
| One-off question in a broader conversation | Yes—channel mention | Yes—@mention in new chat |

The Teams integration can display charts as images, so a blanket "no charts" limitation no longer applies. For interactive visualization controls, open the Genie Agent directly in Azure Databricks or in Genie One. For the Teams-app connection in Microsoft 365 Copilot, consult the [shared integration limitations](/azure/databricks/integrations/msft-m365-copilot#limitations).
