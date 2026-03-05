When you have a clear view of the different stages for deployment, consider when to deploy to these stages.

Continuous Delivery involves deploying multiple times per day with on-demand deployment capabilities.

When defining deployment cadence, consider these questions:

- Should the application be deployed automatically?
- Is multiple daily deployment appropriate?
- Is the target stage available for deployment?

For example, a tester testing an application during the day might not want to deploy a new version of the app during the test phase.

Another consideration is application downtime - avoid deploying during peak usage periods.

Deployment frequency varies between stages.

A common scenario is continuous deployment to the development stage, where each completed change automatically deploys after building.

Deployment to subsequent phases may occur less frequently, such as scheduled overnight deployments.

When designing release strategy, select triggers carefully and consider the required deployment cadence.

Key considerations include:

- Target environment characteristics
- Team usage patterns:
  - Single team environments support frequent deployments
  - Shared environments require coordinated deployment schedules
- User expectations and tolerance for frequent updates
- Deployment duration and complexity
- Downtime impact, performance effects, and user experience
