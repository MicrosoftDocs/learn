In this unit, you'll learn about load tests and thresholds, and how to use them to build your baselines.

## Use Azure Load Testing to evaluate thresholds

During the development phase, the performance of components and resource requirements are often not clearly known or understood. Load tests can help you identify the expected performance of the overall solution and its components, including the scale-out behavior. They can also help you identify the thresholds to expect for building your baseline.

Ask the following questions and reevaluate them regularly:

- How long does an individual request take?
- How many requests, operations, and concurrent users can a component serve per second?
- How many resources are consumed?
- How do 10, 50, and 100 concurrent users affect the underlying infrastructure and back-end service?
- When do the involved components scale in and out?

These questions need to be translated into tests and thresholds. The requests per second, response time, and error percentage are all applicable examples for threshold values. 

After you've recorded the details of your baseline in your notes, use this baseline to help analyze and evaluate the performance of the overall solution and its components in a consistent way. Also use the baseline to identify changes and drifts.

When you run your tests, you might have different requirements for special situations, such as a faulty component or a load spike. In those cases, higher error rates or lower requests per second might be expected and acceptable. The result is different baselines with adjusted thresholds for certain scenarios.

Typical scenarios are:

- High-load situations where a scale-out operation is expected and required. These situations might result in a temporary performance degradation until the operation is completed.
- Chaos experiments, as part of a continuous validation pipeline. A higher error rate can be expected until resiliency measures kick in to self-heal the application or fail over to another region.

With [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing), you can evaluate how your system performs against defined thresholds. The service has a built-in [test criteria](/azure/load-testing/how-to-define-test-criteria?tabs=pipelines) capability. That is, you can specify criteria that a load test needs to pass. 

You can use test criteria to implement different baselines. For example:

:::image type="content" source="../media/deployment-testing-test-criteria.png" border="false" alt-text="Table that shows sample test criteria.":::

You can specify these test criteria in JSON and use the API to add them to your load test. Here's an example:

```json
[
    {
        "passFailMetrics": {
            "<guid>": {
                "clientmetric": "requests_per_sec",
                "aggregate": "avg",
                "condition": "<",
                "value": 1200.0,
                "actualValue": 0.0,
                "result": null,
                "action": "continue"
            },
            "<guid>": {
                "clientmetric": "response_time_ms",
                "aggregate": "avg",
                "condition": ">",
                "value": 75.0,
                "actualValue": 0.0,
                "action": "continue"
              },
              "<guid>": {
                "clientmetric": "error",
                "aggregate": "percentage",
                "condition": ">",
                "value": 0.0,
                "actualValue": 0.0,
                "action": "continue"
              }
        }
    }
]
```

## Set up baselines

A baseline is a set of criteria for metrics that you use to evaluate whether a test has failed or succeeded. Example criteria include:

- Average requests per second
- Error rate
- Maximum response time

To set up baselines for load tests, follow these steps:

1. Define the baselines and test criteria for individual user flows and the overall solution.

1. Adjust the thresholds for regular runs to verify that the application continues to provide the expected performance and doesn't produce any errors.

1. Use a separate baseline for chaos testing that tolerates expected spikes in error rates and temporarily reduced performance.

This activity is continuous and needs to be done regularly. For example, you need to set up baselines after you introduce new features or change service SKUs.
