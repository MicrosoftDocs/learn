Contoso Shoes is an online shoe store that wants to be highly available during an upcoming launch. They migrated their on-premises deployments to the cloud two years ago and have benefitted by adopting the OpEx model. In the last six months, they've experienced issues with availability, and the operators aren't able to troubleshoot issues quickly. The organization now wants to invest in making the workload mission critical and focus on enhancing the overall reliability and observability of the system.

In the previous architecture, the application was deployed in a single region and wasn't able to withstand regional outages. Azure App Service and the external monitoring tools didn't have a way to check the health status of the application itself. This gap led to traffic being routed to unhealthy App Service instances, resulting in failed requests. The team wasn't able to see the cascading impact of issues resulting from an API component affecting its platform dependencies.

By completing this challenge, you've explored a mission-critical design at a high level. You've applied the learnings through the exercises to meet Contoso's needs.

The improved design detects degraded performance of one or more components using a health model. The SRE team can now quickly identify and resolve issues before they can lead to a full outage. Now that the solution is deployed in multiple regions in an active-active model, it can withstand a complete regional failure while giving more system health insights to their operators. Contoso has also improved their customer experience by serving clients faster in a region geographically closer to them.

Congratulations on completing this Challenge Project. You've validated yours skills in analyzing an existing example solution and designing an improved architecture.

## Suggested next steps

The exercises you've completed are a great start but they don't cover all aspects of a mission-critical workload. Continue to explore the design principles and areas given in [Well-Architected mission-critical workloads](/azure/architecture/framework/mission-critical/mission-critical-overview). We recommend these key value areas:

- Continuous validation and testing

    You must fully validate the health of both the application code and infrastructure. The scope must cover the requirements set for reliability, performance, availability, security, quality, and scale.

    > [!VIDEO fc7842c3-7c7a-44dc-ad87-838aa51d0000]

    > **Learn more: [Continuous validation and testing](/azure/architecture/framework/mission-critical/mission-critical-deployment-testing#continuous-validation-and-testing)**

- Use multiple application environments

    It's highly recommended that dev/test environments shouldn't share resources with the production environment. Each environment has its own set of requirements for reliability, capacity, and security. Can you identify services in this architecture that are shared across environments? How will you change the design to align with this recommendation?

    > **Learn more: [Application environments](/azure/architecture/framework/mission-critical/mission-critical-deployment-testing#application-environments)**

- Expanded deployment environments

    Mission-critical systems require rigorous prerelease testing and solid software-development lifecycle (SDLC) practices. Instead of a single, shared development environment, use multiple, ephemeral environments that more closely align with staging and production. You should use a dedicated staging environment for load and performance testing, chaos testing, user acceptance testing (UAT), and security testing.

    > **Learn more: [Ephemeral blue/green deployments](/azure/architecture/framework/mission-critical/mission-critical-deployment-testing#ephemeral-bluegreen-deployments)**

- Add resiliency with message brokers

    Introduce a message broker to help with complex transactions that need coordination with multiple endpoints. Requests can be queued for processing instead of risking the loss of a sale because of a single component failure.

    > **Learn more: [Loosely coupled event-driven architecture](/azure/architecture/framework/mission-critical/mission-critical-application-design#loosely-coupled-event-driven-architecture)**

## Learn more

For more information on designing solutions on Azure, refer to the [Azure Well-Architected Framework](/azure/architecture/framework) guide.

Explore these reference architectures in the Azure Architecture Center as a way to expand your design:

- [Mission-critical baseline architecture](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-intro)
- [Mission-critical baseline architecture with network controls](/azure/architecture/reference-architectures/containers/aks-mission-critical/mission-critical-network-architecture)