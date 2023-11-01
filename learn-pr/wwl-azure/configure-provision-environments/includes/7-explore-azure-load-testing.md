Azure Load Testing Preview is a fully managed load-testing service that enables you to generate a high-scale load.

The service simulates your applications' traffic, helping you optimize application performance, scalability, or capacity.

You can create a load test using existing test scripts based on Apache JMeter. Azure Load Testing abstracts the infrastructure to run your JMeter script and load test your application.

Azure Load Testing collects detailed resource metrics for Azure-based applications to help you [identify performance bottlenecks](/azure/load-testing/overview-what-is-azure-load-testing) across your Azure application components.

You can [automate regression testing](/azure/load-testing/overview-what-is-azure-load-testing) by running load tests as part of your continuous integration and continuous deployment (CI/CD) workflow.

:::image type="content" source="../media/azure-load-testing-preview-70bf5b4d.png" alt-text="Screenshot of the Azure Load Testing flow.":::


> [!NOTE]
> The overview image shows how Azure Load Testing uses Azure Monitor to capture metrics for app components. Learn more about the [supported Azure resource types](/azure/load-testing/resource-supported-azure-resource-types).

You can automatically run a load test at the end of each sprint or in a staging environment to validate a release candidate build.

You can trigger Azure Load Testing from Azure Pipelines or GitHub Actions workflows.

Get started with [adding load testing to your Azure Pipelines CI/CD workflow](/azure/load-testing/tutorial-cicd-azure-pipelines), or use our [Azure Load Testing GitHub action](/azure/load-testing/tutorial-cicd-github-actions).

For more information about the Azure Load Testing preview, see:

 -  [What is Azure Load Testing?](/azure/load-testing/overview-what-is-azure-load-testing)
 -  [Tutorial: Use a load test to identify performance bottlenecks](/azure/load-testing/tutorial-identify-bottlenecks-azure-portal).
 -  [Tutorial: Set up automated load testing](/azure/load-testing/tutorial-cicd-azure-pipelines).
 -  Learn about the [key concepts for Azure Load Testing](/azure/load-testing/concept-load-testing-concepts).
 -  [Quickstart: Create and run a load test with Azure Load Testing](/azure/load-testing/quickstart-create-and-run-load-test).
 -  [Tutorial: Identify performance regressions with Azure Load Testing and GitHub Actions - Azure Load Testing](/azure/load-testing/tutorial-cicd-github-actions).
 -  [Configure Azure Load Testing for high-scale load tests - Azure Load Testing](/azure/load-testing/how-to-high-scale-load).
