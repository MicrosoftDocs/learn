By now, you understand what to monitor and how Azure Monitor supports lightweight monitoring out-of-the-box. The final step before going hands-on is to explore **how to make sense of monitoring data**, and more importantly, how it can guide practical decisions.

This unit focuses on interpretation, not prescribing specific actions, but helping you think critically about what the data means and how to apply it to solution development.

## Monitoring is a feedback loop

Monitoring should never be a passive activity. Instead, it forms a feedback loop. After you deploy a service, you observe how it behaves, compare it to your objectives, and adjust as needed.

This feedback loop can be repeated when needed, where each round helps you narrow in on the right balance between performance and cost.

## Visualize insights with workbooks

Workbooks provide a flexible canvas for analyzing data and creating rich visual reports in the Azure portal. Workbooks can query data from multiple data sources and combine and correlate data from multiple data sets in one visualization, giving you visual representation of your system. Workbooks are interactive, with data updating in real time, and can be shared across teams.

You can use the workbooks that Azure Monitor Insights provide, use the workbook template library, or create your own workbooks.

### Access the prebuilt workbook

When you connect an Application Insights instance to your Azure AI Foundry project, important metrics are already visualized for you in the **Insights for Generative AI applications dashboard**.

:::image type="content" source="../media/open-generative-ai-workbook.gif" alt-text="Animation the Insights for Generative AI applications dashboard linking to the workbook." lightbox="../media/open-generative-ai-workbook.gif":::

When selecting the dashboard, you're linked to a prebuilt Azure Workbook in Azure Monitor that provides real-time insights into the performance metrics, usage patterns, and operational efficiency of your AI applications. You can track data such as execution times, token consumption, and error rates across sessions. You can use these detailed logs and visualizations to identify bottlenecks and optimize workflows.

## How to interpret token usage

Token counts reveal how your prompt and output design affect cost and performance.

- High **input token** counts can suggest overly verbose prompts or unnecessary preambles.
- High **output token** counts can indicate that the model is returning more than needed. For example, long explanations instead of direct answers.
- Spikes in token usage often correlate with longer latency and higher costs per request.

By monitoring token patterns, you can fine-tune your app to be more efficient—sometimes without changing deployment infrastructure at all.

## Mitigate errors

Errors tell you when your deployment is hitting a limit. For example:

- Time-out errors can mean the current compute size is too small.
- Rate-limit errors indicate that throughput exceeds service quotas.
- Failures within a flow step can point to logic errors or data quality issues.

If your error rate increases with usage, that’s a sign your app needs optimization—either in compute capacity or flow design.
