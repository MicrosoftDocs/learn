| :::image type="icon" source="media/goal.svg"::: Spend only on what you need to achieve the highest return on your investments. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Every architectural decision has direct and indirect financial implications. Understand the costs associated with build versus buy options, technology choices, the billing model and licensing, training, operations, and so on.

Given a set of requirements, optimize and make tradeoff decisions, in relation to costs, that still effectively address the cross-cutting concerns of the workload.

The examples for the following approaches are based on a hypothetical company, Contoso Manufacturing (CM). CM runs a custom-built warehouse management system (WMS) to handle its four warehouses across South America and they have decided that it is time to update the solution and move it to the cloud. They are considering a lift-and-shift move of the current solution or a greenfield build with modern cloud tools. CM's senior leadership wants to control costs and has asked the workload team's leaders how they will approach the migration with a goal of maintaining cost efficiency.

The WMS solution is a .NET application running on IIS and uses SQL Server for its databases.

## Measure the workload design's total cost

**Measure the total cost incurred by technology and automation choices, taking into account the impact on ROI. The design must work within the acceptable boundaries for all functional and nonfunctional requirements. The design must also be flexible to accommodate predicted evolution. Factor in the cost of acquisition, training, and change management.**

Implementing a balanced approach that takes ROI into account prevents over-engineering, which might increase costs.

*Challenge*

- The workload engineering team is excited to get this workload into the cloud, joining other CM teams who have already been doing cloud-native development.
- They are aware of the technical debt in the application and expect to address it by rewriting a significant amount of application code and moving to to new cloud-native solutions for many components.
- The engineering team hopes to take this opportunity to completely redesign the system into microservices and host it on AKS, a new but exciting technology for the team.

*Applying the approach and outcomes*

- While the ambition for change is high, they realize that the workload needs to maintain it’s ROI. This means minimal distribution to the warehouse floor staff. It means likely using solutions that do not require extensive new engineering team training, and probably avoiding large rewrites in the process.
- While the allure of “change everything” is still there, they take a pragmatic approach to the design of the system, making sure it stays cost effective, and works within expected parameters, not over engineered. They decided it would make sense to probably stick with a like-for-like solution in the cloud, such as Azure App Service, to ensure that the ROI of the solution stays high and the on-premises system is migrated from expeditiously with the lower cost of the migration.
- During the migration, they will selectively address some technical debt that will enable them to further evolve the platform once it is on Azure, and will consider the ROI as part of the selection process.

## Approach 2 summary [70 character long. Essence of the approach]

Example (Before). No more than four sentences. Highlight one or two key problems.

> **Approach**: Mostly full approach text.

Children's story about the approach.

Example (After) - No more than two sentences, showing how this approach solved the two key problems.

## Approach 3 summary [70 character long. Essence of the approach]

Example (Before). No more than four sentences. Highlight one or two key problems.

> **Approach**: Mostly full approach text.

Children's story about the approach.

Example (After) - No more than two sentences, showing how this approach solved the two key problems.