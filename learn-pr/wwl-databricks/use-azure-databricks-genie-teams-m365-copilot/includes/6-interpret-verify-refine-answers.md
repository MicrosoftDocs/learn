Getting a clear answer from Genie is only the first step. Before you act on that answer—share it with a colleague, include it in a report, or use it to make a decision—you need to inspect it, verify the key assumptions, and decide whether you need more information. This unit builds on the question-asking skills from the previous unit and focuses on what to do after the answer arrives.

## Inspect the answer before you act

Every Genie response includes several elements worth examining before you use the result:

**The answer itself:** Read the response carefully, including any natural-language summary above or below a table. Genie often states the filters and assumptions it applied—for example, "I filtered to Q1 2026 and included all active franchises." If it doesn't state these, ask.

**The source citation:** Genie includes a reference to the source used for the answer. Verify that the source covers the business topic you intended. An agent focused on one topic may not include all the data needed for a broader question.

:::image type="content" source="../media/genie-teams-answer.png" alt-text="Screenshot showing Microsoft Teams Databricks Genie answer.":::

**Suggested follow-up prompts:** These aren't just conveniences—they're a signal about what Genie thinks the natural next questions are. If the suggestions don't match what you'd logically ask next, that might indicate Genie interpreted your question differently than you intended.

> [!CAUTION]
> Genie can generate inaccurate responses even when the response appears confident and well-structured. Always verify numbers against your own expectations before using them in a decision or sharing them with others.

## Spot-check the assumptions Genie made

Even a well-structured SPARK question can produce an answer that's technically correct but not what you intended. Review the details in the response and ask a follow-up question when an assumption isn't clear. Check:

- **Scope:** Does the answer cover the products, regions, customers, or other groups you intended?
- **Period:** Does the date range match the period in your question?
- **Calculation:** Does the answer use the total, average, count, or percentage you requested?
- **Units:** Are the numbers in dollars or thousands of dollars? In units or in cases? Column headers often clarify this, but double-check.

If the response doesn't state one of these details, ask Genie directly. For example, ask, "Does this result include inactive customers?" or "Is this total in dollars or thousands of dollars?"

For Sofia's Q1 sales question, she checks the response and notices the table shows values in thousands of dollars—not the raw dollar figures she expected. She reads the column header ("Revenue (USD 000s)"), confirms that's consistent with how Contoso Bakehouse stores financial data, and adjusts her interpretation accordingly. This takes 30 seconds and prevents a thousandfold misreading.

## Handle ambiguous or uncertain answers

Some answers from Genie require more investigation before they're usable:

**Genie says it doesn't know or asks for clarification.** This is the expected behavior when your question doesn't match the available data or when the agent needs more context. Answer any clarifying questions Genie asks, or rephrase your question using SPARK elements.

**The number is surprisingly high or low.** Before assuming it's an error, ask Genie for a more detailed breakdown or comparison. For example, ask, "Show the monthly sales totals for Germany and France for Q1 2026." Genie answers straightforward factual data questions, but it doesn't reliably explain causes or recommend what to do. Bring verified data to the relevant domain expert when you need interpretation.

**Two similar questions return different numbers.** Ask Genie to state the period, included records, and calculation used for each answer. Then ask a new question that makes those details explicit. If the answers still conflict, ask your data team to verify them.

**Genie explicitly states uncertainty.** If the response includes language like "I'm not certain" or "this may not be complete," treat that as a signal to verify before acting. Ask a follow-up question, check the source, or consult your data team.

## Translate a verified answer into action

Once you've verified the answer, the final step is deciding what to do with it. Genie gives you data; the decision is yours. A few patterns:

- **Share in context:** If you're sharing the number in a Teams channel or meeting, include the key assumptions—the time period, the metric, and the data source—so colleagues understand what they're looking at.
- **Follow up with a deeper question:** Use the verified answer as the starting point for your next SPARK question. A total sales number leads naturally to a regional breakdown, which leads to a specific product or franchise comparison.
- **Escalate for further analysis:** If the answer reveals a trend or anomaly that warrants deeper investigation—for example, one region significantly underperforming—note the finding and bring it to the appropriate analyst or data owner for root-cause analysis. Genie can surface the "what"; human expertise handles the "why."
