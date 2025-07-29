| :::image type="icon" source="../media/goal.svg"::: Spend only what you need to get the most return on investment. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Every architectural decision affects your budget, such as whether you build or buy, what tools you use, or how you license and train. It's important to weigh those options and make trade-offs that still meet your app's needs without overspending.

**Example scenario**

Contoso Manufacturing runs a custom-built warehouse management system (WMS) that handles its four warehouses across South America. They want to update and move the WMS to the cloud. They're deciding between a lift-and-shift move of the current setup or building something new with modern tools. Leadership wants to keep costs under control, so the team needs a plan that maintains cost efficiency.

The WMS solution is a .NET application that runs on Internet Information Services (IIS) and uses SQL Server for its databases.

## Understand the full cost of your design

**Measure the total cost incurred by technology and automation choices, taking into account the impact on return on investment (ROI). The design must work within the acceptable boundaries for all functional and nonfunctional requirements. The design must also be flexible to accommodate predicted evolution. Factor in the cost of acquisition, training, and change management.**

Implementing a balanced approach that takes ROI into account prevents over-engineering, which might increase costs.

*Contoso's challenge*

- The engineering team at Contoso is excited to move their warehouse system to the cloud, just like other teams have done.

- They know the current app has some technical debt, so they're planning to rewrite much of the application code and switch to newer cloud-native tools.
- The engineering team wants to redesign everything into microservices and run it on Azure Kubernetes Service (AKS), which is a new and exciting platform for them.

*Applying the approach and outcomes*

- The team is excited about doing a significant redesign during the cloud move, but they know that they need to maintain the workload's ROI. So they must stick with tools that they already know and avoid major rewrites that require extra engineering team training.

- The workload team takes a practical approach to designing the system. They want it to be cost-effective, meet expectations, and avoid overcomplicating things. To keep the ROI in check and make the migration smooth, they decide to go with an equivalent solution in the cloud, such as Azure App Service.

- They establish a cost baseline that accounts for infrastructure, licensing, and operational costs, as well as less obvious factors like training for new platforms, rewriting legacy code, and managing change across teams. They gain a clearer picture of what's feasible within their budget, which confirms their decision of App Service as the more familiar, lower-risk path.

- During the migration, the team plans to clean up some of the technical debt that makes sense to tackle now. That way, after everything's running on Azure, they'll be in a better spot to keep improving the platform while still keeping the ROI in mind when making those choices.

## Refine the design

**Fine-tune the design by prioritizing services that can reduce the overall cost, don't need additional investment, or don't have a significant impact on functionality. Prioritization should account for the business model and technology choices that bring high ROI.**

You can explore cheaper options that might enable resource flexibility or dynamic scaling, or you might justify the use of existing investments. The prioritization parameters might factor in costs that are required for critical workloads, runtime, and operations, and other costs that might help the team work more efficiently.

*Contoso's challenge*

- The existing workload is hosted on a hyper-converged (HCI) appliance and the team's cost center is charged back for compute, network, and storage costs.

- The workload has deployed the preproduction and production environments on Windows virtual machines.
- GitHub Actions with self-hosted runners is used for running GitHub Actions jobs.

*Applying the approach and outcomes*

- After evaluating several cloud-native options, the team decides that moving the web components to App Service would provide Windows IIS application compatibility without significant changes and wouldn't require significant training.

- The team decides to continue using GitHub Actions with self-hosted runners, but they'll migrate to a virtual machine scale set with the ability to scale to zero nodes when they aren't being used.

## Design your architecture to support cost guardrails

**Set up cost limits in your architecture to keep spending within a safe range, and ensure that your cloud environment costs are kept under those limits.**

Enforcing limits helps avoid surprise charges and ensures that you only use what you actually budget for.

*Contoso's challenge*

- The current system doesn't have cost guardrails, but since it rarely changes, no one's pushed to add them.

- The HCI environment owners have set a resource cap, so the workload can't use more compute or storage than allowed.
- The team's worried that moving to the cloud could lead to unexpected costs, and they're not sure how to avoid that.

*Applying the approach and outcomes*

- The team learns how to use Microsoft Cost Management solutions.

- They plan to set scale limits for the App Service plans.
- They plan to set up a deny policy to block certain expensive virtual machine SKUs from being used.
- They plan to add automation to save on storage. Older or less-used data will automatically move to cheaper storage tiers like cold or archive. This kind of automation wasn't possible in their old HCI environment.
