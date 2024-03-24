| :::image type="icon" source="../media/goal.svg"::: Continuously right-size investment as your workload evolves with the ecosystem. |
| :----------------------------------------------------------------------------------------------------------------------------- |

What was important yesterday might not be important today. As you learn through evaluation of production workloads, expect changes in architecture, business requirements, processes, and even team structure. Your software development lifecycle (SDLC) practices might need to evolve. External factors might also change, like the cloud platform, its resources, and your agreements.

You should carefully assess the impact of all changes on cost. Monitor changes and the ROI trend on a regular cadence, and evaluate whether you need to adjust functional and nonfunctional requirements.

**Example scenario**

Contoso Air provides a baggage tracking solution for airlines. The workload is hosted in Azure and runs on AKS with Cosmos DB for its database and uses Event Hubs for messaging. The workload is deployed in the West US and the East US regions.

## Continuously evaluate and optimize your environment and support costs.

**By using your cost tracking system, continuously evaluate and optimize the costs of resources, data, and paid support. Are there underutilized resources that can be retired, replaced, rebuilt, or refactored?**

You'll reduce costs by avoiding paying for resources that aren't fully utilized. Understanding pricing metrics can help you make decisions that are more aligned with your cost model. It can also prevent unwarranted billing. Resizing or removing underutilized resources, or even changing SKUs, can reduce costs.

You might also be able to save some costs by evaluating the use of your support contracts with your technology suppliers and right-sizing them.

*Contoso's challenge*

- The workload team has always come in under budget, so optimization for cost efficiency hasn't been a priority.
- They're planning to improve the workload's reliability next year and know that doing so will increase their Azure costs, likely pushing the workload over their budget. They're considering asking for an increased budget for next year.

*Applying the approach and outcomes*

- The team decides that before asking for more money, they'll evaluate their current Azure and support costs to look for potential savings opportunities. They look into the per-resource, per-resource group, and per-tag breakdowns of cost in the existing cost tracking system and notice some unexpected spend.
- The team discovers that there are VMs running in their environment that were used for a deprecated build system and are no longer needed, there's a significant amount of old data in Azure Storage that can be moved to a less expensive tier, and they're paying for a support contract with their cloud provider that includes consultative hours that they are'nt using.
- The team optimizes their Azure costs by deleting the unused VMs and moving the old data to Archive storage. They begin working more closely with their cloud provider to make good use of their consulting services.
- The team adds a recurring task to their backlog to perform evaluations of their workload costs going forward.

## Continuously review and refine your workload

**Continuously adjust architecture design decisions, resources, code, and workflows based on ROI data.**

Regular reviews of metrics, performance data, billing reports, and feature usage might lead to fine-tuning that can reduce costs.

*Contoso's challenge*

- Since the team has stayed under budget historically, they haven't looked at alternative approaches to existing functionality. Instead, most of their planning focuses on building new features.
- After finding waste through their initial evaluation, they decide to look at the rest of the current components to look for optimization opportunities.

*Applying the approach and outcomes*

- The team finds that they have allocated more resources than are necessary to low priority flows, and can safely scale back the allocated throughput, while maintaining their performance requirements. Specifically, they can move away from over-provisioning to handle peak loads and implement a queue-based load leveling system instead.
- They also find that a new feature has been added to their selected SKU on their compute platform that replaces some authentication code. Using this feature will mean less code to maintain and test.

## Optimize your deployment environments

**Treat different SDLC environments differently, and deploy the right number of environments. Production environments should be your main cost driver.**

You can save money by understanding that not all environments need to simulate production. Nonproduction environments can have different features, SKUs, instance counts, and even logging.

You also can save costs by creating preproduction environments on-demand and removing them when you no longer need them.

*Contoso's challenge*

- The workload team spends more on preproduction environments than it does on production environments. While this may be important for some scenarios, it seems excessive for this workload.
- The preproduction environments have been built to match the production environment very closely. The workload team appreciates having a very close approximation of the production environment in the lower environments as it provides them a high degree of confidence that behaviors in production will match the lower environments.

*Applying the approach and outcomes*

- After careful evaluation, the team decides that they can accept the tradeoff of a bit of additional risk to realize cost savings that come with having some dissimilarity between environments.
- The team decides to colocate a few of the test environments into the same infrastructure and to shut down unused environments overnight.
- The team also finds opportunities to shift left and perform inner-loop development and testing on local developer workstations.
- By finding ways to make small compromises in their preproduction environments and development practices, they have freed up budget that they'll put to good use in automation efforts.
