Permissions Management is a cloud infrastructure entitlement management (CIEM) solution that provides comprehensive visibility into permissions assigned to all identities. For example, over-privileged workload and user identities, actions, and resources across multicloud infrastructures in Microsoft Azure, Amazon Web Services (AWS), and Google Cloud Platform (GCP).

Permissions Management detects, automatically right-sizes, and continuously monitors unused and excessive permissions.

Organizations have to consider permissions management as a central piece of their Zero Trust security to implement least privilege access across their entire infrastructure:

-   Organizations are increasingly adopting multicloud strategy and are struggling with the lack of visibility and the increasing complexity of managing access permissions.
-   With the proliferation of identities and cloud services, the number of high-risk cloud permissions is exploding, expanding the attack surface for organizations.
-   IT security teams are under increased pressure to ensure access to their expanding cloud estate is secure and compliant.
-   The inconsistency of cloud providers' native access management models makes it even more complex for Security and Identity to manage permissions and enforce least privilege access policies across their entire environment.

![Diagram that shows Microsoft Entra Permissions Management use cases.](../media/key-use-cases.png)

## Key use cases

Permissions Management allows customers to address three key use cases: _discover_, _remediate_, and _monitor_.

Permissions Management has been designed in such a way that we recommended you 'step-through' each of the below phases in order to gain insights into permissions across the organization. This is because you generally can't action what is yet to be discovered, likewise you can't continually evaluate what is yet to be remediated.

![Diagram that shows use case for Permissions Management.](../media/discover-remediate-monitor.png)
<!-- 
[](https://learn.microsoft.com/azure/active-directory/cloud-infrastructure-entitlement-management/overview#discover)
-->
### Discover

Customers can assess permission risks by evaluating the gap between permissions granted and permissions used.

-   Cross-cloud permissions discovery: Granular and normalized metrics for key cloud platforms: AWS, Azure, and GCP.
-   Permission Creep Index (PCI): An aggregated metric that periodically evaluates the level of risk associated with the number of unused or excessive permissions across your identities and resources. It measures how much damage identities can cause based on the permissions they have.
-   Permission usage analytics: Multi-dimensional view of permissions risk for all identities, actions, and resources.
<!-- 
[](https://learn.microsoft.com/azure/active-directory/cloud-infrastructure-entitlement-management/overview#remediate)
-->
### Remediate

Customers can right-size permissions based on usage, grant new permissions on-demand, and automate just-in-time access for cloud resources.

-   Automated deletion of permissions unused for the past 90 days.
-   Permissions on-demand: Grant identities permissions on-demand for a time-limited period or an as-needed basis.
<!-- 
[](https://learn.microsoft.com/azure/active-directory/cloud-infrastructure-entitlement-management/overview#monitor)
-->
### Monitor

Customers can detect anomalous activities with machine learning-powered (ML-powered) alerts and generate detailed forensic reports.

-   ML-powered anomaly detections.
-   Context-rich forensic reports around identities, actions, and resources to support rapid investigation and remediation.

Permissions Management deepens Zero Trust security strategies by augmenting the least privilege access principle, allowing customers to:

-   Get comprehensive visibility: Discover which identity is doing what, where, and when.
-   Automate least privilege access: Use access analytics to ensure identities have the right permissions, at the right time.
-   Unify access policies across infrastructure as a service (IaaS) platforms: Implement consistent security policies across your cloud infrastructure.

Once your organization has explored and implemented the discover, remediation and monitor phases, you've established one of the core pillars of a modern zero-trust security strategy.