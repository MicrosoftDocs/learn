After your policies are in place and you align your organization's processes and procedures with the policies, you must monitor your cloud governance compliance. Use monitoring to determine areas that lack compliance and make changes to reduce noncompliance problems.

**Use monitoring tools** to ensure that you have visibility into your cloud governance. You must be able to promptly detect and resolve noncompliance and monitor the health and performance of your cloud resources.

**Use compliance dashboards,** like the Azure portal, to view the state of compliance in your environment. You can see data like noncompliant initiatives, policies, and resources. You can also view your cloud governance compliance for each specific policy.

**Determine the reason for noncompliance.** For example, a resource might show as noncompliant if it's deployed:

- Before the policy is in place.

- By a user who doesn't have the necessary permissions.
- In a region that doesn't align with the policy.
- With a SKU that doesn't align with the policy.
- Without the required tags.

**Configure alerts** to notify teams or individuals about deviations from your governance policies. Define clear thresholds that trigger the alerts to the appropriate people.

**Develop a remediation plan** to automatically remediate violations quickly. Prioritize high-risk violations. Use manual remediation where you can't implement automated processes. After remediation, update governance policies and enforcement mechanisms to prevent future violations.


Add examples of the Tailwind story


## Use Microsoft Cost Management

Use Microsoft Cost Management to monitor your cost data and manage cloud governance cost. Cost Management combines data about your resource organization, Azure Advisor alerts, and your governance foundation.

Monitor resource optimization to help reduce costs. You can use Azure Advisor to monitor Azure resource costs, and configure alerts for new Azure Advisor recommendations. You can also configure anomaly alerts in Cost Management to notify you when an unexpected cost occurs.

### Exercise: Create a budget

To get started with Cost Management, create your first budget with the [Create and manage Azure budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets) tutorial.

### Exercise: Find opportunities to optimize

If you have existing deployments in your Azure environment, you likely have recommendations in the Azure portal that might affect your overall spending. Complete the [Optimize costs from recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations) tutorial to view recommendations from Azure Advisor and other recommendations that might reduce your costs. The recommendations identify opportunities to apply cost management best practices.

### Exercise: Use Azure Policy to prevent cost risks

To proactively limit unexpected costs, you can use Azure Policy to create guardrails so that specific roles can't overspend. The two most common cost risks occur because of decisions related to:

- **Azure regions**: Asset costs vary between Azure regions. When possible, you can use Azure Policy to limit deploying resources across regions.

- **Azure SKUs**: The SKU that you select during deployment directly affects costs. To limit unexpected budget overrun, you can minimize the use of expensive resources in self-service or workload-owned subscriptions.

To help prevent these risks:

- Add a policy to specify [allowed locations](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fe56962a6-4747-49cd-b67b-bf8b01975c4c) for specific subscriptions to avoid cost drift related to regional pricing.

- Add a policy to [deny VM SKUs](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fcccc23c7-8427-4f53-ad12-b6a63eb452b3) in your nonproduction environments.


