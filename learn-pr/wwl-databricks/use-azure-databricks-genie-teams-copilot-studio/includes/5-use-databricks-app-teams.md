The Databricks app is in your Microsoft Teams sidebar and your workspace is connected. The quality of answers you get from Genie depends directly on the quality of questions you ask. A structured approach called **SPARK** helps you build questions that produce reliable results.

## The SPARK framework

**SPARK** is a five-element checklist for writing Genie questions that remove ambiguity:

| Letter | Element | Description |
|---|---|---|
| **S** | **Scope** | Which data area or domain you're asking about |
| **P** | **Period** | The time range—Q1, last 30 days, full year 2026 |
| **A** | **Aggregation** | How to calculate—total, average, count, percent change |
| **R** | **Result** | The output format you want—table, chart, bullet summary |
| **K** | **Key metric** | The specific value—revenue in dollars, unit count |

Not every question needs all five elements, but including as many as apply significantly reduces guesswork on Genie's part.

## Orient yourself before diving in

When you first connect to a Genie Space, ask an **orientation question**:

> Tell me about this dataset.

or

> What kinds of questions can I ask here?

The response describes the available tables, time periods, geographic dimensions, and suggested question patterns. This step helps you understand the scope before asking specific questions—and avoids the frustrating experience of asking about data the space doesn't contain.

## Apply SPARK to your questions

The most common source of unexpected answers is a **missing time period** (the P in SPARK). Genie makes assumptions when you leave context out, and those assumptions may not match what you intended.

Compare these two questions:

**Vague:** What were my sales?

**Specific (SPARK):** What were total sales in dollars by country for Q1 2026, shown as a table?

The specific version covers all five elements: scope (sales data), period (Q1 2026), aggregation (total), result format (table), and key metric (dollars). That context removes ambiguity and produces a reliable answer.

## Use multi-turn conversations

The Databricks app **maintains conversation context** within the thread. Once you've established the dataset and time period, follow-up questions don't need to repeat that context.

After asking about Q1 sales by country, you can follow up with:

> Which country had the highest growth compared to Q4 2025?

Genie carries the earlier context forward. Multi-turn conversations let you explore data progressively—start broad, then drill into the detail that matters.

> [!NOTE]
> If a user can query the space in the Azure Databricks UI but gets no results in Microsoft Teams, first verify that the Microsoft Teams Databricks app is connected to the same workspace and account where the Genie Space exists. A mismatched workspace or account is the most common cause.

## Read the response carefully

Every Genie response includes the answer, an analysis note, and a source citation. Before using the number:

- **Check which filters were applied** (date range, region, product category). Genie usually states these, but confirm they match your question.
- **Check the unit** (dollars vs. unit count, thousands vs. millions). Read column headers carefully.
- **Review the generated SQL** if the result is unexpected. The response includes a "Show generated code" link. Select it to see exactly what query ran—this is the fastest way to diagnose a result that doesn't look right.

## Give feedback from the right place

If an answer looks wrong, the thumbs up/down, "fix it," and "request review" **feedback controls are in the Databricks Genie Space UI**—not in Microsoft Teams.

From the Microsoft Teams response, follow the source link to open the Genie Space in Azure Databricks. From there, rate the answer and add a note explaining what was wrong. Your space administrators use this feedback to improve the knowledge store, which makes future answers more accurate for everyone.
