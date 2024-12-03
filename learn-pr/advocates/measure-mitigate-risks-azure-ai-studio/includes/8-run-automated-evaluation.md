Automated Evaluations within Azure AI Foundry execute an AI-assisted evaluation which uses LLMs, such as GPT-4, to evaluate the output of generative AI language systems. This process is achieved by instructing an LLM to annotate certain aspects of the AI-generated output. For instance, you can provide GPT-4 with a relevance severity scale (for example, provide criteria for relevance annotation on a 1-5 scale) and then ask GPT-4 to annotate the relevance of an AI system’s response to a given question.

:::image type="content" source="../media/automated-evaluation-results.png" alt-text="A screenshot of the automated evaluation results within Azure AI Foundry. The screenshot displays the metric dashboard." lightbox="../media/automated-evaluation-results.png":::

We’re able to use AI-assisted evaluation to assess both the performance and safety of your generative AI application. AI-assisted evaluations can be beneficial in scenarios where ground truth and expected answers aren't available. In many generative AI scenarios, such as open-ended question answering or creative writing, single correct answers don't exist, making it challenging to establish the ground truth or expected answers that are necessary for traditional metrics.

In the context of the Contoso Camping Store chatbot, you’re provided with a test dataset which includes sample input, and a generated response from the model that is based on its current configuration. Let’s run an automated evaluation to assess the model’s performance and safety.

## Configure and run the automated evaluation

1. In the left navigation, within the **Assess and improve** section, select **Evaluation**.
1. Within the **Automated evaluations** tab, select **Create a evaluation**.
1. For the **What do you want to evaluate?** window, select **Dataset**.

**Basic Information**

1. In the **Evaluation name** field, enter: *automated-eval1*
1. Select **Next**.

**Configure test data**

1. For the **Select the data you want to evaluate** question, select **Add your dataset**.
1. Browse to where you saved **e2e-automated-evaluation-1.jsonl** and select the file for upload.
1. Select **Next**.

**Select metrics**

1. For the **AI Quality (AI Assisted)** metrics, select **Coherence**, **Fluency**, **Similarity**.
1. For the **Connection** field, select your AzureOpenAI connection.
1. For the **Deployment name/Model** field, select the **gpt-4o** model.
1. For the **Risk and safety metrics curated by Microsoft**, select all the metrics.
1. For the **Set the threshold to calculate the defect rate**, select **Medium**.
1. For the **How does your dataset map to the evaluation input?** section, map the following fields:

| **Flow** | **Dataset source** |
| --- | --- |
| response | answer or ${data.answer} |
| query | question or ${data.question} |
| ground_truth | ground_truth or ${data.ground_truth} |

**Review and finish**

1. Confirm that all configurations are accurate. If necessary, select the pencil icon to edit the configurations.
1. Select **Submit**.

> [!NOTE]
> The evaluation may take a few minutes to execute. Once the evaluation is complete, you can view the results by navigating to the evaluation run within the **Automated evaluations** tab.

## Review the evaluation results

The results for the automated evaluation vary as the evaluation is influenced by the GPT model that is used to execute the AI-assisted evaluation. Therefore, the review of results provided is generalized and based on sample automated evaluation results. You’re encouraged to analyze your own automated evaluation results to brainstorm potential improvements that could be made to improve results.

1. In the left navigation, within the **Assess and improve** section, select **Evaluation**.
1. On the **Automated evaluations** tab, select the **automated-eval1** evaluation run from the list to view more details on the run detail page.
1. The **Metric dashboard** provides the averages for each metric. Toggle between the **AI Quality (AI Assisted)** and **Risk and safety** tabs to analyze the average results.
1. The **Detailed metrics result** section provides a breakdown of the results for each row of data evaluated. Scroll through the result table to analyze the results and view the respective reasoning.

> [!TIP]
> Select the **i** icon for each metric to learn more about the meaning of the metric. Also, the highest score possible for each **AI Quality (AI Assisted)** metric is 5.

## Decide on the best course of action

Now that you have the results of the automated evaluation, you’re equipped with analytical data to influence and support your next course of action. Does the system message need adjustments? Is there another data connection to be made? Or do you suspect that another model might provide better results? These ideas are some of ideas that might come to mind after analyzing the results.

## Run a second automated evaluation

To facilitate a comprehensive comparison between two or more runs, you can select the desired runs and initiate the comparison process within a **List** or **Dashboard** view. Let’s run another automated evaluation for the model and compare the results.

> [!NOTE]
> The **e2e-automated-evaluation-2.jsonl** file simulates a fictitious dataset where it is assumed that modifications were made to improve the model, such as modifying the system message, adjusting content filters, and/or grounding with additional data.

## Dashboard view

:::image type="content" source="../media/compare-automated-evaluations.png" alt-text="A screenshot of the comparison of two automated evaluations in Azure AI Foundry. The scores are higher for the second evaluation." lightbox="../media/compare-automated-evaluations.png":::

1. In the left navigation, within the **Assess and improve** section, select **Evaluation**.
1. Create a new evaluation following the steps in the **Configure and run an automated evaluation** exercise and name the evaluation **automated-eval2**. Use the **e2e-automated-evaluation-2.jsonl** file as the dataset.
1. Once the evaluation is complete, select both the **automated-eval1** and **automated-eval2** evaluation runs in the **Automated evaluations** list.
1. Select **Compare**.
1. Hover over the title of **automated-eval1** and select **Set as baseline**. This sets the initial evaluation as the baseline metrics across all evaluation metrics. This is helpful for comparing a baseline set of metrics to newly run evaluations.
1. Observe how the metrics might change after making adjustments to the system prompt or refining the grounded data.
1. For a streamline view to observe differences, enable the **Show differences** toggle. This toggle modifies the table to only display the rows that differ between the baseline run **(automated-eval1)** and the compared run **(automated-eval2)**. This feature can be helpful to highlight discrepancies between runs and pinpoint where potential improvements or adjustments might be needed.

There’s now a significant improvement in results after making changes to the model. Once the chatbot is deployed and used by Contoso Camping Store customers, you’re encouraged to execute more evaluation runs and compare results to analyze the model’s behavior.