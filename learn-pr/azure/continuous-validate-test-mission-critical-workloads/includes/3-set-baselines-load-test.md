In the previous unit, you learned about user and system flows. We also learned that an application can consist of several user and system flows, which might not all have the same requirements regarding performance and availability.

- For example, in the checkout user flow, the average page load duration of each checkout step should be less than 500 milliseconds when up to 100 concurrent users are using the checkout at the same time.

## Use Azure Load Testing to evaluate thresholds

During the development phase, the performance of components and resource requirements are often not clearly known or understood. Azure Load Testing can help to identify the expected performance of the overall solution and its components. which includes the scale-out behavior, and the thresholds to expect for building your baseline.

Ask the following questions and reevaluate them regularly:

- How long does an individual request take?
- How many requests, operations and concurrent users per second can a component serve?
- How many resources are consumed?
- How do 10, 50, and 100 concurrent users affect the underlying infrastructure and backend service?
- When do the involved components scale in and out?

These questions need to be translated into tests and thresholds. After you've recorded the details of your baseline in your notes, use this baseline to help analyze and evaluate the performance of the overall solution and its components in a consistent way, and identify changes and drifts.

With [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing), you can evaluate the expected thresholds. The built-in *test criteria* capability allows you to specify certain criteria that a load test needs to pass. You can use this capability to implement different baselines. For example:

![Diagram showing sample test criteria.](../media/deployment-testing-test-criteria.png)

You can specify these test criteria in JSON and use the API to input them to your load test in Azure Load Testing. Here's an example:

```json
[
    {
        "passFailMetrics": {
            "<guid>": {
                "clientmetric": "requests_per_sec",
                "aggregate": "avg",
                "condition": "<",
                "value": 1200.0,
                "result": null,
                "actualValue": 0.0,
                "action": "continue"
            },
            "<guid>": {
                "action": "continue",
                "actualValue": 0.0,
                "aggregate": "avg",
                "clientmetric": "response_time_ms",
                "condition": ">",
                "value": 75.0
              },
              "<guid>": {
                "action": "continue",
                "actualValue": 0.0,
                "aggregate": "percentage",
                "clientmetric": "error",
                "condition": ">",
                "value": 0.0
              }
        }
    }
]
```

When you run your tests, there might be different requirements for special situations, such as a faulty component or a load spike. In a special situation, as opposed to a normal operation, higher error rates or lower requests per second could be expected and acceptable. The result is different baselines with adjusted thresholds for different scenarios.

Typical scenarios are:

- High load situations where a scale-out operation is expected and required, which might result in a temporary performance degradation until the operation is completed
- Chaos experiments, as part of a continuous validation pipeline, where a higher error rate can be expected until resiliency measures kick in to self-heal the application or fail over to another region

## Set up baselines

To set up baselines for load tests, follow these steps:

1. Define the baselines and test criteria for individual user flows and the overall solution.

1. Adjust the thresholds for regular runs to verify that the application continues to provide the expected performance and doesn't produce any errors.

1. Use a separate baseline for chaos testing that tolerates expected spikes in error rates and temporary reduced performance.

This activity is continuous and needs to be done regularly. For example, after introducing new features, changing service SKUs, and others.
