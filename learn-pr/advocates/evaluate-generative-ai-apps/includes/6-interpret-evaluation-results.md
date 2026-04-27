Accurately interpreting evaluation results is essential because scores only become useful when you read them in context. A good review looks at the evaluator type, the dataset, the user scenario, and the mitigation decision you need to make next. Misreading those signals can lead to overconfidence in a flawed system or to changes that don't address the real problem.

## Start with the evaluator's output contract

Before deciding whether a result is good or bad, confirm what the evaluator actually returned. Current Foundry evaluation results commonly include:

- **A `label`** such as `pass` or `fail` so you can compare across evaluators
- **A `score`** on the evaluator's natural scale
- **A `threshold`** that converts non-binary numeric scores into pass/fail
- **A `reason`** for most LLM-judge evaluators
- **Optional `details`** for some evaluators, especially agent-oriented ones such as `Tool Call Accuracy`

Not every evaluator uses the same score scale:

- **1-5 judge scores** for many quality and RAG evaluators
- **0-1 algorithmic scores** for metrics such as F1, BLEU, GLEU, and METEOR
- **0-7 severity scores** for core harm evaluators (Hate and Unfairness, Sexual, Violence, Self-Harm), with a default pass threshold of 3
- **Boolean or pass/fail results** for evaluators such as Groundedness Pro, Indirect Attack, Protected Materials, Code Vulnerability, and Ungrounded Attributes

A pass label is useful for triage, but don't stop there. Always read the natural score, threshold, and reason behind it.

## Use aggregate and row-level views together

Aggregate results help you spot trends across the whole dataset. Row-level results show which prompts failed, what the model said, and why the evaluator assigned a score or label. Both views matter.

For example, a model might show acceptable average relevance, but the row-level results could reveal that it fails consistently on one type of customer question or one retrieval source. Those clustered failures are often more actionable than the average score itself.

If metrics are missing or an entire category looks suspiciously empty, verify that the evaluator was selected and supported for that run before you interpret the absence of data as a good result.

## Compare runs against a baseline

Single evaluations can be misleading. The most useful comparisons come from running the same dataset and evaluator set before and after a change, then comparing the results against a baseline. This makes it easier to attribute a score change to a prompt revision, retrieval update, filtering change, or model swap.

Current Foundry comparison guidance also emphasizes statistical testing when comparing runs. In the portal comparison view, Microsoft Foundry uses statistical t-testing and color-coded indicators (such as *ImprovedStrong*, *ImprovedWeak*, *DegradedStrong*, *DegradedWeak*, *ChangedStrong*, *ChangedWeak*, and *Inconclusive*) based on sample size and p-value to flag whether a change looks improved, degraded, or inconclusive. Treat a small numerical difference with caution unless the difference is statistically significant and meaningful across enough samples.

## Balance quantitative and qualitative insights

The strongest interpretation combines numeric metrics with human review. Numeric scores tell you where to look; human review explains whether the failure matters in the real experience.

For example, a customer-support response can score well for fluency and relevance but still sound cold or overly procedural. A reviewer might conclude that the answer is technically correct yet likely to frustrate the user because it lacks empathy or fails to answer the user's real concern.

## Look for trends, not isolated wins

Evaluation is most useful when you observe patterns over time. Repeatedly low groundedness can point to a retrieval problem. Repeated safety failures can point to missing guardrails. A strong overall score with a recurring edge-case failure can indicate that your average metrics are hiding a serious risk.

When you interpret results this way, evaluations become more than a report card - they become evidence for what to improve next.

> [!TIP]
> Review the aggregate, comparison, and sample-level views together when you analyze an evaluation run. For the current portal workflow, see [View evaluation results in the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-results).
