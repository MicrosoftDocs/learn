The **Databricks app for Microsoft Teams** gives business users direct access to Genie Spaces without leaving Microsoft Teams. Once a Microsoft Teams administrator installs the app and users connect their accounts, they can ask data questions in chat—in a DM (direct message) or in a channel—and Genie responds with tables, analysis, and source citations.

> [!IMPORTANT]
> The availability of the Databricks app for Microsoft Teams may vary. Verify the current release status with Databricks before deploying to your organization. 

## How installation works

A **Teams administrator** installs the Databricks app from the organization's app catalog. Once installed at the organization level, any user in the organization can access it.

After installation, each user connects the app to a Databricks workspace by signing in with their own credentials through the app's **Home** tab. The connection runs as that user's identity—**Unity Catalog grants apply per user**, not per organization.

:::image type="content" source="../media/databricks-app.png" alt-text="Screenshot of the Databricks app configuration in Microsoft Teams.":::

## DMs and channels

You can use the Databricks app in two surfaces in Microsoft Teams.

**Direct message (DM):** Open a DM with the Databricks app and ask your question. Results are **visible only to you**. DMs are best for personal productivity—exploratory questions, quick lookups, or data validation before a meeting.

**Channel:** Post `@Databricks` in a Microsoft Teams channel. The query runs as you, but the response **appears in the channel and is visible to all channel members**. This is useful when your whole team needs to see the same data in context, such as during a discussion about a sales target or a supply chain issue.

In a channel, each user's question runs as their own identity—the query that runs and the data it returns respect that user's Unity Catalog grants.

## Two query scopes

When you configure the app, you choose how broadly it searches for answers.

**Single Genie Space:** The app connects to **one specific Genie Space**. Every question goes to that space. Choose this when your team works within a defined domain—for example, a sales team that needs only Bakehouse franchise sales data.

**All Genie Spaces (Genie):** The app **routes each question to the most appropriate Genie Space** you have access to. It can also fall back to ad hoc SQL if no space covers the question well. Choose this when users ask varied questions that may span multiple domains.

This scope is configured per DM and per channel independently. A user's personal DM can point to a single space while a team channel uses all-spaces routing, or the reverse.

## What the app can and can't do

| Capability | Behavior |
|---|---|
| **Authentication** | User's Entra ID (SSO). Queries run as the authenticated user. Unity Catalog grants apply per user. |
| **Conversation context** | Maintained within the thread. Follow-up questions don't need to repeat the dataset or prior context. |
| **Source citations** | SQL query and Genie Space link are included in each response. |
| **Feedback** | **Not available in Microsoft Teams.** Users must follow the source link to the Databricks Genie Space UI to submit thumbs up/down, "fix it," or "request review" feedback. |
| **Data scope** | Databricks data only. No access to SharePoint, email, or other Microsoft 365 content. |
| **Custom flows** | None. No topic restrictions, approved responses, or conversation routing beyond Genie Space scope selection. |
| **Customizations required** | No. A Microsoft Teams administrator installs the app once. Each user then connects their own account. |
