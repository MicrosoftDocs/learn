As you build your health model, you define application health in the context of key business requirements by quantifying *healthy*, *degraded*, and *unhealthy* states in a layered and measurable format. Health states should be monitored starting with user flows at the top, down to platform resources at the bottom. Use a *traffic light* model to visually represent these health states by using green, amber, and red as follows:

- **Green**: Healthy state. Key non-functional requirements are fully satisfied and resources are optimally utilized.
- **Yellow**: Degraded state. The application is operational, but user experience might be affected. The operator's attention is required to mitigate this state.
- **Red**: Unhealthy state. Application is percieved as "not working", i.e. performing the business purpose. The effects of the impacted system are apparent to the end user.

Each layer of the health model should capture what the healthy and unhealthy states represent. Is the failure transient or permanent in nature? Will a degraded state eventually lead to unavailability? Translate metrics and metric thresholds for resources to represent what healthy and unhealthy states mean to you based on the application functionality and non-functional requirements. Define health states for components based on their distinct operational characteristics, steady states, and expected behaviors under production load. Performance testing is a key capability when evaluating application health.

When calculating health scores in a health model:

- Represent health states using a granular health score for every distinct application component and every user flow by aggregating health scores for mapped dependent components, considering key non-functional requirements as coefficients:
- Represent the health score for a user flow by the lowest score across all mapped components, factoring in relative attainment against non-functional requirements for the user flow.
- Ensure the model used to calculate health scores consistently reflects operating health. If it doesn't, adjust and redeploy the model to reflect new information.
- Define health score thresholds to reflect the health status.

When you implement a health model, it's important to define the health of individual components through the aggregation and interpretation of key resource-level metrics. The following table shows an example of how you can use resource metrics to define health states:

![Table showing health states for a layered health model.](../media/mission-critical-example-health-definitions.png)

The following diagram shows an example layered health model and demonstrates how a change in health state for a foundational component can have a cascading impact to user flows and overall application health:

![Diagram showing a sample layered health model with cascading heath states.](../media/mission-critical-example-fault-states.png)
