| :::image type="icon" source="../media/goal.svg"::: Buy only what you need to get the most return on investment. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Every architectural decision affects your budget, such as whether you build or buy, what tools you use, or how you license and train. It's important to weigh those options and make trade-offs that still meet your app's needs without overspending.

**Example scenario**

Contoso Manufacturing runs a custom-built warehouse management system (WMS) that handles its four warehouses across South America. They want to update and move the WMS to the cloud. They're deciding between lifting and shifting the current setup or building something new with modern tools. Leadership wants to keep costs under control, so the team needs a plan that balances cost with performance.

The WMS solution is a .NET application that runs on Internet Information Services (IIS) and uses SQL Server for its databases.

## Understand the full cost of your design

**Make sure you look at the total cost of your design, not just the technology and automation, but also the acquisition, training, and changes needed to make it work. Your design should meet all the key requirements including return on investment (ROI) and still be flexible enough to grow with your needs.**

Keeping ROI in mind helps avoid overbuilding something that ends up costing more than it's worth.

*Contoso's challenge*

- The engineering team at Contoso is excited to move their warehouse system to the cloud, just like other teams have done.

- They know the current app has some technical debt, so they're planning to rewrite much of the application code and switch to newer cloud-native tools.
- The engineering team wants to redesign everything into microservices and run it on Azure Kubernetes Service (AKS), which is a new and exciting platform for them.

*Applying the approach and outcomes*

- The team is excited about doing a significant redesign during the cloud move, but they know that they need to maintain the workload's ROI. So they must stick with tools that they already know and avoid major rewrites that require extra engineering team training.

- The workload team takes a practical approach to designing the system. They want it to be cost-effective, meet expectations, and avoid overcomplicating things. To keep the ROI in check and make the migration smooth, they decide to go with an equivalent solution in the cloud, such as Azure App Service.

- During the migration, the team plans to clean up some of the technical debt that makes sense to tackle now. That way, after everything's running on Azure, they'll be in a better spot to keep improving the platform while still keeping the ROI in mind when making those choices.

## Refine the design

**Fine-tune the design by focusing on services that save money, don't need extra investment, or won't affect how things work. Prioritize based on what suits your business model and the technology choices that provide the most value.**

You might find cheaper options that let you scale up or down easily, or you might decide to use tools that you've already invested in. When prioritizing, think about what's critical for running the workload, what affects runtime and operations, and what helps the team work smarter.

*Contoso's challenge*

- The existing workload runs on a hyper-converged (HCI) appliance, and Contoso gets billed for compute, network, and storage. 

- The workload has deployed the preproduction and production environments on Windows virtual machines.
- They use GitHub Actions with self-hosted runners to run GitHub Actions jobs.

*Applying the approach and outcomes*

- After the team checks out several cloud-native options, they choose App Service for the web components. It supports Windows IIS apps with minimal changes and no major training needed.

- They're sticking with GitHub Actions and self-hosted runners, but moving them to a virtual machine scale set that can scale down to zero nodes when idle.

## Design your architecture to support cost guardrails

**Build your architecture in a way that helps keep costs under control. You can use platform tools, policies, design patterns, or automation to stay within budget.**

Using governance policies or built-in design patterns can help avoid surprise charges or unapproved spending.

*Contoso's challenge*

- The current system doesn't have cost guardrails, but since it rarely changes, no one's pushed to add them.

- The HCI environment owners have set a resource cap, so the workload can't use more compute or storage than allowed.
- The team's worried that moving to the cloud could lead to unexpected costs, and they're not sure how to avoid that.

*Applying the approach and outcomes*

- The team learns how to use Microsoft Cost Management solutions.

- They plan to set scale limits for the App Service plans.
- They plan to set up a deny policy to block certain expensive virtual machine SKUs from being used.
- They plan to add automation to save on storage. Older or less-used data will automatically move to cheaper storage tiers like cold or archive. This kind of automation wasn't possible in their old HCI environment.
