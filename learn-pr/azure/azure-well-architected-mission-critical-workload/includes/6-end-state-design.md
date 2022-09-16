The exercises you've completed are a great start but they don't cover all aspects of a mission critical workload. Continue to explore the design principles and areas given in [**Well-Architected mission-critical workloads**](/azure/architecture/framework/mission-critical/mission-critical-overview). We recommend that you fully understand the operational design choices. Here we'll introduce the key value areas that you can examine on your own.


## Continuous validation and test

You must fully validate the health of both the application code and infrastructure. The scope must cover the requirements set of reliability, performance, availability, security, quality, and scale. 

> [!VIDEO fc7842c3-7c7a-44dc-ad87-838aa51d0000]

> **Learn more: [Continuous validation and testing](/azure/architecture/framework/mission-critical/mission-critical-deployment-testing#continuous-validation-and-testing)**

## Application environments

Multiple application environments are needed to run mission-critical workloads. Some might reflect production on a permanent basis while others may be short lived with a reduced level of complexity. These environments should be staged as part of the continuous integration/continuous delivery (CI/CD) pipelines during the development and release cycle so that deployment is fully tested before going into the production environment.

It's highly recommended that dev/test environments shouldn't share resources with the production environment. Each environment has its own set of requirements for reliability, capacity, and security requirements. Can you identify services in this architecture that are shared across the two environments? How will you change the design so align with that recommendation.

> **Learn more: [Application environments](/azure/architecture/framework/mission-critical/mission-critical-deployment-testing#application-environments)**


## Ephemeral deployment environments

Using the blue/green deployment strategy is preferred for mission-critical workloads. This approach requires atleast two identical deployments running in parallel. Blue or the existing deployment serves user traffic while green or the new deployment is created, tested, and  prepared to receive traffic. If the green deployment is successful, it becomes the primary production environment and the blue deployment is decommissioned.

> **Learn more: [Ephemeral blue/green deployments](s/azure/architecture/framework/mission-critical/mission-critical-deployment-testing#ephemeral-bluegreen-deployments)**


