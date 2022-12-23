Although you can run load tests manually, with or without Azure Chaos experiments in parallel, it's recommended to implement an automated continuous validation process that can run regularly in a consistent way. To do so, embed load testing and chaos experiments into your CI/CD pipelines and compare the results against pre-defined baselines. Doing so lowers the entry barrier and effort associated with this activity and allows developers and operations personnel to use it as part of every release or major change, which will result in an improved quality for your releases.

When you inject failures in isolation into an empty or idle environment, it isn't meaningful and won't generate any useful insights. To properly observe a system's behavior, you must put it under load at the same time that the failures are injected. However, when you run your load test, consider adjusting your baselines for certain situations. For example, you might accept a higher response time when a certain component fails, but you still expect the test to pass.

You can use Azure Pipelines, GitHub Actions or the CI/CD tool of your choice.

![Diagram showing a sample pipeline with chaos and load.](../media/pipeline-with-chaos-and-load.png)

 In the pipeline, define the Azure Load Test and Azure Chaos Studio services as Infrastructure-as-Code (IaC) with Azure Resource Manager (ARM) templates, Bicep, Terraform, or others. Azure Load Testing [provides first-party tasks](/azure/load-testing/tutorial-identify-performance-regression-with-cicd) for Azure Pipelines and GitHub Actions to interact with the load testing service, and to create and orchestrate tests.

![Diagram showing a sample pipeline with chaos and load (zoom in).](../media/pipeline-with-chaos-and-load-zoom-in.png)

To produce meaningful results, ensure that the load test runs and the chaos experiments overlap. To properly see the impact of the injected faults, the load test should start before the fault is injected, and continue to run for a while after the Chaos experiment is finished.

 ![Diagram showing sample test criteria.](../media/deployment-testing-test-criteria.png)

 Analyze the failed load test runs to verify if the used baseline is still accurate or whether it needs to be adjusted.
