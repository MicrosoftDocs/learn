You can use *offline evaluations* to figure out how well Azure AI Personalizer does compared with your app's default behavior, and measure how configuration setting changes can improve your model.

When you create a new offline evaluation, its *Optimization discovery* capability can run evaluations against various learning policy values to identify a combination that can improve your model's performance.

## Run offline evaluation

To run an offline evaluation, you go to the Azure portal to find your Azure AI Personalizer resource. You select **Optimize** under Resource management, then you select **Create evaluation**:

:::image type="content" source="../media/7-create-evaluation.png" alt-text="A screenshot showing how to create evaluations.":::

You then provide details about the evaluation in the evaluation form:

:::image type="content" source="../media/7-evaluation-form.png" alt-text="A screenshot showing the evaluation form.":::

You set the following:

- Your chosen **Evaluation name**.
- A **Start date** and **End date**. These specify the range of data that you'll use for evaluation. This data needs to be in the logs, as specified in the Data Retention value.
- **Optimization discovery**. You set this to **Yes** to enable Azure AI Personalizer to try to find more optimal learning policies.
- **Add learning settings** - use this to upload a learning policy file if you want to evaluate a custom or previously exported policy.

You can select **Start evaluation** to run an evaluation.

> [!NOTE]
> Your Azure AI Personalizer resource must have a representative amount of logged data. Generally, you need at least 50,000 events in its logs for meaningful evaluation results.

## Review evaluation results

Your evaluation can take some time to run. This is because it depends on multiple factors, including the amount of data that needs to be processed, the number of learning policies that are to be compared, and whether you requested optimization.

1. When your evaluation has completed, you can select it the list of evaluations. You can then review the performance of your learning policies based on details like their average reward, confidence intervals, and more:

    :::image type="content" source="../media/7-offline-eval-result.png" alt-text="A screenshot showing evaluation results.":::

1. You'll see a few policies including:

    - **Online** - Your Azure AI Personalizer's current policy.
    - **Baseline1** - Your app's baseline policy
    - **BaselineRand** - A policy of taking actions at random.
    - **Inter-len#** or **Hyper#** - Policies created by Optimization discovery.

1. You select **Apply** on the policy that improves the model best.

## Run feature evaluations

You run *feature evaluation* on your log data to:

- Identify which features are most or least important to your model.
- Think of new features that can be useful to learning, by considering features that are currently important to your model.
- Find out potentially unimportant or  features that aren't useful and should be considered for further analysis or deletion.
- Troubleshoot common issues that happen when designing features and providing them to Azure AI Personalizer.

You use the Azure portal to create a feature evaluation report by doing the following:

1. Go to the Azure portal and find your Azure AI Personalizer resource.
1. Select **Monitor** in the navigation pane then select the **Features** tab.

    :::image type="content" source="../media/07-create-feature-evaluation-report.png" alt-text="A screenshot showing how to create a report.":::

1. Next, you provide a report name and select a time range of historical data to use.

    :::image type="content" source="../media/07-create-feature-report-pane.png" alt-text="A screenshot of the create feature effectiveness report pane.":::

1. Finally, you select **Create report** to create your report. Once finished, your report appears in the Features tab.

## Interpret feature scores

Your report will list features and their importance scores. Features with higher importance scores mean they had more of an effect on your model for your chosen time range, than those with lower scores. For example, suppose that you saw that the feature "IsWeekend" has a high importance for  customer purchases. In that case it might be that holidays or long-weekends could also be important factors. As a result, you might want to think about adding features that capture those details.

Just because a feature has a lower importance score, doesn't mean that it's bad, or not useful. Features that have lower importance scores can be a good starting point for further analysis that could help you to improve your model. That's because in reality, there are several reasons why a feature might have had a lower importance, score including:

- The number of occurrences of the feature was low compared with other features.
- The values for the feature didn't have much diversity or variation.
- The values were too noisy (random), or too distinct, and provided little value. This happens if the number of unique values is too high.
- There's a data or formatting issue. Ensure that the feature is formatted properly and sent to Azure AI Personalizer in the expected format.

If a feature's score is low and the reasons above aren't applicable to it, you can think about removing the feature as it might not be helping your model to maximize the average reward.
