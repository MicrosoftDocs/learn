Automated evaluations in Azure AI Foundry use built-in evaluators to score model or dataset outputs at scale. AI-assisted quality evaluators such as coherence and fluency use a judge model, while similarity compares responses against expected answers when you provide ground-truth data. Risk and safety evaluators inspect content for harmful or insecure behavior. Evaluator availability varies by region, which is one reason this module uses **East US 2**.

:::image type="content" source="../media/automated-evaluation-results.png" alt-text="A screenshot of the automated evaluation results within Azure AI Foundry. The screenshot displays the metric dashboard." lightbox="../media/automated-evaluation-results.png":::

AI-assisted evaluation is useful when you want a repeatable way to measure both quality and safety across many prompts. It's especially helpful in generative AI scenarios where outputs are open-ended and traditional pass-or-fail checks aren't enough.

In this unit, you use a **dataset** target. That means Azure AI Foundry scores the responses already stored in the `.jsonl` file instead of rerunning your live playground configuration. The sample dataset includes prompt, answer, and ground-truth fields so you can evaluate the dataset's quality and safety profile at scale.

## Configure and run the automated evaluation

1. In the left navigation, within the **Assess and improve** section, select **Evaluation**.
1. If your portal separates evaluations by type, open the **Automated evaluations** tab and select **Create**. If it uses a single create flow, select **Create** and choose **Dataset** as the evaluation target.

**Basic Information**

1. In the **Evaluation name** field, enter: *automated-eval1*
1. Select **Next**.

**Configure test data**

1. For the **Select the data you want to evaluate** question, select **Add your dataset**.
1. Select **Upload file**, browse to where you saved **e2e-automated-evaluation-1.jsonl**, and select the file for upload.
1. Select **Next**.

**Select metrics**

1. For the **AI Quality (AI Assisted)** metrics, select **Coherence** and **Fluency**. If **Similarity** appears in a separate **Textual similarity** section in your portal, select it there as well. Similarity uses the `ground_truth` field that you map later in this workflow.
1. For the **Connection** field, select your **Azure OpenAI** connection.
1. For the judge **Deployment name/Model** field, select a deployed chat completion model, such as the chat deployment you created earlier. The judge can be the same chat deployment you're testing, or another supported chat deployment in the same project, but it must not be the embedding deployment you created for the index.
1. For the **Risk and safety metrics curated by Microsoft**, select the metrics that apply to this scenario (for example, **Hate and unfairness**, **Sexual**, **Violent**, **Self-harm**, **Protected material**, **Indirect attack**, and **Groundedness Pro**). If your portal exposes **Select all** and your region supports every metric, you can use that option. Region support varies; **East US 2** is one of the regions that supports the full risk and safety set - including **Protected material**, **Indirect attack**, and **Groundedness Pro** - which is why this module uses that region. For more information, see [Rate limits, region support, and enterprise features for evaluation](/azure/ai-foundry/concepts/evaluation-regions-limits-virtual-network) and [Risk and safety evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/risk-safety-evaluators).
1. For **Set the threshold to calculate the defect rate**, select **Medium**. This setting controls how the evaluation report summarizes risk and safety findings for the run; it doesn't change the content filter attached to your deployment, which is configured separately. Use the row-level severity scores and evaluator reasoning to interpret flagged outputs rather than relying only on the aggregate defect rate. For background, see [Risk and safety evaluators](/azure/ai-foundry/concepts/evaluation-evaluators/risk-safety-evaluators) and [Microsoft Foundry risk and safety evaluations Transparency Note](/azure/foundry/concepts/safety-evaluations-transparency-note).
1. For the **How does your dataset map to the evaluation input?** section, map the following fields and select **Next**:

| **Name** | **Data source** |
| --- | --- |
| query | question |
| response | answer |
| ground_truth | ground_truth |

**Review and finish**

1. Confirm that all configurations are accurate. If necessary, select the pencil icon to edit the configurations.
1. Select **Submit**.

> [!NOTE]
> The evaluation may take a few minutes to execute. Once the evaluation is complete, open the evaluation run to review the results. If a metric is unavailable or missing, verify your region and model support. For more information, see [Run evaluations from the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-generative-ai-app) and [Rate limits, region support, and enterprise features for evaluation](/azure/ai-foundry/concepts/evaluation-regions-limits-virtual-network).

## Review the evaluation results

The results for the automated evaluation vary because the evaluation is influenced by the judge model and the dataset. Therefore, the review of results provided is generalized and based on sample automated evaluation results. Treat the scores as signals for investigation, not proof that the app is production-ready, and analyze your own row-level results to decide what to improve next.

1. In the left navigation, within the **Assess and improve** section, select **Evaluation**.
1. Select the **automated-eval1** evaluation run from the list to open the run detail page.
1. Review the average scores for the AI quality and risk and safety evaluators.
1. Inspect the row-level results and reasoning to understand which prompts produced the weakest outcomes.

> [!TIP]
> Select the **i** icon or **Learn more about metrics** link for evaluator definitions and scoring details. For more information, see [View evaluation results in the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-results).

## Decide on the best course of action

Now that you have the results of the automated evaluation, you're equipped with analytical data to influence and support your next course of action. Does the system message need adjustments? Is there another data connection to be made? Or do you suspect that another model might provide better results? These are some of the ideas that might come to mind after analyzing the results.

## Run a second automated evaluation

To facilitate a comprehensive comparison between two or more runs, select the runs you want to compare and open the comparison view. In this exercise, you use a second pregenerated dataset so you can practice the comparison experience without having to regenerate outputs yourself first.

> [!NOTE]
> The **e2e-automated-evaluation-2.jsonl** file is a pregenerated sample that simulates improved outputs after changes such as refining the system message, adjusting content filters, and improving the grounded data. In a real workflow, you would make those changes in your app and then regenerate or capture a fresh dataset before running the second evaluation.

## Compare two evaluation runs

:::image type="content" source="../media/compare-automated-evaluations.png" alt-text="A screenshot of the comparison of two automated evaluations in Azure AI Foundry. The scores are higher for the second evaluation." lightbox="../media/compare-automated-evaluations.png":::

1. In the left navigation, within the **Assess and improve** section, select **Evaluation**.
1. Create a new evaluation following the steps in the **Configure and run the automated evaluation** exercise and name the evaluation **automated-eval2**. Use the **e2e-automated-evaluation-2.jsonl** file as the dataset.
1. Once the evaluation is complete, select both the **automated-eval1** and **automated-eval2** evaluation runs.
1. Select **Compare**.
1. If the comparison view lets you set a baseline, set **automated-eval1** as the baseline.
1. Review which metrics improved, degraded, or remained inconclusive between the two datasets.
1. Inspect the row-level differences to understand why the second run scored differently.

There's now a clearer picture of how the scored outputs differ between runs. In a production workflow, pair automated evaluations with human review and compare fresh runs each time you change prompts, grounding data, models, or guardrails. For more information about evaluator categories, region support, and results interpretation, see [Run evaluations from the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-generative-ai-app), [Rate limits, region support, and enterprise features for evaluation](/azure/ai-foundry/concepts/evaluation-regions-limits-virtual-network), and [View evaluation results in the Microsoft Foundry portal](/azure/foundry/how-to/evaluate-results).
