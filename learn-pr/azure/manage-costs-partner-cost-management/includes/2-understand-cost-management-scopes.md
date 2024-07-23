Costs are organized by different Azure entity hierarchies. It's important to understand the hierarchies before evaluating your bill and the tools available in Azure to manage Fabrikam's costs. 

## Scopes and hierarchies

Two hierarchies are applicable to Microsoft Cost Management. Each node in either hierarchy is known as a *scope*. The scope that you select determines the group of costs that apply to the Cost Management tools that you use.

The Azure *billing hierarchy* is in your partner tenant. Cost Management uses the billing hierarchy specifically to manage your organization's billing data and invoices. Cost Management uses the billing hierarchy's permission roles to manage payments, costs, and accounts. The permission roles are *global admin* and *admin agent* for a direct partner or an indirect partner, as set in Partner Center.

Contoso's subscriptions and resources themselves are in the Azure *resource entity* hierarchy. This hierarchy is located in the customer's (Contoso's) tenant. Resource management and the associated permissions are governed by Azure role-based access control (RBAC).

We'll focus on only Fabrikam's billing hierarchy in this module. To learn more about the scopes available to Contoso in its tenant, see [Azure RBAC scopes](/azure/cost-management-billing/costs/understand-work-scopes?WT.mc_id=costmanagementcontent_docsacmhorizontal_-inproduct-learn#azure-rbac-scopes).

The following diagram shows the full hierarchical structure of Cost Management scopes that are available to Microsoft Cloud Solution Provider (CSP) partners. Scopes for the Azure billing hierarchy are shown on the left in the partner tenant, your Fabrikam tenant. Scopes for the Azure resource entity are on the right in the customer's tenant, Contoso. They're colored orange.

![Diagram that shows Fabrikam's scopes for the billing hierarchy.](../media/02-hierarchy-diagram.png)

### Billing account

The billing account represents the root node of Fabrikam's presence within Azure. All costs across your customers roll up into this scope. Note the following nuances about costs viewed at this scope:

- **Consumption-based costs**: Invoice costs are available in Cost Management only for customers on the Azure plan under the Microsoft Customer Agreement. An example of a consumption-based product is a virtual machine that's been created for Contoso and is billed hourly.
- **Purchase-based costs**: Invoice costs are available in Cost Management for customers on the Azure plan for both the Microsoft Customer Agreement and the classic CSP agreement.
- **Currency**: Regardless of different customer-billed currencies, budgets set at the billing account scope are evaluated in US dollars across your customers, subscriptions, resources, and resource groups.

### Billing profile

The billing profile scope defines subscriptions shown on invoices that Fabrikam receives. The invoices are billed against the scope. After you onboard Fabrikam's customers to a Microsoft Customer Agreement, you receive an invoice. It includes all charges for all products (consumption, purchases, and entitlements) for the customers on the Azure plan under the Microsoft Customer Agreement.

Use the billing profile scope to view pretax costs in the invoiced currency across all your customers for all products and subscriptions included in an invoice. We'll discuss how to analyze your invoice in more detail in the next unit.

Note the cost differences viewed at this scope:

- **Currency**: Currently, the invoiced currency is the default currency when you're viewing costs in the billing profile scope. Budgets set at this scope are in the invoiced currency.
- **CSP offer charges**: When billed in the same currency, these invoices also include the charges for entitlement and purchased products such as software as a service (SaaS), Azure Marketplace, and reservations for Fabrikam's customers who are still in the classic CSP agreement.

### Customer

The customer scope allows you to view pretax invoiced costs in invoiced currency for a specific customer, such as Contoso. You can also filter these costs for a specific subscription, resource group, or resource.

The customer scope doesn't include customers who are in the classic CSP agreement. The scope supports only customers who have an Azure plan under Microsoft Customer Agreement.

## Roles and permissions for Cost Management in the billing hierarchy

Only the users with *global admin* and *admin agent* roles can manage and view costs for billing accounts, billing profiles, and customers directly in the partner's Azure tenant. For more information about Partner Center roles, see [Assign users roles and permissions](/partner-center/permissions-overview).

## Export of cost data

Partners with access to billing scopes in a partner tenant can export their cost and usage data to an Azure storage blob. The blob must be on a subscription in the partner tenant that's not a shared service subscription or a customer's subscription.

To enable export of cost data, we recommended that you set up an independent pay-as-you-go subscription in the partner tenant to host the exported cost data. Users with RBAC access to the subscription can also export the cost data to an Azure storage blob hosted in any subscription in the customer tenant. For more information, see [Create an export in a partner tenant or customer tenant](/azure/cost-management-billing/costs/get-started-partners#create-an-export-in-a-partner-tenant-or-customer-tenant).