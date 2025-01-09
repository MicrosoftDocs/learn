Although you can run load tests and chaos experiments manually, we recommend that you use an automated process. To do so, integrate both validation tests in your continuous integration and continuous delivery (CI/CD) pipelines and automatically compare the results against predefined baselines. 

In this unit, you learn how to use CI/CD pipelines to automate your continuous validation process.

## Advantages of automating validation tests

This technique lowers the entry barrier and effort associated with this activity. Developers and operations personnel can use it as part of each release or major change, which **improves the quality and consistency of test runs**.

Running load test and chaos experiments simultaneously helps you **observe system behavior in an environment that simulates real-world traffic**. The purpose is to predict failures and not break the system.

As you run your load tests, consider adjusting your baselines for certain situations. For example, you might accept a higher response time when a certain component fails, but you still expect the test to pass.

## Set up the automated pipelines

To create a CI/CD pipeline, you can use Azure Pipelines, GitHub Actions, or the CI/CD tool of your choice. This image shows the end-to-end stages of a pipeline in Azure DevOps.

:::image type="content" source="../media/pipeline-with-chaos-and-load.png" border="false" alt-text="Diagram that shows a sample pipeline that has a load test and a chaos experiment." lightbox="../media/pipeline-with-chaos-and-load.png":::

1. In the pipeline, define the Azure Load Testing and Azure Chaos Studio services as infrastructure as code (IaC) by using a tool such as Azure Resource Manager templates, Bicep, or Terraform. Azure Load Testing [provides first-party tasks](/azure/load-testing/quickstart-add-load-test-cicd) for Azure Pipelines and GitHub Actions to interact with the load-testing service, and to create and orchestrate tests.

   :::image type="content" source="../media/pipeline-with-chaos-and-load-zoom-in.png" border="false" alt-text="Diagram that shows the pipeline having integrated chaos and load testing.":::

1. To properly view the impact of the injected faults, make sure that the load test starts before the faults are injected. Continue to run the test for a while after the chaos experiment is finished.

   :::image type="content" source="../media/deployment-testing-test-criteria.png" alt-text="Azure portal screenshot that shows a sample test criteria table." lightbox="../media/deployment-testing-test-criteria.png":::

1. Analyze the failed load tests to see whether the baseline is still accurate or whether it needs to be adjusted.

## Demo: Automated continuous validation

This video shows how to integrate Azure Load Testing and Azure Chaos Studio in an Azure CI/CD pipeline.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=393a9ab4-6816-4bbf-9c25-94a34a5413e0]
