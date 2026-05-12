Managing workspace capacity ensures teams have sufficient Security Compute Units (SCUs) to meet operational demands without over-provisioning resources. Workspace owners monitor usage trends, adjust provisioned and overage SCU allocations, and plan for anticipated load changes. Proper capacity management balances cost optimization with performance requirements.

For Contoso, you monitor the SOC workspace's utilization during incident response surges, adjust the compliance workspace's capacity before quarterly audit periods, and minimize the sandbox workspace's capacity during idle periods.

> [!IMPORTANT]
> SCUs can't be shared between workspaces. Each workspace has available and overage SCUs are independent. If a workspace exhausts its allocation, other workspaces can't contribute capacity to prevent throttling.

## Monitor usage

:::image type="content" source="../media/capacity-management-guide.png" alt-text="Gauge diagram showing SCU utilization zones: green under 30% is over provisioned, blue 30 to 90 percent is correct, and red above 90% is under provisioned." lightbox="../media/capacity-management-guide.png":::

The usage monitoring dashboard provides visibility into SCU consumption, prompt volumes, plugin usage, and capacity trends. The dashboard includes up to 90 days of data.

To access the dashboard:

1. Sign in to Security Copilot and switch to the target workspace.
2. Select the home menu icon, then navigate to **Owner settings** > **Usage monitoring**.

The dashboard displays provisioned units used, overage units used, and the workspace consuming each capacity. Use tabs at the top to toggle between capacity resources.

Use usage patterns to guide capacity decisions:

| Pattern | Indicator | Recommended action |
|---------|-----------|-------------------|
| Sustained near-capacity | Utilization consistently >90% | Increase provisioned SCUs |
| Frequent overage activation | Overage used >20% of hours | Convert overage to provisioned |
| Low baseline | Utilization consistently <30% | Decrease provisioned SCUs |
| Predictable spikes | Quarterly audit periods | Temporarily increase before the period |

When provisioned and overage SCUs are both exhausted, Security Copilot throttles new requests. Users see an error indicating capacity is unavailable until the next billing hour. To avoid disruption, monitor utilization trends and adjust capacity before hitting limits.

## Adjust capacity

Workspace owners with Azure Contributor access to the capacity resource can adjust provisioned and overage SCU allocations from either the owner settings page or the usage dashboard. Capacity changes take effect within 30 minutes.

To update SCUs:

1. Navigate to **Owner settings** > **Security compute units**, then select **Change** - or select **Change units** directly from the usage dashboard.
2. Update the **Provisioned SCUs** or **Number of overage units** as needed.
3. Review the updated estimated monthly cost, then save.

Optionally, select **View billing in Azure** to review costs.

Overage unit changes don't affect baseline costs—overage SCUs are billed only when consumed. To temporarily scale for a quarterly audit, increase overage before the period and reduce it afterward.

## Assign or switch capacity resources

Owners can assign available capacity or switch between capacity resources from the **Manage workspaces** page. Updates require Azure Contributor access to the capacity resource. A capacity can only be assigned to one workspace at a time—assigning it elsewhere requires disassociating it from its current workspace first.

## Delete or disassociate capacity

Deleting capacity permanently removes the resource and ceases billing. Disassociating capacity from a workspace without deleting the resource makes capacity available for other workspaces but leaves the workspace nonfunctional until new capacity is assigned.

> [!WARNING]
> Deleting capacity and its internal data is a permanent action and can't be undone. Session history, feedback, and workspace-specific data are lost. A Security Administrator role is required to delete capacity.

To temporarily disable a workspace without losing data, disassociate the capacity resource and remove user permissions instead. No billing occurs without assigned capacity, and you can reassign capacity and restore access later.

Now that you understand capacity management, you're equipped to optimize workspace configurations, plan for growth, and maintain Security Copilot availability aligned with organizational needs.
