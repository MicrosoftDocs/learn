Getting a useful answer from Genie depends less on the surface you use and more on the question you ask. A vague question produces a vague answer; a well-structured question produces a specific, actionable one. The **SPARK framework** gives you a repeatable checklist for building questions that remove ambiguity and produce reliable results.

## Get context before you ask

When you first access a Genie Agent—or when you're working with an unfamiliar data domain—start with an orientation question before asking anything specific:

> Tell me about this dataset.

or

> What kinds of questions can I ask here?

The response describes the available topics, time periods, geographic dimensions, and suggested question patterns for that agent. This step helps you understand what data is available before you ask a question—and avoids the frustrating experience of asking about data the agent doesn't cover.

For example, Sofia opens the Contoso Bakehouse Sales Agent for the first time and asks, "What kinds of questions can I ask here?" The agent responds by listing available metrics (revenue, unit sales, franchise performance, country/region breakdowns) and the time range covered (2024 through present). With that context, she knows exactly how to frame her Q1 question.

## The SPARK framework

**SPARK** is a five-element checklist for structuring Genie questions:

| Letter | Element | Description | Example |
|---|---|---|---|
| **S** | **Scope** | Which data area or domain you're asking about | Sales data, franchise transactions, HR headcount |
| **P** | **Period** | The time range—Q1, last 30 days, full year 2025 | Q1 2026, January through March 2026 |
| **A** | **Aggregation** | How to calculate—total, average, count, percent change | Total, average per region, count of orders |
| **R** | **Result** | The output format you want—table, summary, single number | Table with country/region breakdown, brief summary |
| **K** | **Key metric** | The specific value or measure you care about | Revenue in dollars, unit count, on-time delivery percentage |

Not every question needs all five elements. But including as many as apply significantly reduces guesswork on Genie's part—and makes it less likely that Genie returns something technically correct but not what you intended.

## Apply SPARK to your questions

The most common source of unexpected answers is a **missing time period** (the P in SPARK). When you don't specify a period, Genie makes an assumption—and that assumption may not match what you had in mind.

Compare these question pairs across different business contexts:

**Sales:**
- Vague: What were my sales?
- SPARK: What were total sales in dollars by country/region for Q1 2026, shown as a table?

**Finance:**
- Vague: Are we over budget?
- SPARK: What is the total actual spend versus budget for the marketing department for Q1 2026, shown as a table with a variance column?

**Operations:**
- Vague: How is fulfillment doing?
- SPARK: What was the average order fulfillment rate by warehouse for March 2026, as a summary?

**HR:**
- Vague: Show me headcount.
- SPARK: What was total headcount by department as of March 31, 2026, shown as a table ranked from largest to smallest?

In each case, the SPARK version covers all five elements: scope (the data domain), period (specific dates), aggregation (how to calculate), result (the format you want), and key metric (the exact value). That structure removes ambiguity and consistently produces a more reliable answer.

## Use multi-turn conversations to drill deeper

Genie maintains conversation context within a thread or conversation session. Once you've established the dataset and time period, follow-up questions don't need to repeat that context.

After asking about Q1 sales by country/region, Sofia follows up with:

> Which country/region had the highest growth compared to Q4 2025?

Genie carries the earlier context forward. She doesn't need to re-specify the metric, the time range, or the data source. Multi-turn conversations let you explore data progressively—start broad, then drill into the detail that matters.

> [!TIP]
> If Genie asks you a clarifying question before answering—for example, "Did you mean revenue or unit count?"—answer it. That clarification ensures the agent has the context it needs to give you a reliable result. If you skip the clarification and repeat the question, Genie makes an assumption that might not be correct.

Context is maintained within a single thread. If you start a new thread or open a new conversation, Genie starts fresh without memory of that earlier thread.
