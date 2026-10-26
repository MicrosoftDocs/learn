Sofia needs to answer a data question in a Teams meeting—and with the Databricks Genie app in Microsoft Teams, she doesn't need to leave Teams to do it. This unit walks through how to find and use the app and how to choose between a direct message and a channel mention.

> [!NOTE]
> The Databricks Genie app in Microsoft Teams is in Public Preview. Verify current availability with your Microsoft 365 administrator or at [Azure Databricks integrations with Microsoft Teams](/azure/databricks/integrations/msft-teams).

## Find and open the Databricks Genie app

The Databricks Genie app is installed by a Microsoft 365 administrator from the Teams app catalog. Once it's installed in your organization, you can find it in the Teams app bar (the icons on the left side of Teams) or by searching for "Databricks Genie" in the **Apps** section.

:::image type="content" source="../media/genie-app-install.png" alt-text="Screenshot showing Microsoft Teams Databricks Genie app.":::

When you send a question and aren't signed in, select **Configure**, enter your Azure Databricks **Workspace URL**, and select **Continue** to sign in to your Azure Databricks account. Ask your administrator for the workspace URL if you don't know it. Genie uses your existing data permissions—the app doesn't give you additional access. A public channel reply can still expose your answer to other members, so check visibility before asking.

## Start a conversation: direct messages and channel mentions

The Databricks Genie app supports two ways to ask a question:

**Direct message (DM):** Open a direct message conversation with the Databricks Genie app. This conversation isn't visible to other channel members. Use this for exploratory questions, sensitive topics, or when you want to experiment without others seeing your question or the answer.

:::image type="content" source="../media/genie-teams-direct.png" alt-text="Screenshot showing Microsoft Teams chat with Databricks Genie.":::

**Channel or group chat mention:** In a channel or group chat, type `@Databricks Genie` followed by your question. By default, the question and Genie's answer are visible to everyone in that conversation. Depending on your organization's settings, Genie may send the answer as a private reply instead. Use a mention when the answer is relevant to the team and appropriate to share.

:::image type="content" source="../media/genie-teams-question.png" alt-text="Screenshot showing Microsoft Teams conversation with Databricks Genie.":::

> [!IMPORTANT]
> Before you mention `@Databricks Genie` in a channel, consider whether the question and answer are appropriate for everyone in the conversation to see. Use a direct message for exploratory questions, preliminary analysis, or sensitive topics.

## Choose the right place to ask

Some Teams channels use a Genie Agent that focuses on a specific business topic. For example, a sales channel might answer questions using an agent that covers sales performance. This focus helps the channel return relevant answers for its usual audience.

Channel owners can pin a specific Genie Agent or use Genie One, which routes questions to relevant data. If an answer seems unexpectedly narrow, ask the channel owner which scope is configured. A direct message has its own workspace and Genie scope settings, so it might cover a different topic, but it isn't necessarily broader.

To start a new Genie conversation in a direct message, send `newchat`. This clears the current conversation context without deleting your Teams messages.

## What you can and can't do in the Teams app

The Teams integration covers natural-language Q&A. Some capabilities available in the Azure Databricks Genie interface aren't available in Teams.

| Capability | Supported in Teams |
|---|---|
| Ask natural-language data questions | Yes |
| Multi-turn follow-up questions in a thread | Yes |
| Source citations in responses | Yes |
| Suggested follow-up prompts | Yes |
| Thumbs up/down feedback on responses | Yes |
| View answer as a chart or visualization | Yes, as an image when included in a response; not shown in private-visibility replies |

> [!TIP]
> Thumbs up or down feedback is sent to Genie One, even when a channel uses a pinned Genie Agent. If an answer looks incorrect, submit feedback and contact your data team when the agent's instructions or data need correction.

Data answers in Teams include sources and suggested follow-up prompts. These prompts give you a starting point for drilling deeper into the data without having to construct your next question from scratch.

Some features differ by conversation type. File uploads are available only in direct messages when your administrator enables the **Genie One File Upload** preview and you have OneDrive for Business. Uploads aren't supported in channels, group chats, or Microsoft 365 Copilot. The Teams app also selects an authorized SQL warehouse automatically; you can't choose compute in the app. See the [current limitations](/azure/databricks/integrations/msft-teams#limitations).
