DLP policies and rules contained within those policies **are processed in a specific order**. This process is called **policy precedence**. You can manually configure the order in which this rule will be selected for evaluation. The rules of DLP policy with the lowest order/priority number are processed first. By default, the first rule is configured as priority "0", the next one as "1", and so on.

All possible matches of policies are still recorded in the audit logs and visible in the DLP reports, even though only one DLP policy and their rule is enforced. DLP policies also provide an option to prevent processing of more policies when a match has been made.

The configured actions for certain condition matches can oppose each other. For example, you configure a DLP policy that blocks external sharing of personal data, without override allowed, and another policy for financial data, which allows override by end users. If only the last matching policy was applied, instead of taking the priority of a policy into account, then a user could hide personal data inside an email that also includes financial data and select the override encoded into the financial data policy to bypass the block action of the personal data policy. However, since the personal data policy should have a higher priority it will be applied instead.

## Changing rule priority

If the financial data policy from the example above was ordered so a rule for a high volume of matches was prioritized below a rule for a low number of matches, even though a high number of matches is more restrictive, the user could still select the override that is allowed in the low matches rule and send out protected data. Even though both actions will be logged it could still take time to notice the behavior and take appropriate actions.

To change the order in which the DLP rules inside a policy are prioritized, you need the DLP Compliance Management role and follow these steps:

1. In the Microsoft 365 Compliance Center, select **Policies**.

1. Expand **Data** and select **Data loss prevention**.

1. Select the policy you want to modify and select **edit policy**.

1. Select **Next** twice to reach the **Customize Advanced DLP rules** dialog.

1. Select **Edit** behind the name of the low volume rule you want to change in the priority order.

1. Select a new priority number from the dropdown menu. You can select "0" to select the highest priority.

1. You can also use PowerShell to change the priority of the DLP rule "Low Volume of Financial Data" to the highest value by using the following cmdlet:

```powershell
Set-DLPComplianceRule -Identity "Low Volume of Financial Data" -Priority 0

```

## Change policy priority

When you create more than one DLP policy, you can change the priority (or order). For example, if you have a personal data DLP policy and another financial data DLP policy and you want the personal data DLP policy to take precedence, follow these steps.

1. In the Microsoft 365 Compliance Center, select **Policies** > **Data loss prevention**.

1. Select the **three vertical dots** behind the name of the personal data policy.

1. Select **Move to Top** to move the policy into the highest priority.

1. You can also use PowerShell to change the priority of the DLP policy "EU Financial Data Policy" to the value 1 by using the following cmdlet:

```powershell
Set-DLPCompliancePolicy -Identity "EU Financial Data Policy" -Priority 1

```

> It is prudent to prioritize policies with less restrictive actions below more restrictive policies. Also, rules with less restrictive actions should be prioritized below more restrictive rules to prevent the less restrictive rules from overwriting any block actions of the more restrictive rules and policies. 

