[Management groups](/azure/governance/management-groups/overview) are containers that help you manage access, policy, and compliance across **multiple subscriptions**.​ You can use management groups to:

- Limit the regions where virtual machines can be created, across subscriptions.

- Provide user access to multiple subscriptions by creating one role assignment that's inherited by other subscriptions.

- Monitor and audit role and policy assignments, across subscriptions.

### Things to know about management groups

As you plan the governance strategy for Tailwind Traders, consider these characteristics of management groups:

- Management groups can be used to aggregate policy and initiative assignments via Azure Policy.

- A management group tree can support up to [six levels of depth](/azure/governance/management-groups/overview). This limit doesn't include the tenant root level or the subscription level.

- Azure role-based access control authorization for management group operations isn't enabled by default.

- By default, all new subscriptions are placed under the root management group.

### Things to consider when creating management groups

Tailwind Traders has Sales, Corporate, and Information Technology (IT) departments. The Sales department manages offices in the West and in the East. The Corporate main office includes Human Resources (HR) and Legal. The IT department handles research, development, and production. There are currently two applications hosted in Azure.

Here's a proposed management group hierarchy for your organization:

:::image type="content" source="../media/management-groups.png" alt-text="Diagram of management groups for the sales, corporate, and IT departments." border="false":::

- **Design management groups with governance in mind**. Use Azure policies at the management group level for all workloads that require the same security, compliance, connectivity, and feature settings.

- **Keep the management group hierarchy reasonably flat**. Plan the Tailwind Traders hierarchy to have no more than three or four levels of management groups. A hierarchy that's too flat doesn't provide flexibility and complexity for large organizations. A hierarchy with too many levels can be difficult to manage. 

- **Consider a top-level management group**. Implement a top-level management group to support common platform policy and Azure role assignments across the entire organization. A Tailwind Traders management group can be a top-level management group for all organizational-wide policies. 

- **Consider an organizational or departmental structure**. Design your management groups based on the organizational structure, to make it easy to understand. Separate the management groups for each Tailwind Traders department like Sales, Corporate, and IT. 

- **Consider a geographical structure**. Build your management groups by using a geographical structure to allow for compliance policies in different regions. Allocate unique management groups for governance in the West and East sales regions for Tailwind Traders. 

- **Consider a production management group**. Institute a production management group to create policies that apply to all corporate products. A production management group for Tailwind Traders can provide product-specific policies for corporate applications. 

- **Consider a sandbox management group**. Offer a sandbox management group for users to experiment with Azure. The sandbox provides isolation from your development, test, and production environments. Users can experiment with resources that might not yet be allowed in official Tailwind Traders production environments. 

- **Consider isolating sensitive information in a separate management group**. Secure sensitive data by using a corporate management group for Tailwind Traders. The separate management group provides both standard and enhanced compliance policies for the main office. 
