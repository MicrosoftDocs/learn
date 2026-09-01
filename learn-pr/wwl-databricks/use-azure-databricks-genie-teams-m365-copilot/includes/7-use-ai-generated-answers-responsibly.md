Genie makes it faster to get answers to data questions, but faster access to data carries responsibilities. The decisions you make from AI-generated answers are your decisions—and the quality of those decisions depends on how critically you engage with what Genie tells you. This unit covers the key responsible-use practices for business users who rely on Genie-generated answers.

## Understand what Genie can and can't answer

Genie excels at **straightforward factual data questions**: questions that can be resolved by querying a database and returning a specific value.

It handles questions like:
- "What were total sales in dollars by region for Q1 2026?"
- "How many active franchise locations are in Germany?"
- "What was the average order fulfillment rate for last month?"

For most business queries, Genie retrieves and reports data—it doesn't diagnose root causes or give strategic recommendations:
- "Why were sales low in Q1?"—a factual query returns the data; interpretation is yours.
- "What should we do about the drop in Germany?"—Genie surfaces numbers, not decisions.
- "Is this trend normal?"—Genie doesn't have the business context to judge normality.

If you ask Genie an interpretive question, it may attempt an answer—but treat that answer as a starting point, not a conclusion. Use Genie to surface the data, then bring it to a conversation with the people who can interpret it.

> [!IMPORTANT]
> Genie can generate inaccurate responses even when the output appears confident and complete. AI systems, including Genie, can produce plausible-sounding but incorrect results. Treat AI-generated data answers as a starting point for your analysis—not as a final, verified source.

## Recognize the risk of AI-generated data errors

AI-generated answers can be wrong for several reasons:

**Ambiguous questions.** A vague question produces an answer based on Genie's best interpretation of your intent—and that interpretation may not match what you meant. The more specific your SPARK question, the lower this risk.

**Source data quality.** Genie answers questions using source data made available by your data team. If that data contains errors, gaps, or outdated records, Genie's answer reflects those issues. Genie doesn't validate the quality of the source data.

**Topic mismatch.** If you ask a question that spans several business topics and the Genie Agent covers only one of them, the answer may be incomplete without Genie flagging that it's incomplete.

**Trusted vs. generated answers.** A response labeled **Trusted** means a domain expert reviewed and confirmed the answer for that specific question. An unlabeled response means Genie generated a new answer. Both can be correct, but a trusted answer provides an additional review signal for high-impact decisions.

The best defense against these risks is the inspect-verify-refine workflow from the previous unit: check the filters, review the source, and ask a follow-up question when something doesn't look right.

## Consider visibility when sharing answers

Where and how you share a Genie answer matters:

**In a direct message or private conversation:** The answer isn't visible to other channel members. This is the appropriate place for exploratory questions, preliminary analysis, or sensitive topics.

**In a public or team channel:** When you mention `@Databricks Genie` in a public channel, both the question and the answer are visible to all channel members. Before posting, consider whether the data is appropriate to share broadly. Some metrics—such as individual employee performance data or pre-announcement financial figures—may have confidentiality requirements that make a public channel the wrong venue.

**In a report or presentation:** When you use a Genie-generated number in a formal deliverable, include the source (the Genie Agent name), the key parameters (date range, scope, aggregation), and a note that the figure was AI-generated and verified. This gives your audience the context they need to evaluate the number.

## Know when to escalate or verify with a domain expert

Not every Genie answer is sufficient on its own. Use the following guidelines to decide when to escalate:

**High-impact decisions:** If a decision affects significant budget, headcount, product direction, or customer relationships, don't rely solely on a Genie answer. Ask your data team or a domain expert to verify the figure independently.

**Unexpectedly high or low values:** If a number surprises you, treat it as a hypothesis rather than a fact until you can verify it. Follow the inspect-verify-refine steps from the previous unit.

**Conflicting answers:** If you ask two similar questions and get different results, escalate to your data team. A discrepancy may indicate a source data issue or a difference in how Genie interpreted the questions.

**Regulatory or compliance-sensitive metrics:** Some business metrics are governed by regulatory requirements—for example, financial reporting figures or privacy-sensitive HR data. These require human verification and shouldn't be sourced from an AI-generated answer without additional review.

Remember: you are accountable for the decisions you make. Genie is a tool that accelerates access to data. The judgment about what to do with that data remains yours.
