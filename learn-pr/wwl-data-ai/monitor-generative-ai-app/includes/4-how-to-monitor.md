Now that you understand what to monitor, it’s time to explore *how* Azure supports performance monitoring in practice. Azure gives you lightweight, code-first tools to inspect and reason about the behavior of your generative AI deployments, without needing to build out full observability stacks.

Effective monitoring requires a multi-faceted approach that includes, **tracing**, **online evaluation**, and **observability** through **Azure Monitor Application Insights**.

Let's explore each of these components in more detail.

## Understand tracing

To continuously monitor your generative AI application, start by **capturing and storing detailed telemetry data**. You can do this by instrumenting your application with the **Azure AI Tracing package**. This package logs trace data to an Azure Monitor Application Insights resource.

The trace data follows the OpenTelemetry standard, ensuring structured and comprehensive observability. Once you have tracing set up, you can analyze your application's request flow, track latency, and monitor resource consumption.

## Understand online evaluation

Continuous evaluation helps you assess the quality, security, and safety of AI-generated outputs in real time. With **Azure AI Online Evaluation**, you can automatically **evaluate your application's responses**, no matter the deployment environment or orchestration framework (for example, Semantic Kernel or LangChain).

You can use built-in evaluators that align with the Azure AI Evaluation SDK or define custom evaluators to track domain-specific performance metrics. By consistently running evaluations on collected trace data, your team can proactively detect and mitigate emerging issues in both pre-production and live deployments.

## Understand Azure Monitor Application Insights

For a comprehensive view of your AI application's health, **Azure Monitor Application Insights** offers advanced observability tools. These tools include:

- Custom dashboards
- Real-time visualization of evaluation results
- Configurable alerting mechanisms

This integration ensures that all critical insights, such as token usage, latency, and request volume, are readily accessible, empowering your team to make data-driven optimizations.

### Set up Azure Monitor alerts

Alerts notify you of critical conditions and can take corrective action.

**Alert rules** can be based on metric or log data:

- **Metric** alert rules provide near-real time alerts based on collected metrics.
- **Log** alert rules based on log data allow for complex logic across data from multiple sources.

Alert rules use **action groups**, which can take actions such as sending email or SMS notifications. Action groups can send notifications using webhooks to trigger external processes or to integrate with IT service management tools. You can share action groups, actions, and sets of recipients across multiple rules.

> [!Note]
> Alerts are stored for 30 days and are deleted after the 30-day retention period.

By leveraging these components, continuous monitoring provides a structured approach to maintaining and improving generative AI applications. Through tracing, online evaluation, and integration with Azure Monitor Application Insights, your team can detect anomalies, optimize performance, and ensure the AI system remains aligned with business objectives and user expectations.
