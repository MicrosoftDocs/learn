Imagine you ask Copilot, "Which products are most profitable?" The semantic model contains both `Profit` and `Profit Margin`. Copilot must choose one measure, and the wrong choice can misdirect decisions. You need to understand what Copilot reads and why the semantic model is the right place to fix this.

:::image type="content" source="../media/copilot-schema-reduction-flow.png" alt-text="Diagram that shows a question flowing through schema reduction with two outcomes based on definition clarity.":::

## What Copilot reads from your semantic model

When someone asks Copilot a question directly, Copilot reads names, descriptions, measures, data types, synonyms, and relationships from the semantic model. It then narrows that information to the fields related to the question. This process is called _schema reduction_.

If `Profit` and `Profit Margin` don't have clear definitions, Copilot has no way to tell them apart during schema reduction. **The semantic model is where Copilot gets its business context — if the meaning isn't there, Copilot guesses.**

> [!NOTE]
> Clear semantic model details reduce ambiguity, but Copilot can still return different answers to the same question.

## Why you fix the semantic model first

You can add an AI instruction that tells Copilot which profit measure to use. But that only works for Copilot — reports still show the same unclear meaning. When you fix the semantic model instead, you create one definition that works for reports, Copilot, and any other AI experience that uses it.

This is why semantic model design comes before Prep for AI controls. The semantic model is the shared foundation. AI-specific controls add guidance only for problems the semantic model can't solve on its own. **Fix the source once, rather than patching each consumer separately.**

## Where to start

To know what "wrong" looks like, you need to know what "right" looks like first. Before you test Copilot, gather the business requirements: which questions do leaders ask, which measures should each question use, and which fields matter for the answer. When you have that baseline, a wrong answer becomes a clear signal.

Since Copilot reads names, descriptions, measures, and relationships, those are the details you need to get right. If Copilot uses `Profit Margin` instead of `Profit`, you know it's a measure problem because your requirements say that question should use `Profit`. **The wrong answer combined with clear requirements tells you exactly where to look.**

Once you know what Copilot reads and what your business requires, the next step is designing the semantic model so those details are clear.

> [!TIP]
> Think of one business question Copilot needs to answer in your organization. Do you know which measure and fields the answer should use? If not, that's where to start.
