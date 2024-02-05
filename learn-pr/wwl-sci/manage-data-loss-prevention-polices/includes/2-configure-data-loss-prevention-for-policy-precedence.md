DLP policies and the rules within them follow a specific order called **policy precedence**. You can manually configure the order in which rules are evaluated. Lower priority numbers are processed first, with the default rule assigned a priority of 0 and subsequent rules assigned higher numbers sequentially.

Even though only one DLP policy and its corresponding rule are enforced, all potential matches of policies are still logged in the audit logs and can be seen in DLP reports. DLP policies also provide an option to prevent processing of more policies once a match has been made.

The configured actions for certain condition matches can conflict with each other. Let's consider an example to understand this better. You configure a DLP policy that blocks external sharing of personal data without any possibility of override. You configure another policy for financial data that allows end users to override it. If the system only applied the last policy that matches the conditions, without considering the priority of each policy, a user could potentially hide personal data within an email that also contains financial data. They could then select the override option provided by the financial data policy to bypass the block action set by the personal data policy. To prevent this scenario, the personal data policy, which should have a higher priority, is applied instead, ensuring that the block action takes precedence over any potential overrides.

## Changing rule priority

Suppose we take the financial data policy example mentioned earlier. Let's arrange it in such a way that a rule with a high volume of matches is given lower priority compared to a rule with a low number of matches. Even though a high number of matches is more restrictive, the user can still override the allowed action specified in the rule with low matches and share protected data. Although both actions are logged, it might take some time to notice this behavior and take appropriate actions.

To change the order in which the DLP rules inside a policy are prioritized, you need the DLP Compliance Management role and follow these steps:

1. In the Microsoft Purview compliance portal, expand **Data loss prevention** then select **Policies**.

1. Select the policy you want to modify, select **Edit policy**.

1. Select **Next** until you reach the **Customize Advanced DLP rules** page.

1. Select **Edit** behind the name of the low volume rule you want to change in the priority order.

1. Select a new priority number from the dropdown menu under **Additional options**. You can select "0" to select the highest priority.

1. You can also use PowerShell to change the priority of the DLP rule "Low Volume of Financial Data" to the highest value by using the following cmdlet:

```powershell
Set-DLPComplianceRule -Identity "Low Volume of Financial Data" -Priority 0
```

## Change policy priority

When you create more than one DLP policy, you can change the priority (or order). For example, if you have a personal data DLP policy and another financial data DLP policy and you want the personal data DLP policy to take precedence, follow these steps.

1. In the Microsoft Purview compliance portal, expand **Data loss prevention** then select **Policies**.

1. Select the **three vertical dots** behind the name of the personal data policy.

1. Select **Move to Top** to move the policy into the highest priority.

1. You can also use PowerShell to change the priority of the DLP policy "EU Financial Data Policy" to the value 1 by using the following cmdlet:

```powershell
Set-DLPCompliancePolicy -Identity "EU Financial Data Policy" -Priority 1
```

It's important to prioritize policies and rules  with less restrictive actions over those that are stricter. This way, we can avoid situations where the less restrictive rules end up overwriting the actions of the more restrictive ones.
