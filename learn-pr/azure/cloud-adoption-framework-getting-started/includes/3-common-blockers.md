In this exercise, you review a few common blockers and find the most applicable getting-started guides to overcome them. This exercise focuses all of the various points of guidance from the Cloud Adoption Framework into manageable, actionable steps.

## Scenario 1: The chief information officer is concerned about progress

As we learned in the previous unit, the Tailwind Traders company is considering migrating two datacenters to avoid costly contract renewals and move to a modern operating model in the cloud. The company assembled a migration team that consists of a project manager, a central operations/infrastructure team, and an IT manager.

In the last three months, the team has migrated a few hundred virtual machines (VMs) to Azure. The team has retired 30 percent of the VMs in the existing datacenter. The team members feel like they're ahead of schedule, but they haven't retired any production hosts yet.

As the deadline for this project approaches, the Chief Information Officer (CIO) has begun to express concerns with progress toward retiring the physical infrastructure in the existing datacenters. Unfortunately, the team doesn't have a clear dependency map to show the hosts for each VM and when a host is no longer needed.

This experience is common for customers who are new to cloud migration. Engaging an experienced partner can help with these concerns, as can proper planning and data-driven decisions.

The getting-started guide for [accelerating migration](/azure/cloud-adoption-framework/get-started/migrate?azure-portal=true) can help the Tailwind Traders migration team address these concerns. In particular, that guide can help the team create a data-driven dialogue with leadership around stakeholder expectations and the general strategy. It can also help the team collect data on the overall portfolio and map that data to actionable cloud-adoption plans.

## Scenario 2: Cost misalignment

The Tailwind Traders migration team has gotten its migration-factory processes running smoothly. The finance director recently joined the team to review the budget and overall progress. That meeting didn't go as planned. Progress toward business objectives was well received, but the cloud costs are rising at a faster pace than expected. Updated forecasts suggest that the final costs of hosting in the cloud are higher than expected.

As cloud adoption scales, customers commonly experience issues related to proper controls. When the migration team accelerated the migration effort, they skipped important steps around governance and establishing proper guardrails. Cost is the first indicator of this missed step. Fortunately, it's the easiest to bring back under control.

The getting-started guide on [managing cloud costs](/azure/cloud-adoption-framework/get-started/manage-costs?azure-portal=true) is the best starting point for this common blocker. That article outlines a series of best practices to quickly optimize enterprise costs and resolve the finance director's concerns. It then builds on those best practices by establishing recurring processes to minimize budgetary surprises in the future.

## Scenario 3: Operations support

When a migration results in hosting a production workload in the cloud, the business now takes a dependency on the operations of those cloud assets. Tailwind Traders didn't account for this dependency. It was assumed that the central operations team would use its existing tools and processes to manage operations. That assumption might not prove accurate.

Before operational management processes could start, the CIO asked the following basic questions. Because the team didn't have answers readily available, the CIO advised that production traffic remain with the current datacenter until the team knew the answers to those questions.

- We can stick with our existing processes, but should we? Is that the best thing for our business, or do we need a dedicated cloud-operations team?
- As we democratize decisions and empower workload teams to drive innovation, how do those teams interact with the operations team?
- What services are included in our operations baseline for all workloads?
- What things can a workload team add to go deeper into operations monitoring and optimization?
- Are we capitalizing on the advanced operations built into the Azure platform?
- What guardrails ensure that all workload teams follow best practices for stable operations?

You don't need to change how you operate to adopt the cloud, but you should be able to answer these basic operations-management questions during any migration of a full datacenter. Transitioning to an operations team after migration is often a blocker for migration efforts. The getting-started guide on [building a cloud operations team](/azure/cloud-adoption-framework/get-started/team/cloud-operations?azure-portal=true) walks through steps to answer each of these questions and determine whether you need a dedicated cloud-operations team.
