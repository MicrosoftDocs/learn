A service-level agreement (SLA) is the formal agreement between a service company and the customer. For Azure, this agreement defines the performance standards that Microsoft commits to for its customers.

The Tailwind Traders team is working on quite a variety of projects! In addition to its main website, the team is adding a mapping feature to its Special Orders application so that it can calculate routes between suppliers and retail stores. The team is also exploring how severe weather tracking can improve its drone guidance system.

As requirements evolve, it's important for the team to understand how the SLA for each service it chooses affects the overall performance guarantees of its applications.

For example, the main website must be available as close to 100 percent of the time as possible. To accomplish that, Tailwind Traders might deploy extra instances of the same virtual machine across different availability zones in the same Azure region. Doing so helps ensure that if one zone is affected, virtual machine instances in the other zone can pick up the load.

The Special Orders application might have more flexible tolerances. As long as retail employees don't lose data and can quickly regain network access, the Special Orders application might have a lower SLA. Here, the team can choose to include less redundancy in its design.

When defining your SLA requirements, be sure to consider both your business needs and the time it takes to restore a component after a failure. Also consider how the use of preview services and preview features might affect your systems in production.

## Next steps

Create a sketch or diagram for an application that you plan to migrate to the cloud. Include each Azure service that you plan to use.

Use the documented [Service Level Agreements](https://azure.microsoft.com/support/legal/sla/?azure-portal=true) to find out the SLA for each Azure service involved. Then compute the composite SLA for your application.

Does the composite SLA meet your requirements? If not, what can you do to improve it?

## Learn more

In this module, you learned about several factors that affect service guarantees on Azure. You also learned how to access preview services and preview features. Here are additional resources to help you go further.

### Work with preview services

* Review the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms?azure-portal=true).
* Learn about updates and new product features on the [Azure announcements blog](https://azure.microsoft.com/blog/topics/announcements?azure-portal=true).

## Azure Fundamentals learning path

This module is part of the [Azure Fundamentals part 6: Describe Azure cost management and service level agreements](/learn/paths/az-900-describe-azure-cost-management-service-level-agreements/?azure-portal=true) learning path, which is one of six learning paths for Azure Fundamentals.

Here are the learning paths in this series:

- [Azure Fundamentals part 1: Describe core Azure concepts](/learn/paths/az-900-describe-cloud-concepts/?azure-portal=true)
- [Azure Fundamentals part 2: Describe core Azure services](/learn/paths/az-900-describe-core-azure-services/?azure-portal=true)
- [Azure Fundamentals part 3: Describe core solutions and management tools on Azure](/learn/paths/az-900-describe-core-solutions-management-tools-azure/?azure-portal=true)
- [Azure Fundamentals part 4: Describe general security and network security features](/learn/paths/az-900-describe-general-security-network-security-features/?azure-portal=true)
- [Azure Fundamentals part 5: Describe identity, governance, privacy, and compliance features](/learn/paths/az-900-describe-identity-governance-privacy-compliance-features/?azure-portal=true)
- [Azure Fundamentals part 6: Describe Azure cost management and service level agreements](/learn/paths/az-900-describe-azure-cost-management-service-level-agreements/?azure-portal=true)
