Now that you understand what Azure Copilot does, you can weigh whether it fits your scenario. Azure Copilot is designed to make you more productive across the lifecycle of your Azure workloads, but it's an assistant—not a replacement for your judgment or for purpose-built tooling in every case.

## Consider using Azure Copilot when

- You want to **work faster across many services** without switching between tools and documentation.
- You prefer to **describe your goal in natural language** rather than remember exact commands, syntax, or where a setting lives.
- You need to **understand your environment quickly**—for example, summarize resources, analyze costs, or interpret a service health event.
- You want help to **generate scripts and configurations**, such as Azure CLI, PowerShell, Terraform, Bicep, or Kubernetes YAML, that you then review and run.
- You're **troubleshooting** and want grounded explanations, recommendations, and next steps.
- You're **learning Azure** and want up-to-date answers grounded in the latest documentation.

## Consider other approaches when

- You need to **act on more than 10 resources at once**. Bulk actions beyond that limit must be performed outside of Azure Copilot.
- You require **fully automated, repeatable pipelines**. Use Azure Copilot to learn and generate the artifacts, then run them through your own automation and infrastructure-as-code processes.
- You operate in an **unsupported environment**, such as a national cloud where Azure Copilot isn't available.

## Current limitations

While Azure Copilot can perform many types of tasks, it might not complete every request. In those cases, it typically explains the limitation and tells you how to carry out the action another way. Keep these general limitations in mind:

- You can't continue the same conversation beyond 24 hours.
- Actions taken on more than 10 resources must be performed outside of Azure Copilot.
- Some responses that display lists are limited to the top five items.
- For some tasks and queries, using a resource's name doesn't work, and you must provide the Azure resource ID or use the **Add** icon to select the resource.
- Excessive use might temporarily throttle your access to Azure Copilot.

:::image type="content" source="../media/copilot-add-context.png" alt-text="Screenshot of how to add context to a conversation in Azure Copilot.":::

Understanding these limitations helps you set the right expectations and decide where Azure Copilot adds the most value.
