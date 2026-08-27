Sofia needs to answer a data question in a Teams meeting—and with the Databricks Genie app in Microsoft Teams, she doesn't need to leave Teams to do it. This unit walks through how to find and use the app and how to choose between a direct message and a channel mention.

> [!NOTE]
> The Databricks Genie app in Microsoft Teams is in Public Preview. Verify current availability with your Microsoft 365 administrator or at [Azure Databricks integrations with Microsoft Teams](/azure/databricks/integrations/msft-teams).

## Find and open the Databricks Genie app

The Databricks Genie app is installed by a Microsoft 365 administrator from the Teams app catalog. Once it's installed in your organization, you can find it in the Teams app bar (the icons on the left side of Teams) or by searching for "Databricks Genie" in the **Apps** section.

:::image type="content" source="../media/genie-app-install.png" alt-text="Screenshot showing Microsoft Teams Databricks Genie app.":::

The first time you open the app, you're prompted to sign in with your own organizational credentials. This matters: Genie only shows you data you're authorized to see. Your access is determined by the permissions your data team set up—the app doesn't give you any additional access.

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

If an answer seems unexpectedly narrow or doesn't cover your topic, try asking the same question in a direct message. The direct message isn't tied to the channel's topic, so it may produce a broader answer. You can also ask the channel owner which topics the channel supports.

## What you can and can't do in the Teams app

The Teams integration covers natural-language Q&A. Some capabilities available in the Azure Databricks Genie interface aren't available in Teams.

| Capability | Supported in Teams |
|---|---|
| Ask natural-language data questions | Yes |
| Multi-turn follow-up questions in a thread | Yes |
| Source citations in responses | Yes |
| Suggested follow-up prompts | Yes |
| Thumbs up/down feedback on responses | Yes |
| View answer as a chart or visualization | No |

> [!TIP]
> Thumbs up or down feedback helps your data team improve the accuracy and relevance of your organization's Genie Agents. If an answer looks incorrect, submit feedback even if you can't explain exactly what's wrong.

Every response in Teams also includes source citations and, often, suggested follow-up prompts. These prompts give you a starting point for drilling deeper into the data without having to construct your next question from scratch.
