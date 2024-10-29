Fail criteria lets you define performance and quality expectations for your application under load. Azure Load Testing supports various client metrics for defining fail criteria, such as error rate or response time. Auto stop criteria enable you to automatically stop your load test when the error rate surpasses a given threshold.

In this unit, you learn how to define fail criteria and auto stop criteria for load tests.

## Load test fail criteria

Load test fail criteria are conditions for client-side metrics, that your test should meet. You define test criteria at the load test level in Azure Load Testing. A load test can have one or more test criteria. When at least one of the test criteria evaluates to true, the load test gets the *failed* status.

You can define test criteria at two levels. A load test can combine criteria at the different levels.

- At the load test level. For example, to ensure that the total error percentage doesn't exceed a threshold.
- At the JMeter request level (JMeter sampler). For example, you could specify a response time threshold of the *getProducts* request, but disregard the response time of the *sign in* request.

You can define a maximum of 50 test criteria for a load test. If there are multiple criteria for the same client metric, the criterion with the lowest threshold value is used.

### Fail criteria structure

The format of fail criteria in Azure Load Testing follows that of a conditional statement for a supported metric. For example, ensure that the average number of requests per second is greater than 500.

Fail criteria have the following structure:

- Test criteria at the load test level: `Aggregate_function (client_metric) condition threshold`.
- Test criteria applied to specific JMeter requests: `Request: Aggregate_function (client_metric) condition threshold`.

The following table describes the different components:

| Parameter            | Description                                                                                                                                                                                                                                                                                                                                                |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Client metric`      | *Required.* The client metric on which the condition should be applied.                                                                                                                                                                                                                                                                                    |
| `Aggregate function` | *Required.* The aggregate function to be applied on the client metric.                                                                                                                                                                                                                                                                                     |
| `Condition`          | *Required.* The comparison operator, such as `greater than`, or `less than`.                                                                                                                                                                                                                                                                               |
| `Threshold`          | *Required.* The numeric value to compare with the client metric.                                                                                                                                                                                                                                                                                           |
| `Request`            | *Optional.* Name of the sampler in the JMeter script to which the criterion applies. If you don't specify a request name, the criterion applies to the aggregate of all the requests in the script. <br/> Don't include any personal data in the sampler name in your JMeter script. The sampler names appear in the Azure Load Testing results dashboard. |

## Load test fail criteria example

The following example defines three fail criteria. The first two criteria apply to the overall load test, and the last one specifies a condition for the `GetCustomerDetails` request.

The test criteria are added in the `failureCriteria` setting.

    ```yaml
    version: v0.1
    testId: SampleTestCICD
    displayName: Sample test from CI/CD
    testPlan: SampleTest.jmx
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

Azure Load Testing automatically stops a load test if the error percentage exceeds a given threshold for a certain time window. Automatically stopping safeguards you against failing tests further incurring costs, for example, because of an incorrectly configured endpoint URL.

In the load test configuration, you can enable or disable the auto stop functionality and configure the error percentage threshold and time window. By default, Azure Load Testing automatically stops a load test that has an error percentage that is at least 90% during any 60-second time window.

You can use the Azure Load Testing auto stop functionality in combination with an [*AutoStop listener*](https://jmeter-plugins.org/wiki/AutoStop/) in your JMeter script. The load test automatically stops when one of the criteria in either the auto stop configuration or the JMeter AutoStop listener is met.

### Auto stop with GitHub Actions

To configure auto stop for your load test in a GitHub Actions workflow, you update the load test configuration YAML file with the `autoStop` setting and specify the `errorPercentage` and `timeWindow`.

The following example automatically stops the load test when the error percentage exceeds 80% during any 2-minute time window:

        ```yaml
        version: v0.1
        testId: SampleTestCICD
        displayName: Sample test from CI/CD
        testPlan: SampleTest.jmx
        description: Load test website home page
        engineInstances: 1
        autoStop:
          errorPercentage: 80
          timeWindow: 120
        ```

- To disable auto stop, add `autoStop: disable` to the configuration file.

The following example disables auto stop for your load test:

        ```yaml
        version: v0.1
        testId: SampleTestCICD
        displayName: Sample test from CI/CD
        testPlan: SampleTest.jmx
        description: Load test website home page
        engineInstances: 1
        autoStop: disable
        ```
