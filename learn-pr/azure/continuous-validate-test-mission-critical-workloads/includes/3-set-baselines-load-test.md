An application can have several user flows, each of which can have different performance characteristics. For example, in the checkout user flow, the average page load duration of each checkout step should be less than 500 ms, when up to 100 concurrent users are using the checkout at the same time. With [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing), you can evaluate the expected thresholds. This service provides a built-in capability in the Azure portal and the API called *test criteria*, which allows you to specify certain criteria that a load test needs to pass. You can use this capability to implement different baselines.

![Diagram showing sample test criteria.](../media/deployment-testing-test-criteria.png)

Because the expected performance of components is often not clearly known or understood, Azure Load Testing can help to identify the performance of individual components, the scale-out behavior and the thresholds to expect.

The expected number of requests per second for the various components might be different or there might be different requirements for normal operations and special situations (for example during a chaos experiment or peak load) where higher error rates or lower requests per second are expected and acceptable.

To set up baselines for load tests, follow these steps:

1. Define the baselines and test criteria for individual user flows and the overall solution.

1. Adjust the thresholds for regular runs to verify that the application continues to provide the expected performance and doesn't produce any errors.

1. Use a separate baseline for chaos testing that tolerates expected spikes in error rates and temporary reduced performance.

   This activity is continuous and needs to be done regularly. For example, after introducing new features, changing service SKUs, and others.
