Although you can run load tests manually, with or without Azure Chaos experiments in parallel, it's recommended to implement an automated continuous validation process that can run regularly in a consistent way. To do so, embed load testing and chaos experiments into your CI/CD pipelines and compare the results against pre-defined baselines. This technique lowers the entry barrier and effort associated with this activity and allows developers and operations personnel to use it as part of each release or major change, which results in improved quality.

When you inject failures in isolation into an empty or idle environment, it isn't meaningful and doesn't generate any useful insights. To properly observe a system's behavior, you must put it under load at the same time that you inject the failures. However, when you run your load tests, consider adjusting your baselines for certain situations. For example, you might accept a higher response time when a certain component fails, but you still expect the test to pass.

You can use Azure Pipelines, GitHub Actions or the CI/CD tool of your choice. For example:

:::image type="content" source="../media/pipeline-with-chaos-and-load.png" border="false" alt-text="Diagram that shows a sample pipeline with chaos and load.":::

 In the pipeline, define the Azure Load Test and Azure Chaos Studio services as Infrastructure-as-Code (IaC) with Azure Resource Manager (ARM) templates, Bicep, Terraform, or others. Azure Load Testing [provides first-party tasks](/azure/load-testing/tutorial-identify-performance-regression-with-cicd) for Azure Pipelines and GitHub Actions to interact with the load testing service, and to create and orchestrate tests. For example:

:::image type="content" source="../media/pipeline-with-chaos-and-load-zoom-in.png" border="false" alt-text="Diagram that shows a sample pipeline with chaos and load (zoomed in).":::

To produce meaningful results, ensure that the load test runs and the chaos experiments overlap. To properly view the impact of the injected faults, ensure the load test starts before the fault is injected, and continues to run for a while after the chaos experiment is finished.

:::image type="content" source="../media/deployment-testing-test-criteria.png" border="false" alt-text="Table that shows sample test criteria.":::

 Analyze the failed load test runs to verify if the used baseline is still accurate or whether it needs to be adjusted.
