The exercises you've completed are a great start but they don't cover all aspects of a mission critical workload. Continue to explore the design principles and areas given in [**Well-Architected mission-critical workloads**](/azure/architecture/framework/mission-critical/mission-critical-overview). We recommend that you fully understand the operational design choices. Here we'll introduce the key value areas that you can examine on your own.


## Continuously validate and test the system

You must fully validate the health of both the application code and infrastructure. The scope must cover the requirements set of reliability, performance, availability, security, quality, and scale. 

> [!VIDEO fc7842c3-7c7a-44dc-ad87-838aa51d0000]

> **Learn more: [Continuous validation and testing](/azure/architecture/framework/mission-critical/mission-critical-deployment-testing#continuous-validation-and-testing)**

## Use multiple application environments

Multiple application environments are needed to run mission-critical workloads. Some might reflect production on a permanent basis while others may be short lived with a reduced level of complexity. These environments should be staged as part of the continuous integration/continuous delivery (CI/CD) pipelines during the development and release cycle so that deployment is fully tested before going into the production environment.

It's highly recommended that **dev/test environments shouldn't share resources with the production environment**. Each environment has its own set of requirements for reliability, capacity, and security. Can you identify services in this architecture that are shared across environments? How will you change the design to align with this recommendation.

> **Learn more: [Application environments](/azure/architecture/framework/mission-critical/mission-critical-deployment-testing#application-environments)**

## Expanded deployment environments

Mission-critical systems require rigorous pre-release testing and solid software development lifecycle (SDLC) practices. Instead of a single, shared development environment, **use multiple, ephemeral environments that more closely align with staging and production**. A dedicated staging environment should be used for load and performance testing, chaos testing, user acceptance testing (UAT), and security testing.

Using **blue/green deployment** strategy is preferred for mission-critical workloads to support zero downtime deployments and mitigate deployment risks. This approach requires at least two identical deployments running in parallel. Blue or the existing deployment serves user traffic while green or the new deployment is created, tested, and prepared to receive traffic. If the green deployment is successful, it becomes the primary production environment and the blue deployment is decommissioned.

> **Learn more: [Ephemeral blue/green deployments](/azure/architecture/framework/mission-critical/mission-critical-deployment-testing#ephemeral-bluegreen-deployments)**


## Add resiliency with message brokers and caches

In the current architecture both reads and writes are handled directly by the database. An alternative approach  is to introduce a message broker. This component can help with complex transactions that need to coordination with multiple endpoints. The requests can be queued for processing instead of risking the loss of a sale because of a signal component failure.

Serve frequent and similar requests from a search index or cache. Caching will reduce runtime dependency on the  database allowing the APT to be more isolated from transient faults. Also, resources won't be consumed in processing a transaction, which could potentially fail and could have been completed without reaching the database.

> **Learn more: [Loosely coupled event-driven architecture](/azure/architecture/framework/mission-critical/mission-critical-application-design#loosely-coupled-event-driven-architecture)**