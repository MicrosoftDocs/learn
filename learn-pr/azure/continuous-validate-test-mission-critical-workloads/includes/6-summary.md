To prevent performance bottlenecks and to increase confidence in new releases, Contoso Shoes has decided to implement [continuous validation](/azure/architecture/guide/testing/mission-critical-deployment-testing). This process contained the definition of relevant user and system flows, the definition of load tests for these flows to validate the expected performance and thresholds, defining baselines for normal and special scenarios like for example during chaos experiments and the implementation embedded into an automated pipeline.

The newly gained insights and the consistent and regular continuous validation process has increased the confidence into new releases and has reduced the number of issues that have occurred as part of releases as well as under normal operations.

## Learning objectives

You've learned how to design and use continuous validation and have applied this knowledge through the exercises to meet an organization's needs. You should now be able to:

- You understand the importance of user and system flows as the foundation for defining load tests and chaos experiments for your workload.
- You established a baseline with expected thresholds for the system.
- You defined requirements for load testing and chaos experiments.
- Design and use continuous validation for a production-ready, mission-critical solution.

Congratulations on completing this training module!

## Learn more

- [Challenge Project - Design a mission-critical web application](/training/modules/azure-mission-critical/)

- For more information about architecture solutions in Azure, see the [Microsoft Azure Well-Architected Framework guide](/azure/architecture/framework) in the Azure Architecture Center.

- For more information about Mission-critical workloads on Azure, see [Mission-critical workloads](/azure/architecture/framework/mission-critical/mission-critical-overview).

- See [Continuous Validation with Azure Load Test and Azure Chaos Studio](/azure/architecture/framework/mission-critical/mission-critical-deployment-testing#demo-video-continuous-validation-with-azure-load-test-and-azure-chaos-studio) for a video of a CV implementation.

- Start the [Mission Critical Well-Architected Review](/assessments/23513bdb-e8a2-4f0b-8b6b-191ee1f52d34) assessment to evaluate the state of your continuous validation solution in your existing mission-critical workload, and to take any recommended actions to improve it. Pay special attention to the *Mission Critical: Deployment and Testing* section.
