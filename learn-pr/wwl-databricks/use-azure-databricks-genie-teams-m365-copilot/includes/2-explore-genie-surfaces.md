Azure Databricks Genie isn't a single product—it's a family of related surfaces, each designed to meet business users where they already work. Understanding the full picture helps you recognize which surface your organization has made available to you and how each one fits into your workflow.

## The Genie family

Genie is available across several surfaces. This module focuses on the options that fit directly into a business user's collaboration workflow:

- **Genie Agents**—AI chat interfaces focused on specific business topics, such as sales pipeline, inventory, or HR metrics. Genie Agents were formerly known as Genie Spaces. Each agent is built and maintained by your data team. You ask a question in plain language, and the agent uses your organization's data to return an answer.
- **Genie One**—a simplified Azure Databricks home designed specifically for business users. It brings together dashboards, Genie Agents, and Databricks Apps in one place.
- **Genie mobile app**—a Public Preview iOS and Android app that mirrors the Genie One experience on a mobile device. You can ask data questions and view dashboards from anywhere.
- **Databricks Genie app in Microsoft Teams** and **Genie on Microsoft 365 Copilot**—integrations that bring Genie Agents into the collaboration tools you use every day. These are covered in detail in the next two units.

## Genie Agents: your organization's data experts

A Genie Agent focuses on a specific business topic. Your data team prepares each agent with the data and business definitions it needs. This context teaches the agent what your organization means by terms like "revenue," "active customer," or "on-time delivery."

When you ask the agent a question, it uses that context to find an answer in your organization's data and returns the result as a table, a summary, or both. The agent never writes, modifies, or deletes data.

:::image type="content" source="../media/genie-agent.png" alt-text="Screenshot of the Genie Agent user interface.":::

A key characteristic of Genie Agents is that they're tailored to your organization. They don't draw on public internet knowledge. Every answer comes from your data.

Your data team can also designate **trusted answers** within an agent: pre-approved responses to specific high-value questions. When Genie uses a trusted answer, the response is labeled **Trusted**. That label means a domain expert has already reviewed and confirmed the answer.

## Genie One: the business-user home in Azure Databricks

Genie One is an Azure Databricks home designed for business users. It brings dashboards, Genie Agents, and Databricks Apps together in one place.

:::image type="content" source="../media/genie-one.png" alt-text="Screenshot of the Genie One user interface.":::

Genie One is the entry point, and each Genie Agent provides a focused chat experience for one business topic.

## The Genie mobile app

The Genie mobile app (Public Preview) brings the Genie One experience to iOS and Android devices. It supports the same natural-language question-and-answer interactions as the desktop experience. This makes it useful when you need a quick data check away from your desk—for example, reviewing sales figures before a customer call or checking inventory levels during a site visit.

:::image type="content" source="../media/genie-mobile.png" alt-text="Screenshot of the Genie mobile app interface.":::

> [!IMPORTANT]
> The Genie mobile app is in Public Preview. Features and availability may change. Verify current availability with your administrator or in the [Azure Databricks release notes](/azure/databricks/release-notes/product/).

## Choosing the surface that fits your situation

Your organization may offer one or more of these surfaces. The table below helps you match a common situation to the right surface.

| Situation | Recommended surface |
|---|---|
| You're in Azure Databricks and want to ask a quick data question | Genie Agent (directly in Azure Databricks or Genie One) |
| You're working in Microsoft Teams and don't want to switch tools | Databricks Genie app in Microsoft Teams |
| You're using Microsoft 365 Copilot for your daily work | Genie on Microsoft 365 Copilot |
| You need a data answer on a mobile device | Genie mobile app |
| You want a single view of dashboards and agents | Genie One |

The next two units explore the Microsoft Teams and Microsoft 365 Copilot surfaces in detail—the ones Sofia uses to answer her question without leaving her collaboration tools.
