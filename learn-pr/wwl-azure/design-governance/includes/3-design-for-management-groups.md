[**Management groups**](/azure/governance/management-groups/overview) are containers that help you manage access, policy, and compliance across **multiple subscriptions**.​ You can use management groups to:

- Limit in which regions, across several subscriptions, virtual machines can be created.

- Provide user access to multiple subscriptions by creating one role assignment that will be inherited by other subscriptions.

- Monitor and audit, across subscriptions, role, and policy assignments.

### Things to know about management groups

- Management groups can be used to aggregate policy and initiative assignments via Azure Policy.

- A management group tree can support up to [six levels of depth](/azure/governance/management-groups/overview). This limit doesn't include the tenant root level or the subscription level.

- Azure role-based access control authorization for management group operations isn't enabled by default.

- By default, all new subscriptions will be placed under the root management group.

### Things to consider when creating management groups

Tailwind Traders has Sales, Corporate, and IT departments. The Sales department manages offices in the West and in the East. The Corporate main office includes Human Resources (HR) and Legal. The Information Technology (IT) department handles research, development, and production. There are currently two apps hosted in Azure. Here’s a proposed management group hierarchy. 

:::image type="content" source="../media/management-groups.png" alt-text="Management groups for sales, corporate, and IT.":::

- **Design management groups with governance in mind.**  For example, apply Azure policies at the management group level for all workloads that require the same security, compliance, connectivity, and feature settings.

- **Keep the management group hierarchy reasonably flat**. Ideally have no more than three or four levels. A hierarchy that is too flat doesn’t provide flexibility and complexity for large organizations. A hierarchy with too many levels will be difficult to manage. 

- **Consider a top-level management group.** This management group supports common platform policy and Azure role assignments across the whole organization. For example, the Tailwinds management group is a top-level management group for all organizational-wide policies. 

- **Consider an organizational or departmental structure**. An organizational structure will be easy to understand. For example, the Sales, Corporate, and IT management groups. 

- **Consider a geographical structure**. A geographical structure allows for compliance policies in different regions. For example, the West and East management groups in Sales. 

- **Consider a production management group.** A production management group creates policies that apply to all corporate products. In our example, the Production management group provides product-specific policies for corporate apps. 

- **Consider a sandbox management group.** A sandbox management group lets users experiment with Azure. The sandbox provides isolation from your development, test, and production environments. Users can experiment with resources that might not yet be allowed in production environments. 

- **Consider isolating sensitive information in a separate management group.** In our example, the Corporate management group provides more standard and compliance policies for the main office. 
