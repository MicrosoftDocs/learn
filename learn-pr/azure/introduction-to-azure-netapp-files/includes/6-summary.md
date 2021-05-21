<!-- 1. Goal and criteria-----------------------------------------------------------------------------

    Goal: Recap that this module's goal is 'evaluate' using the provided decision criteria.

    Format: Short text followed by a bulleted list of the decision criteria developed in the "When to use <product>" unit.

    Heading: none

    Example: "Our goal was to help you evaluate whether Logic Apps would be a good choice for your business process. We developed some criteria you can use to guide your decision:
    * Integration
    * Performance
    * Conditionals
    * Connectors"

-->
Our goal in this module was to help you evaluate whether whether Azure NetApp Files is a suitable storage choice for running your organization's file-based workloads in the cloud. To help you make that decision, we presented some criteria you can use::

- Ease of migration
- Workload scale
- Flexibility
- Storage technology

<!-- 2. Show how you solved the scenario problem(s)---------------------------------------------------

    Goal: Briefly summarize how you applied the decision criteria to the scenario problem(s). Ideally, discuss two scenarios, one where the product was appropriate and one where it wasn't.

    Heading: none; depending on length, you can put this in a separate paragraph or combine this with the previous section into a single paragraph

    Example: "We applied these criteria to our fictional shoe company. The analysis helped us see how difficult it would be to use Logic Apps for each process. Both the social-media monitor and the video archive utility used only the built-in connectors. This characteristic made them perfect for Logic Apps. The online sales portal required more work because it had complex conditionals and needed custom connectors."
 -->

We applied these criteria in the context of our fictional energy company. You learned that in most scenarios, Azure NetApp Files offers:

- Azure NetApp Files supports any POSIX-compliant workload that requires shared file storage via SMB or NSF (or both), so it can "lift-and-shift" these types of workloads.
- Azure NetApp Files works best with enterprise-scale workloads that require the highest performance and availability.
- Azure NetApp Files enables you to change a volume's service level and increase or decrease the size of a capacity pool or volume to match current demand.
- Azure NetApp Files can support any workload that requires shared file storage.

However, you also learned that organizations would probably not benefit from using Azure NetApp Files if they have:

- Workloads that require extensive reconfiguration or recoding to work in the cloud.
- Relatively small-scale and low-performance workloads.
- Mostly static content with relatively constant demand.
- Workloads that have a strict dependency or requirement for storage that is both block-based and direct-attached.

<!-- 3. Describe the business impact ----------------------------------------------------

    Goal: explain how choosing the right product is important

    Heading: none; depending on length, you can put this in a separate paragraph or combine this with the previous section into a single paragraph

    Example: "The criteria help you evaluate whether your business processes are a good match for Logic Apps. First, they let you assess how well Logic Apps will solve your problem. Second, they give you an idea of the amount of customization effort involved in using them for your task. This process should give you enough information to choose the right product for your work."
 -->

Implementing today's enterprise workloads requires the highest storage performance, maximum availability, and the flexibility to meet any demand. In the past, achieving the performance part of this recipe could only be achieved using an on-premises data center. However, data center configurations tend to be inflexible, complex, and expensive. A cloud service such as Azure offers flexibility, simplicity, and cost savings for regular workloads. So the big question today is how do you migrate your most important enterprise workloads to the cloud while still maintaining the highest level of performance and availability? Azure NetApp Files provides data center-quality performance and high availability with all the flexibility of the cloud. The process you went through here should give you enough information to decide the right shared storage solution for your organization

<!-- 4. References (optional) ----------------------------------------------------

    Goal: Provide a few recommendations for further study via a bulleted list of links. This is optional and intended to be used sparingly.
        - use the target page title as the text for your link
        - do not include other text such as a description
        - prefer other first-party sites like Docs reference pages
        - link to third-party sites only when they are trusted and authoritative
        - do not link to other Learn content ("next steps" recommendations are generated automatically)
        - avoid linking to opinion sites such as blog posts

    Heading: "## References"

    Example:
        "References
        * [Administrator role permissions in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/users-groups-roles/directory-assign-admin-roles)
        * [What is Azure role-based access control (Azure RBAC)?](https://docs.microsoft.com/azure/role-based-access-control/overview)
        * [Manage access to billing information for Azure](https://docs.microsoft.com/azure/billing/billing-manage-access)"
 -->

## References

- [Azure NetApp Files](https://azure.microsoft.com/services/netapp/)
- [SLA for Azure NetApp Files](https://azure.microsoft.com/support/legal/sla/netapp/v1_1/)
- [Service levels for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-service-levels)
- [Resource limits for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-resource-limits)
- [FAQs About Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-faqs)
- [Azure Files and Azure NetApp Files comparison](/azure/storage/files/storage-files-netapp-comparison)

<!-- Do not include any other content -->
