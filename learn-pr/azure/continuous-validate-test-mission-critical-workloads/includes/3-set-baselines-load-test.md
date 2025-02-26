Now that you defined the load tests and threshold values, let's use them to build your baselines.

A baseline is a **set of criteria for metrics** that you use to evaluate whether a test failed or succeeded. For example, your criteria might be:

- Average requests per second.
- Error rate.
- Maximum response time.

To set up baselines for load tests, you need to:

1. Define the baselines and test criteria for individual user flows and the overall solution.

1. Adjust the thresholds for regular runs to verify that the application continues to provide the expected performance and doesn't produce any errors.

1. Use a separate baseline for chaos testing that tolerates the expected spikes in error rates and temporarily reduced performance.

This activity is continuous and needs to be done regularly. For example, you need to review baselines after you introduce new features or change service SKUs.

## Use Azure Load Testing to evaluate thresholds

During the development phase, the performance of components and resource requirements are often not clearly known. Load tests can help you identify the expected performance, including the scale-out behavior, of the overall solution and its components. They can also help you identify the thresholds to expect for building your baseline.

Ask the following questions and reevaluate regularly:

- *How long does an individual operation, user flow, or API call take to complete?* 
- *How many requests, operations, and concurrent users can a component serve per second?*
- *How many resources are consumed?*
- *How do 10, 50, and 100 concurrent users affect the underlying infrastructure and back-end service?*
- *When should the components scale in and out?*

The answers lead to tests and thresholds. The requests per second, response time, and error percentage are all applicable examples for threshold values. 

After you noted the details, use values to analyze and evaluate the performance of the overall solution and its components in a consistent way. Also use the baseline to identify the effect of changes and drifts from the expected performance.

When you run the tests, you might have different requirements for special use cases, such as a faulty component or a load spike. For those cases, higher error rates or lower requests per second might be expected and acceptable. You can have a separate baseline that contains adjusted thresholds to accommodate those situations. For example:

- High-load scenarios in which a scale-out operation is expected and required. There might be temporary performance degradation until the operation is completed.
- Chaos experiments, as part of a continuous validation pipeline. A higher error rate can be expected until resiliency measures start to self-heal the application or fail over to another region.

Use [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing) to evaluate how your system performs against defined thresholds. The service has a built-in [test criteria](/azure/load-testing/how-to-define-test-criteria?tabs=pipelines+github) capability. That is, you can specify criteria that a load test needs to pass.

You can use test criteria to implement different baselines, as shown in the following example screenshot.

:::image type="content" source="../media/deployment-testing-test-criteria.png" alt-text="Azure portal screenshot of a table that shows sample test criteria." lightbox="../media/deployment-testing-test-criteria.png":::

You can specify these test criteria in JSON and use the API to add them to your load test. Here's an example:

```json
[
  {
    "passFailMetrics": {
      "<guid-1>": {
        "clientmetric": "requests_per_sec",
        "aggregate": "avg",
        "condition": "<",
        "value": 1200.0,
        "actualValue": 0.0,
        "result": null,
        "action": "continue"
      },
      "<guid-2>": {
        "clientmetric": "response_time_ms",
        "aggregate": "avg",
        "condition": ">",
        "value": 75.0,
        "actualValue": 0.0,
        "action": "continue"
      },
      "<guid-3>": {
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

Another important aspect of continuous validation is injecting tests that simulate real-world issues. In the next unit, you learn about adding chaos experiments to your validation process.
