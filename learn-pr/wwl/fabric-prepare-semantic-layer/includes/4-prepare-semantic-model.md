Your curated gold layer now gives Copilot a clear path for "sales by city." However, the semantic model might include more data than Copilot needs. Copilot might also need a business rule or a set answer for a common question. **Before you mark the semantic model Approved for Copilot, you need to identify and fix these AI-specific gaps.**

:::image type="content" source="../media/prep-for-ai-decision-flow.png" alt-text="Diagram showing the semantic model flowing into three Prep for AI controls and then to Approved for Copilot.":::

## Match each control to a problem

Power BI Desktop has a **Prep data for AI** feature to help optimize your semantic model for Copilot usage. It provides three controls, and each one solves a different type of problem.

- An **AI data schema** defines the focused fields Copilot uses for data questions. Use it when the semantic model supports multiple report areas but Copilot should only use a subset of fields. 
- An **AI instruction** adds business rules that the semantic model can't express, like telling Copilot that `city` means customer city unless someone asks for store city. 
- A **verified answer** returns a human-approved visual and filters when a prompt matches a trigger phrase. Use it when a common question needs the same answer every time.

The semantic model might also support other report areas like finance or service. Copilot doesn't need all those fields to answer sales questions. You can use an AI data schema to limit Copilot to the sales fields it needs without removing fields from the semantic model. If a common question needs an approved map with set filters, a verified answer returns that map. **The result you need determines which control fits**.

## Test before approval

Power BI stores Prep for AI settings on the semantic model, so each setting affects every Copilot experience that uses it. You need to test each control against your business requirements before approving.

Start by asking the same priority questions you gathered earlier. For each answer, check whether Copilot used the fields from your AI data schema, followed the business rules in your AI instructions, and returned the correct verified answer when a trigger phrase matched. Also test questions that are close to a trigger phrase but shouldn't return the verified answer — this confirms the control is scoped correctly.

When something doesn't work as expected, identify which control or semantic model detail caused the issue. Fix one thing at a time, close and reopen the Copilot pane, then retest. Repeat until your priority questions consistently use the right measures, fields, and filters. Only then does the semantic model earn approval — and that approval means you trust the reasoning path for the questions you tested, not that Copilot handles every possible question perfectly.

> [!TIP]
> Think of one problem Copilot has with a semantic model in your organization. Do you need to change the semantic model, limit the data Copilot uses, add a business rule, or return an approved visual? What result tells you that your choice works?
