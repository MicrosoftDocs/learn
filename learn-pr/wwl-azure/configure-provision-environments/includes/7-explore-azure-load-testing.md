Azure Load Testing provides a fully managed load testing service designed for high-scale performance validation and capacity planning.

The service generates realistic traffic patterns to simulate production workloads, enabling comprehensive performance optimization, scalability assessment, and capacity planning initiatives.

Load test creation leverages existing Apache JMeter scripts with infrastructure abstraction, eliminating the complexity of test environment management while maintaining familiar testing frameworks.

Comprehensive resource metrics collection enables [performance bottleneck identification](/azure/load-testing/overview-what-is-azure-load-testing) across Azure application components through detailed telemetry and monitoring integration.

[Automated regression testing](/azure/load-testing/overview-what-is-azure-load-testing) integration with continuous integration and continuous deployment (CI/CD) workflows ensures consistent performance validation throughout the development lifecycle.

:::image type="content" source="../media/azure-load-testing-preview-70bf5b4d.png" alt-text="Screenshot of the Azure Load Testing flow.":::

> [!NOTE]
> The overview image shows how Azure Load Testing uses Azure Monitor to capture metrics for app components. Learn more about the [supported Azure resource types](/azure/load-testing/resource-supported-azure-resource-types).

Automated load testing execution supports sprint-end validation and staging environment verification for release candidate builds, ensuring performance requirements are met before production deployment.

Azure Load Testing integrates seamlessly with Azure Pipelines and GitHub Actions workflows, enabling automated test execution within existing CI/CD infrastructure.

Get started with [adding load testing to your Azure Pipelines CI/CD workflow](/azure/load-testing/tutorial-cicd-azure-pipelines), or use our [Azure Load Testing GitHub action](/azure/load-testing/tutorial-cicd-github-actions).

For more information about the Azure Load Testing preview, see:

- [What is Azure Load Testing?](/azure/load-testing/overview-what-is-azure-load-testing)
- [Tutorial: Use a load test to identify performance bottlenecks](/azure/load-testing/tutorial-identify-bottlenecks-azure-portal).
- [Tutorial: Set up automated load testing](/azure/load-testing/tutorial-cicd-azure-pipelines).
- Learn about the [key concepts for Azure Load Testing](/azure/load-testing/concept-load-testing-concepts).
- [Quickstart: Create and run a load test with Azure Load Testing](/azure/load-testing/quickstart-create-and-run-load-test).
- [Tutorial: Identify performance regressions with Azure Load Testing and GitHub Actions - Azure Load Testing](/azure/load-testing/tutorial-cicd-github-actions).
- [Configure Azure Load Testing for high-scale load tests - Azure Load Testing](/azure/load-testing/how-to-high-scale-load).
