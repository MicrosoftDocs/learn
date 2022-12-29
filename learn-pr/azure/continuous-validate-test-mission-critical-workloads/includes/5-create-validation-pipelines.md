In this unit, you'll learn how to use continuous integration and continuous delivery (CI/CD) pipelines to automate your continuous validation process. Although you can run load tests manually, with or without Azure Chaos experiments in parallel, it's recommended to implement an automated continuous validation process that can run regularly in a consistent way. To do so, you embed load testing and chaos experiments into your CI/CD pipelines and compare the results against pre-defined baselines. This technique lowers the entry barrier and effort associated with this activity and allows developers and operations personnel to use it as part of each release or major change, which results in improved quality.

When you inject failures in isolation into an empty or idle environment, it tends not to generate any useful insights. To properly observe a system's behavior, put it under a load test at the same time that you inject your failures. Use your load test to simulate real-world traffic and not as a stress test to break your system. As you run your load tests, consider adjusting your baselines for certain situations. For example, you might accept a higher response time when a certain component fails, but you still expect the test to pass.

To create a CI/CD pipeline, you can use Azure Pipelines, GitHub Actions or the CI/CD tool of your choice. The following example is a visualization of the end-to-end stages of a pipeline in Azure DevOps:

:::image type="content" source="../media/pipeline-with-chaos-and-load.png" border="false" alt-text="Diagram that shows a sample pipeline with chaos and load.":::

1. In the pipeline, define the Azure Load Test and Azure Chaos Studio services as Infrastructure-as-Code (IaC) with Azure Resource Manager (ARM) templates, Bicep, Terraform, or others. Azure Load Testing [provides first-party tasks](/azure/load-testing/tutorial-identify-performance-regression-with-cicd) for Azure Pipelines and GitHub Actions to interact with the load testing service, and to create and orchestrate tests:

   :::image type="content" source="../media/pipeline-with-chaos-and-load-zoom-in.png" border="false" alt-text="Diagram that shows a sample pipeline with chaos and load (zoomed in).":::

1. To produce meaningful results, ensure that the load test runs and the chaos experiments overlap. To properly view the impact of the injected faults, ensure the load test starts before the fault is injected, and continues to run for a while after the chaos experiment is finished.

   :::image type="content" source="../media/deployment-testing-test-criteria.png" border="false" alt-text="Table that shows sample test criteria.":::

1. Analyze the failed load test runs to verify if the used baseline is still accurate or whether it needs to be adjusted.

For a video that shows how to integrate Azure Load Testing and Azure Chaos Studio in your Azure CI/CD pipelines, see [Continuous validation with Azure Load Test and Azure Chaos Studio](/azure/architecture/framework/mission-critical/mission-critical-deployment-testing#demo-video-continuous-validation-with-azure-load-test-and-azure-chaos-studio).
