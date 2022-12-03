As you build your health model, you define application health in the context of key business requirements by quantifying *healthy*, *degraded*, and *unhealthy* states in a layered and measurable format. Use a *traffic light* model to visually represent these health states by using green, amber, and red as follows:

- Green: Healthy state. Key non-functional requirements are fully satisfied and resources are optimally utilized.
- Amber: Degraded state. The operator's attention is required to mitigate this state.
- Red: Unhealthy state. The effects of the impacted system are apparent to the end user.

Each layer of the health model should capture what the healthy and unhealthy states represent. It's important to distinguish between transient and non-transient failure states to qualify service degradation relative to unavailability. Metrics and metric thresholds for resources must be finely tuned in terms of what values represent healthy and unhealthy states, which are heavily influenced by encompassed application functionality and target non-functional requirements. To capture health states for an individual component, that component's distinct operational characteristics must be understood under a steady state that is reflective of production load. Performance testing is therefore a key capability to define and continually evaluate application health.

When calculating health scores in a health model:

- Represent health states using a granular health score for every distinct application component and every user flow by aggregating health scores for mapped dependent components, considering key non-functional requirements as coefficients:
- Represent the health score for a user flow by the lowest score across all mapped components, factoring in relative attainment against non-functional requirements for the user flow.
- Ensure the model used to calculate health scores consistently reflects operating health. If it doesn't, adjust and redeploy the model to reflect new information.
- Define health score thresholds to reflect the health status.

When you implement a health model, it's important to define the health of individual components through the aggregation and interpretation of key resource-level metrics. The following table shows an example of how you can use resource metrics to define health states:

![Table showing health states for a layered health model.](../media/mission-critical-example-health-definitions.png)

The following diagram shows an example layered health model and demonstrates how a change in health state for a foundational component can have a cascading impact to user flows and overall application health:

![Diagram showing a sample layered health model with cascading heath states.](../media/mission-critical-example-fault-states.png)
