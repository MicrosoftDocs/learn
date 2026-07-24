Fail criteria let you define performance and quality expectations for your application under load. Azure Load Testing supports client metrics, such as error rate or response time, and server-side Azure Monitor metrics. Auto stop criteria enable you to automatically stop your load test when the error rate surpasses a given threshold.

In this unit, you learn how to define fail criteria and auto stop criteria for load tests.

> [!NOTE]
> The examples in this unit use version `v0.1` of the load test configuration schema. The schema changes over time, so review the [load test YAML reference](/azure/app-testing/load-testing/reference-test-config-yaml) for the latest information.

## Load test fail criteria

Load test fail criteria compare client-side or server-side metrics with the quality requirements for your application. You define one or more criteria at the load test level. Azure Load Testing marks the test as failed when at least one criterion evaluates to true. Client-metric criteria can apply at two levels.

- **Load test level:** For example, to ensure that the total error percentage doesn't exceed a threshold.
- **Request level:** For example, you could specify a response time threshold for the *getProducts* request but disregard the response time of the *sign in* request. For a JMeter test, the request name is the JMeter sampler name.

You can also define fail criteria for Azure Monitor metrics from server-side app components. To use server-side criteria, you can configure the app components and metrics to monitor. You can then grant the selected metrics reference identity access to those metrics.

You can define a maximum of 50 test criteria for a load test. If you define multiple criteria for the same client metric, Azure Load Testing uses the criterion with the lowest threshold value.

### Fail criteria structure

The format of fail criteria in Azure Load Testing follows a conditional statement for a supported metric. For example, you can require the average number of requests per second to remain greater than 500.

Each fail criterion identifies a metric, aggregate function, condition, and threshold. A request name can optionally limit a client-metric criterion to one request.

- Test criteria at the load test level: `Aggregate_function (client_metric) condition threshold`.
- Test criteria applied to specific requests: `Request: Aggregate_function (client_metric) condition threshold`.

The following table describes the different components:

| Parameter | Description |
|--|--|
| `Client metric` | *Required.* The client metric that the condition evaluates. |
| `Aggregate function` | *Required.* The aggregate function for the client metric. |
| `Condition` | *Required.* The comparison operator, such as `greater than` or `less than`. |
| `Threshold` | *Required.* The numeric value to compare with the client metric. |
| `Request` | *Optional.* Name of the request to which the criterion applies. For a JMeter test, you can use the sampler name. If you don't specify a request name, the criterion applies to the aggregate of all requests in the test plan. <br/> You shouldn't include personal data in request names because the names appear in the Azure Load Testing results dashboard. |

## Load test fail criteria example

The following example defines three fail criteria. The first two criteria apply to the overall load test, and the last one specifies a condition for the `GetCustomerDetails` request.

You add the test criteria in the `failureCriteria` setting.

```yaml
version: v0.1
testId: SampleTestCICD
displayName: Sample test from CI/CD
testPlan: SampleTest.jmx
testType: JMX
description: Load test website home page
engineInstances: 1
failureCriteria:
  - avg(response_time_ms) > 300
  - percentage(error) > 50
  - GetCustomerDetails: avg(latency) >200
```

When you define a test criterion for a specific JMeter request, the request name should match the name of the JMeter sampler in the JMX file.

:::image type="content" source="../media/jmeter-request-name.png" alt-text="Screenshot of the JMeter user interface, highlighting the request name.":::

## Auto stop configuration

Azure Load Testing automatically stops a load test if the error percentage exceeds a given threshold for a defined time window. Auto stop prevents an incorrectly configured or failing test from continuing to incur costs.

In the load test configuration, you can enable or disable auto stop and configure the error percentage threshold and time window. By default, Azure Load Testing stops a load test that has an error percentage of at least 90% during any 60-second time window.

### Auto stop with GitHub Actions

To configure auto stop for your load test in a GitHub Actions workflow, you update the load test configuration YAML file with the `autoStop` setting and specify the `errorPercentage` and `timeWindow`.

The following example automatically stops the load test when the error percentage exceeds 80% during any 2-minute time window:

```yaml
version: v0.1
testId: SampleTestCICD
displayName: Sample test from CI/CD
testPlan: SampleTest.jmx
testType: JMX
description: Load test website home page
engineInstances: 1
autoStop:
  errorPercentage: 80
  timeWindow: 120
```

You can disable auto stop by adding `autoStop: disable` to the configuration file.

The following example disables auto stop for your load test:

```yaml
version: v0.1
testId: SampleTestCICD
displayName: Sample test from CI/CD
testPlan: SampleTest.jmx
testType: JMX
description: Load test website home page
engineInstances: 1
autoStop: disable
```

You can also combine Azure Load Testing auto stop with an [*AutoStop listener*](https://jmeter-plugins.org/wiki/AutoStop/) in your JMeter script. The load test stops when either the service configuration or the JMeter listener meets its criteria.

