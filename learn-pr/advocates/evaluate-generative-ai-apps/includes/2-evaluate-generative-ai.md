Evaluations are systematic assessments of the performance, reliability, and safety of generative AI applications. They help you validate whether an application is producing useful, grounded, and policy-compliant responses across the scenarios that matter most to your users.

Evaluations are crucial for several reasons:

- **Quality assurance**: They help ensure that AI systems meet the expected standard for usefulness, clarity, and reliability.
- **Safety validation**: They surface harmful or policy-breaking behavior before it reaches end users.
- **Change comparison**: They help you compare prompt, retrieval, model, and tool changes with evidence instead of anecdotes.
- **User trust**: Consistently evaluated applications are easier to improve and easier for stakeholders to trust.

## AI-assisted evaluations in Microsoft Foundry

Generative AI applications usually need more than one metric. In the Foundry portal, built-in evaluators are organized into three high-level groups: **Agent**, **Quality**, and **Safety**. In the full catalog, those groups expand into evaluator families such as general-purpose quality, textual similarity, RAG, risk and safety, and agent evaluators. That structure helps you test different failure modes instead of treating evaluation as a single accuracy score.

AI-assisted evaluators across the quality catalog, plus many agent evaluators, need an Azure OpenAI connection with a deployed GPT model that supports chat completion. Safety evaluators and `Groundedness Pro` use Microsoft's hosted evaluation services instead, so they don't depend on a judge model deployment. That distinction affects prerequisites, cost planning, and which evaluators you can run in a given region.

## Evaluate with Microsoft Foundry

Use the Foundry portal when you want a guided workflow. The current portal flow lets you choose an evaluation target (**Agent**, **Model**, or **Dataset**), upload or generate a dataset, select built-in or custom evaluators, confirm data mapping, and inspect the results in the portal.

:::image type="complex" source="../media/automated-evaluation-results.png" alt-text="A screenshot of automated evaluation results in Microsoft Foundry. Charts display average scores and counts for coherence, fluency, groundedness, and relevance, and a separate view shows risk and safety results.":::
   The image shows an evaluation dashboard with run details and a metric summary. The dashboard includes charts for several evaluators, lets you filter metrics, and provides both quality and risk-and-safety views. This type of result page helps you see the overall trend of a run before you inspect individual prompt and response pairs.
:::image-end:::

After a run completes, review both the aggregate metrics and the row-level results. Aggregate metrics show overall movement, while row-level results show which prompts failed, the scores and labels they received, and why the evaluator marked them that way.

## Use SDK workflows for automation

Use SDK workflows when you need repeatable automation, larger-scale predeployment testing, or CI/CD integration. Current cloud evaluation guidance supports JSONL or CSV dataset evaluations, model-target evaluations, agent-target evaluations, agent-response evaluations (by response ID), synthetic data evaluations (preview), and red team evaluations. Those runs are stored in your Foundry project so you can review them in the portal alongside other evaluations, and you can also schedule them or set up continuous evaluation on sampled production agent responses.

Because cloud evaluation is currently preview, and because some evaluation features have region-specific support, confirm the current preview terms, supported regions, and operational limits before you use it as a production release gate.

Regardless of the tool you choose, combine automated evaluation with targeted human review. A small, representative human-reviewed sample often surfaces tone issues, incomplete answers, or misleading-but-plausible outputs that aggregate scores can hide.

> [!TIP]
> For current procedures, see [Run evaluations from the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-generative-ai-app), [Run evaluations in the cloud by using the Microsoft Foundry SDK](/azure/foundry/how-to/develop/cloud-evaluation), [View evaluation results in the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-results), and [Rate limits, region support, and enterprise features for evaluation](/azure/foundry/concepts/evaluation-regions-limits-virtual-network).
