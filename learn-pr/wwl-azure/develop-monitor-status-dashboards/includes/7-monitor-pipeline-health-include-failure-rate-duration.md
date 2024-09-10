Monitoring the health of Azure Pipelines is fundamental to ensuring the reliability and efficiency of software delivery processes. By tracking health metrics such as pipeline fail rates and duration in combination with assessing and remediating flaky tests, you can identify issues affecting the functionality of pipelines, optimize their performance, and enhance their resiliency. To simplify the monitoring process, you might want to leverage native Azure services such as Azure Pipelines reports and Application Insights, although you also have the option of using third party tools that integrate with Azure DevOps or are accessible via Azure DevOps service hooks.

## Monitoring and assessment targets

There are several monitoring and assessment targets that provide insights into the overall health and reliability of Azure Pipelines. Tracking and remediating their occurrences promotes continuous improvement and high-quality software releases.

### Fail Rate

The failure rate of Azure Pipelines reflects the frequency of build or deployment failures within a specified timeframe. Monitoring this metric helps identify trends and patterns in failures, pinpointing potential issues in code quality, configuration, or infrastructure. By establishing thresholds and alerts based on failure rate, you can promptly address issues, minimize downtime, and ensure the reliability of pipeline workflows.

### Duration

Tracking the duration of pipeline runs is critical for evaluating efficiency and performance of the software delivery process. Its monitoring helps identify processes that may be causing delays or inefficiencies. By analyzing duration trends over time, you can optimize resource utilization, streamline workflows, and accelerate the frequency of software releases.

### Flaky Tests

Flaky tests are automated tests that produce inconsistent results, yielding different outcomes under the same conditions. Flaky tests can cause intermittent build failures, leading to unpredictable pipeline behavior, resulting in unnecessary alerts, consuming resources for investigations, and delaying the progression of the pipeline. They also tend to lead to false positives, where passing tests incorrectly indicate the absence of defects, or false negatives, where failing tests identify non-existing defects.

While flaky tests originate from the testing phase of the pipeline, their impact extends to the overall health and reliability of the pipeline itself. Effectively, identifying flaky tests in Azure Pipelines is essential for maintaining the integrity of test suites and ensuring the reliability of test-driven development practices. By detecting and eliminating flaky tests as part of pipeline health monitoring, you can ensure the stability, accuracy, and confidence of the software delivery processes, yielding higher-quality software releases.

## Monitoring and assessment services and tools

In addition to identifying the monitoring and assessment targets, you also need to determine the most suitable service or tool to deliver the required functionality.

### Azure Pipelines reports

Azure Pipelines offer built-in pipeline run analytics. These analytics are collected and calculated over time and form the basis of the insights visualized through reports. The reports include metrics and trends that help improve pipeline efficiency.

On the reports pages you can review the status of builds and releases, as well as any pending or failed pipelines. The interface provides direct access to detailed logs and metrics for each pipeline.

For example, the *Pipeline pass rate* report provides a granular view of the pipeline pass rate and its trend over time. You can also view which specific task failure contributes to a high number of pipelines run failures and use that insight to fix the top failing tasks.

The *Pipeline duration* report shows detailed breakdown of how long pipelines typically take to complete successfully. This helps with identifying trends and identifying the tasks which contribute most to the pipeline duration.

The *Test failures* report provides a granular view of the top failing tests in the pipeline, along with the failure details.

### Application Insights

Application Insights is a feature of Azure Monitor that allows you to monitor the performance of your applications, including Azure Pipelines. You can use Application Insights to monitor the latency and throughput of your pipelines, as well as any errors or exceptions that occur.

In addition, through integration of Azure Pipelines with Application Insights, it becomes possible to implement continuous monitoring of the entire software development lifecycle. With continuous monitoring, release pipelines are able leverage monitoring data from Application Insights and other Azure resources. When the release pipeline detects an Application Insights alert, the pipeline can gate or roll back the deployment until the alert is resolved.

Conversely, if all checks pass, deployments can progress automatically to production, without the need for manual intervention.

### Service hooks

Service hooks in Azure DevOps facilitate integration with a wide range of external services. They allow you to trigger notifications and actions in response to Azure DevOps events, such as pipeline runs. By incorporating service hooks into your Azure Pipelines monitoring processes, you can, for example, implement real-time notifications in response to pipeline failures and performance issues. In addition, you have the option to automatically initiate corrective actions to enhance the reliability and stability of their software delivery processes.

### Third party monitoring tools

There are also third-party monitoring tools that support integration with Azure Pipelines, including, for example, DataDog, New Relic, and AppDynamics. This provides extra flexibility, especially in scenarios that involve integrating Azure Pipeline monitoring into your existing monitoring strategy.
