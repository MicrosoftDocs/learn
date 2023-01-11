To prevent performance bottlenecks and to increase confidence in new releases, Contoso Shoes decided to implement [continuous validation](/azure/architecture/guide/testing/mission-critical-deployment-testing). To accomplish that, the company:

- Identified relevant user and system flows.
- Defined load tests for the flows to validate the expected performance and thresholds.
- Defined baselines for normal scenarios and special scenarios that were simulated in chaos experiments.
- Embedded the continuous validation process into an automated pipeline.

The newly gained insights from a consistent and regular continuous validation process have increased the company's confidence in new releases. Those insights have also reduced the number of problems in release rollouts and normal operations.

## Learning objectives

You learned how to design and use continuous validation, and you applied this knowledge through the exercises to meet an organization's needs. You should now be able to:

- Explain the importance of user and system flows as the foundation for defining load tests and chaos experiments for your workload.
- Establish a baseline with expected thresholds for the system.
- Define requirements for load testing and chaos experiments.
- Design and use continuous validation for a production-ready, mission-critical solution.

Congratulations on completing this training module.

## Learn more

- Try a challenge project: [Design a mission-critical web application](/training/modules/azure-mission-critical/).

- For more information about architecture solutions in Azure, see the [Microsoft Azure Well-Architected Framework guide](/azure/architecture/framework) in the Azure Architecture Center.

- For more information about mission-critical workloads on Azure, see [Mission-critical workloads](/azure/architecture/framework/mission-critical/mission-critical-overview).

- Start the [Mission Critical Well-Architected Review](/assessments/23513bdb-e8a2-4f0b-8b6b-191ee1f52d34) assessment to evaluate the state of your continuous validation solution in your existing mission-critical workload, and to take any recommended actions to improve it. Pay special attention to the "Mission Critical: Deployment and Testing" section.
