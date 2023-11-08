| :::image type="icon" source="media/goal.svg"::: Spend only on what you need to achieve the highest return on your investments. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Every architectural decision has direct and indirect financial implications. Understand the costs associated with build versus buy options, technology choices, the billing model and licensing, training, operations, and so on.

Given a set of requirements, optimize and make tradeoff decisions, in relation to costs, that still effectively address the cross-cutting concerns of the workload.

The examples for the following approaches are based on a fictional company, Contoso Manufacturing (CM). CM runs a custom-built warehouse management system (WMS) to handle its four warehouses across South America and they have decided that it is time to update the solution and move it to the cloud. They are considering a lift-and-shift move of the current solution or a greenfield build with modern cloud tools. CM's senior leadership wants to control costs and has asked the workload team's leaders how they will approach the migration with a goal of maintaining cost efficiency.

The WMS solution is a .NET application running on IIS and uses SQL Server for its databases.

## Measure the workload design's total cost

**Measure the total cost incurred by technology and automation choices, taking into account the impact on ROI. The design must work within the acceptable boundaries for all functional and nonfunctional requirements. The design must also be flexible to accommodate predicted evolution. Factor in the cost of acquisition, training, and change management.**

Implementing a balanced approach that takes ROI into account prevents over-engineering, which might increase costs.

*Challenge*

- The workload engineering team is excited to get this workload into the cloud, joining other CM teams who have already been doing cloud-native development.
- They are aware of the technical debt in the application and expect to address it by rewriting a significant amount of application code and moving to to new cloud-native solutions for many components.
- The engineering team hopes to take this opportunity to completely redesign the system into microservices and host it on AKS, a new but exciting technology for the team.

*Applying the approach and outcomes*

- While the workload team has a clear desire to do large-scale refactoring as part of the cloud migration, they realize that the workload needs to maintain it’s ROI. Maintaining the workload's ROI will likely point the team toward using solutions that don't require extensive new engineering team training, and they will be unable to make large rewrites to the workload as part of the migration.
- The workload team takes a pragmatic approach to the design of the system, making sure it stays cost effective, and works within expected parameters, and is not over-engineered. To ensure that the ROI is maintained and the migration is performed efficiently, they decided the best approach is to go with a like-for-like solution in the cloud, such as Azure App Service.
- During the migration, they will selectively address some technical debt that will enable them to further evolve the platform once it is on Azure, and will consider the ROI as part of the selection process.

## Refine the design

**Fine-tune the design by prioritizing services that can reduce the overall cost, don't need additional investment, or don't have a significant impact on functionality. Prioritization should account for the business model and technology choices that bring high ROI.**

You'll be able to explore cheaper options that might enable resource flexibility or dynamic scaling, or you might justify the use of existing investments. The prioritization parameters might factor in costs that are required for critical workloads, runtime, and operations, and other costs that might help the team work more efficiently.

*Challenge*

- The existing workload is hosted on a hyper-converged (HCI) appliance and the team's cost center is charged back for compute, network, and storage costs.
- The workload has deployed the pre-production and production environments on Windows virtual machines.
- GitHub Actions with self-hosted runners is used for executing GitHub Actions jobs.

*Applying the approach and outcomes*

- After evaluating several cloud-native options, the team decides that moving the web components to Azure App Service would provide Windows IIS application compatibility without significant changes and wouldn't require significant training.
- The team decides to continue using GitHub Actions with self-hosted runners, but they will migrate to a virtual machine scale set with the ability to scale to zero nodes when they aren't being used.

## Design your architecture to support cost guardrails.

Enforcement via governance policies or built-in application design patterns can prevent incidental or unapproved charges.

*Challenge*

- The existing system has no cost guardrails, but rarely changes so there has been little motivation to build such guardrails.
- The owners of the HCI environment have set a resource limit that applies to this workload, effectively stopping the workload from consuming excess compute and storage resources.
- The team is concerned that moving to the cloud will pose the risk of incurring unexpected costs, and are unsure of how to minimize that risk.

*Applying the approach and outcomes*

- The team educates themselves about Azure cost management solutions.
- The team plans to setup scale limits for the Azure App Service plans.
- The team plans to setup policies to disallow the use of certain higher priced SKUs for the resource types that will be used in the Azure deployment.
- The team plans to implement automation to help control storage costs. Certain data types will automatically move from hot storage to cold or archive storage based on criteria like date of last access. This type of automation is not possible in the HCI environment.