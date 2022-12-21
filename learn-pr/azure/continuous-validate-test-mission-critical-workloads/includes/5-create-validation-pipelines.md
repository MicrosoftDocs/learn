Although you can run load tests manually (with or without Azure Chaos experiments), it's recommended that you run these tests regularly and automated as part of continuous validation. To do so, embed load testing and chaos experiments into a continuous integration and continuous deployment (CI/CD) pipeline.

Injecting failures in isolation isn't meaningful. To be able to properly observe a system's behavior, you must run a load against the system at the same time as the failure, preferably your previously designed load test. However, when you run your load test, you might need to consider adjusting your baselines for certain situations. For example, you might accept a higher response time when a certain component fails but you still expect the test to pass.

You can use Azure Pipelines, GitHub Actions or the CI/CD tool of your choice.

![Diagram showing a sample pipeline with chaos and load](../media/pipeline-with-chaos-and-load.png)

 In the pipeline, define the Azure Load Test and Azure Chaos Studio services as Infrastructure-as-Code (IaC) with Azure Resource Manager templates (ARM templates), Azure Bicep, or Terraform. Azure Load Testing [provides first-party tasks](/azure/load-testing/tutorial-identify-performance-regression-with-cicd) for Azure Pipelines and GitHub Actions to interact with the load testing service.

![Diagram showing a sample pipeline with chaos and load (zoom in)](../media/pipeline-with-chaos-and-load-zoom-in.png)

Ensure that the load test run and the chaos experiments overlap to produce meaningful results. The load test should start before fault is injected and continue to run for some time when the Chaos experiment is finished to properly see the impact of the injected faults.

 Failed load test runs should be analyzed to verify if the used baseline is still accurate or if it needs to be adjusted.
