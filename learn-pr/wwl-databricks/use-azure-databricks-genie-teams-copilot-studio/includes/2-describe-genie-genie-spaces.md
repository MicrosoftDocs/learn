Executives, sales managers, and operations staff all have data questions. What they typically don't have is SQL skills or reliable access to a data team that can respond within minutes. Azure Databricks Genie closes that gap by giving business users a conversational interface to structured enterprise data.

## What Azure Databricks Genie is

Genie is a **natural-language AI interface** for querying your organization's data. You ask a question in plain language, and Genie generates a **read-only SQL query**, runs it against a configured **SQL warehouse**, and returns the results as a table, a chart, or a natural-language summary. Genie never writes, modifies, or deletes data.

:::image type="content" source="../media/genie.png" alt-text="Screenshot of Azure Databricks Genie.":::

A key characteristic is that Genie is **tailored to your organization**. It doesn't draw on public internet knowledge. Every answer comes from your data, governed by **Unity Catalog**.

When Genie isn't certain it has the right answer, it asks for clarification instead of guessing. When it produces an answer, it shows the SQL query it used so you can verify the logic.

## What Genie Spaces are

A **Genie Space** is a curated, topic-scoped conversational environment. Think of it as a focused version of Genie built for a specific **business domain**—sales pipeline, HR metrics, supply chain, or in the case of Contoso Bakehouse, franchise sales and transactions.

A data analyst or data engineer creates a Genie Space by selecting tables from Unity Catalog and adding business-language instructions: what the tables contain, how common terms are defined, how tables relate to each other, and what the most important recurring questions look like. This context is stored in the space's **knowledge store**.

Once a space is ready, users with access can ask it questions the same way they'd ask a colleague. The space uses that curated context to translate each question into accurate SQL, run the query, and return the results.

:::image type="content" source="../media/genie-space.png" alt-text="Screenshot of Azure Databricks Genie Space.":::

> [!NOTE]
> The knowledge store configuration—selecting tables, writing instructions, defining example queries—is covered in a separate unit. See [Configure AI/BI Genie instructions](/training/modules/create-and-organize-objects-in-unity-catalog/9-configure-ai-bi-genie-instructions). This module doesn't repeat that content.

## Trusted answers

Within a Genie Space, administrators can designate **trusted assets**: pre-approved SQL queries that answer specific high-value questions. When Genie uses a trusted asset to respond to your question, the response is labeled **Trusted**. That label signals that a **domain expert**—not just the AI—has already verified the logic.

Trusted answers are especially valuable for metrics that must be consistent across the organization, such as revenue totals, churn rate, or inventory counts. Everyone who asks that question gets the same verified answer.

## Genie Spaces and the Genie interface

It's worth understanding the difference between a *Genie Space* and the broader *Genie interface*.

The Genie interface is the main entry point in Azure Databricks for business users. It surfaces dashboards, Genie Spaces, and Databricks Apps from across your account in a single place. Think of it as the front door.

A Genie Space is a specific room inside that front door—a curated chat experience for one domain, built and maintained by your data team. When you chat with a Genie Space, you're working within that domain's data and rules.

You can access Genie Spaces directly in **Azure Databricks**, through the **Genie mobile app**, through the **Databricks app in Microsoft Teams**, or through a **Copilot Studio agent**. The next units explore the Microsoft Teams paths in detail.
