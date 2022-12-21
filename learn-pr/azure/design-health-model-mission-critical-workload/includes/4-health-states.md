As you build your health model, define application health in the context of key business requirements by quantifying *healthy*, *degraded*, and *unhealthy* states in a layered and measurable format. Health states should be monitored starting with user flows at the top, down to platform resources at the bottom. Use a *traffic light* model to visually represent these health states by using green, yellow, and red colors:

- **Green**: Healthy state. Key non-functional requirements are fully satisfied and resources are optimally utilized.
- **Yellow**: Degraded state. The application is operational, but user experience might be affected. The operator's attention is required to mitigate this state.
- **Red**: Unhealthy state. The application is perceived as "not working" or not performing its business purpose. The effects of the unhealthy state are apparent to users.

Each layer of the health model should capture what a healthy and an unhealthy state represents. Is the failure transient or permanent? Will a degraded state eventually lead to unavailability? Translate metrics and metric thresholds for resources to represent what healthy and unhealthy states mean to you based on the application functionality and non-functional requirements. Define health states for components based on their distinct operational characteristics, steady states, and expected behaviors in a production workload. Performance testing is a key capability when you evaluate application health.

When you calculate health scores in a health model:

- Represent health states by using a granular health score for every distinct application component and every user flow by aggregating health scores for mapped dependent components. Consider key non-functional requirements as coefficients.
- Represent the health score for a user flow by the lowest score across all mapped components. Factor in relative attainment against non-functional requirements for the user flow.
- Ensure that the model you use to calculate health scores consistently reflects operating health. If it doesn't, adjust and redeploy the model to reflect new information.
- Define health score thresholds to reflect a component's health status.

When you implement a health model, it's important to define the health of individual components by aggregating and interpreting key resource-level metrics. The following table shows an example of how you can use resource metrics to define health states:

:::image type="content" source="../media/mission-critical-example-health-definitions.png" border="false" alt-text="Diagram of a table that shows health states for a layered health model.":::

The following diagram shows an example layered health model. The diagram demonstrates how a change in health state for a foundational component can have a cascading impact on user flows and overall application health:

:::image type="content" source="../media/mission-critical-example-fault-states.png" border="false" alt-text="Diagram that shows a sample layered health model with cascading heath states.":::
